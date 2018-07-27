Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD87C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8F208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IC97SaVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbeG0NmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:42:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34689 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388616AbeG0NmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:42:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so4864697wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcWb1zBpy4XR7cEDh/JuKQrGiTv9ZxE5gmhiDpDOusE=;
        b=IC97SaVjKEDuw/to57YywnCOZHFqsslal8YsYN4sLxixMzBV0sKunBak7BemTVcKjG
         Tef34r2WhL6K8xVoP7rPYxOgPgkPUEYLjT5sWiSuraVCcVwvMC+ciy8uJLyDmJ8WoKsF
         4xa90sqIc/i3ON+L0lFynSXJksaDV0LsMJTMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcWb1zBpy4XR7cEDh/JuKQrGiTv9ZxE5gmhiDpDOusE=;
        b=jUm9aAP1RGdpOV9uOqCMeE5faOOlCx6pXr5cxkG7OFMADUAlG/nMnv6H6HyepevcGW
         UoVB23W6U2N3HDds1hhvlEV5dxc6tyvG51UqoQ5N5svtp5eEplK/mc14JIyZ3te5WBdj
         PWvH7ObT0cXTDrxZxVHDxx1Fa0mFwcd7ioBTC+GvZxAbh12Nb2hlvFd2E4Q597JeU6x4
         3d6zzveRgf/p6rTUVKuOFnxzXIgBdHsjDW8YVPcyDI9fWUbAc3Ri3KtdiwoLns+Ry9W+
         1xtsaIYevR86nG5aN23mjjaXH0hFgrqQeVlK8LU9+u7WF4NBWOKbd17wbGXMDkEWpd6z
         94Dg==
X-Gm-Message-State: AOUpUlGS+eDj3yg5pcWVJGmCir0yJ6/CIihAcTgHtp9UvwGP7GoLAtGn
        nIKvf9pUc4rlLF/2ERWBkPwdqQ==
X-Google-Smtp-Source: AAOMgpee9/2tV6uDiTsBD3/1msL+rNZAHP4biOj8pFHg6ngL1kveHuH+12lARdlkmydWwTck73+gAQ==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr4754460wrj.109.1532694029032;
        Fri, 27 Jul 2018 05:20:29 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm6178522wmf.41.2018.07.27.05.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 05:20:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2 04/10] ASoC: wcd9335: add support to wcd9335 codec
Date:   Fri, 27 Jul 2018 13:18:00 +0100
Message-Id: <20180727121806.18209-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
It supports both I2S/I2C and SLIMbus audio interfaces.
On slimbus interface it supports two data lanes; 16 Tx ports
and 8 Rx ports. It has Seven DACs and nine dedicated interpolators,
Seven (six audio ADCs, and one VBAT ADC), Multibutton headset
control (MBHC), Active noise cancellation and Sidetone paths
and processing.

This patchset adds very basic support for playback and capture
via the 9 interpolators and ADC respectively.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/Kconfig   |    5 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/wcd9335.c | 1154 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1161 insertions(+)
 create mode 100644 sound/soc/codecs/wcd9335.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efb095dbcd71..cb09abf18dde 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1066,6 +1066,11 @@ config SND_SOC_UDA1380
         tristate
 	depends on I2C
 
+config SND_SOC_WCD9335
+	tristate "WCD9335 Codec"
+	depends on MFD_WCD9335
+        tristate
+
 config SND_SOC_WL1273
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7ae7c85e8219..01410b63daac 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -192,6 +192,7 @@ snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
+snd-soc-wcd9335-objs := wcd9335.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm-adsp-objs := wm_adsp.o
 snd-soc-wm0010-objs := wm0010.o
@@ -451,6 +452,7 @@ obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
+obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
 obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
 obj-$(CONFIG_SND_SOC_WM0010)	+= snd-soc-wm0010.o
 obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
