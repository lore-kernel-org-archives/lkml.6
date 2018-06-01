Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeFALeo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:34:44 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:41970 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeFALel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:34:41 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2] ARC: Explicitly add -mmedium-calls to CFLAGS
Date: Fri,  1 Jun 2018 14:34:33 +0300
Message-Id: <20180601113433.27119-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC built for arc*-*-linux has "-mmedium-calls" implicitly enabled by default
thus we don't see any problems during Linux kernel compilation.
----------------------------->8------------------------
arc-linux-gcc -mcpu=arc700 -Q --help=target | grep calls
  -mlong-calls                          [disabled]
  -mmedium-calls                        [enabled]
----------------------------->8------------------------

But if we try to use so-called Elf32 toolchain with GCC configured for
arc*-*-elf* then we'd see the following failure:
----------------------------->8------------------------
init/do_mounts.o: In function 'init_rootfs':
do_mounts.c:(.init.text+0x108): relocation truncated to fit: R_ARC_S21W_PCREL
against symbol 'unregister_filesystem' defined in .text section in fs/filesystems.o

arc-elf32-ld: final link failed: Symbol needs debug section which does not exist
make: *** [vmlinux] Error 1
----------------------------->8------------------------

That happens because neither "-mmedium-calls" nor "-mlong-calls" are enabled in
Elf32 GCC:
----------------------------->8------------------------
arc-elf32-gcc -mcpu=arc700 -Q --help=target | grep calls
  -mlong-calls                          [disabled]
  -mmedium-calls                        [disabled]
----------------------------->8------------------------

Now to make it possible to use Elf32 toolchain for building Linux kernel
we're explicitly add "-mmedium-calls" to CFLAGS.

And since we add "-mmedium-calls" to the global CFLAGS there's no point in
having per-file copies thus removing them.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---

Changes v1 -> v2:

 - Removed per-file mentions of "-mmedium-calls"

 arch/arc/Makefile | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index d37f49d6a27f..6c1b20dd76ad 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -16,7 +16,7 @@ endif
 
 KBUILD_DEFCONFIG := nsim_700_defconfig
 
-cflags-y	+= -fno-common -pipe -fno-builtin -D__linux__
+cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
 cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=archs
 
@@ -140,16 +140,3 @@ dtbs: scripts
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-
-# Hacks to enable final link due to absence of link-time branch relexation
-# and gcc choosing optimal(shorter) branches at -O3
-#
-# vineetg Feb 2010: -mlong-calls switched off for overall kernel build
-# However lib/decompress_inflate.o (.init.text) calls
-# zlib_inflate_workspacesize (.text) causing relocation errors.
-# Thus forcing all exten calls in this file to be long calls
-export CFLAGS_decompress_inflate.o = -mmedium-calls
-export CFLAGS_initramfs.o = -mmedium-calls
-ifdef CONFIG_SMP
-export CFLAGS_core.o = -mmedium-calls
-endif
-- 
2.16.2
