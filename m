Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE63ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBE2214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBE2214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIYW7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:59:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40497 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIYW7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:59:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KRsK0FRcz9ttCY;
        Tue, 25 Sep 2018 18:50:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Gf2rwBrlOWlV; Tue, 25 Sep 2018 18:50:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KRsJ6dvXz9ttCN;
        Tue, 25 Sep 2018 18:50:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F383F8B7E5;
        Tue, 25 Sep 2018 18:50:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0qoX954Jkb7s; Tue, 25 Sep 2018 18:50:44 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A773F8B7C8;
        Tue, 25 Sep 2018 18:50:44 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 79C8E70AFE; Tue, 25 Sep 2018 16:50:44 +0000 (UTC)
Message-Id: <922753d83d685a3c7b2cd9883c9330d129f4910b.1537892498.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 03/22] powerpc/8xx: Use patch_site for memory setup
 patching
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Sep 2018 16:50:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8xx TLB miss routines are patched at startup at several places.

This patch uses the new patch_site functionality in order
to get a better code readability and avoid a label mess when
dumping the code with 'objdump -d'

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h |  5 +++++
 arch/powerpc/kernel/head_8xx.S     | 19 +++++++++++--------
 arch/powerpc/mm/8xx_mmu.c          | 23 +++++++----------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 193f53116c7a..3a15d6647d47 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -229,6 +229,11 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
 	BUG();
 }
 
+/* patch sites */
+extern s32 patch__itlbmiss_linmem_top;
+extern s32 patch__dtlbmiss_linmem_top, patch__dtlbmiss_immr_jmp;
+extern s32 patch__fixupdar_linmem_top;
+
 #endif /* !__ASSEMBLY__ */
 
 #if defined(CONFIG_PPC_4K_PAGES)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 12c92a483fb1..0425571a533d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -31,6 +31,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/code-patching-asm.h>
 
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
 /* By simply checking Address >= 0x80000000, we know if its a kernel address */
@@ -318,8 +319,8 @@ InstructionTLBMiss:
 	cmpli	cr0, r11, PAGE_OFFSET@h
 #ifndef CONFIG_PIN_TLB_TEXT
 	/* It is assumed that kernel code fits into the first 8M page */
-_ENTRY(ITLBMiss_cmp)
-	cmpli	cr7, r11, (PAGE_OFFSET + 0x0800000)@h
+0:	cmpli	cr7, r11, (PAGE_OFFSET + 0x0800000)@h
+	patch_site	0b, patch__itlbmiss_linmem_top
 #endif
 #endif
 #endif
@@ -436,11 +437,11 @@ DataStoreTLBMiss:
 #ifndef CONFIG_PIN_TLB_IMMR
 	cmpli	cr0, r11, VIRT_IMMR_BASE@h
 #endif
-_ENTRY(DTLBMiss_cmp)
-	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
+0:	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
+	patch_site	0b, patch__dtlbmiss_linmem_top
 #ifndef CONFIG_PIN_TLB_IMMR
-_ENTRY(DTLBMiss_jmp)
-	beq-	DTLBMissIMMR
+0:	beq-	DTLBMissIMMR
+	patch_site	0b, patch__dtlbmiss_immr_jmp
 #endif
 	blt	cr7, DTLBMissLinear
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
@@ -714,8 +715,10 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 	blt+	3f
 	rlwinm	r11, r10, 16, 0xfff8
-_ENTRY(FixupDAR_cmp)
-	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
+
+0:	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
+	patch_site	0b, patch__fixupdar_linmem_top
+
 	/* create physical page address from effective address */
 	tophys(r11, r10)
 	blt-	cr7, 201f
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index fee599cf3bc3..d39f3af03221 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -97,22 +97,13 @@ static void __init mmu_mapin_immr(void)
 		map_kernel_page(v + offset, p + offset, PAGE_KERNEL_NCG);
 }
 
-/* Address of instructions to patch */
-#ifndef CONFIG_PIN_TLB_IMMR
-extern unsigned int DTLBMiss_jmp;
-#endif
-extern unsigned int DTLBMiss_cmp, FixupDAR_cmp;
-#ifndef CONFIG_PIN_TLB_TEXT
-extern unsigned int ITLBMiss_cmp;
-#endif
-
-static void __init mmu_patch_cmp_limit(unsigned int *addr, unsigned long mapped)
+static void __init mmu_patch_cmp_limit(s32 *site, unsigned long mapped)
 {
-	unsigned int instr = *addr;
+	unsigned int instr = *(unsigned int *)site_addr(site);
 
 	instr &= 0xffff0000;
 	instr |= (unsigned long)__va(mapped) >> 16;
-	patch_instruction(addr, instr);
+	patch_instruction_site(site, instr);
 }
 
 unsigned long __init mmu_mapin_ram(unsigned long top)
@@ -123,17 +114,17 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 		mapped = 0;
 		mmu_mapin_immr();
 #ifndef CONFIG_PIN_TLB_IMMR
-		patch_instruction(&DTLBMiss_jmp, PPC_INST_NOP);
+		patch_instruction_site(&patch__dtlbmiss_immr_jmp, PPC_INST_NOP);
 #endif
 #ifndef CONFIG_PIN_TLB_TEXT
-		mmu_patch_cmp_limit(&ITLBMiss_cmp, 0);
+		mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, 0);
 #endif
 	} else {
 		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
 	}
 
-	mmu_patch_cmp_limit(&DTLBMiss_cmp, mapped);
-	mmu_patch_cmp_limit(&FixupDAR_cmp, mapped);
+	mmu_patch_cmp_limit(&patch__dtlbmiss_linmem_top, mapped);
+	mmu_patch_cmp_limit(&patch__fixupdar_linmem_top, mapped);
 
 	/* If the size of RAM is not an exact power of two, we may not
 	 * have covered RAM in its entirety with 8 MiB
-- 
2.13.3

