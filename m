Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B958C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27587206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfAHOJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:09:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52506 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbfAHOI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C948680D;
        Tue,  8 Jan 2019 06:08:58 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCAF93F70D;
        Tue,  8 Jan 2019 06:08:56 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v8 26/26] arm64: Enable the support of pseudo-NMIs
Date:   Tue,  8 Jan 2019 14:07:44 +0000
Message-Id: <1546956464-48825-27-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a build option and a command line parameter to build and enable the
support of pseudo-NMIs.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 arch/arm64/Kconfig                              | 14 ++++++++++++++
 arch/arm64/kernel/cpufeature.c                  | 11 ++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf..173e2cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1197,6 +1197,12 @@
 			to discrete, to make X server driver able to add WB
 			entry later. This parameter enables that.
 
+	enable_pseudo_nmi [ARM64]
+			Enables support for pseudo-NMIs in the kernel. This
+			requires both the kernel to be built with
+			CONFIG_ARM64_PSEUDO_NMI and to be running on a
+			platform with GICv3.
+
 	enable_timer_pin_1 [X86]
 			Enable PIN 1 of APIC timer
 			Can be useful to work around chipset bugs
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d3..8d84bfd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1328,6 +1328,20 @@ config ARM64_MODULE_PLTS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
 
+config ARM64_PSEUDO_NMI
+	bool "Support for NMI-like interrupts"
+	select CONFIG_ARM_GIC_V3
+	help
+	  Adds support for mimicking Non-Maskable Interrupts through the use of
+	  GIC interrupt priority. This support requires version 3 or later of
+	  Arm GIC.
+
+	  This high priority configuration for interrupts need to be
+	  explicitly enabled through the new kernel parameter
+	  "enable_pseudo_nmi".
+
+	  If unsure, say N
+
 config RELOCATABLE
 	bool
 	help
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 71c8d4f..9df1217 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1202,10 +1202,19 @@ static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 #ifdef CONFIG_ARM64_PSEUDO_NMI
+static bool enable_pseudo_nmi;
+
+static int __init early_enable_pseudo_nmi(char *p)
+{
+	enable_pseudo_nmi = true;
+	return 0;
+}
+early_param("enable_pseudo_nmi", early_enable_pseudo_nmi);
+
 static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 				   int scope)
 {
-	return false;
+	return enable_pseudo_nmi && has_useable_gicv3_cpuif(entry, scope);
 }
 #endif
 
-- 
1.9.1

