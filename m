Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbeE1GIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:08:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17888 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbeE1GIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:08:35 -0400
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/Makefile: set -mcpu=860 flag for the 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180528060834.72DE86F377@po14934vm.idsi0.si.c-s.fr>
Date: Mon, 28 May 2018 06:08:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiled with GCC 8.1, vmlinux is significantly bigger than
with GCC 4.8.

When looking at the generated code with objdump, we notice that
all functions and loops when a 16 bytes alignment. This significantly
increases the size of the kernel. It is pointless and even
counterproductive as on the 8xx 'nop' also consumes one clock cycle.

Size of vmlinux with GCC 4.8:
   text	   data	    bss	    dec	    hex	filename
5801948	1626076	 457796	7885820	 7853fc	vmlinux

Size of vmlinux with GCC 8.1:
   text	   data	    bss	    dec	    hex	filename
6764592	1630652	 456476	8851720	 871108	vmlinux

Size of vmlinux with GCC 8.1 and this patch:
   text	   data	    bss	    dec	    hex	filename
6331544	1631756	 456476	8419776	 8079c0	vmlinux

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6a050b42a9f2..26ccd0b91512 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -178,6 +178,7 @@ CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
 CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
 CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
 CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
+CFLAGS-$(CONFIG_PPC_8xx) += $(call cc-option,-mcpu=860)
 
 # Altivec option not allowed with e500mc64 in GCC.
 ifeq ($(CONFIG_ALTIVEC),y)
-- 
2.13.3
