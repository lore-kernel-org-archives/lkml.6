Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BFFECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E33E21530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E33E21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeIZWrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:47:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50104 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbeIZWrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:47:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1EF7A9;
        Wed, 26 Sep 2018 09:34:03 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C98AA3F5B3;
        Wed, 26 Sep 2018 09:34:00 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        suzuki.poulose@arm.com, will.deacon@arm.com, dave.martin@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/18] kvm: arm64: Switch to per VM IPA limit
Date:   Wed, 26 Sep 2018 17:32:49 +0100
Message-Id: <20180926163258.20218-14-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926163258.20218-1-suzuki.poulose@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can manage the stage2 page table per VM, switch the
configuration details to per VM instance. The VTCR is updated
with the values specific to the VM based on the configuration.
We store the IPA size and the number of stage2 page table levels
for the guest already in VTCR. Decode it back from the vtcr
field wherever we need it.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h        | 2 ++
 arch/arm64/include/asm/kvm_mmu.h        | 2 +-
 arch/arm64/include/asm/stage2_pgtable.h | 2 +-
 arch/arm64/kvm/reset.c                  | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index f913adb44f93..e4240568cc18 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -197,6 +197,8 @@
 	VTCR_EL2_SL0_TO_LVLS(((vtcr) & VTCR_EL2_SL0_MASK) >> VTCR_EL2_SL0_SHIFT)
 
 #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN)
+#define VTCR_EL2_IPA(vtcr)		(64 - ((vtcr) & VTCR_EL2_T0SZ_MASK))
+
 /*
  * ARM VMSAv8-64 defines an algorithm for finding the translation table
  * descriptors in section D4.2.8 in ARM DDI 0487C.a.
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index ac3ca9690bad..77b1af9e64db 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -142,7 +142,7 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
  */
 #define KVM_PHYS_SHIFT	(40)
 
-#define kvm_phys_shift(kvm)		KVM_PHYS_SHIFT
+#define kvm_phys_shift(kvm)		VTCR_EL2_IPA(kvm->arch.vtcr)
 #define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
 #define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - _AC(1, ULL))
 
diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 36a0a1165003..c62fe118a898 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -43,7 +43,7 @@
  */
 #define stage2_pgtable_levels(ipa)	ARM64_HW_PGTABLE_LEVELS((ipa) - 4)
 #define STAGE2_PGTABLE_LEVELS		stage2_pgtable_levels(KVM_PHYS_SHIFT)
-#define kvm_stage2_levels(kvm)		stage2_pgtable_levels(kvm_phys_shift(kvm))
+#define kvm_stage2_levels(kvm)		VTCR_EL2_LVLS(kvm->arch.vtcr)
 
 /*
  * With all the supported VA_BITs and 40bit guest IPA, the following condition
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 1ced1e37374e..2bf41e007390 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -160,7 +160,7 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
 	if (phys_shift > KVM_PHYS_SHIFT)
 		phys_shift = KVM_PHYS_SHIFT;
 	vtcr |= VTCR_EL2_T0SZ(phys_shift);
-	vtcr |= VTCR_EL2_LVLS_TO_SL0(kvm_stage2_levels(kvm));
+	vtcr |= VTCR_EL2_LVLS_TO_SL0(stage2_pgtable_levels(phys_shift));
 
 	/*
 	 * Enable the Hardware Access Flag management, unconditionally
-- 
2.19.0

