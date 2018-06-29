Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B59C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187D427DB1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187D427DB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeF2LQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:16:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755201AbeF2LQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:16:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6651A1684;
        Fri, 29 Jun 2018 04:16:24 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F87C3F266;
        Fri, 29 Jun 2018 04:16:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 04/20] kvm: arm64: Clean up VTCR_EL2 initialisation
Date:   Fri, 29 Jun 2018 12:15:24 +0100
Message-Id: <1530270944-11351-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper for converting the parange to the physical shift.
Also, add the missing definitions for the VTCR_EL2 register fields
and use them instead of hard coding numbers.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V2
 - Part 2 of the split from original patch.
 - Also add missing VTCR field helpers and use them.
---
 arch/arm64/include/asm/kvm_arm.h |  3 +++
 arch/arm64/kvm/hyp/s2-setup.c    | 30 ++++++------------------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6dd285e..3dffd38 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -106,6 +106,7 @@
 #define VTCR_EL2_RES1		(1 << 31)
 #define VTCR_EL2_HD		(1 << 22)
 #define VTCR_EL2_HA		(1 << 21)
+#define VTCR_EL2_PS_SHIFT	TCR_EL2_PS_SHIFT
 #define VTCR_EL2_PS_MASK	TCR_EL2_PS_MASK
 #define VTCR_EL2_TG0_MASK	TCR_TG0_MASK
 #define VTCR_EL2_TG0_4K		TCR_TG0_4K
@@ -126,6 +127,8 @@
 #define VTCR_EL2_VS_8BIT	(0 << VTCR_EL2_VS_SHIFT)
 #define VTCR_EL2_VS_16BIT	(1 << VTCR_EL2_VS_SHIFT)
 
+#define VTCR_EL2_T0SZ(x)	TCR_T0SZ(x)
+
 /*
  * We configure the Stage-2 page tables to always restrict the IPA space to be
  * 40 bits wide (T0SZ = 24).  Systems with a PARange smaller than 40 bits are
diff --git a/arch/arm64/kvm/hyp/s2-setup.c b/arch/arm64/kvm/hyp/s2-setup.c
index 603e1ee..81094f1 100644
--- a/arch/arm64/kvm/hyp/s2-setup.c
+++ b/arch/arm64/kvm/hyp/s2-setup.c
@@ -19,11 +19,13 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
+#include <asm/cpufeature.h>
 
 u32 __hyp_text __init_stage2_translation(void)
 {
 	u64 val = VTCR_EL2_FLAGS;
 	u64 parange;
+	u32 phys_shift;
 	u64 tmp;
 
 	/*
@@ -34,30 +36,10 @@ u32 __hyp_text __init_stage2_translation(void)
 	parange = read_sysreg(id_aa64mmfr0_el1) & 7;
 	if (parange > ID_AA64MMFR0_PARANGE_MAX)
 		parange = ID_AA64MMFR0_PARANGE_MAX;
-	val |= parange << 16;
+	val |= parange << VTCR_EL2_PS_SHIFT;
 
 	/* Compute the actual PARange... */
-	switch (parange) {
-	case 0:
-		parange = 32;
-		break;
-	case 1:
-		parange = 36;
-		break;
-	case 2:
-		parange = 40;
-		break;
-	case 3:
-		parange = 42;
-		break;
-	case 4:
-		parange = 44;
-		break;
-	case 5:
-	default:
-		parange = 48;
-		break;
-	}
+	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
 
 	/*
 	 * ... and clamp it to 40 bits, unless we have some braindead
@@ -65,7 +47,7 @@ u32 __hyp_text __init_stage2_translation(void)
 	 * return that value for the rest of the kernel to decide what
 	 * to do.
 	 */
-	val |= 64 - (parange > 40 ? 40 : parange);
+	val |= VTCR_EL2_T0SZ(phys_shift > 40 ? 40 : phys_shift);
 
 	/*
 	 * Check the availability of Hardware Access Flag / Dirty Bit
@@ -86,5 +68,5 @@ u32 __hyp_text __init_stage2_translation(void)
 
 	write_sysreg(val, vtcr_el2);
 
-	return parange;
+	return phys_shift;
 }
-- 
2.7.4

