Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DAAC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C9240F1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C9240F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeGEOJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:09:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50278 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753449AbeGEOJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:09:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0541518A;
        Thu,  5 Jul 2018 07:09:40 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE493F5BA;
        Thu,  5 Jul 2018 07:09:39 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 3/7] KVM: arm64: Support dirty page tracking for PUD hugepages
Date:   Thu,  5 Jul 2018 15:08:46 +0100
Message-Id: <20180705140850.5801-4-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705140850.5801-1-punit.agrawal@arm.com>
References: <20180705140850.5801-1-punit.agrawal@arm.com>
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/arm/include/asm/kvm_mmu.h   | 16 ++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h | 10 ++++++++++
 virt/kvm/arm/mmu.c               | 11 +++++++----
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index d095c2d0b284..c23722f75d5c 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -80,6 +80,22 @@ void kvm_clear_hyp_idmap(void);
 
 #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
 
+/*
+ * The following kvm_*pud*() functionas are provided strictly to allow
+ * sharing code with arm64. They should never be called in practice.
+ */
+static inline void kvm_set_s2pud_readonly(pud_t *pud)
+{
+	BUG();
+}
+
+static inline bool kvm_s2pud_readonly(pud_t *pud)
+{
+	BUG();
+	return false;
+}
+
+
 static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
 {
 	*pmd = new_pmd;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 689def9bb9d5..84051930ddfe 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -239,6 +239,16 @@ static inline bool kvm_s2pmd_exec(pmd_t *pmdp)
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
 static inline bool kvm_page_empty(void *ptr)
 {
 	struct page *ptr_page = virt_to_page(ptr);
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 040cd0bce5e1..db04b18218c1 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1288,9 +1288,12 @@ static void  stage2_wp_puds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
 	do {
 		next = stage2_pud_addr_end(addr, end);
 		if (!stage2_pud_none(*pud)) {
-			/* TODO:PUD not supported, revisit later if supported */
-			BUG_ON(stage2_pud_huge(*pud));
-			stage2_wp_pmds(pud, addr, next);
+			if (stage2_pud_huge(*pud)) {
+				if (!kvm_s2pud_readonly(pud))
+					kvm_set_s2pud_readonly(pud);
+			} else {
+				stage2_wp_pmds(pud, addr, next);
+			}
 		}
 	} while (pud++, addr = next, addr != end);
 }
@@ -1333,7 +1336,7 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
  *
  * Called to start logging dirty pages after memory region
  * KVM_MEM_LOG_DIRTY_PAGES operation is called. After this function returns
- * all present PMD and PTEs are write protected in the memory region.
+ * all present PUD, PMD and PTEs are write protected in the memory region.
  * Afterwards read of dirty page log can be called.
  *
  * Acquires kvm_mmu_lock. Called with kvm->slots_lock mutex acquired,
-- 
2.17.1

