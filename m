Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A2DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864982084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864982084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeH1Tog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:36 -0400
Received: from foss.arm.com ([217.140.101.70]:41038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1Tof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFF1E80D;
        Tue, 28 Aug 2018 08:52:18 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDC7A3F557;
        Tue, 28 Aug 2018 08:52:16 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v5 13/27] arm/arm64: gic-v3: Add helper functions to manage IRQ priorities
Date:   Tue, 28 Aug 2018 16:51:23 +0100
Message-Id: <1535471497-38854-14-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to check if priority masking is supported and accessors
for PMR/RPR.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 21 +++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 0bd5307..58d5d3e 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -34,6 +34,7 @@
 #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
 #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
 #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
+#define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)

 #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
 #define ICC_AP0R0			__ICC_AP0Rx(0)
@@ -245,6 +246,21 @@ static inline void gic_write_bpr1(u32 val)
 	write_sysreg(val, ICC_BPR1);
 }

+static inline u32 gic_read_pmr(void)
+{
+	return read_sysreg(ICC_PMR);
+}
+
+static inline void gic_write_pmr(u32 val)
+{
+	write_sysreg(val, ICC_PMR);
+}
+
+static inline u32 gic_read_rpr(void)
+{
+	return read_sysreg(ICC_RPR);
+}
+
 /*
  * Even in 32bit systems that use LPAE, there is no guarantee that the I/O
  * interface provides true 64bit atomic accesses, so using strd/ldrd doesn't
@@ -347,5 +363,10 @@ static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)

 #define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)

+static inline bool gic_prio_masking_enabled(void)
+{
+	return false;
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index e278f94..19a5b1f 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -114,6 +114,21 @@ static inline void gic_write_bpr1(u32 val)
 	write_sysreg_s(val, SYS_ICC_BPR1_EL1);
 }

+static inline u32 gic_read_pmr(void)
+{
+	return read_sysreg_s(SYS_ICC_PMR_EL1);
+}
+
+static inline void gic_write_pmr(u32 val)
+{
+	write_sysreg_s(val, SYS_ICC_PMR_EL1);
+}
+
+static inline u32 gic_read_rpr(void)
+{
+	return read_sysreg_s(SYS_ICC_RPR_EL1);
+}
+
 #define gic_read_typer(c)		readq_relaxed(c)
 #define gic_write_irouter(v, c)		writeq_relaxed(v, c)
 #define gic_read_lpir(c)		readq_relaxed(c)
@@ -140,5 +155,11 @@ static inline void gic_write_bpr1(u32 val)
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)

+static inline bool gic_prio_masking_enabled(void)
+{
+	return IS_ENABLED(CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS)
+	       && cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
--
1.9.1
