Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FEAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCD9214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfAJPL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:11:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:53280 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfAJPLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:11:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43b8br0CZdz9v0f9;
        Thu, 10 Jan 2019 16:11:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id es62tmCoB7hB; Thu, 10 Jan 2019 16:11:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43b8bq6r0Cz9v0f8;
        Thu, 10 Jan 2019 16:11:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EF898B89F;
        Thu, 10 Jan 2019 16:11:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4jEjxP4PCT1L; Thu, 10 Jan 2019 16:11:53 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 359DB8B898;
        Thu, 10 Jan 2019 16:11:53 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 005A76BF21; Thu, 10 Jan 2019 15:11:52 +0000 (UTC)
Message-Id: <92a11828c9560a29f999e2333a936a326bfdbc77.1547132681.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1547132681.git.christophe.leroy@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/15] powerpc/mm/32s: add setibat() clearibat() and
 update_bats()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 10 Jan 2019 15:11:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setibat() and clearibat() allows to manipulate IBATs independently
of DBATs.

update_bats() allows to update bats after init. This is done
with MMU off.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 ++
 arch/powerpc/kernel/head_32.S                 | 35 +++++++++++++++++++++++++++
 arch/powerpc/mm/ppc_mmu_32.c                  | 32 ++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 0c261ba2c826..5cb588395fdc 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -92,6 +92,8 @@ typedef struct {
 	unsigned long vdso_base;
 } mm_context_t;
 
+void update_bats(void);
+
 /* patch sites */
 extern s32 patch__hash_page_A0, patch__hash_page_A1, patch__hash_page_A2;
 extern s32 patch__hash_page_B, patch__hash_page_C;
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 05b08db3901d..51cc40a632e0 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1105,6 +1105,41 @@ BEGIN_MMU_FTR_SECTION
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	blr
 
+_ENTRY(update_bats)
+	lis	r4, 1f@h
+	ori	r4, r4, 1f@l
+	tophys(r4, r4)
+	mfmsr	r6
+	mflr	r7
+	li	r3, MSR_KERNEL & ~(MSR_IR | MSR_DR)
+	rlwinm	r0, r6, 0, ~MSR_RI
+	rlwinm	r0, r0, 0, ~MSR_EE
+	mtmsr	r0
+	mtspr	SPRN_SRR0, r4
+	mtspr	SPRN_SRR1, r3
+	SYNC
+	RFI
+1:	bl	clear_bats
+	lis	r3, BATS@ha
+	addi	r3, r3, BATS@l
+	tophys(r3, r3)
+	LOAD_BAT(0, r3, r4, r5)
+	LOAD_BAT(1, r3, r4, r5)
+	LOAD_BAT(2, r3, r4, r5)
+	LOAD_BAT(3, r3, r4, r5)
+BEGIN_MMU_FTR_SECTION
+	LOAD_BAT(4, r3, r4, r5)
+	LOAD_BAT(5, r3, r4, r5)
+	LOAD_BAT(6, r3, r4, r5)
+	LOAD_BAT(7, r3, r4, r5)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
+	li	r3, MSR_KERNEL & ~(MSR_IR | MSR_DR | MSR_RI)
+	mtmsr	r3
+	mtspr	SPRN_SRR0, r7
+	mtspr	SPRN_SRR1, r6
+	SYNC
+	RFI
+
 flush_tlbs:
 	lis	r10, 0x40
 1:	addic.	r10, r10, -0x1000
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 42320688e415..b690bf01312c 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -106,6 +106,38 @@ static unsigned int block_size(unsigned long base, unsigned long top)
 	return min3(max_size, 1U << base_shift, 1U << block_shift);
 }
 
+/*
+ * Set up one of the IBAT (block address translation) register pairs.
+ * The parameters are not checked; in particular size must be a power
+ * of 2 between 128k and 256M.
+ * Only for 603+ ...
+ */
+static void setibat(int index, unsigned long virt, phys_addr_t phys,
+		    unsigned int size, pgprot_t prot)
+{
+	unsigned int bl = (size >> 17) - 1;
+	int wimgxpp;
+	struct ppc_bat *bat = BATS[index];
+	unsigned long flags = pgprot_val(prot);
+
+	if (!cpu_has_feature(CPU_FTR_NEED_COHERENT))
+		flags &= ~_PAGE_COHERENT;
+
+	wimgxpp = (flags & _PAGE_COHERENT) | (_PAGE_EXEC ? BPP_RX : BPP_XX);
+	bat[0].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
+	bat[0].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
+	if (flags & _PAGE_USER)
+		bat[0].batu |= 1;	/* Vp = 1 */
+}
+
+static void clearibat(int index)
+{
+	struct ppc_bat *bat = BATS[index];
+
+	bat[0].batu = 0;
+	bat[0].batl = 0;
+}
+
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	int idx;
-- 
2.13.3

