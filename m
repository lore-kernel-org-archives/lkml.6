Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7726021783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoPi8xiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfAJPGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:06:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37707 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfAJPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:06:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so11785138wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jg5tDJEfSevd0lU2BCM4+y3CblETPT3z3+5xc997m1A=;
        b=SoPi8xiNseTy40vooeSFs1Xld6yTaH4g68byiDWzz/f5LAUQyQNOvj/8bU0hbVOGCm
         Fv6tp2ZwUhYfiommxr+3ZbIXAL8dixB9yMd4mpqWKBlu/cCHEcpzAe03M2F2s3beEfY8
         hGg2SAWnnC/ZtbsWsf4nV+qqL4ssG83kld9YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jg5tDJEfSevd0lU2BCM4+y3CblETPT3z3+5xc997m1A=;
        b=hiIeNcrp3kbgEQ04HvLRXlB6g8RXxwC9qBLd29BJ49ew5ELyWxABw+RjmL5AUZ/NNz
         Yx9/iIBvsu7klPE9JkpgHKGynmMextAHLWBXa++YokPoKkXfERXxWDDJNypiO9LhgQ/O
         +bMrYfUGjXuQ/gbULKkIL/wpxouINsZ69iWpd3X5kZ40lTzwT9PjwYJKl0DkjFyqpxxq
         TB8PyrvlNE1hZIxMgUPTDBJIB6HZkJTe3aW6mMl8fwFTswAPnH94PAej0QPNQI0PiSz+
         ZRZtOhL0SSKP5vBzEe0oOTEddMNEcLgKbv8aws3A6K6libTxc+3BdNingDzXRjKn59aY
         4CGg==
X-Gm-Message-State: AJcUuke8n25pG0bT6cCow3jQSu28/3yDSSLThmsRG38lJD/xQX/Te5Do
        RuFd2lN/VvGy+aVJCxwYtNq8qw==
X-Google-Smtp-Source: ALg8bN7EFoFmUwSHW2SFGLHh4/oJSVQS+zhO7cNaC/680hoXI6ax2zKkRIXYTwnMBClr6U+LfXWufQ==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr9965627wrn.171.1547132789299;
        Thu, 10 Jan 2019 07:06:29 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b12sm51063754wrt.17.2019.01.10.07.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 07:06:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 4/8] ASoC: wcd9335: add basic controls
Date:   Thu, 10 Jan 2019 15:06:12 +0000
Message-Id: <20190110150616.2332-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic controls found in wcd9335 codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 359 +++++++++++++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 238851eca45c..ab4738ba3176 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -105,6 +105,18 @@ enum {
 	NUM_CODEC_DAIS,
 };
 
+enum {
+	COMPANDER_1, /* HPH_L */
+	COMPANDER_2, /* HPH_R */
+	COMPANDER_3, /* LO1_DIFF */
+	COMPANDER_4, /* LO2_DIFF */
+	COMPANDER_5, /* LO3_SE */
+	COMPANDER_6, /* LO4_SE */
+	COMPANDER_7, /* SWR SPK CH1 */
+	COMPANDER_8, /* SWR SPK CH2 */
+	COMPANDER_MAX,
+};
+
 enum {
 	INTn_2_INP_SEL_ZERO = 0,
 	INTn_2_INP_SEL_RX0,
@@ -184,6 +196,8 @@ struct wcd9335_codec {
 
 	struct wcd_clsh_ctrl *clsh_ctrl;
 	u32 hph_mode;
+	int comp_enabled[COMPANDER_MAX];
+
 	int intr1;
 	int reset_gpio;
 	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
@@ -301,6 +315,118 @@ static const struct wcd9335_reg_mask_val wcd9335_codec_reg_init[] = {
 	{WCD9335_HPH_REFBUFF_LP_CTL, 0x06, 0x02},
 };
 
+/* Cutoff frequency for high pass filter */
+static const char * const cf_text[] = {
+	"CF_NEG_3DB_4HZ", "CF_NEG_3DB_75HZ", "CF_NEG_3DB_150HZ"
+};
+
+static const char * const rx_cf_text[] = {
+	"CF_NEG_3DB_4HZ", "CF_NEG_3DB_75HZ", "CF_NEG_3DB_150HZ",
+	"CF_NEG_3DB_0P48HZ"
+};
+
+static const char * const wcd9335_ear_pa_gain_text[] = {
+	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
+	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
+};
+
+static const char * const rx_hph_mode_mux_text[] = {
+	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
+};
+
+static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
+static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
+static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
+
+static const struct soc_enum wcd9335_ear_pa_gain_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wcd9335_ear_pa_gain_text),
+			wcd9335_ear_pa_gain_text);
+
+static const struct soc_enum cf_dec0_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX0_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX1_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec2_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX2_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec3_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX3_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec4_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX4_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec5_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX5_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec6_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX6_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec7_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX7_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec8_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX8_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_int0_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX0_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int0_2_enum, WCD9335_CDC_RX0_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int1_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX1_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int1_2_enum, WCD9335_CDC_RX1_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int2_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX2_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int2_2_enum, WCD9335_CDC_RX2_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int3_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX3_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int3_2_enum, WCD9335_CDC_RX3_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int4_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX4_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int4_2_enum, WCD9335_CDC_RX4_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int5_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX5_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int5_2_enum, WCD9335_CDC_RX5_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int6_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX6_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int6_2_enum, WCD9335_CDC_RX6_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int7_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX7_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int7_2_enum, WCD9335_CDC_RX7_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int8_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX8_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int8_2_enum, WCD9335_CDC_RX8_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum rx_hph_mode_mux_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text),
+			    rx_hph_mode_mux_text);
+
 static int wcd9335_set_mix_interpolator_rate(struct snd_soc_dai *dai,
 					     int rate_val,
 					     u32 rate)
