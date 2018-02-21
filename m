Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBUDP0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:15:26 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45451 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeBUDPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:15:25 -0500
X-Google-Smtp-Source: AG47ELtQ9xg4faZPx02CL8fUbqoY3bncsQBBECJ8OxACmVmt/gEHDvblOdvQZZk9ZDwigJ9dQvXTZg==
Date: Tue, 20 Feb 2018 22:15:23 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
In-Reply-To: <20180220215954.4092811-4-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802202213560.31644@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-4-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Arnd Bergmann wrote:

> We need some way to pass -mbig-endian to the linker during the
> LTO link stage, otherwise we get a waning like
> 
> arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian
> 
> for each file we link in.
> 
> There is probably a better method of passing that flag, I'm just
> adding it to a different hack that I added earlier for x86 LTO
> here.

Didn't the patch below fix it for you already?

----- >8
Date: Fri, 1 Sep 2017 18:37:52 -0400
Subject: [PATCH] scripts/gcc-ld: LTO on ARM needs arch specific gcc flags

Otherwise the final link where code generation happens produces code
for the wrong ISA when the default CPU configured into gcc is not the
one we need.

Also display the actual command when invoked with "make V=1".

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/scripts/gcc-ld b/scripts/gcc-ld
index d95dd0be38..fa53be2a34 100755
--- a/scripts/gcc-ld
+++ b/scripts/gcc-ld
@@ -27,4 +27,10 @@ while [ "$1" != "" ] ; do
 	shift
 done
 
-exec $CC $ARGS
+case "${KBUILD_VERBOSE}" in
+*1*)
+	set -x
+	;;
+esac
+
+exec $CC $KBUILD_CFLAGS $ARGS
