Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B10FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B0227DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B0227DCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935994AbeF2LRM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:17:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60332 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965425AbeF2LRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:17:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69DB415AD;
        Fri, 29 Jun 2018 04:17:07 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12B433F266;
        Fri, 29 Jun 2018 04:17:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 20/20] kvm: arm64: Fall back to normal stage2 entry level
Date:   Fri, 29 Jun 2018 12:15:40 +0100
Message-Id: <1530270944-11351-21-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use concatenated entry level page tables (upto 16tables) for
stage2. If we don't have sufficient contiguous pages (e.g, 16 * 64K),
fallback to the normal page table format, by going one level
deeper if permitted.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
New in v3
---
 arch/arm64/include/asm/kvm_arm.h |  7 +++++++
 arch/arm64/include/asm/kvm_mmu.h | 18 +----------------
 arch/arm64/kvm/guest.c           | 42 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index cb6a2ee..42eb528 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -137,6 +137,8 @@
  *
  * VTCR_EL2.SL0 and T0SZ are configured per VM at runtime before switching to
  * the VM.
+ *
+ * With 16k/64k, the maximum number of levels supported at Stage2 is 3.
  */
 
 #define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
@@ -150,6 +152,7 @@
  */
 #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_64K
 #define VTCR_EL2_TGRAN_SL0_BASE		3UL
+#define ARM64_TGRAN_STAGE2_MAX_LEVELS	3
 
 #elif defined(CONFIG_ARM64_16K_PAGES)
 /*
@@ -158,6 +161,8 @@
  */
 #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_16K
 #define VTCR_EL2_TGRAN_SL0_BASE		3UL
+#define ARM64_TGRAN_STAGE2_MAX_LEVELS	3
+
 #else	/* 4K */
 /*
  * Stage2 translation configuration:
@@ -165,6 +170,8 @@
  */
 #define VTCR_EL2_TGRAN			VTCR_EL2_TG0_4K
 #define VTCR_EL2_TGRAN_SL0_BASE		2UL
+#define ARM64_TGRAN_STAGE2_MAX_LEVELS	4
+
 #endif
 
 #define VTCR_EL2_FLAGS		(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN)
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index d38f395..50f632e 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -527,23 +527,7 @@ static inline u64 kvm_vttbr_baddr_mask(struct kvm *kvm)
 	return vttbr_baddr_mask(kvm_phys_shift(kvm), kvm_stage2_levels(kvm));
 }
 
-static inline void *stage2_alloc_pgd(struct kvm *kvm)
-{
-	u32 ipa, lvls;
-
-	/*
-	 * Stage2 page table can support concatenation of (upto 16) tables
-	 * at the entry level, thereby reducing the number of levels.
-	 */
-	ipa = kvm_phys_shift(kvm);
-	lvls = stage2_pt_levels(ipa);
-
-	kvm->arch.s2_levels = lvls;
-	kvm->arch.vtcr_private = VTCR_EL2_SL0(lvls) | TCR_T0SZ(ipa);
-
-	return alloc_pages_exact(stage2_pgd_size(kvm),
-				 GFP_KERNEL | __GFP_ZERO);
-}
+extern void *stage2_alloc_pgd(struct kvm *kvm);
 
 static inline u32 kvm_get_ipa_limit(void)
 {
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 56a0260..5a3a687 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -31,6 +31,8 @@
 #include <asm/kvm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_mmu.h>
+#include <asm/pgtable-hwdef.h>
 
 #include "trace.h"
 
@@ -458,3 +460,43 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 
 	return ret;
 }
+
+void *stage2_alloc_pgd(struct kvm *kvm)
+{
+	u32 ipa, s2_lvls, lvls;
+	u64 pgd_size;
+	void *pgd;
+
+	/*
+	 * Stage2 page table can support concatenation of (upto 16) tables
+	 * at the entry level, thereby reducing the number of levels. We try
+	 * to use concatenation wherever possible. If we fail, fallback to
+	 * normal levels if possible.
+	 */
+	ipa = kvm_phys_shift(kvm);
+	lvls = s2_lvls = stage2_pt_levels(ipa);
+
+retry:
+	pgd_size = __s2_pgd_size(ipa, lvls);
+	pgd = alloc_pages_exact(pgd_size, GFP_KERNEL | __GFP_ZERO);
+
+	/* Check if the PGD meets the alignment requirements */
+	if (pgd && (virt_to_phys(pgd) & ~vttbr_baddr_mask(ipa, lvls))) {
+		free_pages_exact(pgd, pgd_size);
+		pgd = NULL;
+	}
+
+	if (pgd) {
+		kvm->arch.s2_levels = lvls;
+		kvm->arch.vtcr_private = VTCR_EL2_SL0(lvls) | TCR_T0SZ(ipa);
+	} else {
+		/* Check if we can use an entry level without concatenation */
+		lvls = ARM64_HW_PGTABLE_LEVELS(ipa);
+		if ((lvls > s2_lvls) &&
+		    (lvls <= CONFIG_PGTABLE_LEVELS) &&
+		    (lvls <= ARM64_TGRAN_STAGE2_MAX_LEVELS))
+			goto retry;
+	}
+
+	return pgd;
+}
-- 
2.7.4