new file mode 100644
index 000000000000..bd9de5d45fa9
--- /dev/null
+++ b/sound/soc/codecs/wcd9335.c
@@ -0,0 +1,1154 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+// Copyright (c) 2017-2018, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/wait.h>
+#include <linux/bitops.h>
+#include <linux/regulator/consumer.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/slimbus.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include <sound/info.h>
+#include <dt-bindings/mfd/wcd9335.h>
+#include <linux/mfd/wcd9335/wcd9335.h>
+#include <linux/mfd/wcd9335/registers.h>
+
+#define WCD9335_RATES_MASK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+			    SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
+			    SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
+/* Fractional Rates */
+#define WCD9335_FRAC_RATES_MASK (SNDRV_PCM_RATE_44100)
+#define WCD9335_FORMATS_S16_S24_LE (SNDRV_PCM_FMTBIT_S16_LE | \
+				  SNDRV_PCM_FMTBIT_S24_LE)
+
+/* slave port water mark level
+ *   (0: 6bytes, 1: 9bytes, 2: 12 bytes, 3: 15 bytes)
+ */
+#define SLAVE_PORT_WATER_MARK_6BYTES  0
+#define SLAVE_PORT_WATER_MARK_9BYTES  1
+#define SLAVE_PORT_WATER_MARK_12BYTES 2
+#define SLAVE_PORT_WATER_MARK_15BYTES 3
+#define SLAVE_PORT_WATER_MARK_SHIFT 1
+#define SLAVE_PORT_ENABLE           1
+#define SLAVE_PORT_DISABLE          0
+#define WCD9335_SLIM_WATER_MARK_VAL \
+	((SLAVE_PORT_WATER_MARK_12BYTES << SLAVE_PORT_WATER_MARK_SHIFT) | \
+	 (SLAVE_PORT_ENABLE))
+
+#define WCD9335_SLIM_NUM_PORT_REG 3
+#define WCD9335_SLIM_PGD_PORT_INT_TX_EN0 (WCD9335_SLIM_PGD_PORT_INT_EN0 + 2)
+
+#define WCD9335_MCLK_CLK_12P288MHZ	12288000
+#define WCD9335_MCLK_CLK_9P6MHZ		9600000
+
+#define WCD9335_SLIM_CLOSE_TIMEOUT 1000
+#define WCD9335_SLIM_IRQ_OVERFLOW (1 << 0)
+#define WCD9335_SLIM_IRQ_UNDERFLOW (1 << 1)
+#define WCD9335_SLIM_IRQ_PORT_CLOSED (1 << 2)
+
+#define WCD9335_NUM_INTERPOLATORS 9
+#define WCD9335_RX_START	16
+#define WCD9335_SLIM_CH_START 128
+
+#define WCD9335_SLIM_RX_CH(p) \
+	{.port = p + WCD9335_RX_START, .shift = p,}
+
+/* vout step value */
+#define WCD9335_CALCULATE_VOUT_D(req_mv) (((req_mv - 650) * 10) / 25)
+
+enum {
+	WCD9335_RX0 = 0,
+	WCD9335_RX1,
+	WCD9335_RX2,
+	WCD9335_RX3,
+	WCD9335_RX4,
+	WCD9335_RX5,
+	WCD9335_RX6,
+	WCD9335_RX7,
+	WCD9335_RX8,
+	WCD9335_RX9,
+	WCD9335_RX10,
+	WCD9335_RX11,
+	WCD9335_RX12,
+	WCD9335_RX_MAX,
+};
+
+enum {
+	SIDO_SOURCE_INTERNAL = 0,
+	SIDO_SOURCE_RCO_BG,
+};
+
+enum wcd9335_sido_voltage {
+	SIDO_VOLTAGE_SVS_MV = 950,
+	SIDO_VOLTAGE_NOMINAL_MV = 1100,
+};
+
+enum {
+	AIF1_PB = 0,
+	AIF1_CAP,
+	AIF2_PB,
+	AIF2_CAP,
+	AIF3_PB,
+	AIF3_CAP,
+	AIF4_PB,
+	NUM_CODEC_DAIS,
+};
+
+enum {
+	INTn_2_INP_SEL_ZERO = 0,
+	INTn_2_INP_SEL_RX0,
+	INTn_2_INP_SEL_RX1,
+	INTn_2_INP_SEL_RX2,
+	INTn_2_INP_SEL_RX3,
+	INTn_2_INP_SEL_RX4,
+	INTn_2_INP_SEL_RX5,
+	INTn_2_INP_SEL_RX6,
+	INTn_2_INP_SEL_RX7,
+	INTn_2_INP_SEL_PROXIMITY,
+};
+
+enum {
+	INTn_1_MIX_INP_SEL_ZERO = 0,
+	INTn_1_MIX_INP_SEL_DEC0,
+	INTn_1_MIX_INP_SEL_DEC1,
+	INTn_1_MIX_INP_SEL_IIR0,
+	INTn_1_MIX_INP_SEL_IIR1,
+	INTn_1_MIX_INP_SEL_RX0,
+	INTn_1_MIX_INP_SEL_RX1,
+	INTn_1_MIX_INP_SEL_RX2,
+	INTn_1_MIX_INP_SEL_RX3,
+	INTn_1_MIX_INP_SEL_RX4,
+	INTn_1_MIX_INP_SEL_RX5,
+	INTn_1_MIX_INP_SEL_RX6,
+	INTn_1_MIX_INP_SEL_RX7,
+
+};
+
+enum wcd_clock_type {
+	WCD_CLK_OFF,
+	WCD_CLK_RCO,
+	WCD_CLK_MCLK,
+};
+
+struct wcd9335_slim_ch {
+	u32 ch_num;
+	u16 port;
+	u16 shift;
+	struct list_head list;
+};
+
+struct wcd_slim_codec_dai_data {
+	struct list_head slim_ch_list;
+	struct slim_stream_config sconfig;
+	struct slim_stream_runtime *sruntime;
+};
+
+struct wcd9335_codec {
+	struct device *dev;
+	struct clk *mclk;
+	struct clk *native_clk;
+	u32 mclk_rate;
+	u8 intf_type;
+	u8 version;
+
+	struct slim_device *slim;
+	struct slim_device *slim_ifd;
+	struct regmap *regmap;
+	struct regmap *if_regmap;
+	struct regmap_irq_chip_data *irq_data;
+
+	struct wcd9335_slim_ch rx_chs[WCD9335_RX_MAX];
+	u32 num_rx_port;
+
+	int sido_input_src;
+	enum wcd9335_sido_voltage sido_voltage;
+
+	struct wcd_slim_codec_dai_data dai[NUM_CODEC_DAIS];
+	struct snd_soc_component *component;
+
+	int master_bias_users;
+	int clk_mclk_users;
+	int clk_rco_users;
+	int sido_ccl_cnt;
+	enum wcd_clock_type clk_type;
+
+	u32 hph_mode;
+};
+
+static const struct wcd9335_slim_ch wcd9335_rx_chs[WCD9335_RX_MAX] = {
+	WCD9335_SLIM_RX_CH(0),	 /* 16 */
+	WCD9335_SLIM_RX_CH(1),	 /* 17 */
+	WCD9335_SLIM_RX_CH(2),
+	WCD9335_SLIM_RX_CH(3),
+	WCD9335_SLIM_RX_CH(4),
+	WCD9335_SLIM_RX_CH(5),
+	WCD9335_SLIM_RX_CH(6),
+	WCD9335_SLIM_RX_CH(7),
+	WCD9335_SLIM_RX_CH(8),
+	WCD9335_SLIM_RX_CH(9),
+	WCD9335_SLIM_RX_CH(10),
+	WCD9335_SLIM_RX_CH(11),
+	WCD9335_SLIM_RX_CH(12),
+};
+
+struct interp_sample_rate {
+	int rate;
+	int rate_val;
+};
+
+static struct interp_sample_rate int_mix_rate_val[] = {
+	{48000, 0x4},	/* 48K */
+	{96000, 0x5},	/* 96K */
+	{192000, 0x6},	/* 192K */
+};
+
+static struct interp_sample_rate int_prim_rate_val[] = {
+	{8000, 0x0},	/* 8K */
+	{16000, 0x1},	/* 16K */
+	{24000, -EINVAL},/* 24K */
+	{32000, 0x3},	/* 32K */
+	{48000, 0x4},	/* 48K */
+	{96000, 0x5},	/* 96K */
+	{192000, 0x6},	/* 192K */
+	{384000, 0x7},	/* 384K */
+	{44100, 0x8}, /* 44.1K */
+};
+
+struct wcd9335_reg_mask_val {
+	u16 reg;
+	u8 mask;
+	u8 val;
+};
+
+static const struct wcd9335_reg_mask_val wcd9335_codec_reg_init_val_2_0[] = {
+	{WCD9335_RCO_CTRL_2, 0x0F, 0x08},
+	{WCD9335_RX_BIAS_FLYB_MID_RST, 0xF0, 0x10},
+	{WCD9335_FLYBACK_CTRL_1, 0x20, 0x20},
+	{WCD9335_HPH_OCP_CTL, 0xFF, 0x5A},
+	{WCD9335_HPH_L_TEST, 0x01, 0x01},
+	{WCD9335_HPH_R_TEST, 0x01, 0x01},
+	{WCD9335_CDC_BOOST0_BOOST_CFG1, 0x3F, 0x12},
+	{WCD9335_CDC_BOOST0_BOOST_CFG2, 0x1C, 0x08},
+	{WCD9335_CDC_COMPANDER7_CTL7, 0x1E, 0x18},
+	{WCD9335_CDC_BOOST1_BOOST_CFG1, 0x3F, 0x12},
+	{WCD9335_CDC_BOOST1_BOOST_CFG2, 0x1C, 0x08},
+	{WCD9335_CDC_COMPANDER8_CTL7, 0x1E, 0x18},
+	{WCD9335_CDC_TX0_TX_PATH_SEC7, 0xFF, 0x45},
+	{WCD9335_CDC_RX0_RX_PATH_SEC0, 0xFC, 0xF4},
+	{WCD9335_HPH_REFBUFF_LP_CTL, 0x08, 0x08},
+	{WCD9335_HPH_REFBUFF_LP_CTL, 0x06, 0x02},
+};
+
+static const struct wcd9335_reg_mask_val wcd9335_codec_reg_init_common_val[] = {
+	/* Rbuckfly/R_EAR(32) */
+	{WCD9335_CDC_CLSH_K2_MSB, 0x0F, 0x00},
+	{WCD9335_CDC_CLSH_K2_LSB, 0xFF, 0x60},
+	{WCD9335_CPE_SS_DMIC_CFG, 0x80, 0x00},
+	{WCD9335_CDC_BOOST0_BOOST_CTL, 0x70, 0x50},
+	{WCD9335_CDC_BOOST1_BOOST_CTL, 0x70, 0x50},
+	{WCD9335_CDC_RX7_RX_PATH_CFG1, 0x08, 0x08},
+	{WCD9335_CDC_RX8_RX_PATH_CFG1, 0x08, 0x08},
+	{WCD9335_ANA_LO_1_2, 0x3C, 0X3C},
+	{WCD9335_DIFF_LO_COM_SWCAP_REFBUF_FREQ, 0x70, 0x00},
+	{WCD9335_DIFF_LO_COM_PA_FREQ, 0x70, 0x40},
+	{WCD9335_SOC_MAD_AUDIO_CTL_2, 0x03, 0x03},
+	{WCD9335_CDC_TOP_TOP_CFG1, 0x02, 0x02},
+	{WCD9335_CDC_TOP_TOP_CFG1, 0x01, 0x01},
+	{WCD9335_EAR_CMBUFF, 0x08, 0x00},
+	{WCD9335_CDC_TX9_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_TX10_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_TX11_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_TX12_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_COMPANDER7_CTL3, 0x80, 0x80},
+	{WCD9335_CDC_COMPANDER8_CTL3, 0x80, 0x80},
+	{WCD9335_CDC_COMPANDER7_CTL7, 0x01, 0x01},
+	{WCD9335_CDC_COMPANDER8_CTL7, 0x01, 0x01},
+	{WCD9335_CDC_RX0_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX1_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX2_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX3_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX4_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX5_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX6_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX7_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX8_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX0_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX1_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX2_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX3_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX4_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX5_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX6_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX7_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX8_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_VBADC_IBIAS_FE, 0x0C, 0x08},
+};
+
+static int wcd9335_set_mix_interpolator_rate(struct snd_soc_dai *dai,
+					     int rate_val,
+					     u32 rate)
+{
+	struct snd_soc_component *component = dai->component;
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	struct wcd9335_slim_ch *ch;
+	int val, j;
+
+	list_for_each_entry(ch, &wcd->dai[dai->id].slim_ch_list, list) {
+		for (j = 0; j < WCD9335_NUM_INTERPOLATORS; j++) {
+			val = snd_soc_component_read32(component,
+					WCD9335_CDC_RX_INP_MUX_RX_INT_CFG1(j)) &
+					WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+
+			if (val == (ch->shift + INTn_2_INP_SEL_RX0))
+				snd_soc_component_update_bits(component,
+						WCD9335_CDC_RX_PATH_MIX_CTL(j),
+						WCD9335_CDC_MIX_PCM_RATE_MASK,
+						rate_val);
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_set_prim_interpolator_rate(struct snd_soc_dai *dai,
+					      u8 rate_val,
+					      u32 rate)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
+	struct wcd9335_slim_ch *ch;
+	u8 cfg0, cfg1, inp0_sel, inp1_sel, inp2_sel;
+	int inp, j;
+
+	list_for_each_entry(ch, &wcd->dai[dai->id].slim_ch_list, list) {
+		inp = ch->shift + INTn_1_MIX_INP_SEL_RX0;
+		/*
+		 * Loop through all interpolator MUX inputs and find out
+		 * to which interpolator input, the slim rx port
+		 * is connected
+		 */
+		for (j = 0; j < WCD9335_NUM_INTERPOLATORS; j++) {
+			cfg0 = snd_soc_component_read32(comp,
+					WCD9335_CDC_RX_INP_MUX_RX_INT_CFG0(j));
+			cfg1 = snd_soc_component_read32(comp,
+					WCD9335_CDC_RX_INP_MUX_RX_INT_CFG1(j));
+
+			inp0_sel = cfg0 & WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+			inp1_sel = (cfg0 >> 4) & WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+			inp2_sel = (cfg1 >> 4) & WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+
+			if ((inp0_sel == inp) ||  (inp1_sel == inp) ||
+			    (inp2_sel == inp)) {
+				/* rate is in Hz */
+				if ((j == 0) && (rate == 44100))
+					dev_info(wcd->dev,
+						"Cannot set 44.1KHz on INT0\n");
+				else
+					snd_soc_component_update_bits(comp,
+						WCD9335_CDC_RX_PATH_CTL(j),
+						WCD9335_CDC_MIX_PCM_RATE_MASK,
+						rate_val);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_set_interpolator_rate(struct snd_soc_dai *dai, u32 rate)
+{
+	int i;
+
+	/* set mixing path rate */
+	for (i = 0; i < ARRAY_SIZE(int_mix_rate_val); i++) {
+		if (rate == int_mix_rate_val[i].rate) {
+			wcd9335_set_mix_interpolator_rate(dai,
+					int_mix_rate_val[i].rate_val, rate);
+			break;
+		}
+	}
+
+	/* set primary path sample rate */
+	for (i = 0; i < ARRAY_SIZE(int_prim_rate_val); i++) {
+		if (rate == int_prim_rate_val[i].rate) {
+			wcd9335_set_prim_interpolator_rate(dai,
+					int_prim_rate_val[i].rate_val, rate);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_slim_set_hw_params(struct wcd9335_codec *wcd,
+				 struct wcd_slim_codec_dai_data *dai_data,
+				 int direction)
+{
+	struct list_head *slim_ch_list = &dai_data->slim_ch_list;
+	struct slim_stream_config *cfg = &dai_data->sconfig;
+	struct wcd9335_slim_ch *ch;
+	u16 payload = 0;
+	int ret, i;
+
+	cfg->ch_count = 0;
+	cfg->direction = direction;
+	cfg->port_mask = 0;
+
+	/* Configure slave interface device */
+	list_for_each_entry(ch, slim_ch_list, list) {
+		cfg->ch_count++;
+		payload |= 1 << ch->shift;
+		cfg->port_mask |= BIT(ch->port);
+	}
+
+	cfg->chs = kcalloc(cfg->ch_count, sizeof(unsigned int), GFP_KERNEL);
+	if (!cfg->chs)
+		return -ENOMEM;
+
+	i = 0;
+	list_for_each_entry(ch, slim_ch_list, list) {
+		cfg->chs[i++] = ch->ch_num;
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* write to interface device */
+			ret = regmap_write(wcd->if_regmap,
+				WCD9335_SLIM_PGD_RX_PORT_MULTI_CHNL_0(ch->port),
+				payload);
+
+			if (ret < 0)
+				goto err;
+
+			/* configure the slave port for water mark and enable*/
+			ret = regmap_write(wcd->if_regmap,
+					WCD9335_SLIM_PGD_RX_PORT_CFG(ch->port),
+					WCD9335_SLIM_WATER_MARK_VAL);
+			if (ret < 0)
+				goto err;
+		}
+	}
+
+	dai_data->sruntime = slim_stream_allocate(wcd->slim, "WCD9335-SLIM");
+	slim_stream_prepare(dai_data->sruntime, cfg);
+
+	return 0;
+
+err:
+	dev_err(wcd->dev, "Error Setting slim hw params\n");
+	kfree(cfg->chs);
+	cfg->chs = NULL;
+
+	return ret;
+}
+
+static int wcd9335_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct wcd9335_codec *wcd;
+	int ret;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		ret = wcd9335_set_interpolator_rate(dai, params_rate(params));
+		if (ret) {
+			dev_err(wcd->dev, "cannot set sample rate: %u\n",
+				params_rate(params));
+			return ret;
+		}
+		switch (params_width(params)) {
+		case 16 ... 24:
+			wcd->dai[dai->id].sconfig.bps = params_width(params);
+			break;
+		default:
+			dev_err(wcd->dev, "%s: Invalid format 0x%x\n",
+				__func__, params_width(params));
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(wcd->dev, "Invalid stream type %d\n",
+			substream->stream);
+		return -EINVAL;
+	};
+
+	wcd->dai[dai->id].sconfig.rate = params_rate(params);
+	wcd9335_slim_set_hw_params(wcd, &wcd->dai[dai->id], substream->stream);
+
+	return 0;
+}
+
+static int wcd9335_prepare(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct wcd_slim_codec_dai_data *dai_data;
+	struct wcd9335_codec *wcd;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+	dai_data = &wcd->dai[dai->id];
+	slim_stream_enable(dai_data->sruntime);
+
+	return 0;
+}
+
+static int wcd9335_set_channel_map(struct snd_soc_dai *dai,
+				   unsigned int tx_num, unsigned int *tx_slot,
+				   unsigned int rx_num, unsigned int *rx_slot)
+{
+	struct wcd9335_codec *wcd;
+	int i;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+
+	if (!tx_slot || !rx_slot) {
+		dev_err(wcd->dev, "Invalid tx_slot=%p, rx_slot=%p\n",
+			tx_slot, rx_slot);
+		return -EINVAL;
+	}
+
+	if (wcd->rx_chs) {
+		wcd->num_rx_port = rx_num;
+		for (i = 0; i < rx_num; i++) {
+			wcd->rx_chs[i].ch_num = rx_slot[i];
+			INIT_LIST_HEAD(&wcd->rx_chs[i].list);
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_get_channel_map(struct snd_soc_dai *dai,
+				   unsigned int *tx_num, unsigned int *tx_slot,
+				   unsigned int *rx_num, unsigned int *rx_slot)
+{
+	struct wcd9335_slim_ch *ch;
+	struct wcd9335_codec *wcd;
+	int i = 0;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+
+	switch (dai->id) {
+	case AIF1_PB:
+	case AIF2_PB:
+	case AIF3_PB:
+	case AIF4_PB:
+		if (!rx_slot || !rx_num) {
+			dev_err(wcd->dev, "Invalid rx_slot %p or rx_num %p\n",
+				rx_slot, rx_num);
+			return -EINVAL;
+		}
+
+		list_for_each_entry(ch, &wcd->dai[dai->id].slim_ch_list, list)
+			rx_slot[i++] = ch->ch_num;
+
+		*rx_num = i;
+		break;
+	default:
+		dev_err(wcd->dev, "Invalid DAI ID %x\n", dai->id);
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops wcd9335_dai_ops = {
+	.hw_params = wcd9335_hw_params,
+	.prepare = wcd9335_prepare,
+	.set_channel_map = wcd9335_set_channel_map,
+	.get_channel_map = wcd9335_get_channel_map,
+};
+
+static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
+	[0] = {
+		.name = "wcd9335_rx1",
+		.id = AIF1_PB,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_max = 192000,
+			.rate_min = 8000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[1] = {
+		.name = "wcd9335_tx1",
+		.id = AIF1_CAP,
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.rates = WCD9335_RATES_MASK,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 4,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[2] = {
+		.name = "wcd9335_rx2",
+		.id = AIF2_PB,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[3] = {
+		.name = "wcd9335_tx2",
+		.id = AIF2_CAP,
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.rates = WCD9335_RATES_MASK,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 4,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[4] = {
+		.name = "wcd9335_rx3",
+		.id = AIF3_PB,
+		.playback = {
+			.stream_name = "AIF3 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[5] = {
+		.name = "wcd9335_tx3",
+		.id = AIF3_CAP,
+		.capture = {
+			.stream_name = "AIF3 Capture",
+			.rates = WCD9335_RATES_MASK,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 4,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[6] = {
+		.name = "wcd9335_rx4",
+		.id = AIF4_PB,
+		.playback = {
+			.stream_name = "AIF4 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+};
+
+static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
+{
+	struct wcd9335_codec *wcd = data;
+	unsigned long status = 0;
+	int i, j, port_id;
+	unsigned int val, int_val = 0;
+	bool tx;
+	unsigned short reg = 0;
+
+	for (i = WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0, j = 0;
+	     i <= WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1; i++, j++) {
+		regmap_read(wcd->if_regmap, i, &val);
+		status |= ((u32)val << (8 * j));
+	}
+
+	for_each_set_bit(j, &status, 32) {
+		tx = (j >= 16 ? true : false);
+		port_id = (tx ? j - 16 : j);
+		regmap_read(wcd->if_regmap,
+				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
+		if (val) {
+			if (!tx)
+				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
+					(port_id / 8);
+			else
+				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
+					(port_id / 8);
+			regmap_read(
+				wcd->if_regmap, reg, &int_val);
+			/*
+			 * Ignore interrupts for ports for which the
+			 * interrupts are not specifically enabled.
+			 */
+			if (!(int_val & (1 << (port_id % 8))))
+				continue;
+		}
+		if (val & WCD9335_SLIM_IRQ_OVERFLOW)
+			dev_err_ratelimited(wcd->dev,
+			   "%s: overflow error on %s port %d, value %x\n",
+			   __func__, (tx ? "TX" : "RX"), port_id, val);
+		if (val & WCD9335_SLIM_IRQ_UNDERFLOW)
+			dev_err_ratelimited(wcd->dev,
+			   "%s: underflow error on %s port %d, value %x\n",
+			   __func__, (tx ? "TX" : "RX"), port_id, val);
+		if ((val & WCD9335_SLIM_IRQ_OVERFLOW) ||
+			(val & WCD9335_SLIM_IRQ_UNDERFLOW)) {
+			if (!tx)
+				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
+					(port_id / 8);
+			else
+				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
+					(port_id / 8);
+			regmap_read(
+				wcd->if_regmap, reg, &int_val);
+			if (int_val & (1 << (port_id % 8))) {
+				int_val = int_val ^ (1 << (port_id % 8));
+				regmap_write(wcd->if_regmap,
+					reg, int_val);
+			}
+		}
+
+		regmap_write(wcd->if_regmap,
+				WCD9335_SLIM_PGD_PORT_INT_CLR_RX_0 + (j / 8),
+				BIT(j % 8));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
+{
+	int slim_irq = regmap_irq_get_virq(wcd->irq_data, WCD9335_IRQ_SLIMBUS);
+	int i, ret = 0;
+
+	ret = request_threaded_irq(slim_irq, NULL, wcd9335_slimbus_irq,
+				   IRQF_TRIGGER_RISING, "SLIMBus Slave", wcd);
+	if (ret) {
+		dev_err(wcd->dev, "Failed to request SLIMBUS irq\n");
+		return ret;
+	}
+
+	/* enable interrupts on all slave ports */
+	for (i = 0; i < WCD9335_SLIM_NUM_PORT_REG; i++)
+		regmap_write(wcd->if_regmap, WCD9335_SLIM_PGD_PORT_INT_EN0 + i,
+			     0xFF);
+
+	return ret;
+}
+
+static void wcd9335_cdc_sido_ccl_enable(struct wcd9335_codec *wcd,
+					bool ccl_flag)
+{
+	struct snd_soc_component *comp = wcd->component;
+
+	if (ccl_flag) {
+		if (++wcd->sido_ccl_cnt == 1)
+			snd_soc_component_write(comp, WCD9335_SIDO_SIDO_CCL_10,
+					WCD9335_SIDO_SIDO_CCL_DEF_VALUE);
+	} else {
+		if (wcd->sido_ccl_cnt == 0) {
+			dev_err(wcd->dev, "sido_ccl already disabled\n");
+			return;
+		}
+		if (--wcd->sido_ccl_cnt == 0)
+			snd_soc_component_write(comp, WCD9335_SIDO_SIDO_CCL_10,
+				WCD9335_SIDO_SIDO_CCL_10_ICHARG_PWR_SEL_C320FF);
+	}
+}
+
+static int wcd9335_enable_master_bias(struct wcd9335_codec *wcd)
+{
+	wcd->master_bias_users++;
+	if (wcd->master_bias_users == 1) {
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+					WCD9335_ANA_BIAS_EN_MASK,
+					WCD9335_ANA_BIAS_ENABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+					WCD9335_ANA_BIAS_PRECHRG_EN_MASK,
+					WCD9335_ANA_BIAS_PRECHRG_ENABLE);
+		/*
+		 * 1ms delay is required after pre-charge is enabled
+		 * as per HW requirement
+		 */
+		usleep_range(1000, 1100);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+					WCD9335_ANA_BIAS_PRECHRG_EN_MASK,
+					WCD9335_ANA_BIAS_PRECHRG_DISABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_MANUAL);
+	}
+
+	return 0;
+}
+
+static int wcd9335_enable_mclk(struct wcd9335_codec *wcd)
+{
+	/* Enable mclk requires master bias to be enabled first */
+	if (wcd->master_bias_users <= 0)
+		return -EINVAL;
+
+	if (((wcd->clk_mclk_users == 0) && (wcd->clk_type == WCD_CLK_MCLK)) ||
+	    ((wcd->clk_mclk_users > 0) && (wcd->clk_type != WCD_CLK_MCLK))) {
+		dev_err(wcd->dev, "Error enabling MCLK, clk_type: %d\n",
+			wcd->clk_type);
+		return -EINVAL;
+	}
+
+	if (++wcd->clk_mclk_users == 1) {
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_EXT_CLKBUF_EN_MASK,
+					WCD9335_ANA_CLK_EXT_CLKBUF_ENABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_SRC_MASK,
+					WCD9335_ANA_CLK_MCLK_SRC_EXTERNAL);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_EN_MASK,
+					WCD9335_ANA_CLK_MCLK_ENABLE);
+		regmap_update_bits(wcd->regmap,
+				   WCD9335_CDC_CLK_RST_CTRL_FS_CNT_CONTROL,
+				   WCD9335_CDC_CLK_RST_CTRL_FS_CNT_EN_MASK,
+				   WCD9335_CDC_CLK_RST_CTRL_FS_CNT_ENABLE);
+		regmap_update_bits(wcd->regmap,
+				   WCD9335_CDC_CLK_RST_CTRL_MCLK_CONTROL,
+				   WCD9335_CDC_CLK_RST_CTRL_MCLK_EN_MASK,
+				   WCD9335_CDC_CLK_RST_CTRL_MCLK_ENABLE);
+		/*
+		 * 10us sleep is required after clock is enabled
+		 * as per HW requirement
+		 */
+		usleep_range(10, 15);
+	}
+
+	wcd->clk_type = WCD_CLK_MCLK;
+
+	return 0;
+}
+
+static int wcd9335_disable_mclk(struct wcd9335_codec *wcd)
+{
+	if (wcd->clk_mclk_users <= 0)
+		return -EINVAL;
+
+	if (--wcd->clk_mclk_users == 0) {
+		if (wcd->clk_rco_users > 0) {
+			/* MCLK to RCO switch */
+			regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_SRC_MASK,
+					WCD9335_ANA_CLK_MCLK_SRC_RCO);
+			wcd->clk_type = WCD_CLK_RCO;
+		} else {
+			regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_EN_MASK,
+					WCD9335_ANA_CLK_MCLK_DISABLE);
+			wcd->clk_type = WCD_CLK_OFF;
+		}
+
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_EXT_CLKBUF_EN_MASK,
+					WCD9335_ANA_CLK_EXT_CLKBUF_DISABLE);
+	}
+
+	return 0;
+}
+
+static int wcd9335_disable_master_bias(struct wcd9335_codec *wcd)
+{
+	if (wcd->master_bias_users <= 0)
+		return -EINVAL;
+
+	wcd->master_bias_users--;
+	if (wcd->master_bias_users == 0) {
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+				WCD9335_ANA_BIAS_EN_MASK,
+				WCD9335_ANA_BIAS_DISABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_MANUAL);
+	}
+	return 0;
+}
+
+static int wcd9335_cdc_req_mclk_enable(struct wcd9335_codec *wcd,
+				     bool enable)
+{
+	int ret = 0;
+
+	if (enable) {
+		wcd9335_cdc_sido_ccl_enable(wcd, true);
+		ret = clk_prepare_enable(wcd->mclk);
+		if (ret) {
+			dev_err(wcd->dev, "%s: ext clk enable failed\n",
+				__func__);
+			goto err;
+		}
+		/* get BG */
+		wcd9335_enable_master_bias(wcd);
+		/* get MCLK */
+		wcd9335_enable_mclk(wcd);
+
+	} else {
+		/* put MCLK */
+		wcd9335_disable_mclk(wcd);
+		/* put BG */
+		wcd9335_disable_master_bias(wcd);
+		clk_disable_unprepare(wcd->mclk);
+		wcd9335_cdc_sido_ccl_enable(wcd, false);
+	}
+err:
+	return ret;
+}
+
+static void wcd9335_codec_apply_sido_voltage(struct wcd9335_codec *wcd,
+					     enum wcd9335_sido_voltage req_mv)
+{
+	struct snd_soc_component *comp = wcd->component;
+	int vout_d_val;
+
+	if (req_mv == wcd->sido_voltage)
+		return;
+
+	/* compute the vout_d step value */
+	vout_d_val = WCD9335_CALCULATE_VOUT_D(req_mv) &
+			WCD9335_ANA_BUCK_VOUT_MASK;
+	snd_soc_component_write(comp, WCD9335_ANA_BUCK_VOUT_D, vout_d_val);
+	snd_soc_component_update_bits(comp, WCD9335_ANA_BUCK_CTL,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_MASK,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_ENABLE);
+
+	/* 1 msec sleep required after SIDO Vout_D voltage change */
+	usleep_range(1000, 1100);
+	wcd->sido_voltage = req_mv;
+	snd_soc_component_update_bits(comp, WCD9335_ANA_BUCK_CTL,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_MASK,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_DISABLE);
+}
+
+static int wcd9335_codec_update_sido_voltage(struct wcd9335_codec *wcd,
+					     enum wcd9335_sido_voltage req_mv)
+{
+	int ret = 0;
+
+	/* enable mclk before setting SIDO voltage */
+	ret = wcd9335_cdc_req_mclk_enable(wcd, true);
+	if (ret) {
+		dev_err(wcd->dev, "Ext clk enable failed\n");
+		goto err;
+	}
+
+	wcd9335_codec_apply_sido_voltage(wcd, req_mv);
+	wcd9335_cdc_req_mclk_enable(wcd, false);
+
+err:
+	return ret;
+}
+
+static int _wcd9335_codec_enable_mclk(struct snd_soc_component *component,
+				      int enable)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int ret;
+
+	if (enable) {
+		ret = wcd9335_cdc_req_mclk_enable(wcd, true);
+		if (ret)
+			return ret;
+
+		wcd9335_codec_apply_sido_voltage(wcd,
+				SIDO_VOLTAGE_NOMINAL_MV);
+	} else {
+		wcd9335_codec_update_sido_voltage(wcd,
+					wcd->sido_voltage);
+		wcd9335_cdc_req_mclk_enable(wcd, false);
+	}
+
+	return 0;
+}
+
+static void wcd9335_enable_sido_buck(struct snd_soc_component *component)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	snd_soc_component_update_bits(component, WCD9335_ANA_RCO,
+					WCD9335_ANA_RCO_BG_EN_MASK,
+					WCD9335_ANA_RCO_BG_ENABLE);
+	snd_soc_component_update_bits(component, WCD9335_ANA_BUCK_CTL,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_MASK,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_EXT);
+	/* 100us sleep needed after IREF settings */
+	usleep_range(100, 110);
+	snd_soc_component_update_bits(component, WCD9335_ANA_BUCK_CTL,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_MASK,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_EXT);
+	/* 100us sleep needed after VREF settings */
+	usleep_range(100, 110);
+	wcd->sido_input_src = SIDO_SOURCE_RCO_BG;
+}
+
+static int wcd9335_enable_efuse_sensing(struct snd_soc_component *comp)
+{
+	_wcd9335_codec_enable_mclk(comp, true);
+	snd_soc_component_update_bits(comp,
+				WCD9335_CHIP_TIER_CTRL_EFUSE_CTL,
+				WCD9335_CHIP_TIER_CTRL_EFUSE_EN_MASK,
+				WCD9335_CHIP_TIER_CTRL_EFUSE_ENABLE);
+	/*
+	 * 5ms sleep required after enabling efuse control
+	 * before checking the status.
+	 */
+	usleep_range(5000, 5500);
+
+	if (!(snd_soc_component_read32(comp,
+					WCD9335_CHIP_TIER_CTRL_EFUSE_STATUS) &
+					WCD9335_CHIP_TIER_CTRL_EFUSE_EN_MASK))
+		WARN(1, "%s: Efuse sense is not complete\n", __func__);
+
+	wcd9335_enable_sido_buck(comp);
+	_wcd9335_codec_enable_mclk(comp, false);
+
+	return 0;
+}
+
+static void wcd9335_codec_init(struct snd_soc_component *component)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int i;
+
+	/* ungate MCLK and set clk rate */
+	regmap_update_bits(wcd->regmap, WCD9335_CODEC_RPM_CLK_GATE,
+				WCD9335_CODEC_RPM_CLK_GATE_MCLK_GATE_MASK, 0);
+
+	regmap_update_bits(wcd->regmap, WCD9335_CODEC_RPM_CLK_MCLK_CFG,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_9P6MHZ);
+
+	for (i = 0; i < ARRAY_SIZE(wcd9335_codec_reg_init_common_val); i++)
+		snd_soc_component_update_bits(component,
+				wcd9335_codec_reg_init_common_val[i].reg,
+				wcd9335_codec_reg_init_common_val[i].mask,
+				wcd9335_codec_reg_init_common_val[i].val);
+
+	if (WCD9335_IS_2_0(wcd->version)) {
+		for (i = 0; i < ARRAY_SIZE(wcd9335_codec_reg_init_val_2_0); i++)
+			snd_soc_component_update_bits(component,
+					wcd9335_codec_reg_init_val_2_0[i].reg,
+					wcd9335_codec_reg_init_val_2_0[i].mask,
+					wcd9335_codec_reg_init_val_2_0[i].val);
+	}
+
+	wcd9335_enable_efuse_sensing(component);
+}
+
+static int wcd9335_codec_probe(struct snd_soc_component *component)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int i;
+
+	snd_soc_component_init_regmap(component, wcd->regmap);
+	wcd->component = component;
+
+	wcd9335_codec_init(component);
+
+	for (i = 0; i < NUM_CODEC_DAIS; i++)
+		INIT_LIST_HEAD(&wcd->dai[i].slim_ch_list);
+
+	return wcd9335_setup_irqs(wcd);
+}
+
+static void wcd9335_codec_remove(struct snd_soc_component *comp)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
+
+	free_irq(regmap_irq_get_virq(wcd->irq_data, WCD9335_IRQ_SLIMBUS), wcd);
+}
+
+static int wcd9335_codec_set_sysclk(struct snd_soc_component *comp,
+				    int clk_id, int source,
+				    unsigned int freq, int dir)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
+
+	wcd->mclk_rate = freq;
+
+	if (wcd->mclk_rate == WCD9335_MCLK_CLK_12P288MHZ)
+		snd_soc_component_update_bits(comp,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_12P288MHZ);
+	else if (wcd->mclk_rate == WCD9335_MCLK_CLK_9P6MHZ)
+		snd_soc_component_update_bits(comp,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_9P6MHZ);
+
+	return clk_set_rate(wcd->mclk, freq);
+}
+
+static const struct snd_soc_component_driver wcd9335_component_drv = {
+	.probe = wcd9335_codec_probe,
+	.remove = wcd9335_codec_remove,
+	.set_sysclk = wcd9335_codec_set_sysclk,
+};
+
+static int wcd9335_probe(struct platform_device *pdev)
+{
+	struct wcd9335 *pdata = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct wcd9335_codec *wcd;
+
+	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
+	if (!wcd)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, wcd);
+
+	memcpy(wcd->rx_chs, wcd9335_rx_chs, sizeof(wcd9335_rx_chs));
+
+	wcd->regmap = pdata->regmap;
+	wcd->if_regmap = pdata->ifd_regmap;
+	wcd->slim = pdata->slim;
+	wcd->slim_ifd = pdata->slim_ifd;
+	wcd->irq_data = pdata->irq_data;
+	wcd->version = pdata->version;
+	wcd->intf_type = pdata->intf_type;
+	wcd->dev = dev;
+	wcd->mclk = pdata->mclk;
+	wcd->native_clk = pdata->native_clk;
+	wcd->sido_input_src = SIDO_SOURCE_INTERNAL;
+	wcd->sido_voltage = SIDO_VOLTAGE_NOMINAL_MV;
+
+	return devm_snd_soc_register_component(dev, &wcd9335_component_drv,
+					       wcd9335_slim_dais,
+					       ARRAY_SIZE(wcd9335_slim_dais));
+}
+
+static struct platform_driver wcd9335_codec_driver = {
+	.probe = wcd9335_probe,
+	.driver = {
+		.name = "wcd9335-codec",
+	},
+};
+module_platform_driver(wcd9335_codec_driver);
+MODULE_DESCRIPTION("WCD9335 Codec driver");
+MODULE_LICENSE("GPL v2");
-- 
2.16.2

