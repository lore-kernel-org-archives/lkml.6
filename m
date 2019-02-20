Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C78C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A511820859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NeYStfWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfBTR3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:29:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20927 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfBTR3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:29:24 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444PjY0mvDz9v0w0;
        Wed, 20 Feb 2019 18:29:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=NeYStfWa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dtg-LMC_BTPM; Wed, 20 Feb 2019 18:29:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444PjX6qXLz9v0vr;
        Wed, 20 Feb 2019 18:29:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550683761; bh=OATlyRKqtJ74LnxLwnFHIOP2Xlql4f6I50sMfjyLz/E=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=NeYStfWa8scv0ctIX9iJfGHdljUYVroSmwaPBGiv51vWjtxF78ePyl/hPxgJ8XqOt
         RmHtioGZJxAuG+1jBn0vEQwVguBX8FFwBDgQ5xyrYwFq3sUHuca9KfZZiOYNdLqx7h
         Stou6tPfdcfLiYym3d04a6DBNECrUc8J46inTyDk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C4008B84F;
        Wed, 20 Feb 2019 18:29:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jj7AwG5dRMm9; Wed, 20 Feb 2019 18:29:22 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EA5F8B84A;
        Wed, 20 Feb 2019 18:29:22 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5BAC36E85E; Wed, 20 Feb 2019 17:29:22 +0000 (UTC)
Message-Id: <079cf03b24e931803d2171a036db34bb19193a08.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 15/16] powerpc/8xx: don't disable large TLBs with
 CONFIG_STRICT_KERNEL_RWX
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Feb 2019 17:29:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements handling of STRICT_KERNEL_RWX with
large TLBs directly in the TLB miss handlers.

To do so, etext and sinittext are aligned on 512kB boundaries
and the miss handlers use 512kB pages instead of 8Mb pages for
addresses close to the boundaries.

It sets RO PP flags for addresses under sinittext.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  2 ++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  3 +-
 arch/powerpc/kernel/head_8xx.S               | 54 +++++++++++++++++++++-------
 arch/powerpc/mm/8xx_mmu.c                    | 31 +++++++++++++++-
 arch/powerpc/mm/init_32.c                    |  2 +-
 arch/powerpc/mm/mmu_decl.h                   |  2 +-
 6 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 20c4e3a62b90..c4d6c97d7699 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -739,6 +739,7 @@ config ETEXT_SHIFT
 	int "_etext shift" if ETEXT_SHIFT_BOOL
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	default 19 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
 	help
 	  On Book3S 32 (603+), IBATs are used to map kernel text.
@@ -759,6 +760,7 @@ config DATA_SHIFT
 	default 24 if STRICT_KERNEL_RWX && PPC64
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	default 19 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
 	help
 	  On Book3S 32 (603+), DBATs are used to map kernel text and rodata RO.
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index b0f764c827c0..0a1a3fc54e54 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -231,9 +231,10 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
 }
 
 /* patch sites */
-extern s32 patch__itlbmiss_linmem_top;
+extern s32 patch__itlbmiss_linmem_top, patch__itlbmiss_linmem_top8;
 extern s32 patch__dtlbmiss_linmem_top, patch__dtlbmiss_immr_jmp;
 extern s32 patch__fixupdar_linmem_top;
+extern s32 patch__dtlbmiss_romem_top, patch__dtlbmiss_romem_top8;
 
 extern s32 patch__itlbmiss_exit_1, patch__itlbmiss_exit_2;
 extern s32 patch__dtlbmiss_exit_1, patch__dtlbmiss_exit_2, patch__dtlbmiss_exit_3;
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 4a2e3ffdb5bb..01ed8f3c95c8 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -292,6 +292,17 @@ SystemCall:
  */
 	EXCEPTION(0x1000, SoftEmu, program_check_exception, EXC_XFER_STD)
 
+/* Called from DataStoreTLBMiss when perf TLB misses events are activated */
+#ifdef CONFIG_PERF_EVENTS
+	patch_site	0f, patch__dtlbmiss_perf
+0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+#endif
+
 	. = 0x1100
 /*
  * For the MPC8xx, this is a software tablewalk to load the instruction
@@ -405,10 +416,20 @@ InstructionTLBMiss:
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
 	mtcr	r11
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	patch_site	0f, patch__itlbmiss_linmem_top8
+
+	mfspr	r10, SPRN_SRR0
+0:	subis	r11, r10, (PAGE_OFFSET - 0x80000000)@ha
+	rlwinm	r11, r11, 4, MI_PS8MEG ^ MI_PS512K
+	ori	r11, r11, MI_PS512K | MI_SVALID
+	rlwinm	r10, r10, 0, 0x0ff80000	/* 8xx supports max 256Mb RAM */
+#else
 	/* Set 8M byte page and mark it valid */
 	li	r11, MI_PS8MEG | MI_SVALID
