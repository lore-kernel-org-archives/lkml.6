Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC34C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9098027E12
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9098027E12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754954AbeF2LUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:20:55 -0400
Received: from foss.arm.com ([217.140.101.70]:60184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965094AbeF2LQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:16:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC2918A;
        Fri, 29 Jun 2018 04:16:43 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 889DF3F266;
        Fri, 29 Jun 2018 04:16:40 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Christoffer Dall <cdall@arm.com>
Subject: [PATCH v3 11/20] kvm: arm64: Helper for computing VTCR_EL2.SL0
Date:   Fri, 29 Jun 2018 12:15:31 +0100
Message-Id: <1530270944-11351-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VTCR_EL2 holds the following key stage2 translation table
parameters:
  SL0  - Entry level in the page table lookup.
  T0SZ - Denotes the size of the memory addressed by the table.

We have been using fixed values for the SL0 depending on the
page size as we have a fixed IPA size. But since we are about
to make it dynamic, we need to calculate the SL0 at runtime
per VM. This patch adds a helper to comput the value of SL0 for
a given IPA.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - Part 2 of split from VTCR & VTTBR dynamic configuration
---
 arch/arm64/include/asm/kvm_arm.h | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index c557f45..11a7db0 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -153,7 +153,8 @@
  * 2 level page tables (SL = 1)
  */
 #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
-#define VTTBR_X_TGRAN_MAGIC		38
+#define VTCR_EL2_TGRAN_SL0_BASE		3UL
+
 #elif defined(CONFIG_ARM64_16K_PAGES)
 /*
  * Stage2 translation configuration:
@@ -161,7 +162,7 @@
  * 2 level page tables (SL = 1)
  */
 #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
-#define VTTBR_X_TGRAN_MAGIC		42
+#define VTCR_EL2_TGRAN_SL0_BASE		3UL
 #else	/* 4K */
 /*
  * Stage2 translation configuration:
@@ -169,11 +170,39 @@
  * 3 level page tables (SL = 1)
  */
 #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
-#define VTTBR_X_TGRAN_MAGIC		37
+#define VTCR_EL2_TGRAN_SL0_BASE		2UL
 #endif
 
 #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
 /*
+ * VTCR_EL2:SL0 indicates the entry level for Stage2 translation.
+ * Interestingly, it depends on the page size.
+ * See D.10.2.110, VTCR_EL2, in ARM DDI 0487B.b
+ *
+ *	-----------------------------------------
+ *	| Entry level		|  4K  | 16K/64K |
+ *	------------------------------------------
+ *	| Level: 0		|  2   |   -     |
+ *	------------------------------------------
+ *	| Level: 1		|  1   |   2     |
+ *	------------------------------------------
+ *	| Level: 2		|  0   |   1     |
+ *	------------------------------------------
+ *	| Level: 3		|  -   |   0     |
+ *	------------------------------------------
+ *
+ * That table roughly translates to :
+ *
+ *	SL0(PAGE_SIZE, Entry_level) = SL0_BASE(PAGE_SIZE) - Entry_Level
+ *
+ * Where SL0_BASE(4K) = 2 and SL0_BASE(16K) = 3, SL0_BASE(64K) = 3, provided
+ * we take care of ruling out the unsupported cases and
+ * Entry_Level = 4 - Number_of_levels.
+ *
+ */
+#define VTCR_EL2_SL0(levels) \
+	((VTCR_EL2_TGRAN_SL0_BASE - (4 - (levels))) << VTCR_EL2_SL0_SHIFT)
+/*
  * ARM VMSAv8-64 defines an algorithm for finding the translation table
  * descriptors in section D4.2.8 in ARM DDI 0487B.b.
  *
-- 
2.7.4

