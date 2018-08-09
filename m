Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D888C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71C21B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71C21B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeHIKiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:38:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19299 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbeHIKiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:38:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41mLdW3sN8z9tvQ0;
        Thu,  9 Aug 2018 10:14:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L1huK3siM7tn; Thu,  9 Aug 2018 10:14:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41mLdW3Ngvz9tvPt;
        Thu,  9 Aug 2018 10:14:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE6C38B83F;
        Thu,  9 Aug 2018 10:14:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xq53Pdpv6AgF; Thu,  9 Aug 2018 10:14:41 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE1AD8B74B;
        Thu,  9 Aug 2018 10:14:41 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 89B1071229; Thu,  9 Aug 2018 08:14:41 +0000 (UTC)
Message-Id: <da0c182b76c27988b88ebd35ee284f5be5882dd1.1533802042.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/lib: Use patch_site to patch copy_32 functions once
 cache is enabled
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  9 Aug 2018 08:14:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol memcpy_nocache_branch defined in order to allow patching
of memset function once cache is enabled leads to confusing reports
by perf tool.

Using the new patch_site functionality solves this issue.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-prototypes.h | 1 +
 arch/powerpc/kernel/setup_32.c            | 7 +++----
 arch/powerpc/lib/copy_32.S                | 9 ++++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 70fdc5b9b9fb..1f4691ce4126 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -146,6 +146,7 @@ void _kvmppc_save_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
 /* Patch sites */
 extern s32 patch__call_flush_count_cache;
 extern s32 patch__flush_count_cache_return;
+extern s32 patch__memset_nocache, patch__memcpy_nocache;
 
 extern long flush_count_cache;
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 0e3743343280..ba969278bf4d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -97,11 +97,10 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  * We do the initial parsing of the flat device-tree and prepares
  * for the MMU to be fully initialized.
  */
-extern unsigned int memset_nocache_branch; /* Insn to be replaced by NOP */
-
 notrace void __init machine_init(u64 dt_ptr)
 {
-	unsigned int *addr = &memset_nocache_branch;
+	unsigned int *addr = (unsigned int *)((unsigned long)&patch__memset_nocache +
+					       patch__memset_nocache);
 	unsigned long insn;
 
 	/* Configure static keys first, now that we're relocated. */
@@ -110,7 +109,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
-	patch_instruction((unsigned int *)&memcpy, PPC_INST_NOP);
+	patch_instruction_site(&patch__memcpy_nocache, PPC_INST_NOP);
 
 	insn = create_cond_branch(addr, branch_target(addr), 0x820000);
 	patch_instruction(addr, insn);	/* replace b by bne cr0 */
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index da425bb6b369..ba66846fe973 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -13,6 +13,7 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/code-patching-asm.h>
 
 #define COPY_16_BYTES		\
 	lwz	r7,4(r4);	\
@@ -107,8 +108,8 @@ _GLOBAL(memset)
 	 * Skip optimised bloc until cache is enabled. Will be replaced
 	 * by 'bne' during boot to use normal procedure if r4 is not zero
 	 */
-_GLOBAL(memset_nocache_branch)
-	b	2f
+5:	b	2f
+	patch_site	5b, patch__memset_nocache
 
 	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
 	add	r8,r7,r5
@@ -168,7 +169,9 @@ _GLOBAL(memmove)
 	/* fall through */
 
 _GLOBAL(memcpy)
-	b	generic_memcpy
+1:	b	generic_memcpy
+	patch_site	1b, patch__memcpy_nocache
+
 	add	r7,r3,r5		/* test if the src & dst overlap */
 	add	r8,r4,r5
 	cmplw	0,r4,r7
-- 
2.13.3

