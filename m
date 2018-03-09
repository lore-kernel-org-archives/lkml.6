Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeCIQZx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:25:53 -0500
Received: from mail1.bemta5.messagelabs.com ([195.245.231.145]:6909 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751215AbeCIQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:25:49 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42KJ27nUWLdz66I
  og5YuTYtTLXvYLa5cPMRkMfXhEzaL+UfOsVrsPf+R2eLblQ4mi8u75rBZLL1+kcmic1c/q0Xr
  3iPsFhu+r2V04PbY8LmJzaP10l82jzXz1jB67Jx1l91jwaZSj02rOtk89r1dxuaxfstVFo/Pm
  +QCOKNYM/OS8isSWDOO7Z/OXtDtWrFz+W3mBsY2qy5GLg4hgXWMEpuvXWXuYuQEciokTnUuZA
  Wx2QQsJCafeMAGYrMIqEhMWw1RIyzgI3HhzXFWkGYRgUuMEltefQArYhZ4yChxqT8axOYVcJB
  4/H8RC4QtKHFy5hMWiBoJiYMvXkAtM5A4vaARLC4hYC8x/T3IAg4gW1+i8VgsRNhQ4vusbywQ
  YXOJvq0JExj5ZyEZOgvJ0AWMTKsYNYpTi8pSi3SNDPSSijLTM0pyEzNzdA0NTPVyU4uLE9NTc
  xKTivWS83M3MQKjo56BgXEHY+Nsv0OMkhxMSqK8uvMXRQnxJeWnVGYkFmfEF5XmpBYfYpTh4F
  CS4J2zBSgnWJSanlqRlpkDjFOYtAQHj5IIbwxImre4IDG3ODMdInWKUZfjxovXbcxCLHn5eal
  S4rzLQYoEQIoySvPgRsBSxiVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrwJIFN4MvNK4Da9
  AjqCCeiIvZcXgBxRkoiQkmpglDpg2e2oobCka87aX/ezlvTemLpuau5Sz9kH+u8E1HnsWPRJY
  NpDDhdl9V+pZ17qB+1hXFFZmf/Du4JZMURo8ma7DN3lP41iShhepfO+Epi9c3eQ3OYeW+FNLj
  fmCZyekL4wuvHJ2tRtby1XbvyrGRoX/Pjcg1X8jr5pT0rS5za8Lurxvueup8RSnJFoqMVcVJw
  IALEGqSEUAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-179.messagelabs.com!1520612745!100935735!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 9 Mar 2018 16:25:43 +0000
Subject: [PATCH] ASoC: da7219: Add common clock usage for providing DAI clks
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@google.com>,
        Support Opensource <support.opensource@diasemi.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <20180309162544.783133FB14@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 09/03/2018 09:48:00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need to use DA7219 as DAI clock master for other codecs
within a system, which means that the DAI clocks are required to
remain, regardless of whether the codec is actually running
playback/capture. To be able to expose control of the DAI clocking
the common clock framework has been employed.

The current implementation adds a simple clock gate for enabling
and disabling the DAI clocks, with no rate control supported
(this is still handled through standard hw_params() functions as
before). If DT is enabled then the clock is added to the OF
providers list, otherwise a clkdev lookup is used.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7219.txt |   6 +
 include/sound/da7219.h                             |   2 +
 sound/soc/codecs/da7219.c                          | 129 +++++++++++++++++++--
 sound/soc/codecs/da7219.h                          |   9 ++
 4 files changed, 138 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index 5b54d2d..c3df92d 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -25,6 +25,9 @@ Optional properties:
   interrupt is to be used to wake system, otherwise "irq" should be used.
 - wakeup-source: Flag to indicate this device can wake system (suspend/resume).
 
+- #clock-cells :  Should be set to '<0>', only one clock source provided;
+- clock-output-names : Name given for DAI clocks output;
+
 - clocks : phandle and clock specifier for codec MCLK.
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
 
@@ -83,6 +86,9 @@ Example:
 		VDDMIC-supply = <&reg_audio>;
 		VDDIO-supply = <&reg_audio>;
 
+		#clock-cells = <0>;
+		clock-output-names = "dai-clks";
+
 		clocks = <&clks 201>;
 		clock-names = "mclk";
 
diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 409ef139..1bfcb16 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -36,6 +36,8 @@ enum da7219_mic_amp_in_sel {
 struct da7219_pdata {
 	bool wakeup_source;
 
+	const char *dai_clks_name;
+
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5e043d0..4412159 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -13,6 +13,8 @@
 
 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
 #include <linux/property.h>
@@ -772,16 +774,27 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 pll_ctrl, pll_status;
-	int i = 0;
+	int i = 0, ret;
 	bool srm_lock = false;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (da7219->master)
+		if (da7219->master) {
 			/* Enable DAI clks for master mode */
-			snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-					    DA7219_DAI_CLK_EN_MASK,
-					    DA7219_DAI_CLK_EN_MASK);
+			if (da7219->dai_clks) {
+				ret = clk_prepare_enable(da7219->dai_clks);
+				if (ret) {
+					dev_err(component->dev,
+						"Failed to enable dai_clks\n");
+					return ret;
+				}
+			} else {
+				snd_soc_component_update_bits(component,
+							      DA7219_DAI_CLK_MODE,
+							      DA7219_DAI_CLK_EN_MASK,
+							      DA7219_DAI_CLK_EN_MASK);
+			}
+		}
 
 		/* PC synchronised to DAI */
 		snd_soc_component_update_bits(component, DA7219_PC_COUNT,
@@ -814,9 +827,16 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 				    DA7219_PC_FREERUN_MASK);
 
 		/* Disable DAI clks if in master mode */
-		if (da7219->master)
-			snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-					    DA7219_DAI_CLK_EN_MASK, 0);
+		if (da7219->master) {
+			if (da7219->dai_clks)
+				clk_disable_unprepare(da7219->dai_clks);
+			else
+				snd_soc_component_update_bits(component,
+							      DA7219_DAI_CLK_MODE,
+							      DA7219_DAI_CLK_EN_MASK,
+							      0);
+		}
+
 		return 0;
 	default:
 		return -EINVAL;
@@ -1598,6 +1618,12 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 
 	pdata->wakeup_source = device_property_read_bool(dev, "wakeup-source");
 
+	pdata->dai_clks_name = "da7219-dai-clks";
+	if (device_property_read_string(dev, "clock-output-names",
+					&pdata->dai_clks_name))
+		dev_warn(dev, "Using default clk name: %s\n",
+			 pdata->dai_clks_name);
+
 	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
 		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
 	else
@@ -1712,6 +1738,88 @@ static int da7219_handle_supplies(struct snd_soc_component *component)
 	return 0;
 }
 
