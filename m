Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3496D214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3496D214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbeHBNxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:53:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16328 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbeHBNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:53:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b62f2130000>; Thu, 02 Aug 2018 04:59:16 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Aug 2018 04:59:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Aug 2018 04:59:22 -0700
Received: from BGMAIL103.nvidia.com (10.25.59.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Aug
 2018 11:59:19 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by bgmail103.nvidia.com
 (10.25.59.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Aug
 2018 11:59:14 +0000
Received: from vreddytalla-dt.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 2 Aug 2018 11:59:09 +0000
From:   Venkat Reddy Talla <vreddytalla@nvidia.com>
To:     <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <jonathanh@nvidia.com>, <pdeschrijver@nvidia.com>,
        <vivek.gautam@codeaurora.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <mperttunen@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <avienamo@nvidia.com>, <talho@nvidia.com>, <ldewangan@nvidia.com>,
        <vreddytalla@nvidia.com>
Subject: [PATCH 1/3]  soc/tegra: pmc: set IO pad power state and voltage via pinctrl fw
Date:   Thu, 2 Aug 2018 17:29:01 +0530
Message-ID: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IO pins of Tegra SoCs are grouped for common control
of IO interface like setting voltage signal levels and
power state of the interface. These groups are referred
to as IO pads.The power state and voltage control of IO pins
can be done at IO pads level.

Tegra SoCs support powering down IO pads when they are
not used even in the active state of system.
This saves power from that IO interface. Also it supports
multiple voltage level in IO pins for interfacing on
some of pads. The IO pad voltage is automatically detected
till Tegra124, hence SW need not to configure this.
But from Tegra210, the automatic detection logic has been
removed, hence SW need to explicitly set the IO pad
voltage into IO pad configuration registers.

Add support to configure the power state and voltage level
of the IO pads from client driver via pincontrol framework.

Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 891 +++++++++++++++++++++++++++++++++++++-----------
 include/soc/tegra/pmc.h |  21 +-
 2 files changed, 701 insertions(+), 211 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 2d6f3fc..af69f42 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -33,6 +33,9 @@
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/reboot.h>
@@ -45,6 +48,8 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
+
 #define PMC_CNTRL			0x0
 #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
 #define  PMC_CNTRL_CPU_PWRREQ_OE	BIT(16) /* CPU pwr req enable */
@@ -118,6 +123,17 @@
 
 #define GPU_RG_CNTRL			0x2d4
 
+#define TEGRA_PMC_SEL_DPD_TIM		0x1c8
+#define TEGRA_PMC_IO_DPD_SAMPLE		0x20
+#define TEGRA_PMC_PWR_DET_ENABLE	0x48
+#define TEGRA_PMC_PWR_DET_VAL		0xe4
+#define TEGRA_PMC_IO_DPD_REQ		0x74
+#define TEGRA_PMC_IO_DPD_STATUS		0x78
+#define TEGRA_PMC_IO_DPD2_REQ		0x7C
+#define TEGRA_PMC_IO_DPD2_STATUS	0x80
+#define TEGRA_PMC_E_18V_PWR		0x3C
+#define TEGRA_PMC_E_33V_PWR		0x40
+
 /* Tegra186 and later */
 #define WAKE_AOWAKE_CTRL 0x4f4
 #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
@@ -132,9 +148,21 @@ struct tegra_powergate {
 };
 
 struct tegra_io_pad_soc {
-	enum tegra_io_pad id;
+	const char *name;
+	const unsigned int pins[1];
+	unsigned int npins;
 	unsigned int dpd;
 	unsigned int voltage;
+	unsigned int io_power;
+	unsigned int dpd_req_reg;
+	unsigned int dpd_status_reg;
+	unsigned int dpd_timer_reg;
+	unsigned int dpd_sample_reg;
+	unsigned int pwr_det_enable_reg;
+	unsigned int pwr_det_val_reg;
+	unsigned int pad_uv_0;
+	unsigned int pad_uv_1;
+	bool bdsdmem_cfc;
 };
 
 struct tegra_pmc_regs {
@@ -157,6 +185,8 @@ struct tegra_pmc_soc {
 
 	const struct tegra_io_pad_soc *io_pads;
 	unsigned int num_io_pads;
+	const struct pinctrl_pin_desc *descs;
+	unsigned int num_descs;
 
 	const struct tegra_pmc_regs *regs;
 	void (*init)(struct tegra_pmc *pmc);
@@ -187,6 +217,10 @@ struct tegra_pmc_soc {
  * @lp0_vec_size: size of the LP0 warm boot code
  * @powergates_available: Bitmap of available power gates
  * @powergates_lock: mutex for power gate register access
+ * @pctl: pinctrl handle which is returned after registering pinctrl
+ * @pinctrl_desc: Pincontrol descriptor for IO pads
+ * @allow_dynamic_switch: restrict the voltage change for each io pad
+ * @voltage_switch_restriction_enabled: restrict voltage switch for all io pads
  */
 struct tegra_pmc {
 	struct device *dev;
@@ -216,6 +250,15 @@ struct tegra_pmc {
 	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
 
 	struct mutex powergates_lock;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_desc pinctrl_desc;
+	bool *allow_dynamic_switch;
+	bool voltage_switch_restriction_enabled;
+};
+
+static const char * const tegra_sor_pad_names[] = {
+	[TEGRA_IO_RAIL_HDMI] = "hdmi",
+	[TEGRA_IO_RAIL_LVDS] = "lvds",
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -907,70 +950,42 @@ static void tegra_powergate_init(struct tegra_pmc *pmc,
 	of_node_put(np);
 }
 
-static const struct tegra_io_pad_soc *
-tegra_io_pad_find(struct tegra_pmc *pmc, enum tegra_io_pad id)
-{
-	unsigned int i;
-
-	for (i = 0; i < pmc->soc->num_io_pads; i++)
-		if (pmc->soc->io_pads[i].id == id)
-			return &pmc->soc->io_pads[i];
-
-	return NULL;
-}
-
-static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
-				unsigned long *status, u32 *mask)
+static int tegra_io_pad_prepare(const struct tegra_io_pad_soc *pad)
 {
-	const struct tegra_io_pad_soc *pad;
 	unsigned long rate, value;
 
-	pad = tegra_io_pad_find(pmc, id);
-	if (!pad) {
-		pr_err("invalid I/O pad ID %u\n", id);
-		return -ENOENT;
-	}
-
 	if (pad->dpd == UINT_MAX)
 		return -ENOTSUPP;
 
-	*mask = BIT(pad->dpd % 32);
+	if (!pmc->clk)
+		return 0;
 
-	if (pad->dpd < 32) {
-		*status = pmc->soc->regs->dpd_status;
-		*request = pmc->soc->regs->dpd_req;
-	} else {
-		*status = pmc->soc->regs->dpd2_status;
-		*request = pmc->soc->regs->dpd2_req;
+	rate = clk_get_rate(pmc->clk);
+	if (!rate) {
+		dev_err(pmc->dev, "Failed to get clock rate\n");
+		return -ENODEV;
 	}
 
-	if (pmc->clk) {
-		rate = clk_get_rate(pmc->clk);
-		if (!rate) {
-			pr_err("failed to get clock rate\n");
-			return -ENODEV;
-		}
+	tegra_pmc_writel(DPD_SAMPLE_ENABLE, pad->dpd_sample_reg);
 
-		tegra_pmc_writel(DPD_SAMPLE_ENABLE, DPD_SAMPLE);
-
-		/* must be at least 200 ns, in APB (PCLK) clock cycles */
-		value = DIV_ROUND_UP(1000000000, rate);
-		value = DIV_ROUND_UP(200, value);
-		tegra_pmc_writel(value, SEL_DPD_TIM);
-	}
+	/* must be at least 200 ns, in APB (PCLK) clock cycles */
+	value = DIV_ROUND_UP(1000000000, rate);
+	value = DIV_ROUND_UP(200, value);
+	tegra_pmc_writel(value, pad->dpd_timer_reg);
 
 	return 0;
 }
 
-static int tegra_io_pad_poll(unsigned long offset, u32 mask,
+static int tegra_io_pad_poll(const struct tegra_io_pad_soc *pad,
 			     u32 val, unsigned long timeout)
 {
 	u32 value;
+	u32 mask = BIT(pad->dpd);
 
 	timeout = jiffies + msecs_to_jiffies(timeout);
 
 	while (time_after(timeout, jiffies)) {
-		value = tegra_pmc_readl(offset);
+		value = tegra_pmc_readl(pad->dpd_status_reg);
 		if ((value & mask) == val)
 			return 0;
 
@@ -980,10 +995,22 @@ static int tegra_io_pad_poll(unsigned long offset, u32 mask,
 	return -ETIMEDOUT;
 }
 
-static void tegra_io_pad_unprepare(void)
+static void tegra_io_pad_unprepare(const struct tegra_io_pad_soc *pad)
 {
 	if (pmc->clk)
-		tegra_pmc_writel(DPD_SAMPLE_DISABLE, DPD_SAMPLE);
+		tegra_pmc_writel(DPD_SAMPLE_DISABLE,  pad->dpd_sample_reg);
+}
+
+static const struct tegra_io_pad_soc *tegra_get_pad_by_name(const char *pname)
+{
+	unsigned int i;
+
+	for (i = 0; i < pmc->soc->num_io_pads; ++i) {
+		if (!strcmp(pname, pmc->soc->io_pads[i].name))
+			return &pmc->soc->io_pads[i];
+	}
+
+	return NULL;
 }
 
 /**
@@ -992,35 +1019,33 @@ static void tegra_io_pad_unprepare(void)
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int tegra_io_pad_power_enable(enum tegra_io_pad id)
+static int tegra_io_pad_power_enable(const struct tegra_io_pad_soc *pad)
 {
-	unsigned long request, status;
-	u32 mask;
 	int err;
 
 	mutex_lock(&pmc->powergates_lock);
 
-	err = tegra_io_pad_prepare(id, &request, &status, &mask);
+	err = tegra_io_pad_prepare(pad);
 	if (err < 0) {
-		pr_err("failed to prepare I/O pad: %d\n", err);
+		pr_err("failed to prepare I/O pad %s: %d\n", pad->name, err);
 		goto unlock;
 	}
 
-	tegra_pmc_writel(IO_DPD_REQ_CODE_OFF | mask, request);
+	tegra_pmc_writel(IO_DPD_REQ_CODE_OFF | BIT(pad->dpd),
+			 pad->dpd_req_reg);
 
-	err = tegra_io_pad_poll(status, mask, 0, 250);
+	err = tegra_io_pad_poll(pad, 0, 250);
 	if (err < 0) {
-		pr_err("failed to enable I/O pad: %d\n", err);
+		pr_err("failed to enable I/O pad %s: %d\n", pad->name, err);
 		goto unlock;
 	}
 
-	tegra_io_pad_unprepare();
+	tegra_io_pad_unprepare(pad);
 
 unlock:
 	mutex_unlock(&pmc->powergates_lock);
 	return err;
 }
-EXPORT_SYMBOL(tegra_io_pad_power_enable);
 
 /**
  * tegra_io_pad_power_disable() - disable power to I/O pad
@@ -1028,65 +1053,63 @@ EXPORT_SYMBOL(tegra_io_pad_power_enable);
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int tegra_io_pad_power_disable(enum tegra_io_pad id)
+static int tegra_io_pad_power_disable(const struct tegra_io_pad_soc *pad)
 {
-	unsigned long request, status;
-	u32 mask;
 	int err;
 
 	mutex_lock(&pmc->powergates_lock);
 
-	err = tegra_io_pad_prepare(id, &request, &status, &mask);
+	err = tegra_io_pad_prepare(pad);
 	if (err < 0) {
-		pr_err("failed to prepare I/O pad: %d\n", err);
+		pr_err("failed to prepare I/O pad %s: %d\n", pad->name, err);
 		goto unlock;
 	}
 
-	tegra_pmc_writel(IO_DPD_REQ_CODE_ON | mask, request);
+	tegra_pmc_writel(IO_DPD_REQ_CODE_ON | BIT(pad->dpd),
+			 pad->dpd_req_reg);
 
-	err = tegra_io_pad_poll(status, mask, mask, 250);
+	err = tegra_io_pad_poll(pad, BIT(pad->dpd), 250);
 	if (err < 0) {
-		pr_err("failed to disable I/O pad: %d\n", err);
+		pr_err("failed to disable I/O pad %s: %d\n", pad->name, err);
 		goto unlock;
 	}
 
-	tegra_io_pad_unprepare();
+	tegra_io_pad_unprepare(pad);
 
 unlock:
 	mutex_unlock(&pmc->powergates_lock);
 	return err;
 }
-EXPORT_SYMBOL(tegra_io_pad_power_disable);
 
-int tegra_io_pad_set_voltage(enum tegra_io_pad id,
-			     enum tegra_io_pad_voltage voltage)
+static int tegra_io_pad_set_voltage(const struct tegra_io_pad_soc *pad,
+				    int io_pad_uv)
 {
-	const struct tegra_io_pad_soc *pad;
 	u32 value;
 
-	pad = tegra_io_pad_find(pmc, id);
-	if (!pad)
-		return -ENOENT;
-
 	if (pad->voltage == UINT_MAX)
 		return -ENOTSUPP;
 
+	if (io_pad_uv != pad->pad_uv_0 && io_pad_uv != pad->pad_uv_1)
+		return -EINVAL;
+
 	mutex_lock(&pmc->powergates_lock);
 
 	/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
-	value = tegra_pmc_readl(PMC_PWR_DET);
-	value |= BIT(pad->voltage);
-	tegra_pmc_writel(value, PMC_PWR_DET);
+	if (pad->pwr_det_enable_reg != UINT_MAX) {
+		value = tegra_pmc_readl(pad->pwr_det_enable_reg);
+		value |= BIT(pad->voltage);
+		tegra_pmc_writel(value, pad->pwr_det_enable_reg);
+	}
 
 	/* update I/O voltage */
-	value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+	value = tegra_pmc_readl(pad->pwr_det_val_reg);
 
-	if (voltage == TEGRA_IO_PAD_1800000UV)
+	if (io_pad_uv == pad->pad_uv_0)
 		value &= ~BIT(pad->voltage);
 	else
 		value |= BIT(pad->voltage);
 
-	tegra_pmc_writel(value, PMC_PWR_DET_VALUE);
+	tegra_pmc_writel(value, pad->pwr_det_val_reg);
 
 	mutex_unlock(&pmc->powergates_lock);
 
@@ -1094,28 +1117,289 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 
 	return 0;
 }
-EXPORT_SYMBOL(tegra_io_pad_set_voltage);
 
-int tegra_io_pad_get_voltage(enum tegra_io_pad id)
+static int tegra_io_pad_get_voltage(const struct tegra_io_pad_soc *pad)
 {
-	const struct tegra_io_pad_soc *pad;
 	u32 value;
 
-	pad = tegra_io_pad_find(pmc, id);
-	if (!pad)
-		return -ENOENT;
-
 	if (pad->voltage == UINT_MAX)
 		return -ENOTSUPP;
 
-	value = tegra_pmc_readl(PMC_PWR_DET_VALUE);
+	value = tegra_pmc_readl(pad->pwr_det_val_reg);
 
 	if ((value & BIT(pad->voltage)) == 0)
-		return TEGRA_IO_PAD_1800000UV;
+		return pad->pad_uv_0;
 
-	return TEGRA_IO_PAD_3300000UV;
+	return pad->pad_uv_1;
+}
+
+/**
+ * tegra_io_pad_is_powered() - check if IO pad is powered
+ * @pad: Tegra I/O pad SOC data for which power status need to check
+ *
+ * Return 1 if power-ON, 0 if power OFF and error number in
+ * negative if pad ID is not valid or power down not supported
+ * on given IO pad.
+ */
+static int tegra_io_pad_is_powered(const struct tegra_io_pad_soc *pad)
+{
+	u32 value;
+
+	if (pad->dpd == UINT_MAX)
+		return -ENOTSUPP;
+
+	value = tegra_pmc_readl(pad->dpd_status_reg);
+
+	return !(value & BIT(pad->dpd));
+}
+
+static int tegra_io_pads_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct tegra_pmc *tpmc = pinctrl_dev_get_drvdata(pctldev);
+
+	return tpmc->soc->num_io_pads;
+}
+
+static const char *tegra_io_pads_pinctrl_get_group_name(
+			struct pinctrl_dev *pctldev, unsigned int group)
+{
+	struct tegra_pmc *tpmc = pinctrl_dev_get_drvdata(pctldev);
+
+	return tpmc->soc->io_pads[group].name;
+}
+
+static int tegra_io_pads_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+						unsigned int group,
+						const unsigned int **pins,
+						unsigned int *num_pins)
+{
+	struct tegra_pmc *tpmc = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = tpmc->soc->io_pads[group].pins;
+	*num_pins = tpmc->soc->io_pads[group].npins;
+
+	return 0;
+}
+
+enum tegra_io_rail_pads_params {
+	TEGRA_IO_PAD_POWER_SOURCE_VOLTAGE = PIN_CONFIG_END + 1,
+	TEGRA_IO_PAD_DYNAMIC_VOLTAGE_SWITCH = PIN_CONFIG_END + 2,
+};
+
+static const struct pinconf_generic_params tegra_io_pads_cfg_params[] = {
+	{
+		.property = "nvidia,power-source-voltage",
+		.param = TEGRA_IO_PAD_POWER_SOURCE_VOLTAGE,
+	}, {
+		.property = "nvidia,enable-voltage-switching",
+		.param = TEGRA_IO_PAD_DYNAMIC_VOLTAGE_SWITCH,
+	},
+};
+
+static const struct pinctrl_ops tegra_io_pads_pinctrl_ops = {
+	.get_groups_count = tegra_io_pads_pinctrl_get_groups_count,
+	.get_group_name	= tegra_io_pads_pinctrl_get_group_name,
+	.get_group_pins	= tegra_io_pads_pinctrl_get_group_pins,
+	.dt_node_to_map	= pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map	= pinconf_generic_dt_free_map,
+};
+
+static int tegra_io_pads_pinconf_get(struct pinctrl_dev *pctldev,
+				     unsigned int pin,
+				     unsigned long *config)
+{
+	struct tegra_pmc *tpmc = pinctrl_dev_get_drvdata(pctldev);
+	u16 param = pinconf_to_config_param(*config);
+	const struct tegra_io_pad_soc *pad = &tpmc->soc->io_pads[pin];
+	u16 arg = 0;
+	int ret;
+
+	switch (param) {
+	case PIN_CONFIG_LOW_POWER_MODE:
+		ret = tegra_io_pad_is_powered(pad);
+		if (ret < 0)
+			return ret;
+		arg = !ret;
+		break;
+	case TEGRA_IO_PAD_POWER_SOURCE_VOLTAGE:
+		if (pmc->soc->io_pads[pin].voltage == UINT_MAX)
+			return -EINVAL;
+
+		ret = tegra_io_pad_get_voltage(pad);
+		if (ret < 0)
+			return ret;
+		arg = ret;
+		break;
+	case TEGRA_IO_PAD_DYNAMIC_VOLTAGE_SWITCH:
+		if (pmc->soc->io_pads[pin].voltage == UINT_MAX)
+			return -EINVAL;
+
+		if (pmc->voltage_switch_restriction_enabled &&
+		    pmc->allow_dynamic_switch[pin])
+			arg = 1;
+		else
+			arg = 0;
+		break;
+	default:
+		dev_dbg(tpmc->dev, "I/O pad %s does not support param %d\n",
+			pad->name, param);
+		return -EINVAL;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int tegra_io_pads_pinconf_set(struct pinctrl_dev *pctldev,
+				     unsigned int pin, unsigned long *configs,
+				     unsigned int num_configs)
+{
+	struct tegra_pmc *tpmc = pinctrl_dev_get_drvdata(pctldev);
+	const struct tegra_io_pad_soc *pad = &tpmc->soc->io_pads[pin];
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < num_configs; i++) {
+		u16 param_val = pinconf_to_config_argument(configs[i]);
+		u16 param = pinconf_to_config_param(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_LOW_POWER_MODE:
+			if (param_val)
+				ret = tegra_io_pad_power_disable(pad);
+			else
+				ret = tegra_io_pad_power_enable(pad);
+			if (ret < 0) {
+				dev_err(tpmc->dev,
+					"Failed to set low power %s of I/O pad %s: %d\n",
+					(param_val) ? "disable" : "enable",
+					pad->name, ret);
+				return ret;
+			}
+			break;
+		case TEGRA_IO_PAD_POWER_SOURCE_VOLTAGE:
+			if (pmc->soc->io_pads[pin].voltage == UINT_MAX)
+				return -EINVAL;
+
+			if (pmc->voltage_switch_restriction_enabled &&
+			    !pmc->allow_dynamic_switch[pin]) {
+				dev_err(tpmc->dev,
+					"IO Pad %s: Dynamic voltage switching not allowed\n",
+					pad->name);
+				return -EINVAL;
+			}
+
+			ret = tegra_io_pad_set_voltage(pad, param_val);
+			if (ret < 0) {
+				dev_err(tpmc->dev,
+					"Failed to set voltage %d of pin %u: %d\n",
+					param_val, pin, ret);
+				return ret;
+			}
+			break;
+		case TEGRA_IO_PAD_DYNAMIC_VOLTAGE_SWITCH:
+			if (pmc->soc->io_pads[pin].voltage == UINT_MAX)
+				return -EINVAL;
+
+			pmc->allow_dynamic_switch[pin] = true;
+			break;
+		default:
+			dev_err(tpmc->dev, "I/O pad %s does not support param %d\n",
+				pad->name, param);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void tegra_io_pads_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+					   struct seq_file *s, unsigned int pin)
+{
+	struct tegra_pmc *tpmc = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long config = 0;
+	u16 param, param_val;
+	int ret;
+	int i;
+
+	for (i = 0; i < tpmc->pinctrl_desc.num_custom_params; ++i) {
+		param = tpmc->pinctrl_desc.custom_params[i].param;
+		config = pinconf_to_config_packed(param, 0);
+		ret = tegra_io_pads_pinconf_get(pctldev, pin, &config);
+		if (ret < 0)
+			continue;
+		param_val = pinconf_to_config_argument(config);
+		switch (param) {
+		case TEGRA_IO_PAD_POWER_SOURCE_VOLTAGE:
+			if (param_val == TEGRA_IO_PAD_VOLTAGE_1200000UV)
+				seq_puts(s, "\n\t\tPad voltage 1200000uV");
+			else if (param_val == TEGRA_IO_PAD_VOLTAGE_1800000UV)
+				seq_puts(s, "\n\t\tPad voltage 1800000uV");
+			else
+				seq_puts(s, "\n\t\tPad voltage 3300000uV");
+			break;
+		case TEGRA_IO_PAD_DYNAMIC_VOLTAGE_SWITCH:
+			seq_printf(s, "\n\t\tSwitching voltage: %s",
+				   (param_val) ? "Enable" : "Disable");
+			break;
+		default:
+			break;
+		}
+	}
+}
+#else
+static void tegra_io_pads_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+					   struct seq_file *s, unsigned int pin)
+{
+}
+#endif
+
+static const struct pinconf_ops tegra_io_pads_pinconf_ops = {
+	.pin_config_get = tegra_io_pads_pinconf_get,
+	.pin_config_set = tegra_io_pads_pinconf_set,
+	.pin_config_dbg_show = tegra_io_pads_pinconf_dbg_show,
+	.is_generic = true,
+};
+
+static int tegra_io_pads_pinctrl_init(struct tegra_pmc *pmc)
+{
+	if (!pmc->soc->num_descs)
+		return 0;
+
+	pmc->allow_dynamic_switch = devm_kzalloc(pmc->dev, pmc->soc->num_descs *
+					 sizeof(*pmc->allow_dynamic_switch),
+					 GFP_KERNEL);
+	if (!pmc->allow_dynamic_switch) {
+		pr_err("failed to allocate allow_dynamic_switch\n");
+		return 0;
+	}
+
+	pmc->voltage_switch_restriction_enabled = false;
+	pmc->pinctrl_desc.name = "pinctrl-pmc-io-pads";
+	pmc->pinctrl_desc.pctlops = &tegra_io_pads_pinctrl_ops;
+	pmc->pinctrl_desc.confops = &tegra_io_pads_pinconf_ops;
+	pmc->pinctrl_desc.pins = pmc->soc->descs;
+	pmc->pinctrl_desc.npins = pmc->soc->num_descs;
+	pmc->pinctrl_desc.custom_params = tegra_io_pads_cfg_params;
+	pmc->pinctrl_desc.num_custom_params =
+				ARRAY_SIZE(tegra_io_pads_cfg_params);
+
+	pmc->pctl = devm_pinctrl_register(pmc->dev, &pmc->pinctrl_desc, pmc);
+	if (IS_ERR(pmc->pctl)) {
+		int ret = PTR_ERR(pmc->pctl);
+
+		pr_err("failed to register pinctrl-io-pad: %d\n", ret);
+		return ret;
+	}
+
+	pmc->voltage_switch_restriction_enabled =
+		of_property_read_bool(pmc->dev->of_node,
+				      "nvidia,restrict-voltage-switch");
+
+	return 0;
 }
-EXPORT_SYMBOL(tegra_io_pad_get_voltage);
 
 /**
  * tegra_io_rail_power_on() - enable power to I/O rail
@@ -1125,7 +1409,20 @@ EXPORT_SYMBOL(tegra_io_pad_get_voltage);
  */
 int tegra_io_rail_power_on(unsigned int id)
 {
-	return tegra_io_pad_power_enable(id);
+	const struct tegra_io_pad_soc *pad;
+
+	if (id != TEGRA_IO_RAIL_LVDS && id != TEGRA_IO_RAIL_HDMI) {
+		dev_err(pmc->dev, "invalid pad id\n");
+		return -EINVAL;
+	}
+
+	pad = tegra_get_pad_by_name(tegra_sor_pad_names[id]);
+	if (!pad) {
+		dev_err(pmc->dev, "IO Pad not found\n");
+		return -EINVAL;
+	}
+
+	return tegra_io_pad_power_enable(pad);
 }
 EXPORT_SYMBOL(tegra_io_rail_power_on);
 
@@ -1137,7 +1434,20 @@ EXPORT_SYMBOL(tegra_io_rail_power_on);
  */
 int tegra_io_rail_power_off(unsigned int id)
 {
-	return tegra_io_pad_power_disable(id);
+	const struct tegra_io_pad_soc *pad;
+
+	if (id != TEGRA_IO_RAIL_LVDS && id != TEGRA_IO_RAIL_HDMI) {
+		dev_err(pmc->dev, "invalid pad id\n");
+		return -EINVAL;
+	}
+
+	pad = tegra_get_pad_by_name(tegra_sor_pad_names[id]);
+	if (!pad) {
+		dev_err(pmc->dev, "IO Pad not found\n");
+		return -EINVAL;
+	}
+
+	return tegra_io_pad_power_disable(pad);
 }
 EXPORT_SYMBOL(tegra_io_rail_power_off);
 
@@ -1436,6 +1746,10 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = tegra_io_pads_pinctrl_init(pmc);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&pmc->powergates_lock);
 	iounmap(pmc->base);
 	pmc->base = base;
@@ -1649,37 +1963,77 @@ static const u8 tegra124_cpu_powergates[] = {
 	TEGRA_POWERGATE_CPU3,
 };
 
+#define TEGRA124_IO_PAD_CONFIG(_pin, _npins, _name, _dpd,	\
+			       _vbit, _iopower, _reg)		\
+	{							\
+		.name =  #_name,				\
+		.pins = {(_pin)},				\
+		.npins = _npins,				\
+		.dpd = _dpd,					\
+		.voltage = _vbit,				\
+		.io_power = _iopower,				\
+		.dpd_req_reg = TEGRA_PMC_IO_##_reg##_REQ,	\
+		.dpd_status_reg = TEGRA_PMC_IO_##_reg##_STATUS,	\
+		.dpd_timer_reg = TEGRA_PMC_SEL_DPD_TIM,		\
+		.dpd_sample_reg = TEGRA_PMC_IO_DPD_SAMPLE,	\
+		.pwr_det_enable_reg = TEGRA_PMC_PWR_DET_ENABLE, \
+		.pwr_det_val_reg = TEGRA_PMC_PWR_DET_VAL, \
+	},
+
+/**
+ * All IO pads of Tegra SoCs do not support the low power and multi level
+ * voltage configurations for its pads.
+ * Defining macros for different cases as follows:
+ * TEGRA_IO_PAD_LPONLY : IO pad which support low power state but
+ *			 operate in single level of IO voltage.
+ */
+#define TEGRA124_IO_PAD_LPONLY(_pin, _name, _dpd, _reg)	\
+	TEGRA124_IO_PAD_CONFIG(_pin, 1, _name, _dpd, UINT_MAX, UINT_MAX, _reg)
+
+#define TEGRA124_IO_PAD_DESC_LP(_pin, _name, _dpd, _reg)	\
+	{					\
+		.number = _pin,			\
+		.name = #_name,			\
+	},
+
+#define TEGRA124_IO_PAD_TABLE(_lponly_, _pvonly_, _lp_n_pv_)	\
+	_lponly_(0, audio, 17, DPD)			\
+	_lponly_(1, bb, 15, DPD)			\
+	_lponly_(2, cam, 4, DPD2)			\
+	_lponly_(3, comp, 22, DPD)			\
+	_lponly_(4, csia, 0, DPD2)			\
+	_lponly_(5, csib, 1, DPD2)			\
+	_lponly_(6, csie, 12, DPD2)			\
+	_lponly_(7, dp, 19, DPD2)			\
+	_lponly_(8, dsi, 2, DPD)			\
+	_lponly_(9, dsib, 7, DPD2)			\
+	_lponly_(10, dsic, 8, DPD2)			\
+	_lponly_(11, dsid, 9, DPD2)			\
+	_lponly_(12, hdmi, 28, DPD)			\
+	_lponly_(13, hsic, 19, DPD)			\
+	_lponly_(14, lvds, 25, DPD2)			\
+	_lponly_(15, mipi-bias, 3, DPD)			\
+	_lponly_(16, nand, 13, DPD)			\
+	_lponly_(17, pex-bias, 4, DPD)			\
+	_lponly_(18, pex-clk1, 5, DPD)			\
+	_lponly_(19, pex-clk2, 6, DPD)			\
+	_lponly_(20, pex-ctrl, 0, DPD2)			\
+	_lponly_(21, sdmmc1, 1, DPD2)		\
+	_lponly_(22, sdmmc3, 2, DPD2)		\
+	_lponly_(23, sdmmc4, 3, DPD2)		\
+	_lponly_(24, sys-ddc, 26, DPD)		\
+	_lponly_(25, uart, 14, DPD)		\
+	_lponly_(26, usb0, 9, DPD)			\
+	_lponly_(27, usb1, 10, DPD)			\
+	_lponly_(28, usb2, 11, DPD)			\
+	_lponly_(29, usb-bias, 12, DPD)			\
+
 static const struct tegra_io_pad_soc tegra124_io_pads[] = {
-	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_BB, .dpd = 15, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CAM, .dpd = 36, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_COMP, .dpd = 22, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 44, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 39, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 40, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSID, .dpd = 41, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HDMI, .dpd = 28, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HV, .dpd = 38, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_LVDS, .dpd = 57, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_NAND, .dpd = 13, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_BIAS, .dpd = 4, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 5, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC1, .dpd = 33, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC3, .dpd = 34, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 35, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SYS_DDC, .dpd = 58, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
+	TEGRA124_IO_PAD_TABLE(TEGRA124_IO_PAD_LPONLY, NULL, NULL)
+};
+
+static const struct pinctrl_pin_desc tegra124_io_pads_pinctrl_desc[] = {
+	TEGRA124_IO_PAD_TABLE(TEGRA124_IO_PAD_DESC_LP, NULL, NULL)
 };
 
 static const struct tegra_pmc_soc tegra124_pmc_soc = {
@@ -1694,6 +2048,8 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
+	.num_descs = ARRAY_SIZE(tegra124_io_pads_pinctrl_desc),
+	.descs = tegra124_io_pads_pinctrl_desc,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -1730,45 +2086,111 @@ static const u8 tegra210_cpu_powergates[] = {
 	TEGRA_POWERGATE_CPU3,
 };
 
+#define TEGRA210X_IO_PAD_CONFIG(_pin, _npins, _name, _dpd,	\
+			       _vbit, _iopower, _reg, _bds)	\
+	{							\
+		.name =  #_name,				\
+		.pins = {(_pin)},				\
+		.npins = _npins,				\
+		.dpd = _dpd,					\
+		.voltage = _vbit,				\
+		.io_power = _iopower,				\
+		.dpd_req_reg = TEGRA_PMC_IO_##_reg##_REQ,	\
+		.dpd_status_reg = TEGRA_PMC_IO_##_reg##_STATUS,	\
+		.dpd_timer_reg = TEGRA_PMC_SEL_DPD_TIM,		\
+		.dpd_sample_reg = TEGRA_PMC_IO_DPD_SAMPLE,	\
+		.bdsdmem_cfc = _bds,				\
+		.pwr_det_enable_reg = TEGRA_PMC_PWR_DET_ENABLE, \
+		.pwr_det_val_reg = TEGRA_PMC_PWR_DET_VAL, \
+		.pad_uv_0 = TEGRA_IO_PAD_VOLTAGE_1800000UV,	\
+		.pad_uv_1 = TEGRA_IO_PAD_VOLTAGE_3300000UV,	\
+	},
+
+#define TEGRA210_IO_PAD_CONFIG(_pin, _npins, _name, _dpd,	\
+			       _vbit, _iopower, _reg)		\
+	TEGRA210X_IO_PAD_CONFIG(_pin, _npins, _name, _dpd,	\
+				_vbit, _iopower, _reg, false)
+
+/**
+ * All IO pads of Tegra SoCs do not support the low power and multi level
+ * voltage configurations for its pads.
+ * Defining macros for different cases as follows:
+ * TEGRA_IO_PAD_LPONLY : IO pad which support low power state but
+ *			 operate in single level of IO voltage.
+ * TEGRA_IO_PAD_LP_N_PV: IO pad which support low power state as well as
+ *			 it can operate in multi-level voltages.
+ * TEGRA_IO_PAD_PVONLY:  IO pad which does not support low power state but
+ *			 it can operate in multi-level voltages.
+ */
+#define TEGRA210_IO_PAD_LPONLY(_pin, _name, _dpd, _reg)	\
+	TEGRA210_IO_PAD_CONFIG(_pin, 1, _name, _dpd, UINT_MAX, UINT_MAX, _reg)
+
+#define TEGRA210_IO_PAD_LP_N_PV(_pin, _name, _dpd, _vbit, _io, _reg)  \
+	TEGRA210_IO_PAD_CONFIG(_pin, 1, _name, _dpd, _vbit, _io, _reg)
+
+#define TEGRA210_IO_PAD_PVONLY(_pin, _name, _vbit, _io, _reg)	\
+	TEGRA210_IO_PAD_CONFIG(_pin, 0, _name, UINT_MAX, _vbit, _io, _reg)
+
+#define TEGRA210_IO_PAD_DESC_LP(_pin, _name, _dpd, _reg)	\
+	{					\
+		.number = _pin,			\
+		.name = #_name,			\
+	},
+#define TEGRA210_IO_PAD_DESC_LP_N_PV(_pin, _name, _dpd, _vbit, _io, _reg) \
+	TEGRA210_IO_PAD_DESC_LP(_pin, _name, _dpd, _reg)
+
+#define TEGRA210_IO_PAD_DESC_PV(_pin, _name, _vbit, _io, _reg) \
+	TEGRA210_IO_PAD_DESC_LP(_pin, _name, UINT_MAX, _reg)
+
+#define TEGRA210_IO_PAD_TABLE(_lponly_, _pvonly_, _lp_n_pv_)	\
+	_lp_n_pv_(0, audio, 17, 5, 5, DPD)		\
+	_lp_n_pv_(1, audio-hv, 29, 18, 18, DPD2)	\
+	_lp_n_pv_(2, cam, 4, 10, 10, DPD2)		\
+	_lponly_(3, csia, 0, DPD)			\
+	_lponly_(4, csib, 1, DPD)			\
+	_lponly_(5, csic, 10, DPD2)			\
+	_lponly_(6, csid, 11, DPD2)			\
+	_lponly_(7, csie, 12, DPD2)			\
+	_lponly_(8, csif, 13, DPD2)			\
+	_lp_n_pv_(9, dbg, 25, 19, 19, DPD)		\
+	_lponly_(10, debug-nonao, 26, DPD)		\
+	_lp_n_pv_(11, dmic, 18, 20, 20, DPD2)		\
+	_lponly_(12, dp, 19, DPD2)			\
+	_lponly_(13, dsi, 2, DPD)			\
+	_lponly_(14, dsib, 7, DPD2)			\
+	_lponly_(15, dsic, 8, DPD2)			\
+	_lponly_(16, dsid, 9, DPD2)			\
+	_lponly_(17, emmc, 3, DPD2)			\
+	_lponly_(18, emmc2, 5, DPD2)			\
+	_lp_n_pv_(19, gpio, 27, 21, 21, DPD)		\
+	_lponly_(20, hdmi, 28, DPD)			\
+	_lponly_(21, hsic, 19, DPD)			\
+	_lponly_(22, lvds, 25, DPD2)			\
+	_lponly_(23, mipi-bias, 3, DPD)			\
+	_lponly_(24, pex-bias, 4, DPD)			\
+	_lponly_(25, pex-clk1, 5, DPD)			\
+	_lponly_(26, pex-clk2, 6, DPD)			\
+	_pvonly_(27, pex-ctrl, 11, 11, DPD2)		\
+	_lp_n_pv_(28, sdmmc1, 1, 12, 12, DPD2)		\
+	_lp_n_pv_(29, sdmmc3, 2, 13, 13, DPD2)		\
+	_lp_n_pv_(30, spi, 14, 22, 22, DPD2)		\
+	_lp_n_pv_(31, spi-hv, 15, 23, 23, DPD2)		\
+	_lp_n_pv_(32, uart, 14, 2, 2, DPD)		\
+	_lponly_(33, usb0, 9, DPD)			\
+	_lponly_(34, usb1, 10, DPD)			\
+	_lponly_(35, usb2, 11, DPD)			\
+	_lponly_(36, usb3, 18, DPD)			\
+	_lponly_(37, usb-bias, 12, DPD)			\
+	_pvonly_(38, sys, 12, UINT_MAX, DPD)
+
 static const struct tegra_io_pad_soc tegra210_io_pads[] = {
-	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = 5 },
-	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = 18 },
-	{ .id = TEGRA_IO_PAD_CAM, .dpd = 36, .voltage = 10 },
-	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIC, .dpd = 42, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSID, .dpd = 43, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 44, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 45, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DBG, .dpd = 25, .voltage = 19 },
-	{ .id = TEGRA_IO_PAD_DEBUG_NONAO, .dpd = 26, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DMIC, .dpd = 50, .voltage = 20 },
-	{ .id = TEGRA_IO_PAD_DP, .dpd = 51, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 39, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 40, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSID, .dpd = 41, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_EMMC, .dpd = 35, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_EMMC2, .dpd = 37, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_GPIO, .dpd = 27, .voltage = 21 },
-	{ .id = TEGRA_IO_PAD_HDMI, .dpd = 28, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_LVDS, .dpd = 57, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_BIAS, .dpd = 4, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 5, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = UINT_MAX, .voltage = 11 },
-	{ .id = TEGRA_IO_PAD_SDMMC1, .dpd = 33, .voltage = 12 },
-	{ .id = TEGRA_IO_PAD_SDMMC3, .dpd = 34, .voltage = 13 },
-	{ .id = TEGRA_IO_PAD_SPI, .dpd = 46, .voltage = 22 },
-	{ .id = TEGRA_IO_PAD_SPI_HV, .dpd = 47, .voltage = 23 },
-	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = 2 },
-	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB3, .dpd = 18, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
+	TEGRA210_IO_PAD_TABLE(TEGRA210_IO_PAD_LPONLY, TEGRA210_IO_PAD_PVONLY,
+			      TEGRA210_IO_PAD_LP_N_PV)
+};
+
+static const struct pinctrl_pin_desc tegra210_io_pads_pinctrl_desc[] = {
+	TEGRA210_IO_PAD_TABLE(TEGRA210_IO_PAD_DESC_LP, TEGRA210_IO_PAD_DESC_PV,
+			      TEGRA210_IO_PAD_DESC_LP_N_PV)
 };
 
 static const struct tegra_pmc_soc tegra210_pmc_soc = {
@@ -1782,50 +2204,12 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
 	.io_pads = tegra210_io_pads,
 	.regs = &tegra20_pmc_regs,
+	.num_descs = ARRAY_SIZE(tegra210_io_pads_pinctrl_desc),
+	.descs = tegra210_io_pads_pinctrl_desc,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
 };
 
-static const struct tegra_io_pad_soc tegra186_io_pads[] = {
-	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK_BIAS, .dpd = 4, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK3, .dpd = 5, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 7, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DBG, .dpd = 25, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HDMI_DP0, .dpd = 28, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HDMI_DP1, .dpd = 29, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC2_HV, .dpd = 34, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 36, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CAM, .dpd = 38, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 40, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 41, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSID, .dpd = 42, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIC, .dpd = 43, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSID, .dpd = 44, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 45, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 46, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SPI, .dpd = 47, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_UFS, .dpd = 49, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DMIC_HV, .dpd = 52, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_EDP, .dpd = 53, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CONN, .dpd = 60, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = UINT_MAX },
-};
-
 static const struct tegra_pmc_regs tegra186_pmc_regs = {
 	.scratch0 = 0x2000,
 	.dpd_req = 0x74,
@@ -1869,6 +2253,111 @@ static void tegra186_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 	iounmap(wake);
 }
 
+#define TEGRA186_IO_PAD_CONFIG(_pin, _npins, _name, _dpd_reg, _dpd_bit,     \
+			       _padv_reg, _padv_bit, _v0, _v1, _iopwr_bit,  \
+			       _bds)  \
+	{							\
+		.name =  #_name,				\
+		.pins = {(_pin)},				\
+		.npins = _npins,				\
+		.dpd_req_reg = TEGRA_PMC_IO_##_dpd_reg##_REQ,	\
+		.dpd_status_reg = TEGRA_PMC_IO_##_dpd_reg##_STATUS,	\
+		.dpd_timer_reg = TEGRA_PMC_SEL_DPD_TIM,		\
+		.dpd_sample_reg = TEGRA_PMC_IO_DPD_SAMPLE,	\
+		.dpd = _dpd_bit,				\
+		.pwr_det_val_reg = TEGRA_PMC_##_padv_reg##_PWR, \
+		.pwr_det_enable_reg = UINT_MAX,		\
+		.pad_uv_0 = TEGRA_IO_PAD_VOLTAGE_##_v0##000UV,	\
+		.pad_uv_1 = TEGRA_IO_PAD_VOLTAGE_##_v1##000UV,	\
+		.voltage = _padv_bit,				\
+		.io_power = _iopwr_bit,				\
+		.bdsdmem_cfc = _bds,				\
+	},
+
+#define TEGRA186_IO_PAD_LPONLY(_pin, _name, _dpd_reg, _dpd_bit, _iopwr_bit, \
+			       _bds)					    \
+	TEGRA186_IO_PAD_CONFIG(_pin, 1, _name, _dpd_reg, _dpd_bit,	    \
+			       E_33V, UINT_MAX, 1200, 1200, _iopwr_bit, _bds)
+
+#define TEGRA186_IO_PAD_LP_N_PV(_pin, _name, _dpd_reg, _dpd_bit, _padv_reg, \
+				_padv_bit, _v0, _v1, _iopwr_bit, _bds)	    \
+	TEGRA186_IO_PAD_CONFIG(_pin, 1, _name, _dpd_reg, _dpd_bit,	    \
+			       _padv_reg, _padv_bit, _v0, _v1, _iopwr_bit,  \
+			       _bds)
+
+#define TEGRA186_IO_PAD_PVONLY(_pin, _name, _padv_reg, _padv_bit, _v0, _v1, \
+			       _iopwr_bit, _bds)			    \
+	TEGRA186_IO_PAD_CONFIG(_pin, 1, _name, DPD, UINT_MAX, _padv_reg,    \
+			       _padv_bit, _v0, _v1, _iopwr_bit, _bds)
+
+#define TEGRA186_IO_PAD_DESC_LP(_pin, _name, _dpd_reg, _dpd_bit, _iopwr_bit, \
+				_bds)					     \
+	{								\
+		.number = _pin,						\
+		.name = #_name,						\
+	},
+
+#define TEGRA186_IO_PAD_DESC_LP_N_PV(_pin, _name, _dpd_reg, _dpd_bit,	\
+				     _padv_reg, _padv_bit, _v0, _v1,	\
+				     _iopwr_bit, _bds)			\
+	TEGRA186_IO_PAD_DESC_LP(_pin, _name, _dpd_reg, _dpd_bit,	\
+				_iopwr_bit, _bds)
+
+#define TEGRA186_IO_PAD_DESC_PV(_pin, _name, _padv_reg, _padv_bit, _v0, _v1, \
+			       _iopwr_bit, _bds)			    \
+	TEGRA186_IO_PAD_DESC_LP(_pin, _name, UINT_MAX, UINT_MAX,	    \
+				UINT_MAX, UINT_MAX)
+
+#define TEGRA186_IO_PAD_TABLE(_lponly_, _pvonly_, _lp_n_pv_)	\
+	_lponly_(0, csia, DPD, 0, UINT_MAX, false)			\
+	_lponly_(1, csib, DPD, 1, UINT_MAX, false)			\
+	_lponly_(2, dsi, DPD, 2, UINT_MAX, false)			\
+	_lponly_(3, mipi-bias, DPD, 3, 9, false)			\
+	_lponly_(4, pex-clk_bias, DPD, 4, UINT_MAX, false)		\
+	_lponly_(5, pex-clk3, DPD, 5, UINT_MAX, false)			\
+	_lponly_(6, pex-clk2, DPD, 6, UINT_MAX, false)			\
+	_lponly_(7, pex-clk1, DPD, 7, UINT_MAX, false)			\
+	_lponly_(8, usb0, DPD, 9, UINT_MAX, false)			\
+	_lponly_(9, usb1, DPD, 10, UINT_MAX, false)			\
+	_lponly_(10, usb2, DPD, 11, UINT_MAX, false)			\
+	_lponly_(11, usb-bias, DPD, 12, UINT_MAX, false)		\
+	_lponly_(12, uart, DPD, 14, 2, false)				\
+	_lponly_(13, audio, DPD, 17, 5, false)				\
+	_lponly_(14, hsic, DPD, 19, UINT_MAX, false)			\
+	_lp_n_pv_(15, dbg, DPD, 25, E_18V, 4, 1200, 1800, 19, false)	\
+	_lponly_(16, hdmi-dp0, DPD, 28, UINT_MAX, false)		\
+	_lponly_(17, hdmi-dp1, DPD, 29, UINT_MAX, false)		\
+	_lponly_(18, pex-ctrl, DPD2, 0, 11, false)			\
+	_lp_n_pv_(19, sdmmc2-hv, DPD2, 2, E_33V, 5, 1800, 3300, 30, true) \
+	_lponly_(20, sdmmc4, DPD2, 4, 14, false)			\
+	_lponly_(21, cam, DPD2, 6, 10, false)				\
+	_lponly_(22, dsib, DPD2, 8, UINT_MAX, false)			\
+	_lponly_(23, dsic, DPD2, 9, UINT_MAX, false)			\
+	_lponly_(24, dsid, DPD2, 10, UINT_MAX, false)			\
+	_lponly_(25, csic, DPD2, 11, UINT_MAX, false)			\
+	_lponly_(26, csid, DPD2, 12, UINT_MAX, false)			\
+	_lponly_(27, csie, DPD2, 13, UINT_MAX, false)			\
+	_lponly_(28, csif, DPD2, 14, UINT_MAX, false)			\
+	_lp_n_pv_(29, spi, DPD2, 15, E_18V, 5, 1200, 1800, 22, false)	\
+	_lp_n_pv_(30, ufs, DPD2, 17, E_18V, 0, 1200, 1800, 6, false)	\
+	_lp_n_pv_(31, dmic-hv, DPD2, 20, E_33V, 2, 1800, 3300, 28, true) \
+	_lponly_(32, edp, DPD2, 21, 4, false)				\
+	_lp_n_pv_(33, sdmmc1-hv, DPD2, 23, E_33V, 4, 1800, 3300, 15, true) \
+	_lp_n_pv_(34, sdmmc3-hv, DPD2, 24, E_33V, 6, 1800, 3300, 31, true) \
+	_lponly_(35, conn, DPD2, 28, 3, false)				\
+	_lp_n_pv_(36, audio-hv, DPD2, 29, E_33V, 1, 1800, 3300, 18, true) \
+	_pvonly_(37, ao-hv, E_33V, 0, 1800, 3300, 27, true)
+
+static const struct tegra_io_pad_soc tegra186_io_pads[] = {
+	TEGRA186_IO_PAD_TABLE(TEGRA186_IO_PAD_LPONLY, TEGRA186_IO_PAD_PVONLY,
+			      TEGRA186_IO_PAD_LP_N_PV)
+};
+
+static const struct pinctrl_pin_desc tegra186_io_pads_pinctrl_desc[] = {
+	TEGRA186_IO_PAD_TABLE(TEGRA186_IO_PAD_DESC_LP, TEGRA186_IO_PAD_DESC_PV,
+			      TEGRA186_IO_PAD_DESC_LP_N_PV)
+};
+
 static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_powergates = 0,
 	.powergates = NULL,
