Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155AECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23717214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23717214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeIQQJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:09:58 -0400
Received: from foss.arm.com ([217.140.101.70]:56652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbeIQQJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:09:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006311BB2;
        Mon, 17 Sep 2018 03:43:10 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79B7E3F5BD;
        Mon, 17 Sep 2018 03:43:07 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, will.deacon@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, dave.martin@arm.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH v5 17/18] kvm: arm64: Limit the minimum number of page table levels
Date:   Mon, 17 Sep 2018 11:41:39 +0100
Message-Id: <20180917104144.19188-18-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917104144.19188-1-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
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
 arch/arm64/include/asm/stage2_pgtable.h |  8 +++++++-
 arch/arm64/kvm/reset.c                  | 12 +++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 352ec4158fdf..6a56fdff0823 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -72,8 +72,14 @@
 /*
  * The number of PTRS across all concatenated stage2 tables given by the
  * number of bits resolved at the initial level.
+ * If we force more number of levels than necessary, we may have
+ * stage2_pgdir_shift > IPA, in which case, stage2_pgd_ptrs will have
+ * one entry.
  */
-#define __s2_pgd_ptrs(ipa, lvls)	(1 << ((ipa) - pt_levels_pgdir_shift((lvls))))
+#define pgd_ptrs_shift(ipa, pgdir_shift)	\
+	((ipa) > (pgdir_shift) ? ((ipa) - (pgdir_shift)) : 0)
+#define __s2_pgd_ptrs(ipa, lvls)		\
+	(1 << (pgd_ptrs_shift((ipa), pt_levels_pgdir_shift(lvls))))
 #define __s2_pgd_size(ipa, lvls)	(__s2_pgd_ptrs((ipa), (lvls)) * sizeof(pgd_t))
 
 #define stage2_pgd_ptrs(kvm)		__s2_pgd_ptrs(kvm_phys_shift(kvm), kvm_stage2_levels(kvm))
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 76972b19bdd7..0393bb974b23 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -190,10 +190,19 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
 {
 	u64 vtcr = VTCR_EL2_FLAGS;
 	u64 parange;
+	u8 lvls;
 
 	if (type)
 		return -EINVAL;
 
+	/*
+	 * Use a minimum 2 level page table to prevent splitting
+	 * host PMD huge pages at stage2.
+	 */
+	lvls = stage2_pgtable_levels(KVM_PHYS_SHIFT);
+	if (lvls < 2)
+		lvls = 2;
+
 	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
 	if (parange > ID_AA64MMFR0_PARANGE_MAX)
 		parange = ID_AA64MMFR0_PARANGE_MAX;
@@ -210,7 +219,8 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
 	vtcr |= (kvm_get_vmid_bits() == 16) ?
 		VTCR_EL2_VS_16BIT :
 		VTCR_EL2_VS_8BIT;
-	vtcr |= VTCR_EL2_LVLS_TO_SL0(stage2_pgtable_levels(KVM_PHYS_SHIFT));
+
+	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
 	vtcr |= VTCR_EL2_T0SZ(KVM_PHYS_SHIFT);
 
 	kvm->arch.vtcr = vtcr;
-- 
2.19.0

