Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AED214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KVYu/JfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLRHgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:36:05 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18464 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeLRHf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a3370000>; Mon, 17 Dec 2018 23:35:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:35:24 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:24 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a33a0000>; Mon, 17 Dec 2018 23:35:24 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 07/12] thermal: tegra: add support for thermal IRQ
Date:   Tue, 18 Dec 2018 15:34:39 +0800
Message-ID: <1545118484-23641-9-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118519; bh=G15Pv9thgucJEnkh3gL6F4n8hVRhnV/fuB/DJvWL7ck=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KVYu/JfCax/OFnPPRHRCxxgneUdaA0z//A3ImNgaoL97LQqu1jeEurQDYQY68wBrf
         vKvhIgKPEmiP3oA+DROsBoJAPBLOIDIBr8WnVXTwN0ivAGWLOVNuK79f6A0sS39oBH
         ZRE6Sl8uBhq4rRs/Zc+3FPss4eVdbytpk/B3QODf8mTpjErfyWx+dTVyIPr09kizm/
         Ygz90PbR6EBPqrD4Ww/fZN4IcQBUMDYaKIdQ4s0MSK5xAZvZmY/qga8fBYMjKfaVbo
         cJ23VTtJ0jOOVdRvuAWE9FaKSF3BbYbGMKjfk2+Jy8bg+BfrkJ/VK4PeOiNRYPl5wB
         5LubDYUWWdN6Q==
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
index d3cef88a3f22..c66fdd546ef0 100644
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
@@ -1312,6 +1420,32 @@ static void tegra_soctherm_throttle(struct device *dev)
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
@@ -1505,6 +1639,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 	}
 
+	err = soctherm_interrupts_init(pdev, tegra);
+
 	soctherm_debug_init(pdev);
 
 	return 0;
-- 
2.7.4

