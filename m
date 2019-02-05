Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447E320830
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Iw9VDj+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfBEDMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:12:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42064 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfBEDMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549336317; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lh1gCd97iYU6SD1/yU+k/VukBSA/zBGCso9Sj9wBI5Q=;
        b=Iw9VDj+/bPUUDiQhmLUiQ6hw+XIszwUV+SKoYVb2vCb0KOlfYQIGaVVBs9dg94MdoA2qp5
        qvujSMekiRHB5hea5d+lbWlVKHAHnwuDOj1t31kMVq3QydCJlx1LFRjrznuGXBzIY+cMnt
        APpcWD9tr+DaQ5rCRQ0ZfHDrMqHF3Ek=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/6] ASoC: codecs: Add jz4725b-codec driver
Date:   Tue,  5 Feb 2019 00:11:08 -0300
Message-Id: <20190205031108.26171-6-paul@crapouillou.net>
In-Reply-To: <20190205031108.26171-1-paul@crapouillou.net>
References: <20190205031108.26171-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add jz4725b-codec driver to support the internal CODEC found in the
JZ4725B SoC from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/Kconfig   |  12 +
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/jz4725b.c | 599 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 613 insertions(+)
 create mode 100644 sound/soc/codecs/jz4725b.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2a6d3f86ca96..7b27b70d0a92 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -88,6 +88,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
+	select SND_SOC_JZ4725B_CODEC
 	select SND_SOC_LM4857 if I2C
 	select SND_SOC_LM49453 if I2C
 	select SND_SOC_MAX98088 if I2C
@@ -570,6 +571,17 @@ config SND_SOC_JZ4740_CODEC
 	  This driver can also be built as a module. If so, the module
 	  will be called snd-soc-jz4740-codec.
 
+config SND_SOC_JZ4725B_CODEC
+	depends on MIPS || COMPILE_TEST
+	select REGMAP
+	tristate "Ingenic JZ4725B internal CODEC"
+	help
+	  Enable support for the internal CODEC found in the JZ4725B SoC
+	  from Ingenic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called snd-soc-jz4725b-codec.
+
 config SND_SOC_L3
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 66f55d185620..5ea9eaff1817 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -84,6 +84,7 @@ snd-soc-ics43432-objs := ics43432.o
 snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
+snd-soc-jz4725b-codec-objs := jz4725b.o
 snd-soc-l3-objs := l3.o
 snd-soc-lm4857-objs := lm4857.o
 snd-soc-lm49453-objs := lm49453.o
@@ -350,6 +351,7 @@ obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
+obj-$(CONFIG_SND_SOC_JZ4725B_CODEC)	+= snd-soc-jz4725b-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_LM4857)	+= snd-soc-lm4857.o
 obj-$(CONFIG_SND_SOC_LM49453)   += snd-soc-lm49453.o
diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
new file mode 100644
index 000000000000..e3dba92f30bd
--- /dev/null
+++ b/sound/soc/codecs/jz4725b.c
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ4725B CODEC driver
+ *
+ * Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+
+#include <linux/delay.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define ICDC_RGADW_OFFSET		0x00
+#define ICDC_RGDATA_OFFSET		0x04
+
+/* ICDC internal register access control register(RGADW) */
+#define ICDC_RGADW_RGWR			BIT(16)
+
+#define ICDC_RGADW_RGADDR_OFFSET	8
+#define	ICDC_RGADW_RGADDR_MASK		GENMASK(14, ICDC_RGADW_RGADDR_OFFSET)
+
+#define ICDC_RGADW_RGDIN_OFFSET		0
+#define	ICDC_RGADW_RGDIN_MASK		GENMASK(7, ICDC_RGADW_RGDIN_OFFSET)
+
+/* ICDC internal register data output register (RGDATA)*/
+#define ICDC_RGDATA_IRQ			BIT(8)
+
+#define ICDC_RGDATA_RGDOUT_OFFSET	0
+#define ICDC_RGDATA_RGDOUT_MASK		GENMASK(7, ICDC_RGDATA_RGDOUT_OFFSET)
+
+/* JZ internal register space */
+enum {
+	JZ4725B_CODEC_REG_AICR,
+	JZ4725B_CODEC_REG_CR1,
+	JZ4725B_CODEC_REG_CR2,
+	JZ4725B_CODEC_REG_CCR1,
+	JZ4725B_CODEC_REG_CCR2,
+	JZ4725B_CODEC_REG_PMR1,
+	JZ4725B_CODEC_REG_PMR2,
+	JZ4725B_CODEC_REG_CRR,
+	JZ4725B_CODEC_REG_ICR,
+	JZ4725B_CODEC_REG_IFR,
+	JZ4725B_CODEC_REG_CGR1,
+	JZ4725B_CODEC_REG_CGR2,
+	JZ4725B_CODEC_REG_CGR3,
+	JZ4725B_CODEC_REG_CGR4,
+	JZ4725B_CODEC_REG_CGR5,
+	JZ4725B_CODEC_REG_CGR6,
+	JZ4725B_CODEC_REG_CGR7,
+	JZ4725B_CODEC_REG_CGR8,
+	JZ4725B_CODEC_REG_CGR9,
+	JZ4725B_CODEC_REG_CGR10,
+	JZ4725B_CODEC_REG_TR1,
+	JZ4725B_CODEC_REG_TR2,
+	JZ4725B_CODEC_REG_CR3,
+	JZ4725B_CODEC_REG_AGC1,
+	JZ4725B_CODEC_REG_AGC2,
+	JZ4725B_CODEC_REG_AGC3,
+	JZ4725B_CODEC_REG_AGC4,
+	JZ4725B_CODEC_REG_AGC5,
+};
+
+#define REG_AICR_CONFIG1_OFFSET		0
+#define REG_AICR_CONFIG1_MASK		(0xf << REG_AICR_CONFIG1_OFFSET)
+
+#define REG_CR1_SB_MICBIAS_OFFSET	7
+#define REG_CR1_MONO_OFFSET		6
+#define REG_CR1_DAC_MUTE_OFFSET		5
+#define REG_CR1_HP_DIS_OFFSET		4
+#define REG_CR1_DACSEL_OFFSET		3
+#define REG_CR1_BYPASS_OFFSET		2
+
+#define REG_CR2_DAC_DEEMP_OFFSET	7
+#define REG_CR2_DAC_ADWL_OFFSET		5
+#define REG_CR2_DAC_ADWL_MASK		(0x3 << REG_CR2_DAC_ADWL_OFFSET)
+#define REG_CR2_ADC_ADWL_OFFSET		3
+#define REG_CR2_ADC_ADWL_MASK		(0x3 << REG_CR2_ADC_ADWL_OFFSET)
+#define REG_CR2_ADC_HPF_OFFSET		2
+
+#define REG_CR3_SB_MIC1_OFFSET		7
+#define REG_CR3_SB_MIC2_OFFSET		6
+#define REG_CR3_SIDETONE1_OFFSET	5
+#define REG_CR3_SIDETONE2_OFFSET	4
+#define REG_CR3_MICDIFF_OFFSET		3
+#define REG_CR3_MICSTEREO_OFFSET	2
+#define REG_CR3_INSEL_OFFSET		0
+#define REG_CR3_INSEL_MASK		(0x3 << REG_CR3_INSEL_OFFSET)
+
+#define REG_CCR1_CONFIG4_OFFSET		0
+#define REG_CCR1_CONFIG4_MASK		(0xf << REG_CCR1_CONFIG4_OFFSET)
+
+#define REG_CCR2_DFREQ_OFFSET		4
+#define REG_CCR2_DFREQ_MASK		(0xf << REG_CCR2_DFREQ_OFFSET)
+#define REG_CCR2_AFREQ_OFFSET		0
+#define REG_CCR2_AFREQ_MASK		(0xf << REG_CCR2_AFREQ_OFFSET)
+
+#define REG_PMR1_SB_DAC_OFFSET		7
+#define REG_PMR1_SB_OUT_OFFSET		6
+#define REG_PMR1_SB_MIX_OFFSET		5
+#define REG_PMR1_SB_ADC_OFFSET		4
+#define REG_PMR1_SB_LIN_OFFSET		3
+#define REG_PMR1_SB_IND_OFFSET		0
+
+#define REG_PMR2_LRGI_OFFSET		7
+#define REG_PMR2_RLGI_OFFSET		6
+#define REG_PMR2_LRGOD_OFFSET		5
+#define REG_PMR2_RLGOD_OFFSET		4
+#define REG_PMR2_GIM_OFFSET		3
+#define REG_PMR2_SB_MC_OFFSET		2
+#define REG_PMR2_SB_OFFSET		1
+#define REG_PMR2_SB_SLEEP_OFFSET	0
+
+#define REG_IFR_RAMP_UP_DONE_OFFSET	3
+#define REG_IFR_RAMP_DOWN_DONE_OFFSET	2
+
+#define REG_CGR1_GODL_OFFSET		4
+#define REG_CGR1_GODL_MASK		(0xf << REG_CGR1_GODL_OFFSET)
+#define REG_CGR1_GODR_OFFSET		0
+#define REG_CGR1_GODR_MASK		(0xf << REG_CGR1_GODR_OFFSET)
+
+#define REG_CGR2_GO1R_OFFSET		0
+#define REG_CGR2_GO1R_MASK		(0x1f << REG_CGR2_GO1R_OFFSET)
+
+#define REG_CGR3_GO1L_OFFSET		0
+#define REG_CGR3_GO1L_MASK		(0x1f << REG_CGR3_GO1L_OFFSET)
+
+struct jz_icdc {
+	struct regmap *regmap;
+	void __iomem *base;
+	struct clk *clk;
+};
+
+static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_dac_tlv, -2250, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(jz4725b_line_tlv, -1500, 600);
+
+static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
+	SOC_DOUBLE_TLV("Master Playback Volume",
+		       JZ4725B_CODEC_REG_CGR1,
+		       REG_CGR1_GODL_OFFSET,
+		       REG_CGR1_GODR_OFFSET,
+		       0xf, 1, jz4725b_dac_tlv),
+	SOC_DOUBLE_R_TLV("Master Capture Volume",
+			 JZ4725B_CODEC_REG_CGR3,
+			 JZ4725B_CODEC_REG_CGR2,
+			 REG_CGR2_GO1R_OFFSET,
+			 0x1f, 1, jz4725b_line_tlv),
+
+	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
+		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
+
+	SOC_SINGLE("Deemphatize Filter Playback Switch",
+		   JZ4725B_CODEC_REG_CR2,
+		   REG_CR2_DAC_DEEMP_OFFSET, 1, 0),
+
+	SOC_SINGLE("High-Pass Filter Capture Switch",
+		   JZ4725B_CODEC_REG_CR2,
+		   REG_CR2_ADC_HPF_OFFSET, 1, 0),
+};
+
+static const char * const jz4725b_codec_adc_src_texts[] = {
+	"Mic 1", "Mic 2", "Line In", "Mixer",
+};
+static const unsigned int jz4725b_codec_adc_src_values[] = { 0, 1, 2, 3, };
+static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
+					JZ4725B_CODEC_REG_CR3,
+					REG_CR3_INSEL_OFFSET,
+					REG_CR3_INSEL_MASK,
+					jz4725b_codec_adc_src_texts,
+					jz4725b_codec_adc_src_values);
+static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
+			SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
+
+static const struct snd_kcontrol_new jz4725b_codec_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line In Bypass", JZ4725B_CODEC_REG_CR1,
+			REG_CR1_BYPASS_OFFSET, 1, 0),
+};
+
+static int jz4725b_out_stage_enable(struct snd_soc_dapm_widget *w,
+				    struct snd_kcontrol *kcontrol,
+				    int event)
+{
+	struct snd_soc_component *codec = snd_soc_dapm_to_component(w->dapm);
+	struct jz_icdc *icdc = snd_soc_component_get_drvdata(codec);
+	struct regmap *map = icdc->regmap;
+	unsigned int val;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return regmap_update_bits(map, JZ4725B_CODEC_REG_IFR,
+					  BIT(REG_IFR_RAMP_UP_DONE_OFFSET), 0);
+	case SND_SOC_DAPM_POST_PMU:
+		return regmap_read_poll_timeout(map, JZ4725B_CODEC_REG_IFR,
+			       val, val & BIT(REG_IFR_RAMP_UP_DONE_OFFSET),
+			       100000, 500000);
+	case SND_SOC_DAPM_PRE_PMD:
+		return regmap_update_bits(map, JZ4725B_CODEC_REG_IFR,
+				BIT(REG_IFR_RAMP_DOWN_DONE_OFFSET), 0);
+	case SND_SOC_DAPM_POST_PMD:
+		return regmap_read_poll_timeout(map, JZ4725B_CODEC_REG_IFR,
+			       val, val & BIT(REG_IFR_RAMP_DOWN_DONE_OFFSET),
+			       100000, 500000);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct snd_soc_dapm_widget jz4725b_codec_dapm_widgets[] = {
+	/* DAC */
+	SND_SOC_DAPM_DAC("DAC", "Playback",
+			 JZ4725B_CODEC_REG_PMR1, REG_PMR1_SB_DAC_OFFSET, 1),
+
+	/* ADC */
+	SND_SOC_DAPM_ADC("ADC", "Capture",
+			 JZ4725B_CODEC_REG_PMR1, REG_PMR1_SB_ADC_OFFSET, 1),
+
+	SND_SOC_DAPM_MUX("ADC Source", SND_SOC_NOPM, 0, 0,
+			 &jz4725b_codec_adc_src_ctrl),
+
+	/* Mixer */
+	SND_SOC_DAPM_MIXER("Mixer", JZ4725B_CODEC_REG_PMR1,
+			   REG_PMR1_SB_MIX_OFFSET, 1,
+			   jz4725b_codec_mixer_controls,
+			   ARRAY_SIZE(jz4725b_codec_mixer_controls)),
+	SND_SOC_DAPM_MIXER("DAC to Mixer", JZ4725B_CODEC_REG_CR1,
+			   REG_CR1_DACSEL_OFFSET, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("Line In", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("HP Out", JZ4725B_CODEC_REG_CR1,
+			   REG_CR1_HP_DIS_OFFSET, 1, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("Mic 1", JZ4725B_CODEC_REG_CR3,
+			   REG_CR3_SB_MIC1_OFFSET, 1, NULL, 0),
+	SND_SOC_DAPM_MIXER("Mic 2", JZ4725B_CODEC_REG_CR3,
+			   REG_CR3_SB_MIC2_OFFSET, 1, NULL, 0),
+
+	SND_SOC_DAPM_MIXER_E("Out Stage", JZ4725B_CODEC_REG_PMR1,
+			     REG_PMR1_SB_OUT_OFFSET, 1, NULL, 0,
+			     jz4725b_out_stage_enable,
+			     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			     SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER("Mixer to ADC", JZ4725B_CODEC_REG_PMR1,
+			   REG_PMR1_SB_IND_OFFSET, 1, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("Mic Bias", JZ4725B_CODEC_REG_CR1,
+			    REG_CR1_SB_MICBIAS_OFFSET, 1, NULL, 0),
+
+	/* Pins */
+	SND_SOC_DAPM_INPUT("MIC1P"),
+	SND_SOC_DAPM_INPUT("MIC1N"),
+	SND_SOC_DAPM_INPUT("MIC2P"),
+	SND_SOC_DAPM_INPUT("MIC2N"),
+
+	SND_SOC_DAPM_INPUT("LLINEIN"),
+	SND_SOC_DAPM_INPUT("RLINEIN"),
+
+	SND_SOC_DAPM_OUTPUT("LHPOUT"),
+	SND_SOC_DAPM_OUTPUT("RHPOUT"),
+};
+
+static const struct snd_soc_dapm_route jz4725b_codec_dapm_routes[] = {
+	{"Mic 1", NULL, "MIC1P"},
+	{"Mic 1", NULL, "MIC1N"},
+	{"Mic 2", NULL, "MIC2P"},
+	{"Mic 2", NULL, "MIC2N"},
+
+	{"Line In", NULL, "LLINEIN"},
+	{"Line In", NULL, "RLINEIN"},
+
+	{"Mixer", "Line In Bypass", "Line In"},
+	{"DAC to Mixer", NULL, "DAC"},
+	{"Mixer", NULL, "DAC to Mixer"},
+
+	{"Mixer to ADC", NULL, "Mixer"},
+	{"ADC Source", "Mixer", "Mixer to ADC"},
+	{"ADC Source", "Line In", "Line In"},
+	{"ADC Source", "Mic 1", "Mic 1"},
+	{"ADC Source", "Mic 2", "Mic 2"},
+	{"ADC", NULL, "ADC Source"},
+
+	{"Out Stage", NULL, "Mixer"},
+	{"HP Out", NULL, "Out Stage"},
+	{"LHPOUT", NULL, "HP Out"},
+	{"RHPOUT", NULL, "HP Out"},
+};
+
+static int jz4725b_codec_set_bias_level(struct snd_soc_component *component,
+					enum snd_soc_bias_level level)
+{
+	struct jz_icdc *icdc = snd_soc_component_get_drvdata(component);
+	struct regmap *map = icdc->regmap;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
+				   BIT(REG_PMR2_SB_SLEEP_OFFSET), 0);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		/* Enable sound hardware */
+		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
+				   BIT(REG_PMR2_SB_OFFSET), 0);
+		msleep(224);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
+				   BIT(REG_PMR2_SB_SLEEP_OFFSET),
+				   BIT(REG_PMR2_SB_SLEEP_OFFSET));
+		break;
+	case SND_SOC_BIAS_OFF:
+		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
+				   BIT(REG_PMR2_SB_OFFSET),
+				   BIT(REG_PMR2_SB_OFFSET));
+		break;
+	}
+
+	return 0;
+}
+
+static int jz4725b_codec_dev_probe(struct snd_soc_component *component)
+{
+	struct jz_icdc *icdc = snd_soc_component_get_drvdata(component);
+	struct regmap *map = icdc->regmap;
+
+	clk_prepare_enable(icdc->clk);
+
+	/* Write CONFIGn (n=1 to 8) bits.
+	 * The value 0x0f is specified in the datasheet as a requirement.
+	 */
+	regmap_write(map, JZ4725B_CODEC_REG_AICR,
+		     0xf << REG_AICR_CONFIG1_OFFSET);
+	regmap_write(map, JZ4725B_CODEC_REG_CCR1,
+		     0x0 << REG_CCR1_CONFIG4_OFFSET);
+
+	return 0;
+}
+
+static void jz4725b_codec_dev_remove(struct snd_soc_component *component)
+{
+	struct jz_icdc *icdc = snd_soc_component_get_drvdata(component);
+
+	clk_disable_unprepare(icdc->clk);
+}
+
+static const struct snd_soc_component_driver jz4725b_codec = {
+	.probe			= jz4725b_codec_dev_probe,
+	.remove			= jz4725b_codec_dev_remove,
+	.set_bias_level		= jz4725b_codec_set_bias_level,
+	.controls		= jz4725b_codec_controls,
+	.num_controls		= ARRAY_SIZE(jz4725b_codec_controls),
+	.dapm_widgets		= jz4725b_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(jz4725b_codec_dapm_widgets),
+	.dapm_routes		= jz4725b_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(jz4725b_codec_dapm_routes),
+	.suspend_bias_off	= 1,
+	.use_pmdown_time	= 1,
+};
+
+static const unsigned int jz4725b_codec_sample_rates[] = {
+	96000, 48000, 44100, 32000,
+	24000, 22050, 16000, 12000,
+	11025, 9600, 8000,
+};
+
+static int jz4725b_codec_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct jz_icdc *icdc = snd_soc_component_get_drvdata(dai->component);
+	unsigned int rate, bit_width;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bit_width = 0;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		bit_width = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		bit_width = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		bit_width = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (rate = 0; rate < ARRAY_SIZE(jz4725b_codec_sample_rates); rate++) {
+		if (jz4725b_codec_sample_rates[rate] == params_rate(params))
+			break;
+	}
+
+	if (rate == ARRAY_SIZE(jz4725b_codec_sample_rates))
+		return -EINVAL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_update_bits(icdc->regmap,
+				   JZ4725B_CODEC_REG_CR2,
+				   REG_CR2_DAC_ADWL_MASK,
+				   bit_width << REG_CR2_DAC_ADWL_OFFSET);
+
+		regmap_update_bits(icdc->regmap,
+				   JZ4725B_CODEC_REG_CCR2,
+				   REG_CCR2_DFREQ_MASK,
+				   rate << REG_CCR2_DFREQ_OFFSET);
+	} else {
+		regmap_update_bits(icdc->regmap,
+				   JZ4725B_CODEC_REG_CR2,
+				   REG_CR2_ADC_ADWL_MASK,
+				   bit_width << REG_CR2_ADC_ADWL_OFFSET);
+
+		regmap_update_bits(icdc->regmap,
+				   JZ4725B_CODEC_REG_CCR2,
+				   REG_CCR2_AFREQ_MASK,
+				   rate << REG_CCR2_AFREQ_OFFSET);
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops jz4725b_codec_dai_ops = {
+	.hw_params = jz4725b_codec_hw_params,
+};
+
+#define JZ_ICDC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S18_3LE | \
+			 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_3LE)
+
+static struct snd_soc_dai_driver jz4725b_codec_dai = {
+	.name = "jz4725b-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = JZ_ICDC_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = JZ_ICDC_FORMATS,
+	},
+	.ops = &jz4725b_codec_dai_ops,
+};
+
+static bool jz4725b_codec_volatile(struct device *dev, unsigned int reg)
+{
+	return reg == JZ4725B_CODEC_REG_IFR;
+}
+
+static bool jz4725b_codec_can_access_reg(struct device *dev, unsigned int reg)
+{
+	return (reg != JZ4725B_CODEC_REG_TR1) && (reg != JZ4725B_CODEC_REG_TR2);
+}
+
+static int jz4725b_codec_io_wait(struct jz_icdc *icdc)
+{
+	u32 reg;
+
+	return readl_poll_timeout(icdc->base + ICDC_RGADW_OFFSET, reg,
+				  !(reg & ICDC_RGADW_RGWR), 1000, 10000);
+}
+
+static int jz4725b_codec_reg_read(void *context, unsigned int reg,
+				  unsigned int *val)
+{
+	struct jz_icdc *icdc = context;
+	unsigned int i;
+	u32 tmp;
+	int ret;
+
+	ret = jz4725b_codec_io_wait(icdc);
+	if (ret)
+		return ret;
+
+	tmp = readl(icdc->base + ICDC_RGADW_OFFSET);
+	tmp = (tmp & ~ICDC_RGADW_RGADDR_MASK)
+	    | (reg << ICDC_RGADW_RGADDR_OFFSET);
+	writel(tmp, icdc->base + ICDC_RGADW_OFFSET);
+
+	/* wait 6+ cycles */
+	for (i = 0; i < 6; i++)
+		*val = readl(icdc->base + ICDC_RGDATA_OFFSET) &
+			ICDC_RGDATA_RGDOUT_MASK;
+
+	return 0;
+}
+
+static int jz4725b_codec_reg_write(void *context, unsigned int reg,
+				   unsigned int val)
+{
+	struct jz_icdc *icdc = context;
+	int ret;
+
+	ret = jz4725b_codec_io_wait(icdc);
+	if (ret)
+		return ret;
+
+	writel(ICDC_RGADW_RGWR | (reg << ICDC_RGADW_RGADDR_OFFSET) | val,
+			icdc->base + ICDC_RGADW_OFFSET);
+
+	ret = jz4725b_codec_io_wait(icdc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const u8 jz4725b_codec_reg_defaults[] = {
+	0x0c, 0xaa, 0x78, 0x00, 0x00, 0xff, 0x03, 0x51,
+	0x3f, 0x00, 0x00, 0x04, 0x04, 0x04, 0x04, 0x04,
+	0x04, 0x0a, 0x0a, 0x00, 0x00, 0x00, 0xc0, 0x34,
+	0x07, 0x44, 0x1f, 0x00,
+};
+
+static const struct regmap_config jz4725b_codec_regmap_config = {
+	.reg_bits = 7,
+	.val_bits = 8,
+
+	.max_register = JZ4725B_CODEC_REG_AGC5,
+	.volatile_reg = jz4725b_codec_volatile,
+	.readable_reg = jz4725b_codec_can_access_reg,
+	.writeable_reg = jz4725b_codec_can_access_reg,
+
+	.reg_read = jz4725b_codec_reg_read,
+	.reg_write = jz4725b_codec_reg_write,
+
+	.reg_defaults_raw = jz4725b_codec_reg_defaults,
+	.num_reg_defaults_raw = ARRAY_SIZE(jz4725b_codec_reg_defaults),
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int jz4725b_codec_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct jz_icdc *icdc;
+	struct resource *mem;
+	int ret;
+
+	icdc = devm_kzalloc(dev, sizeof(*icdc), GFP_KERNEL);
+	if (!icdc)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	icdc->base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(icdc->base))
+		return PTR_ERR(icdc->base);
+
+	icdc->regmap = devm_regmap_init(dev, NULL, icdc,
+					&jz4725b_codec_regmap_config);
+	if (IS_ERR(icdc->regmap))
+		return PTR_ERR(icdc->regmap);
+
+	icdc->clk = devm_clk_get(&pdev->dev, "aic");
+	if (IS_ERR(icdc->clk))
+		return PTR_ERR(icdc->clk);
+
+	platform_set_drvdata(pdev, icdc);
+
+	ret = devm_snd_soc_register_component(dev, &jz4725b_codec,
+					      &jz4725b_codec_dai, 1);
+	if (ret)
+		dev_err(dev, "Failed to register codec\n");
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id jz4725b_codec_of_matches[] = {
+	{ .compatible = "ingenic,jz4725b-codec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jz4725b_codec_of_matches);
+#endif
+
+static struct platform_driver jz4725b_codec_driver = {
+	.probe = jz4725b_codec_probe,
+	.driver = {
+		.name = "jz4725b-codec",
+		.of_match_table = of_match_ptr(jz4725b_codec_of_matches),
+	},
+};
+module_platform_driver(jz4725b_codec_driver);
+
+MODULE_DESCRIPTION("JZ4725B SoC internal codec driver");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

