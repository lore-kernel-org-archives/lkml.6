Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346CAC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0272D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PIIwG6gX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfAULel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:34:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:26207 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfAULei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:34:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43jqFy3GjVz9v3wF;
        Mon, 21 Jan 2019 12:34:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PIIwG6gX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iMBQWnes_JGE; Mon, 21 Jan 2019 12:34:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43jqFy28xjz9v3wD;
        Mon, 21 Jan 2019 12:34:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548070470; bh=gYgGmND3mbaqrV7MZ/3IKEIKVSoSwnqCPaXIlWu5rM4=;
        h=From:Subject:To:Cc:Date:From;
        b=PIIwG6gXkbmREg4x1PNlZZll69MmFJCnJVAUGrR7Qz0dXbei5vwbxwRwC2cCbbHvx
         BC/ZaiLwiagD/uUQvhzklNU1QYS2ghr0ucMbJSgXL+43MtH+QpHuJoT9si+5C6yWJI
         jjNNkn3PPgXfuEgWO1VS9GrTJeiH9uiceZBXGrSY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D393B8B7AA;
        Mon, 21 Jan 2019 12:34:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lGKDHx_q2v5G; Mon, 21 Jan 2019 12:34:36 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6B7D8B7A1;
        Mon, 21 Jan 2019 12:34:36 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8C9397188A; Mon, 21 Jan 2019 11:34:36 +0000 (UTC)
Message-Id: <6658dcb02424fbd5e19be3c3c9abb1a20253db46.1547801451.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc/8xx: replace most #ifdef by IS_ENABLED() in
 8xx_mmu.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 21 Jan 2019 11:34:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces most #ifdef mess by IS_ENABLED() in 8xx_mmu.c
This has the advantage of allowing syntax verification at compile
time regardless of selected options.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: left CONFIG_BDI_SWITCH change aside as it goes away in another patch

 arch/powerpc/mm/8xx_mmu.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index bfa503cff351..92b677faea8c 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -66,26 +66,22 @@ unsigned long p_block_mapped(phys_addr_t pa)
 void __init MMU_init_hw(void)
 {
 	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
-#ifdef CONFIG_PIN_TLB_DATA
-	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
-	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY;
-#ifdef CONFIG_PIN_TLB_IMMR
-	int i = 29;
-#else
-	int i = 28;
-#endif
-	unsigned long addr = 0;
-	unsigned long mem = total_lowmem;
-
-	for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
-		mtspr(SPRN_MD_CTR, ctr | (i << 8));
-		mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
-		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
-		mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
-		addr += LARGE_PAGE_SIZE_8M;
-		mem -= LARGE_PAGE_SIZE_8M;
+	if (IS_ENABLED(CONFIG_PIN_TLB_DATA)) {
+		unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
+		unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY;
+		int i = IS_ENABLED(CONFIG_PIN_TLB_IMMR) ? 29 : 28;
+		unsigned long addr = 0;
+		unsigned long mem = total_lowmem;
+
+		for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
+			mtspr(SPRN_MD_CTR, ctr | (i << 8));
+			mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
+			mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
+			mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
+			addr += LARGE_PAGE_SIZE_8M;
+			mem -= LARGE_PAGE_SIZE_8M;
+		}
 	}
-#endif
 }
 
 static void __init mmu_mapin_immr(void)
@@ -110,12 +106,10 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	if (__map_without_ltlbs) {
 		mapped = 0;
 		mmu_mapin_immr();
-#ifndef CONFIG_PIN_TLB_IMMR
-		patch_instruction_site(&patch__dtlbmiss_immr_jmp, PPC_INST_NOP);
-#endif
-#ifndef CONFIG_PIN_TLB_TEXT
-		mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, 0);
-#endif
+		if (!IS_ENABLED(CONFIG_PIN_TLB_IMMR))
+			patch_instruction_site(&patch__dtlbmiss_immr_jmp, PPC_INST_NOP);
+		if (!IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+			mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, 0);
 	} else {
 		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
 	}
-- 
2.13.3

