Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7FAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D720875
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7D720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeGJMzK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:55:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5032 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932998AbeGJMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:55:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b44ac810001>; Tue, 10 Jul 2018 05:54:25 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 10 Jul 2018 05:55:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 10 Jul 2018 05:55:08 -0700
Received: from dhcp-10-21-25-168.Nvidia.com (10.21.25.201) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Tue, 10 Jul 2018 12:55:05 +0000
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] soc/tegra: pmc: Implement pad configuration via pinctrl
Date:   Tue, 10 Jul 2018 15:54:55 +0300
Message-ID: <1531227295-12752-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
References: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a pinctrl device and implement get and set functions for
PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index b833334..8677391 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -33,6 +33,9 @@
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
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
@@ -162,6 +167,9 @@ struct tegra_pmc_soc {
 	const struct tegra_io_pad_soc *io_pads;
 	unsigned int num_io_pads;
 
+	const struct pinctrl_pin_desc *pin_descs;
+	unsigned int num_pin_descs;
+
 	const struct tegra_pmc_regs *regs;
 	void (*init)(struct tegra_pmc *pmc);
 	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
@@ -220,6 +228,8 @@ struct tegra_pmc {
 	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
 
 	struct mutex powergates_lock;
+
+	struct pinctrl_dev *pctl_dev;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1400,6 +1410,145 @@ static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
 	of_node_put(np);
 }
 
+static int tegra_io_pad_pinctrl_get_groups_count(struct pinctrl_dev *pctl_dev)
+{
+	return pmc->soc->num_io_pads;
+}
+
+static const char *tegra_io_pad_pinctrl_get_group_name(
+		struct pinctrl_dev *pctl, unsigned int group)
+{
+	return pmc->soc->io_pads[group].name;
+}
+
+static int tegra_io_pad_pinctrl_get_group_pins(struct pinctrl_dev *pctl_dev,
+					       unsigned int group,
+					       const unsigned int **pins,
+					       unsigned int *num_pins)
+{
+	*pins = &pmc->soc->io_pads[group].id;
+	*num_pins = 1;
+	return 0;
+}
+
+static const struct pinctrl_ops tegra_io_pad_pinctrl_ops = {
+	.get_groups_count = tegra_io_pad_pinctrl_get_groups_count,
+	.get_group_name = tegra_io_pad_pinctrl_get_group_name,
+	.get_group_pins = tegra_io_pad_pinctrl_get_group_pins,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map = pinconf_generic_dt_free_map,
+};
+
+static int tegra_io_pad_pinconf_get(struct pinctrl_dev *pctl_dev,
+				    unsigned int pin, unsigned long *config)
+{
+	const struct tegra_io_pad_soc *pad = tegra_io_pad_find(pmc, pin);
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	int ret;
+	u32 arg;
+
+	switch (param) {
+	case PIN_CONFIG_POWER_SOURCE:
+		ret = tegra_io_pad_get_voltage(pad->id);
+		if (ret == TEGRA_IO_PAD_1800000UV)
+			arg = TEGRA_IO_PAD_VOLTAGE_1V8;
+		else if (ret == TEGRA_IO_PAD_3300000UV)
+			arg = TEGRA_IO_PAD_VOLTAGE_3V3;
+		else if (ret < 0)
+			return ret;
+		else
+			return -EINVAL;
+		break;
+	case PIN_CONFIG_LOW_POWER_MODE:
+		ret = tegra_io_pad_is_powered(pad->id);
+		if (ret < 0)
+			return ret;
+		arg = !ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int tegra_io_pad_pinconf_set(struct pinctrl_dev *pctl_dev,
+				    unsigned int pin, unsigned long *configs,
+				    unsigned int num_configs)
+{
+	const struct tegra_io_pad_soc *pad = tegra_io_pad_find(pmc, pin);
+	enum tegra_io_pad_voltage voltage;
+	enum pin_config_param param;
+	unsigned int i;
+	int err;
+	u32 arg;
+
+	for (i = 0; i < num_configs; ++i) {
+		param = pinconf_to_config_param(configs[i]);
+		arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_LOW_POWER_MODE:
+			if (arg)
+				err = tegra_io_pad_power_disable(pad->id);
+			else
+				err = tegra_io_pad_power_enable(pad->id);
+			if (err)
+				return err;
+			break;
+		case PIN_CONFIG_POWER_SOURCE:
+			if (arg == TEGRA_IO_PAD_VOLTAGE_1V8)
+				voltage = TEGRA_IO_PAD_1800000UV;
+			else if (arg == TEGRA_IO_PAD_VOLTAGE_3V3)
+				voltage = TEGRA_IO_PAD_3300000UV;
+			else
+				return -EINVAL;
+			err = tegra_io_pad_set_voltage(pad->id, voltage);
+			if (err)
+				return err;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops tegra_io_pad_pinconf_ops = {
+	.pin_config_get = tegra_io_pad_pinconf_get,
+	.pin_config_set = tegra_io_pad_pinconf_set,
+	.is_generic = true,
+};
+
+static struct pinctrl_desc tegra_pmc_pctl_desc = {
+	.pctlops = &tegra_io_pad_pinctrl_ops,
+	.confops = &tegra_io_pad_pinconf_ops,
+};
+
+static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
+{
+	int err = 0;
+
+	if (!pmc->soc->num_pin_descs)
+		return 0;
+
+	tegra_pmc_pctl_desc.name = dev_name(pmc->dev);
+	tegra_pmc_pctl_desc.pins = pmc->soc->pin_descs;
+	tegra_pmc_pctl_desc.npins = pmc->soc->num_pin_descs;
+
+	pmc->pctl_dev = devm_pinctrl_register(pmc->dev, &tegra_pmc_pctl_desc,
+					      pmc);
+	if (IS_ERR(pmc->pctl_dev)) {
+		err = PTR_ERR(pmc->pctl_dev);
+		dev_err(pmc->dev, "unable to register pinctrl, %d\n", err);
+	}
+
+	return err;
+}
+
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -1477,18 +1626,27 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	err = register_restart_handler(&tegra_pmc_restart_handler);
 	if (err) {
-		debugfs_remove(pmc->debugfs);
 		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
 			err);
-		return err;
+		goto cleanup_debugfs;
 	}
 
+	err = tegra_pmc_pinctrl_init(pmc);
+	if (err)
+		goto cleanup_restart_handler;
+
 	mutex_lock(&pmc->powergates_lock);
 	iounmap(pmc->base);
 	pmc->base = base;
 	mutex_unlock(&pmc->powergates_lock);
 
 	return 0;
+
+cleanup_restart_handler:
+	unregister_restart_handler(&tegra_pmc_restart_handler);
+cleanup_debugfs:
+	debugfs_remove(pmc->debugfs);
+	return err;
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
@@ -1578,6 +1736,8 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.has_gpu_clamps = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
+	.num_pin_descs = 0,
+	.pin_descs = NULL,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1617,6 +1777,8 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
+	.num_pin_descs = 0,
+	.pin_descs = NULL,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1660,6 +1822,8 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
+	.num_pin_descs = 0,
+	.pin_descs = NULL,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1706,6 +1870,12 @@ static const u8 tegra124_cpu_powergates[] = {
 		.name	= _name,			\
 	},
 
+#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
+	(struct pinctrl_pin_desc) {			\
+		.number = _id,				\
+		.name	= _name			\
+	},
+
 #define TEGRA124_IO_PAD_TABLE(_pad)					\
 	/* .id                          .dpd    .voltage  .name	*/	\
 	_pad(TEGRA_IO_PAD_AUDIO,	17,	UINT_MAX, "audio")	\
@@ -1743,6 +1913,10 @@ static const struct tegra_io_pad_soc tegra124_io_pads[] = {
 	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
+static const struct pinctrl_pin_desc tegra124_pin_descs[] = {
+	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
+};
+
 static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_powergates = ARRAY_SIZE(tegra124_powergates),
 	.powergates = tegra124_powergates,
@@ -1753,6 +1927,8 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.has_impl_33v_pwr = false,
 	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
 	.io_pads = tegra124_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra124_pin_descs),
+	.pin_descs = tegra124_pin_descs,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1837,6 +2013,10 @@ static const struct tegra_io_pad_soc tegra210_io_pads[] = {
 	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
+static const struct pinctrl_pin_desc tegra210_pin_descs[] = {
+	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
+};
+
 static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_powergates = ARRAY_SIZE(tegra210_powergates),
 	.powergates = tegra210_powergates,
@@ -1848,6 +2028,8 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.needs_mbist_war = true,
 	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
 	.io_pads = tegra210_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra210_pin_descs),
+	.pin_descs = tegra210_pin_descs,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1897,6 +2079,10 @@ static const struct tegra_io_pad_soc tegra186_io_pads[] = {
 	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
+static const struct pinctrl_pin_desc tegra186_pin_descs[] = {
+	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
+};
+
 static const struct tegra_pmc_regs tegra186_pmc_regs = {
 	.scratch0 = 0x2000,
 	.dpd_req = 0x74,
@@ -1950,6 +2136,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.has_impl_33v_pwr = true,
 	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
 	.io_pads = tegra186_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra186_pin_descs),
+	.pin_descs = tegra186_pin_descs,
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
-- 
2.7.4

