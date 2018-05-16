Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeEPPDk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:03:40 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:48052 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeEPPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:03:38 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARC: Explicitly add -mmedium-calls to CFLAGS
Date: Wed, 16 May 2018 18:03:30 +0300
Message-Id: <20180516150330.31182-1-abrodkin@synopsys.com>
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

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index d37f49d6a27f..db9ce90c3cc0 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -16,7 +16,7 @@ endif
 
 KBUILD_DEFCONFIG := nsim_700_defconfig
 
-cflags-y	+= -fno-common -pipe -fno-builtin -D__linux__
+cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
 cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=archs
 
-- 
2.16.2