@@ -697,6 +823,237 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 	},
 };
 
+static int wcd9335_get_compander(struct snd_kcontrol *kc,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	int comp = ((struct soc_mixer_control *)kc->private_value)->shift;
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	ucontrol->value.integer.value[0] = wcd->comp_enabled[comp];
+	return 0;
+}
+
+static int wcd9335_set_compander(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int comp = ((struct soc_mixer_control *) kc->private_value)->shift;
+	int value = ucontrol->value.integer.value[0];
+	int sel;
+
+	wcd->comp_enabled[comp] = value;
+	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
+		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
+
+	/* Any specific register configuration for compander */
+	switch (comp) {
+	case COMPANDER_1:
+		/* Set Gain Source Select based on compander enable/disable */
+		snd_soc_component_update_bits(component, WCD9335_HPH_L_EN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_2:
+		snd_soc_component_update_bits(component, WCD9335_HPH_R_EN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_5:
+		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO3_GAIN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_6:
+		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO4_GAIN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	default:
+		break;
+	};
+
+	return 0;
+}
+
+static int wcd9335_rx_hph_mode_get(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	ucontrol->value.enumerated.item[0] = wcd->hph_mode;
+
+	return 0;
+}
+
+static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	u32 mode_val;
+
+	mode_val = ucontrol->value.enumerated.item[0];
+
+	if (mode_val == 0) {
+		dev_err(wcd->dev, "Invalid HPH Mode, default to ClSH HiFi\n");
+		mode_val = CLS_H_HIFI;
+	}
+	wcd->hph_mode = mode_val;
+
+	return 0;
+}
+
+static int wcd9335_ear_pa_gain_get(struct snd_kcontrol *kc,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	int ear_pa_gain;
+
+	ear_pa_gain = snd_soc_component_read32(component, WCD9335_ANA_EAR);
+	ear_pa_gain = (ear_pa_gain & 0x70) >> 4;
+	ucontrol->value.enumerated.item[0] = ear_pa_gain;
+
+	return 0;
+}
+
+static int wcd9335_ear_pa_gain_put(struct snd_kcontrol *kc,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	u8 ear_pa_gain;
+
+	ear_pa_gain =  ucontrol->value.enumerated.item[0] << 4;
+	snd_soc_component_update_bits(component, WCD9335_ANA_EAR,
+					0x70, ear_pa_gain);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new wcd9335_snd_controls[] = {
+	/* -84dB min - 40dB max */
+	SOC_SINGLE_SX_TLV("RX0 Digital Volume", WCD9335_CDC_RX0_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX1 Digital Volume", WCD9335_CDC_RX1_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX2 Digital Volume", WCD9335_CDC_RX2_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX3 Digital Volume", WCD9335_CDC_RX3_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX4 Digital Volume", WCD9335_CDC_RX4_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX5 Digital Volume", WCD9335_CDC_RX5_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX6 Digital Volume", WCD9335_CDC_RX6_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX7 Digital Volume", WCD9335_CDC_RX7_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX8 Digital Volume", WCD9335_CDC_RX8_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX0 Mix Digital Volume",
+			  WCD9335_CDC_RX0_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX1 Mix Digital Volume",
+			  WCD9335_CDC_RX1_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX2 Mix Digital Volume",
+			  WCD9335_CDC_RX2_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX3 Mix Digital Volume",
+			  WCD9335_CDC_RX3_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX4 Mix Digital Volume",
+			  WCD9335_CDC_RX4_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX5 Mix Digital Volume",
+			  WCD9335_CDC_RX5_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX6 Mix Digital Volume",
+			  WCD9335_CDC_RX6_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX7 Mix Digital Volume",
+			  WCD9335_CDC_RX7_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX8 Mix Digital Volume",
+			  WCD9335_CDC_RX8_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_ENUM("RX INT0_1 HPF cut off", cf_int0_1_enum),
+	SOC_ENUM("RX INT0_2 HPF cut off", cf_int0_2_enum),
+	SOC_ENUM("RX INT1_1 HPF cut off", cf_int1_1_enum),
+	SOC_ENUM("RX INT1_2 HPF cut off", cf_int1_2_enum),
+	SOC_ENUM("RX INT2_1 HPF cut off", cf_int2_1_enum),
+	SOC_ENUM("RX INT2_2 HPF cut off", cf_int2_2_enum),
+	SOC_ENUM("RX INT3_1 HPF cut off", cf_int3_1_enum),
+	SOC_ENUM("RX INT3_2 HPF cut off", cf_int3_2_enum),
+	SOC_ENUM("RX INT4_1 HPF cut off", cf_int4_1_enum),
+	SOC_ENUM("RX INT4_2 HPF cut off", cf_int4_2_enum),
+	SOC_ENUM("RX INT5_1 HPF cut off", cf_int5_1_enum),
+	SOC_ENUM("RX INT5_2 HPF cut off", cf_int5_2_enum),
+	SOC_ENUM("RX INT6_1 HPF cut off", cf_int6_1_enum),
+	SOC_ENUM("RX INT6_2 HPF cut off", cf_int6_2_enum),
+	SOC_ENUM("RX INT7_1 HPF cut off", cf_int7_1_enum),
+	SOC_ENUM("RX INT7_2 HPF cut off", cf_int7_2_enum),
+	SOC_ENUM("RX INT8_1 HPF cut off", cf_int8_1_enum),
+	SOC_ENUM("RX INT8_2 HPF cut off", cf_int8_2_enum),
+	SOC_SINGLE_EXT("COMP1 Switch", SND_SOC_NOPM, COMPANDER_1, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP2 Switch", SND_SOC_NOPM, COMPANDER_2, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP3 Switch", SND_SOC_NOPM, COMPANDER_3, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP4 Switch", SND_SOC_NOPM, COMPANDER_4, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP5 Switch", SND_SOC_NOPM, COMPANDER_5, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP6 Switch", SND_SOC_NOPM, COMPANDER_6, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP7 Switch", SND_SOC_NOPM, COMPANDER_7, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP8 Switch", SND_SOC_NOPM, COMPANDER_8, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
+		       wcd9335_rx_hph_mode_get, wcd9335_rx_hph_mode_put),
+
+	/* Gain Controls */
+	SOC_ENUM_EXT("EAR PA Gain", wcd9335_ear_pa_gain_enum,
+		wcd9335_ear_pa_gain_get, wcd9335_ear_pa_gain_put),
+
+	SOC_SINGLE_TLV("HPHL Volume", WCD9335_HPH_L_EN, 0, 20, 1,
+		line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD9335_HPH_R_EN, 0, 20, 1,
+		line_gain),
+	SOC_SINGLE_TLV("LINEOUT1 Volume", WCD9335_DIFF_LO_LO1_COMPANDER,
+			3, 16, 1, line_gain),
+	SOC_SINGLE_TLV("LINEOUT2 Volume", WCD9335_DIFF_LO_LO2_COMPANDER,
+			3, 16, 1, line_gain),
+	SOC_SINGLE_TLV("LINEOUT3 Volume", WCD9335_SE_LO_LO3_GAIN, 0, 20, 1,
+			line_gain),
+	SOC_SINGLE_TLV("LINEOUT4 Volume", WCD9335_SE_LO_LO4_GAIN, 0, 20, 1,
+			line_gain),
+
+	SOC_SINGLE_TLV("ADC1 Volume", WCD9335_ANA_AMIC1, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", WCD9335_ANA_AMIC2, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", WCD9335_ANA_AMIC3, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC4 Volume", WCD9335_ANA_AMIC4, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC5 Volume", WCD9335_ANA_AMIC5, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC6 Volume", WCD9335_ANA_AMIC6, 0, 20, 0,
+			analog_gain),
+
+	SOC_ENUM("TX0 HPF cut off", cf_dec0_enum),
+	SOC_ENUM("TX1 HPF cut off", cf_dec1_enum),
+	SOC_ENUM("TX2 HPF cut off", cf_dec2_enum),
+	SOC_ENUM("TX3 HPF cut off", cf_dec3_enum),
+	SOC_ENUM("TX4 HPF cut off", cf_dec4_enum),
+	SOC_ENUM("TX5 HPF cut off", cf_dec5_enum),
+	SOC_ENUM("TX6 HPF cut off", cf_dec6_enum),
+	SOC_ENUM("TX7 HPF cut off", cf_dec7_enum),
+	SOC_ENUM("TX8 HPF cut off", cf_dec8_enum),
+};
+
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 {
 	struct wcd9335_codec *wcd = data;
@@ -1157,6 +1514,8 @@ static const struct snd_soc_component_driver wcd9335_component_drv = {
 	.probe = wcd9335_codec_probe,
 	.remove = wcd9335_codec_remove,
 	.set_sysclk = wcd9335_codec_set_sysclk,
+	.controls = wcd9335_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd9335_snd_controls),
 };
 
 static int wcd9335_probe(struct wcd9335_codec *wcd)
-- 
2.20.1

