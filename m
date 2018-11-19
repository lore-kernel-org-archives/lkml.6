Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD822089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlfaS2KB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD822089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbeKTC6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbeKTC6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B86D208E3;
        Mon, 19 Nov 2018 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645270;
        bh=eGjSnZ5GKnbkNA9Ok8AGmTc4C0+9jYCIdCBrLkpXSuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlfaS2KB6RxGIKWOcDEBnW4Jw1Maq//Zi7hU76plq63mvdYTIq1OfWhgWqR/Osc/n
         DHoEpaAjJ5EAF/EuWzkkheqTq3ty9Fg1jjT3N/zho01LFPUcYEr3ZiWCtCJ84G9OYs
         vkLxF5BsJSn2vEtClOrQsfbyqGexuETDw7Dhk3xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 099/205] Revert "powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for CONFIG_SWAP"
Date:   Mon, 19 Nov 2018 17:26:46 +0100
Message-Id: <20181119162633.158884876@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit cc4ebf5c0a3440ed0a32d25c55ebdb6ce5f3c0bc upstream.

This reverts commit 4f94b2c7462d9720b2afa7e8e8d4c19446bb31ce.

That commit was buggy, as it used rlwinm instead of rlwimi.
Instead of fixing that bug, we revert the previous commit in order to
reduce the dependency between L1 entries and L2 entries

Fixes: 4f94b2c7462d9 ("powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for CONFIG_SWAP")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/mmu-8xx.h |   34 ++++-----------------------
 arch/powerpc/kernel/head_8xx.S     |   45 ++++++++++++++++++++++---------------
 arch/powerpc/mm/8xx_mmu.c          |    2 -
 3 files changed, 34 insertions(+), 47 deletions(-)

--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -34,20 +34,12 @@
  * respectively NA for All or X for Supervisor and no access for User.
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
- * We also use the 2nd APG bit for _PAGE_ACCESSED when having SWAP:
- * When that bit is not set access is done iaw "all user"
- * which means no access iaw page rules.
- * Therefore, we define 4 APG groups. lsb is _PMD_USER, 2nd is _PAGE_ACCESSED
- * 0x => No access => 11 (all accesses performed as user iaw page definition)
- * 10 => No user => 01 (all accesses performed according to page definition)
- * 11 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
  * We define all 16 groups so that all other bits of APG can take any value
  */
-#ifdef CONFIG_SWAP
-#define MI_APG_INIT	0xf4f4f4f4
-#else
 #define MI_APG_INIT	0x44444444
-#endif
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
@@ -115,20 +107,12 @@
  * Supervisor and no access for user and NA for ALL.
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
- * We also use the 2nd APG bit for _PAGE_ACCESSED when having SWAP:
- * When that bit is not set access is done iaw "all user"
- * which means no access iaw page rules.
- * Therefore, we define 4 APG groups. lsb is _PMD_USER, 2nd is _PAGE_ACCESSED
- * 0x => No access => 11 (all accesses performed as user iaw page definition)
- * 10 => No user => 01 (all accesses performed according to page definition)
- * 11 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
  * We define all 16 groups so that all other bits of APG can take any value
  */
-#ifdef CONFIG_SWAP
-#define MD_APG_INIT	0xf4f4f4f4
-#else
 #define MD_APG_INIT	0x44444444
-#endif
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
@@ -180,12 +164,6 @@
  */
 #define SPRN_M_TW	799
 
-/* APGs */
-#define M_APG0		0x00000000
-#define M_APG1		0x00000020
-#define M_APG2		0x00000040
-#define M_APG3		0x00000060
-
 #ifdef CONFIG_PPC_MM_SLICES
 #include <asm/nohash/32/slice.h>
 #define SLICE_ARRAY_SIZE	(1 << (32 - SLICE_LOW_SHIFT - 1))
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -353,13 +353,14 @@ _ENTRY(ITLBMiss_cmp)
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtcr	r12
 #endif
-
-#ifdef CONFIG_SWAP
-	rlwinm	r11, r10, 31, _PAGE_ACCESSED >> 1
-#endif
 	/* Load the MI_TWC with the attributes for this "segment." */
 	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 