+#ifdef CONFIG_COMMON_CLK
+static int da7219_dai_clks_prepare(struct clk_hw *hw)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv, dai_clks_hw);
+	struct snd_soc_component *component = da7219->aad->component;
+
+	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+				      DA7219_DAI_CLK_EN_MASK,
+				      DA7219_DAI_CLK_EN_MASK);
+
+	return 0;
+}
+
+static void da7219_dai_clks_unprepare(struct clk_hw *hw)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv, dai_clks_hw);
+	struct snd_soc_component *component = da7219->aad->component;
+
+	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+				      DA7219_DAI_CLK_EN_MASK, 0);
+}
+
+static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv, dai_clks_hw);
+	struct snd_soc_component *component = da7219->aad->component;
+	u8 clk_reg;
+
+	clk_reg = snd_soc_component_read32(component, DA7219_DAI_CLK_MODE);
+
+	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
+}
+
+const struct clk_ops da7219_dai_clks_ops = {
+	.prepare = da7219_dai_clks_prepare,
+	.unprepare = da7219_dai_clks_unprepare,
+	.is_prepared = da7219_dai_clks_is_prepared,
+};
+
+static void da7219_register_dai_clks(struct snd_soc_component *component)
+{
+	struct device *dev = component->dev;
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	struct da7219_pdata *pdata = da7219->pdata;
+	struct clk_init_data init = {};
+	struct clk *dai_clks;
+	struct clk_lookup *dai_clks_lookup;
+
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	init.name = pdata->dai_clks_name;
+	init.ops = &da7219_dai_clks_ops;
+	da7219->dai_clks_hw.init = &init;
+
+	dai_clks = devm_clk_register(dev, &da7219->dai_clks_hw);
+	if (IS_ERR(dai_clks)) {
+		dev_warn(dev, "Failed to register DAI clocks: %ld\n",
+			 PTR_ERR(dai_clks));
+		return;
+	}
+	da7219->dai_clks = dai_clks;
+
+	/* If we're using DT, then register as provider accordingly */
+	if (dev->of_node) {
+		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					    &da7219->dai_clks_hw);
+	} else {
+		dai_clks_lookup = clkdev_create(dai_clks, pdata->dai_clks_name,
+						"%s", dev_name(dev));
+		if (!dai_clks_lookup)
+			dev_warn(dev, "Failed to create DAI clkdev");
+		else
+			da7219->dai_clks_lookup = dai_clks_lookup;
+	}
+}
+#else
+static inline void da7219_register_dai_clks(struct snd_soc_component *component) {}
+#endif /* CONFIG_COMMON_CLK */
+
 static void da7219_handle_pdata(struct snd_soc_component *component)
 {
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
@@ -1722,6 +1830,8 @@ static void da7219_handle_pdata(struct snd_soc_component *component)
 
 		da7219->wakeup_source = pdata->wakeup_source;
 
+		da7219_register_dai_clks(component);
+
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
 		case DA7219_MICBIAS_1_6V:
@@ -1856,6 +1966,9 @@ static void da7219_remove(struct snd_soc_component *component)
 
 	da7219_aad_exit(component);
 
+	if (da7219->dai_clks_lookup)
+		clkdev_drop(da7219->dai_clks_lookup);
+
 	/* Supplies */
 	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
 }
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 1acb34c..1b00023 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -14,6 +14,9 @@
 #ifndef __DA7219_H
 #define __DA7219_H
 
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <sound/da7219.h>
@@ -813,6 +816,12 @@ struct da7219_priv {
 	struct mutex ctrl_lock;
 	struct mutex pll_lock;
 
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw dai_clks_hw;
+#endif
+	struct clk_lookup *dai_clks_lookup;
+	struct clk *dai_clks;
+
 	struct clk *mclk;
 	unsigned int mclk_rate;
 	int clk_src;
-- 
1.9.1
