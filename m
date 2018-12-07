Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE7EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA9F20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA9F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLGSkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:40:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51956 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeLGSkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:40:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857DD15BE;
        Fri,  7 Dec 2018 10:40:07 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D10D3F5AF;
        Fri,  7 Dec 2018 10:40:04 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/13] arm64: add pointer authentication register bits
Date:   Fri,  7 Dec 2018 18:39:20 +0000
Message-Id: <20181207183931.4285-3-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

The ARMv8.3 pointer authentication extension adds:

* New fields in ID_AA64ISAR1 to report the presence of pointer
  authentication functionality.

* New control bits in SCTLR_ELx to enable this functionality.

* New system registers to hold the keys necessary for this
  functionality.

* A new ESR_ELx.EC code used when the new instructions are affected by
  configurable traps

This patch adds the relevant definitions to <asm/sysreg.h> and
<asm/esr.h> for these, to be used by subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/esr.h    |  3 ++-
 arch/arm64/include/asm/sysreg.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 23602a0083ad..52233f00d53d 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -30,7 +30,8 @@
 #define ESR_ELx_EC_CP14_LS	(0x06)
 #define ESR_ELx_EC_FP_ASIMD	(0x07)
 #define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
-/* Unallocated EC: 0x09 - 0x0B */
+#define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
+/* Unallocated EC: 0x0A - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
 /* Unallocated EC: 0x0d */
 #define ESR_ELx_EC_ILL		(0x0E)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 842fb9572661..cb6d7a2a2316 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -183,6 +183,19 @@
 #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
 #define SYS_TCR_EL1			sys_reg(3, 0, 2, 0, 2)
 
+#define SYS_APIAKEYLO_EL1		sys_reg(3, 0, 2, 1, 0)
+#define SYS_APIAKEYHI_EL1		sys_reg(3, 0, 2, 1, 1)
+#define SYS_APIBKEYLO_EL1		sys_reg(3, 0, 2, 1, 2)
+#define SYS_APIBKEYHI_EL1		sys_reg(3, 0, 2, 1, 3)
+
+#define SYS_APDAKEYLO_EL1		sys_reg(3, 0, 2, 2, 0)
+#define SYS_APDAKEYHI_EL1		sys_reg(3, 0, 2, 2, 1)
+#define SYS_APDBKEYLO_EL1		sys_reg(3, 0, 2, 2, 2)
+#define SYS_APDBKEYHI_EL1		sys_reg(3, 0, 2, 2, 3)
+
+#define SYS_APGAKEYLO_EL1		sys_reg(3, 0, 2, 3, 0)
+#define SYS_APGAKEYHI_EL1		sys_reg(3, 0, 2, 3, 1)
+
 #define SYS_ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
 
 #define SYS_AFSR0_EL1			sys_reg(3, 0, 5, 1, 0)
@@ -432,9 +445,13 @@
 
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_DSSBS	(1UL << 44)
+#define SCTLR_ELx_ENIA	(1 << 31)
+#define SCTLR_ELx_ENIB	(1 << 30)
+#define SCTLR_ELx_ENDA	(1 << 27)
 #define SCTLR_ELx_EE    (1 << 25)
 #define SCTLR_ELx_IESB	(1 << 21)
 #define SCTLR_ELx_WXN	(1 << 19)
+#define SCTLR_ELx_ENDB	(1 << 13)
 #define SCTLR_ELx_I	(1 << 12)
 #define SCTLR_ELx_SA	(1 << 3)
 #define SCTLR_ELx_C	(1 << 2)
@@ -528,11 +545,24 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64isar1 */
+#define ID_AA64ISAR1_GPI_SHIFT		28
+#define ID_AA64ISAR1_GPA_SHIFT		24
 #define ID_AA64ISAR1_LRCPC_SHIFT	20
 #define ID_AA64ISAR1_FCMA_SHIFT		16
 #define ID_AA64ISAR1_JSCVT_SHIFT	12
+#define ID_AA64ISAR1_API_SHIFT		8
+#define ID_AA64ISAR1_APA_SHIFT		4
 #define ID_AA64ISAR1_DPB_SHIFT		0
 
+#define ID_AA64ISAR1_APA_NI		0x0
+#define ID_AA64ISAR1_APA_ARCHITECTED	0x1
+#define ID_AA64ISAR1_API_NI		0x0
+#define ID_AA64ISAR1_API_IMP_DEF	0x1
+#define ID_AA64ISAR1_GPA_NI		0x0
+#define ID_AA64ISAR1_GPA_ARCHITECTED	0x1
+#define ID_AA64ISAR1_GPI_NI		0x0
+#define ID_AA64ISAR1_GPI_IMP_DEF	0x1
+
 /* id_aa64pfr0 */
 #define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_CSV2_SHIFT		56
-- 
2.11.0

