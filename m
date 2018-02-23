Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBWA7c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:59:32 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38308 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeBWA73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:59:29 -0500
X-Google-Smtp-Source: AH8x225XgsQHroguEEFespii9Br3NnuijQMpoxJuJYx3sBlU9pes2IN00YO85WTkEwJ95OevBiJ+dw==
Date: Thu, 22 Feb 2018 16:59:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kbuild test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: boot: Define __ASSEMBLY__ for its.S build
Message-ID: <20180223005926.GA18630@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS %.its.S compiler command did not define __ASSEMBLY__, which meant
when compiler_types.h was added to kconfig.h, unexpected things appeared
(e.g. struct declarations) which should not have been present. As done in
the general %.S compiler command, __ASSEMBLY__ is now included here too.

The failure was:

    Error: arch/mips/boot/vmlinux.gz.its:201.1-2 syntax error
    FATAL ERROR: Unable to parse input tree
    /usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
    /usr/bin/mkimage Can't add hashes to FIT blob

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 28128c61e08e ("kconfig.h: Include compiler types to avoid missed struct attributes")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 1bd5c4f00d19..c22da16d67b8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,6 +126,7 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+			-D__ASSEMBLY__ \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
-- 
2.7.4


-- 
Kees Cook
Pixel Security