+#ifdef CONFIG_SWAP
+	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
+	and	r11, r11, r10
+	rlwimi	r10, r11, 0, _PAGE_PRESENT
+#endif
 	li	r11, RPN_PATTERN | 0x200
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 20 and 23 must be clear.
@@ -470,14 +471,22 @@ _ENTRY(DTLBMiss_jmp)
 	 * above.
 	 */
 	rlwimi	r11, r10, 0, _PAGE_GUARDED
-#ifdef CONFIG_SWAP
-	/* _PAGE_ACCESSED has to be set. We use second APG bit for that, 0
-	 * on that bit will represent a Non Access group
-	 */
-	rlwinm	r11, r10, 31, _PAGE_ACCESSED >> 1
-#endif
 	mtspr	SPRN_MD_TWC, r11
 
+	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
+	 * We also need to know if the insn is a load/store, so:
+	 * Clear _PAGE_PRESENT and load that which will
+	 * trap into DTLB Error with store bit set accordinly.
+	 */
+	/* PRESENT=0x1, ACCESSED=0x20
+	 * r11 = ((r10 & PRESENT) & ((r10 & ACCESSED) >> 5));
+	 * r10 = (r10 & ~PRESENT) | r11;
+	 */
+#ifdef CONFIG_SWAP
+	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
+	and	r11, r11, r10
+	rlwimi	r10, r11, 0, _PAGE_PRESENT
+#endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
@@ -637,8 +646,8 @@ InstructionBreakpoint:
  */
 DTLBMissIMMR:
 	mtcr	r12
-	/* Set 512k byte guarded page and mark it valid and accessed */
-	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID | M_APG2
+	/* Set 512k byte guarded page and mark it valid */
+	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
 	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
@@ -656,8 +665,8 @@ _ENTRY(dtlb_miss_exit_2)
 
 DTLBMissLinear:
 	mtcr	r12
-	/* Set 8M byte page and mark it valid and accessed */
-	li	r11, MD_PS8MEG | MD_SVALID | M_APG2
+	/* Set 8M byte page and mark it valid */
+	li	r11, MD_PS8MEG | MD_SVALID
 	mtspr	SPRN_MD_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
@@ -675,8 +684,8 @@ _ENTRY(dtlb_miss_exit_3)
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
 	mtcr	r12
-	/* Set 8M byte page and mark it valid,accessed */
-	li	r11, MI_PS8MEG | MI_SVALID | M_APG2
+	/* Set 8M byte page and mark it valid */
+	li	r11, MI_PS8MEG | MI_SVALID
 	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
@@ -960,7 +969,7 @@ initial_mmu:
 	ori	r8, r8, MI_EVALID	/* Mark it valid */
 	mtspr	SPRN_MI_EPN, r8
 	li	r8, MI_PS8MEG /* Set 8M byte page */
-	ori	r8, r8, MI_SVALID | M_APG2	/* Make it valid, APG 2 */
+	ori	r8, r8, MI_SVALID	/* Make it valid */
 	mtspr	SPRN_MI_TWC, r8
 	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
 	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
@@ -987,7 +996,7 @@ initial_mmu:
 	ori	r8, r8, MD_EVALID	/* Mark it valid */
 	mtspr	SPRN_MD_EPN, r8
 	li	r8, MD_PS512K | MD_GUARDED	/* Set 512k byte page */
-	ori	r8, r8, MD_SVALID | M_APG2	/* Make it valid and accessed */
+	ori	r8, r8, MD_SVALID	/* Make it valid */
 	mtspr	SPRN_MD_TWC, r8
 	mr	r8, r9			/* Create paddr for TLB */
 	ori	r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -79,7 +79,7 @@ void __init MMU_init_hw(void)
 	for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
 		mtspr(SPRN_MD_CTR, ctr | (i << 8));
 		mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
-		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID | M_APG2);
+		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
 		mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
 		addr += LARGE_PAGE_SIZE_8M;
 		mem -= LARGE_PAGE_SIZE_8M;