@@ -1878,6 +2367,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.has_gpu_clamps = false,
 	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
 	.io_pads = tegra186_io_pads,
+	.num_descs = ARRAY_SIZE(tegra186_io_pads_pinctrl_desc),
+	.descs = tegra186_io_pads_pinctrl_desc,
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index c32bf91..c3acc2e 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (c) 2010 Google, Inc
- * Copyright (c) 2014 NVIDIA Corporation
+ * Copyright (c) 2014-2018 NVIDIA Corporation
  *
  * Author:
  *	Colin Cross <ccross@google.com>
@@ -160,11 +160,10 @@ int tegra_powergate_remove_clamping(unsigned int id);
 int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 				      struct reset_control *rst);
 
-int tegra_io_pad_power_enable(enum tegra_io_pad id);
-int tegra_io_pad_power_disable(enum tegra_io_pad id);
-int tegra_io_pad_set_voltage(enum tegra_io_pad id,
-			     enum tegra_io_pad_voltage voltage);
-int tegra_io_pad_get_voltage(enum tegra_io_pad id);
+int tegra_pmc_io_pad_low_power_enable(const char *pad_name);
+int tegra_pmc_io_pad_low_power_disable(const char *pad_name);
+int tegra_pmc_io_pad_set_voltage(const char *pad_name, unsigned int pad_uv);
+int tegra_pmc_io_pad_get_voltage(const char *pad_name);
 
 /* deprecated, use tegra_io_pad_power_{enable,disable}() instead */
 int tegra_io_rail_power_on(unsigned int id);
@@ -202,23 +201,23 @@ static inline int tegra_powergate_sequence_power_up(unsigned int id,
 	return -ENOSYS;
 }
 
-static inline int tegra_io_pad_power_enable(enum tegra_io_pad id)
+static inline int tegra_pmc_io_pad_low_power_enable(const char *pad_name)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_io_pad_power_disable(enum tegra_io_pad id)
+static inline int tegra_pmc_io_pad_low_power_disable(const char *pad_name)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_io_pad_set_voltage(enum tegra_io_pad id,
-					   enum tegra_io_pad_voltage voltage)
+static inline int tegra_pmc_io_pad_set_voltage(const char *pad_name,
+					       unsigned int pad_uv)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_io_pad_get_voltage(enum tegra_io_pad id)
+static inline int tegra_pmc_io_pad_get_voltage(const char *pad_name)
 {
 	return -ENOSYS;
 }
-- 
2.1.4

