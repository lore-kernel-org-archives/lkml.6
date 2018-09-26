Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C7EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3721536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA3721536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeIZWsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:48:00 -0400
Received: from foss.arm.com ([217.140.101.70]:50164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbeIZWsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:48:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A32641684;
        Wed, 26 Sep 2018 09:34:14 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AE933F5B3;
        Wed, 26 Sep 2018 09:34:12 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        suzuki.poulose@arm.com, will.deacon@arm.com, dave.martin@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/18] kvm: arm64: Limit the minimum number of page table levels
Date:   Wed, 26 Sep 2018 17:32:53 +0100
Message-Id: <20180926163258.20218-18-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926163258.20218-1-suzuki.poulose@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are about to remove the lower limit on the IPA size,
make sure that we do not go to 1 level page table (e.g, with
32bit IPA on 64K host with concatenation) to avoid splitting
the host PMD huge pages at stage2.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Change since v5:
 - Cosmetic changes to the comment
 - Remove unnecessary new line
---
 arch/arm64/include/asm/stage2_pgtable.h |  7 ++++++-
 arch/arm64/kvm/reset.c                  | 10 +++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index c62fe118a898..2cce769ba4c6 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -72,8 +72,13 @@
 /*
  * The number of PTRS across all concatenated stage2 tables given by the
  * number of bits resolved at the initial level.
+ * If we force more levels than necessary, we may have (stage2_pgdir_shift > IPA),
+ * in which case, stage2_pgd_ptrs will have one entry.
  */
-#define __s2_pgd_ptrs(ipa, lvls)	(1 << ((ipa) - pt_levels_pgdir_shift((lvls))))
+#define pgd_ptrs_shift(ipa, pgdir_shift)	\
+	((ipa) > (pgdir_shift) ? ((ipa) - (pgdir_shift)) : 0)
+#define __s2_pgd_ptrs(ipa, lvls)		\
+	(1 << (pgd_ptrs_shift((ipa), pt_levels_pgdir_shift(lvls))))
 #define __s2_pgd_size(ipa, lvls)	(__s2_pgd_ptrs((ipa), (lvls)) * sizeof(pgd_t))
 
 #define stage2_pgd_ptrs(kvm)		__s2_pgd_ptrs(kvm_phys_shift(kvm), kvm_stage2_levels(kvm))
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 96b3f50101bc..f156e45760bc 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -190,6 +190,7 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
 {
 	u64 vtcr = VTCR_EL2_FLAGS;
 	u32 parange, phys_shift;
+	u8 lvls;
 
 	if (type)
 		return -EINVAL;
@@ -203,7 +204,14 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
 	if (phys_shift > KVM_PHYS_SHIFT)
 		phys_shift = KVM_PHYS_SHIFT;
 	vtcr |= VTCR_EL2_T0SZ(phys_shift);
-	vtcr |= VTCR_EL2_LVLS_TO_SL0(stage2_pgtable_levels(phys_shift));
+	/*
+	 * Use a minimum 2 level page table to prevent splitting
+	 * host PMD huge pages at stage2.
+	 */
+	lvls = stage2_pgtable_levels(phys_shift);
+	if (lvls < 2)
+		lvls = 2;
+	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
 
 	/*
 	 * Enable the Hardware Access Flag management, unconditionally
-- 
2.19.0

