#!/bin/bash

FFMPEG_VER=1.2
IOSSDK_VER=6.1
ARCHS="armv6 armv7 armv7s i386"

remove_arch() {
	OLD_ARCHS="$ARCHS"
	NEW_ARCHS=""
	REMOVAL="$1"

	for ARCH in $OLD_ARCHS; do
		if [ "$ARCH" != "$REMOVAL" ] ; then
			NEW_ARCHS="$NEW_ARCHS $ARCH"
		fi
	done
	
	ARCHS=$NEW_ARCHS
}

# armv7s is only supported in iOS 6.0+
CHECK=`echo $IOSSDK_VER '>= 6.0' | bc -l`
if [ "$CHECK" = "0" ] ; then
	remove_arch "armv7s"
fi

# armv6 is not supported any more since iOS 6.0
CHECK=`echo $IOSSDK_VER '< 6.0' | bc -l`
if [ "$CHECK" = "0" ] ; then
	remove_arch "armv6"
fi

echo 'Architectures to build:' $ARCHS
    


