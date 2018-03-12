Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeCLCk5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 22:40:57 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37812 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbeCLCk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 22:40:56 -0400
X-Google-Smtp-Source: AG47ELtYnf+UK+hj6Ap/BVsKjm6kLjoFmV+/SsAZqTGbqnFYa4JH3pFEB2mO0rXOW8xgl+/ZZDoUkQ==
Date: Sun, 11 Mar 2018 22:40:53 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <20180220215954.4092811-2-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-2-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Arnd Bergmann wrote:

> This fails during deflate_xip_data.sh
> 
>   /home/arnd/cross-gcc/bin/arm-linux-gnueabi-objcopy -O binary -R .comment -S  vmlinux arch/arm/boot/xipImage && /bin/bash -c '/git/arm-soc/arch/arm/boot/deflate_xip_data.sh vmlinux arch/arm/boot/xipImage || { rm -f arch/arm/boot/xipImage; false; }'
> make -f /git/arm-soc/scripts/Makefile.modpost
> + sym_val __data_loc
> + sed -n / __data_loc$/{s/ .*$//p;q}
> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> + local val=ac74c0f4
> + [ ac74c0f4 ]
> + echo 2893332724
> + __data_loc=2893332724
> + sym_val _edata_loc
> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> + sed -n / _edata_loc$/{s/ .*$//p;q}
> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> + local val=ac7b8744
> + [ ac7b8744 ]
> + echo 2893776708
> + _edata_loc=2893776708
> + sym_val _xiprom
> + sed -n / _xiprom$/{s/ .*$//p;q}
> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> 
> Obviously we want to make the combination work, no idea why it doesn't.

Well, it does work regardless of the noise. Here the nm output is piped 
into sed, and the later exits early when it finds what it is looking 
for, causing nm to complain about the broken pipe.

Here's a patch silencing this bogus error message and fixing other minor 
issues.

----- >8
Subject: [PATCH] ARM: deflate_xip_data.sh: minor fixes

Send nm complaints about broken pipe (when sed exits early) to /dev/null.
All errors should be printed to stderr.
Don't trap on normal exit so the trap can return an error code.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/boot/deflate_xip_data.sh b/arch/arm/boot/deflate_xip_data.sh
index 1189598a25..5e7d758ebd 100755
--- a/arch/arm/boot/deflate_xip_data.sh
+++ b/arch/arm/boot/deflate_xip_data.sh
@@ -30,7 +30,7 @@ esac
 
 sym_val() {
 	# extract hex value for symbol in $1
-	local val=$($NM "$VMLINUX" | sed -n "/ $1$/{s/ .*$//p;q}")
+	local val=$($NM "$VMLINUX" 2>/dev/null | sed -n "/ $1\$/{s/ .*$//p;q}")
 	[ "$val" ] || { echo "can't find $1 in $VMLINUX" 1>&2; exit 1; }
 	# convert from hex to decimal
 	echo $((0x$val))
@@ -48,12 +48,12 @@ data_end=$(($_edata_loc - $base_offset))
 file_end=$(stat -c "%s" "$XIPIMAGE")
 if [ "$file_end" != "$data_end" ]; then
 	printf "end of xipImage doesn't match with _edata_loc (%#x vs %#x)\n" \
-	       $(($file_end + $base_offset)) $_edata_loc 2>&1
+	       $(($file_end + $base_offset)) $_edata_loc 1>&2
 	exit 1;
 fi
 
 # be ready to clean up
-trap 'rm -f "$XIPIMAGE.tmp"' 0 1 2 3
+trap 'rm -f "$XIPIMAGE.tmp"; exit 1' 1 2 3
 
 # substitute the data section by a compressed version
 $DD if="$XIPIMAGE" count=$data_start iflag=count_bytes of="$XIPIMAGE.tmp"