-	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+#endif
+	mtspr	SPRN_MI_TWC, r11
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
@@ -494,16 +515,6 @@ DataStoreTLBMiss:
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_1
 
-#ifdef CONFIG_PERF_EVENTS
-	patch_site	0f, patch__dtlbmiss_perf
-0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	addi	r10, r10, 1
-	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
-#endif
-
 DTLBMissIMMR:
 	mtcr	r11
 	/* Set 512k byte guarded page and mark it valid */
@@ -525,10 +536,29 @@ DTLBMissIMMR:
 
 DTLBMissLinear:
 	mtcr	r11
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	patch_site	0f, patch__dtlbmiss_romem_top8
+
+0:	subis	r11, r10, (PAGE_OFFSET - 0x80000000)@ha
+	rlwinm	r11, r11, 0, 0xff800000
+	neg	r10, r11
+	or	r11, r11, r10
+	rlwinm	r11, r11, 4, MI_PS8MEG ^ MI_PS512K
+	ori	r11, r11, MI_PS512K | MI_SVALID
+	mfspr	r10, SPRN_MD_EPN
+	rlwinm	r10, r10, 0, 0x0ff80000	/* 8xx supports max 256Mb RAM */
+#else
 	/* Set 8M byte page and mark it valid */
 	li	r11, MD_PS8MEG | MD_SVALID
+#endif
 	mtspr	SPRN_MD_TWC, r11
-	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	patch_site	0f, patch__dtlbmiss_romem_top
+
+0:	subis	r11, r10, 0
+	rlwimi	r10, r11, 11, _PAGE_RO
+#endif
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 46bc26ef71e9..62d4e6d76cd7 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -94,11 +94,20 @@ static void __init mmu_mapin_immr(void)
 		map_kernel_page(v + offset, p + offset, PAGE_KERNEL_NCG);
 }
 
-static void __init mmu_patch_cmp_limit(s32 *site, unsigned long mapped)
+static void mmu_patch_cmp_limit(s32 *site, unsigned long mapped)
 {
 	modify_instruction_site(site, 0xffff, (unsigned long)__va(mapped) >> 16);
 }
 
+static void mmu_patch_addis(s32 *site, long simm)
+{
+	unsigned int instr = *(unsigned int *)patch_site_addr(site);
+
+	instr &= 0xffff0000;
+	instr |= ((unsigned long)simm) >> 16;
+	patch_instruction_site(site, instr);
+}
+
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long mapped;
@@ -135,6 +144,26 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	return mapped;
 }
 
+void mmu_mark_initmem_nx(void)
+{
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) && CONFIG_ETEXT_SHIFT < 23)
+		mmu_patch_addis(&patch__itlbmiss_linmem_top8,
+				-((long)_etext & ~(LARGE_PAGE_SIZE_8M - 1)));
+	if (!IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+		mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, __pa(_etext));
+}
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void mmu_mark_rodata_ro(void)
+{
+	if (CONFIG_DATA_SHIFT < 23)
+		mmu_patch_addis(&patch__dtlbmiss_romem_top8,
+				-__pa(((unsigned long)_sinittext) &
+				      ~(LARGE_PAGE_SIZE_8M - 1)));
+	mmu_patch_addis(&patch__dtlbmiss_romem_top, -__pa(_sinittext));
+}
+#endif
+
 void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size)
 {
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index bc28995a37ea..41a3513cadc9 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -108,7 +108,7 @@ static void __init MMU_setup(void)
 		__map_without_bats = 1;
 		__map_without_ltlbs = 1;
 	}
-	if (strict_kernel_rwx_enabled())
+	if (strict_kernel_rwx_enabled() && !IS_ENABLED(CONFIG_PPC_8xx))
 		__map_without_ltlbs = 1;
 }
 
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 98fc94affc29..74ff61dabcb1 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -166,7 +166,7 @@ static inline phys_addr_t v_block_mapped(unsigned long va) { return 0; }
 static inline unsigned long p_block_mapped(phys_addr_t pa) { return 0; }
 #endif
 
-#if defined(CONFIG_PPC_BOOK3S_32)
+#if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_PPC_8xx)
 void mmu_mark_initmem_nx(void);
 void mmu_mark_rodata_ro(void);
 #else
-- 
2.13.3

