Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A122081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A122081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeLKRMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:12:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53580 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbeLKRMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:12:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E5581688;
        Tue, 11 Dec 2018 09:12:14 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 724853F6A8;
        Tue, 11 Dec 2018 09:12:12 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        anshuman.khandual@arm.com
Subject: [PATCH v10 4/8] KVM: arm64: Support dirty page tracking for PUD hugepages
Date:   Tue, 11 Dec 2018 17:10:37 +0000
Message-Id: <1544548241-6417-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punit.agrawal@arm.com>

In preparation for creating PUD hugepages at stage 2, add support for
write protecting PUD hugepages when they are encountered. Write
protecting guest tables is used to track dirty pages when migrating
VMs.

Also, provide trivial implementations of required kvm_s2pud_* helpers
to allow sharing of code with arm32.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
[ Replaced BUG() => WARN_ON() in arm32 pud helpers ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   | 15 +++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h | 10 ++++++++++
 virt/kvm/arm/mmu.c               | 11 +++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index e6eff8b..9fe6c30 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -87,6 +87,21 @@ void kvm_clear_hyp_idmap(void);
 
 #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
 
+/*
+ * The following kvm_*pud*() functions are provided strictly to allow
+ * sharing code with arm64. They should never be called in practice.
+ */
+static inline void kvm_set_s2pud_readonly(pud_t *pud)
+{
+	WARN_ON(1);
+}
+
+static inline bool kvm_s2pud_readonly(pud_t *pud)
+{
+	WARN_ON(1);
+	return false;
+}
+
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= L_PTE_S2_RDWR;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 13d4827..8da6d1b 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -251,6 +251,16 @@ static inline bool kvm_s2pmd_exec(pmd_t *pmdp)
 	return !(READ_ONCE(pmd_val(*pmdp)) & PMD_S2_XN);
 }
 
+static inline void kvm_set_s2pud_readonly(pud_t *pudp)
+{
+	kvm_set_s2pte_readonly((pte_t *)pudp);
+}
+
+static inline bool kvm_s2pud_readonly(pud_t *pudp)
+{
+	return kvm_s2pte_readonly((pte_t *)pudp);
+}
+
 #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
 
 #ifdef __PAGETABLE_PMD_FOLDED
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index fb5325f..1c669c3 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1347,9 +1347,12 @@ static void  stage2_wp_puds(struct kvm *kvm, pgd_t *pgd,
 	do {
 		next = stage2_pud_addr_end(kvm, addr, end);
 		if (!stage2_pud_none(kvm, *pud)) {
-			/* TODO:PUD not supported, revisit later if supported */
-			BUG_ON(stage2_pud_huge(kvm, *pud));
-			stage2_wp_pmds(kvm, pud, addr, next);
+			if (stage2_pud_huge(kvm, *pud)) {
+				if (!kvm_s2pud_readonly(pud))
+					kvm_set_s2pud_readonly(pud);
+			} else {
+				stage2_wp_pmds(kvm, pud, addr, next);
+			}
 		}
 	} while (pud++, addr = next, addr != end);
 }
@@ -1392,7 +1395,7 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
  *
  * Called to start logging dirty pages after memory region
  * KVM_MEM_LOG_DIRTY_PAGES operation is called. After this function returns
- * all present PMD and PTEs are write protected in the memory region.
+ * all present PUD, PMD and PTEs are write protected in the memory region.
  * Afterwards read of dirty page log can be called.
  *
  * Acquires kvm_mmu_lock. Called with kvm->slots_lock mutex acquired,
-- 
2.7.4

