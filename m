Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3142088E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xOn+Clyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3142088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbeGXR5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbeGXR5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:53 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99AE220875;
        Tue, 24 Jul 2018 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532451031;
        bh=G+pdJvrgoJEK2XNhPD0u8suzxiJVUnjVAuFJX0SUmLg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=xOn+Clyce6m/73qzM30hIYfdKy2CLjIMO7PHqLd+eYdM2WbNeLdxrgYkxOB5iaM6v
         /5g5L1AzY8wMNuncQ9g/0aJeRaONvos+gntLyoqcOSANXeAOVZPrZ80Q7EhLpLqxF4
         vTJJdfwbZrPXIi8nTQo7m9EgC5PP9/VuHxiSkpNs=
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
Subject: [PATCH v2 4/4] ARM: exynos: Fix imprecise abort during Exynos5422 suspend to RAM
Date:   Tue, 24 Jul 2018 18:49:46 +0200
Message-Id: <20180724164946.6274-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180724164946.6274-1-krzk@kernel.org>
References: <20180724164946.6274-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
imprecise abort:

	PM: Syncing filesystems ... done.
	Freezing user space processes ... (elapsed 0.003 seconds) done.
	OOM killer disabled.
	Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
	wake enabled for irq 139
	Disabling non-boot CPUs ...
	IRQ51 no longer affine to CPU1
	IRQ52 no longer affine to CPU2
	IRQ53 no longer affine to CPU3
	IRQ54 no longer affine to CPU4
	IRQ55 no longer affine to CPU5
	IRQ56 no longer affine to CPU6
	cpu cpu4: Dropping the link to regulator.40
	IRQ57 no longer affine to CPU7
	Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
	Internal error: : 1008 [#1] PREEMPT SMP ARM

with last call trace in exynos_suspend_enter().

The abort is caused by writing to register in secure part of sysram.
Boards booted under secure firmware (e.g. Hardkernel Odroid boards)
should access non-secure sysram.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use non-secure sysram only if secure-firmware node is present in DT
   (pointed by Marek).
---
 Documentation/arm/Samsung/Bootloader-interface.txt |  1 +
 arch/arm/mach-exynos/common.h                      |  1 +
 arch/arm/mach-exynos/firmware.c                    | 14 +++++++++++---
 arch/arm/mach-exynos/suspend.c                     | 16 +++++++++++++---
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm/Samsung/Bootloader-interface.txt b/Documentation/arm/Samsung/Bootloader-interface.txt
index ed494ac0beb2..d17ed518a7ea 100644
--- a/Documentation/arm/Samsung/Bootloader-interface.txt
+++ b/Documentation/arm/Samsung/Bootloader-interface.txt
@@ -26,6 +26,7 @@ Offset        Value                                        Purpose
 0x20          0xfcba0d10 (Magic cookie)                    AFTR
 0x24          exynos_cpu_resume_ns                         AFTR
 0x28 + 4*cpu  0x8 (Magic cookie, Exynos3250)               AFTR
+0x28          0x0 or last value during resume (Exynos542x) System suspend
 
 
 2. Secure mode
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index dcd21bb95e3b..f96730cce6e8 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -110,6 +110,7 @@ void exynos_firmware_init(void);
 #define EXYNOS_SLEEP_MAGIC	0x00000bad
 #define EXYNOS_AFTR_MAGIC	0xfcba0d10
 
+bool __init exynos_secure_firmware_available(void);
 void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
 void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
 
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index be1f20fe28f4..d602e3bf3f96 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -185,7 +185,7 @@ static void exynos_l2_configure(const struct l2x0_regs *regs)
 	exynos_smc(SMC_CMD_L2X0SETUP2, regs->pwr_ctrl, regs->aux_ctrl, 0);
 }
 
-void __init exynos_firmware_init(void)
+bool __init exynos_secure_firmware_available(void)
 {
 	struct device_node *nd;
 	const __be32 *addr;
@@ -193,14 +193,22 @@ void __init exynos_firmware_init(void)
 	nd = of_find_compatible_node(NULL, NULL,
 					"samsung,secure-firmware");
 	if (!nd)
-		return;
+		return false;
 
 	addr = of_get_address(nd, 0, NULL, NULL);
 	if (!addr) {
 		pr_err("%s: No address specified.\n", __func__);
-		return;
+		return false;
 	}
 
+	return true;
+}
+
+void __init exynos_firmware_init(void)
+{
+	if (!exynos_secure_firmware_available())
+		return;
+
 	pr_info("Running under secure firmware.\n");
 
 	register_firmware_ops(&exynos_firmware_ops);
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index d42ef1be2c70..ed0248b25060 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -63,6 +63,7 @@ struct exynos_pm_data {
 struct exynos_pm_state {
 	int cpu_state;
 	unsigned int pmu_spare3;
+	void __iomem *sysram_base;
 };
 
 static const struct exynos_pm_data *pm_data __ro_after_init;
@@ -261,7 +262,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
-	writel_relaxed(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
+	writel_relaxed(0x0, pm_state.sysram_base + EXYNOS5420_CPU_STATE);
 
 	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM)) {
 		mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
@@ -333,7 +334,7 @@ static void exynos5420_pm_prepare(void)
 	 * needs to restore it back in case, the primary cpu fails to
 	 * suspend for any reason.
 	 */
-	pm_state.cpu_state = readl_relaxed(sysram_base_addr +
+	pm_state.cpu_state = readl_relaxed(pm_state.sysram_base +
 					   EXYNOS5420_CPU_STATE);
 
 	exynos_pm_enter_sleep_mode();
@@ -453,7 +454,7 @@ static void exynos5420_pm_resume(void)
 
 	/* Restore the sysram cpu state register */
 	writel_relaxed(pm_state.cpu_state,
-		       sysram_base_addr + EXYNOS5420_CPU_STATE);
+		       pm_state.sysram_base + EXYNOS5420_CPU_STATE);
 
 	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
 			S5P_CENTRAL_SEQ_OPTION);
@@ -658,4 +659,13 @@ void __init exynos_pm_init(void)
 
 	register_syscore_ops(&exynos_pm_syscore_ops);
 	suspend_set_ops(&exynos_suspend_ops);
+
+	/*
+	 * Applicable as of now only to Exynos542x. If booted under secure
+	 * firmware, the non-secure region of sysram should be used.
+	 */
+	if (exynos_secure_firmware_available())
+		pm_state.sysram_base = sysram_ns_base_addr;
+	else
+		pm_state.sysram_base = sysram_base_addr;
 }
-- 
2.14.1

