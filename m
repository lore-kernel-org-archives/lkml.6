Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8659E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeLLQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:48:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbeLLQr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:47:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738F31688;
        Wed, 12 Dec 2018 08:47:59 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83F553F575;
        Wed, 12 Dec 2018 08:47:57 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v7 05/25] arm/arm64: gic-v3: Add PMR and RPR accessors
Date:   Wed, 12 Dec 2018 16:47:05 +0000
Message-Id: <1544633245-6036-6-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions to access system registers related to interrupt
priorities: PMR and RPR.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 16 ++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 0bd5307..bef0b5d 100644
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
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index e278f94..37193e2 100644
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
-- 
1.9.1

