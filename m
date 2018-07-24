Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C84ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54DC2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRPGxVEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54DC2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbeGXR5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388414AbeGXR5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:48 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E19A020882;
        Tue, 24 Jul 2018 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532451026;
        bh=xWLknxL1PDXVCqTR6qH5NCeCvJ9qCdNL8y3YzjJn6Gk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dRPGxVEtpDLYG0bzW3UVVTBEr1eNh0amammxdUwBw9CoGvOk54ld1nNpPu0+gzxCZ
         BNL+y/s3R78EAGGzi+oD0D58Ubx1swKOzOV+kJshX7EKGTpx0TIv34i9pOlKa6ivAN
         p6P3S5bEpQAhqGfEP/Zjmo/dJOMGciRvVIde29VU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: exynos: Store Exynos5420 register state in one variable
Date:   Tue, 24 Jul 2018 18:49:44 +0200
Message-Id: <20180724164946.6274-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180724164946.6274-1-krzk@kernel.org>
References: <20180724164946.6274-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of keeping two static variables put them into one struct which
later can grow.  This will reduce number of file-scope symbols.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
New patch.
---
 arch/arm/mach-exynos/suspend.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index d3db306a5a70..5d4822e5d0ba 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -59,10 +59,14 @@ struct exynos_pm_data {
 	int (*cpu_suspend)(unsigned long);
 };
 
-static const struct exynos_pm_data *pm_data __ro_after_init;
+/* Used only on Exynos542x/5800 */
+struct exynos_pm_state {
+	int cpu_state;
+	unsigned int pmu_spare3;
+};
 
-static int exynos5420_cpu_state;
-static unsigned int exynos_pmu_spare3;
+static const struct exynos_pm_data *pm_data __ro_after_init;
+static struct exynos_pm_state pm_state;
 
 /*
  * GIC wake-up support
@@ -320,7 +324,7 @@ static void exynos5420_pm_prepare(void)
 	/* Set wake-up mask registers */
 	exynos_pm_set_wakeup_mask();
 
-	exynos_pmu_spare3 = pmu_raw_readl(S5P_PMU_SPARE3);
+	pm_state.pmu_spare3 = pmu_raw_readl(S5P_PMU_SPARE3);
 	/*
 	 * The cpu state needs to be saved and restored so that the
 	 * secondary CPUs will enter low power start. Though the U-Boot
@@ -328,8 +332,8 @@ static void exynos5420_pm_prepare(void)
 	 * needs to restore it back in case, the primary cpu fails to
 	 * suspend for any reason.
 	 */
-	exynos5420_cpu_state = readl_relaxed(sysram_base_addr +
-					     EXYNOS5420_CPU_STATE);
+	pm_state.cpu_state = readl_relaxed(sysram_base_addr +
+					   EXYNOS5420_CPU_STATE);
 
 	exynos_pm_enter_sleep_mode();
 
@@ -447,7 +451,7 @@ static void exynos5420_pm_resume(void)
 		       EXYNOS5_ARM_CORE0_SYS_PWR_REG);
 
 	/* Restore the sysram cpu state register */
-	writel_relaxed(exynos5420_cpu_state,
+	writel_relaxed(pm_state.cpu_state,
 		       sysram_base_addr + EXYNOS5420_CPU_STATE);
 
 	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
@@ -456,7 +460,7 @@ static void exynos5420_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	pmu_raw_writel(exynos_pmu_spare3, S5P_PMU_SPARE3);
+	pmu_raw_writel(pm_state.pmu_spare3, S5P_PMU_SPARE3);
 
 early_wakeup:
 
-- 
2.14.1

