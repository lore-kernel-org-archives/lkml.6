Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C281B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rcuhkIME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfBUKTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:19:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11619 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfBUKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:19:13 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b1d0001>; Thu, 21 Feb 2019 02:19:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:19:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 Feb 2019 02:19:11 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:19:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:19:11 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b1c0001>; Thu, 21 Feb 2019 02:19:10 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 07/12] thermal: tegra: add support for thermal IRQ
Date:   Thu, 21 Feb 2019 18:18:42 +0800
Message-ID: <1550744327-4677-8-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744350; bh=K2wuCMZAKb98gZmUx7FG5yObQgOW8d+BbynyQmmUvL8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=rcuhkIMEBFKcHbxG1n4cc2UvS1yqyJhqdUldWzNFxcZWaXoMaDJAzC38ZdPirXxi/
         jj6vBHCHd+r1UfHBf3OazNe9LeBmJulaO+e6qkCwOHoS2Ipp7kwVcr+XgrpZhO54n9
         8uaaFBFJfSXmcry/r4kdxvgQ4mwI8DHQg3tDRfxywD2sP1FJD9uZNDrqqqvbCazluA
         SEYLS85g9cOXj0qGmqB4DInV3/mgEHUdTyXHfnes9QsU06T7QpRkxFwyyVxdO/09aG
         2rNeuwE5Rbnp/uaCz7/77SV1Gg7F0flOq5TBVkTjR8suaHMHMGT0031MzP5jI/5T79
         4YAt7vaUI3jJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support to generate an interrupt when the temperature
crosses a programmed threshold and notify the thermal framework.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 136 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index edbb90da1ac3..16275de2d67b 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -86,6 +86,20 @@
 #define THERMCTL_LVL0_UP_STATS			0x10
 #define THERMCTL_LVL0_DN_STATS			0x14
 
+#define THERMCTL_INTR_STATUS			0x84
+#define THERMCTL_INTR_ENABLE			0x88
+#define THERMCTL_INTR_DISABLE			0x8c
+
+#define TH_INTR_MD0_MASK			BIT(25)
+#define TH_INTR_MU0_MASK			BIT(24)
+#define TH_INTR_GD0_MASK			BIT(17)
+#define TH_INTR_GU0_MASK			BIT(16)
+#define TH_INTR_CD0_MASK			BIT(9)
+#define TH_INTR_CU0_MASK			BIT(8)
+#define TH_INTR_PD0_MASK			BIT(1)
+#define TH_INTR_PU0_MASK			BIT(0)
+#define TH_INTR_IGNORE_MASK			0xFCFCFCFC
+
 #define THERMCTL_STATS_CTL			0x94
 #define STATS_CTL_CLR_DN			0x8
 #define STATS_CTL_EN_DN				0x4
@@ -242,6 +256,8 @@ struct tegra_soctherm {
 	void __iomem *clk_regs;
 	void __iomem *ccroc_regs;
 
+	int thermal_irq;
+
 	u32 *calib;
 	struct thermal_zone_device **thermctl_tzs;
 	struct tegra_soctherm_soc *soc;
@@ -640,6 +656,98 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	return 0;
 }
 
+static irqreturn_t soctherm_thermal_isr(int irq, void *dev_id)
+{
+	struct tegra_soctherm *ts = dev_id;
+	u32 r;
+
+	r = readl(ts->regs + THERMCTL_INTR_STATUS);
+	writel(r, ts->regs + THERMCTL_INTR_DISABLE);
+
+	return IRQ_WAKE_THREAD;
+}
+
+/**
+ * soctherm_thermal_isr_thread() - Handles a thermal interrupt request
+ * @irq:       The interrupt number being requested; not used
+ * @dev_id:    Opaque pointer to tegra_soctherm;
+ *
+ * Clears the interrupt status register if there are expected
+ * interrupt bits set.
+ * The interrupt(s) are then handled by updating the corresponding
+ * thermal zones.
+ *
+ * An error is logged if any unexpected interrupt bits are set.
+ *
+ * Disabled interrupts are re-enabled.
+ *
+ * Return: %IRQ_HANDLED. Interrupt was handled and no further processing
+ * is needed.
+ */
+static irqreturn_t soctherm_thermal_isr_thread(int irq, void *dev_id)
+{
+	struct tegra_soctherm *ts = dev_id;
+	struct thermal_zone_device *tz;
+	u32 st, ex = 0, cp = 0, gp = 0, pl = 0, me = 0;
+
+	st = readl(ts->regs + THERMCTL_INTR_STATUS);
+
+	/* deliberately clear expected interrupts handled in SW */
+	cp |= st & TH_INTR_CD0_MASK;
+	cp |= st & TH_INTR_CU0_MASK;
+
+	gp |= st & TH_INTR_GD0_MASK;
+	gp |= st & TH_INTR_GU0_MASK;
+
+	pl |= st & TH_INTR_PD0_MASK;
+	pl |= st & TH_INTR_PU0_MASK;
+
+	me |= st & TH_INTR_MD0_MASK;
+	me |= st & TH_INTR_MU0_MASK;
+
+	ex |= cp | gp | pl | me;
+	if (ex) {
+		writel(ex, ts->regs + THERMCTL_INTR_STATUS);
+		st &= ~ex;
+
+		if (cp) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_CPU];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+
+		if (gp) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_GPU];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+
+		if (pl) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_PLLX];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+
+		if (me) {
+			tz = ts->thermctl_tzs[TEGRA124_SOCTHERM_SENSOR_MEM];
+			thermal_zone_device_update(tz,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
+	}
+
+	/* deliberately ignore expected interrupts NOT handled in SW */
+	ex |= TH_INTR_IGNORE_MASK;
+	st &= ~ex;
+
+	if (st) {
+		/* Whine about any other unexpected INTR bits still set */
+		pr_err("soctherm: Ignored unexpected INTRs 0x%08x\n", st);
+		writel(st, ts->regs + THERMCTL_INTR_STATUS);
+	}
+
+	return IRQ_HANDLED;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int regs_show(struct seq_file *s, void *data)
 {
@@ -1302,6 +1410,32 @@ static void tegra_soctherm_throttle(struct device *dev)
 	writel(v, ts->regs + THERMCTL_STATS_CTL);
 }
 
+static int soctherm_interrupts_init(struct platform_device *pdev,
+				    struct tegra_soctherm *tegra)
+{
+	int ret;
+
+	tegra->thermal_irq = platform_get_irq(pdev, 0);
+	if (tegra->thermal_irq < 0) {
+		dev_dbg(&pdev->dev, "get 'thermal_irq' failed.\n");
+		return 0;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev,
+					tegra->thermal_irq,
+					soctherm_thermal_isr,
+					soctherm_thermal_isr_thread,
+					IRQF_ONESHOT,
+					dev_name(&pdev->dev),
+					tegra);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static void soctherm_init(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
@@ -1495,6 +1629,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 	}
 
+	err = soctherm_interrupts_init(pdev, tegra);
+
 	soctherm_debug_init(pdev);
 
 	return 0;
-- 
2.7.4

