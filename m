Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B00F20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UWqm7+Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B00F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeHaSzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:55:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33138 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbeHaSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:55:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VElF9V014358;
        Fri, 31 Aug 2018 09:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535726835;
        bh=yPvjAaKWq91lAPOsWwCEJheKsOYCxf/GjnNdvJ75LR4=;
        h=From:To:CC:Subject:Date;
        b=UWqm7+HtyUTKEfI6qeTN52qmVplYNSMHpk6iwquD6nGwVmJhS4H09BNbJgK2faomp
         50SvI/Ft1bad4vhmELIVbxwhP72UMoK8w+fBdXUnVn981qdg7Hj5LDLbf/LMIso0Wz
         eeI8P1a+EpOC637bq/WehVBdKulOIUdtYM9hHGTo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VElFVO032752;
        Fri, 31 Aug 2018 09:47:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 09:47:15 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 09:47:15 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VElFFA028191;
        Fri, 31 Aug 2018 09:47:15 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VElEx17475;
        Fri, 31 Aug 2018 09:47:14 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v2 1/2] ASoC: codecs: tas5720: add TAS5722 specific volume control
Date:   Fri, 31 Aug 2018 09:47:13 -0500
Message-ID: <20180831144714.16499-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Dannenberg <dannenberg@ti.com>

The TAS5722 supports modifying volume in 0.25dB steps (as opposed to
0.5dB steps on the TAS5720). Introduce a custom mixer control that
allows taking advantage of this finer output volume granularity.

Also add custom getters/setters for access as the TAS5722 digital volume
controls are split over two registers.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---

Changes from v1:
 - Revise commit message
 - codec -> component

 sound/soc/codecs/tas5720.c | 88 ++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index ae3d032ac35a..3c469112477a 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -485,15 +485,56 @@ static const DECLARE_TLV_DB_RANGE(dac_analog_tlv,
 );
 
 /*
- * DAC digital volumes. From -103.5 to 24 dB in 0.5 dB steps. Note that
- * setting the gain below -100 dB (register value <0x7) is effectively a MUTE
- * as per device datasheet.
+ * DAC digital volumes. From -103.5 to 24 dB in 0.5 dB or 0.25 dB steps
+ * depending on the device. Note that setting the gain below -100 dB
+ * (register value <0x7) is effectively a MUTE as per device datasheet.
+ *
+ * Note that for the TAS5722 the digital volume controls are actually split
+ * over two registers, so we need custom getters/setters for access.
  */
-static DECLARE_TLV_DB_SCALE(dac_tlv, -10350, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas5720_dac_tlv, -10350, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas5722_dac_tlv, -10350, 25, 0);
+
+static int tas5722_volume_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	unsigned int val;
+
+	snd_soc_component_read(component, TAS5720_VOLUME_CTRL_REG, &val);
+	ucontrol->value.integer.value[0] = val << 1;
+
+	snd_soc_component_read(component, TAS5722_DIGITAL_CTRL2_REG, &val);
+	ucontrol->value.integer.value[0] |= val & TAS5722_VOL_CONTROL_LSB;
+
+	return 0;
+}
+
+static int tas5722_volume_set(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	unsigned int sel = ucontrol->value.integer.value[0];
+
+	snd_soc_component_write(component, TAS5720_VOLUME_CTRL_REG, sel >> 1);
+	snd_soc_component_update_bits(component, TAS5722_DIGITAL_CTRL2_REG,
+				      TAS5722_VOL_CONTROL_LSB, sel);
+
+	return 0;
+}
 
 static const struct snd_kcontrol_new tas5720_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
-		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, dac_tlv),
+		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, tas5720_dac_tlv),
+	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
+		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),
+};
+
+static const struct snd_kcontrol_new tas5722_snd_controls[] = {
+	SOC_SINGLE_EXT_TLV("Speaker Driver Playback Volume",
+			   0, 0, 511, 0,
+			   tas5722_volume_get, tas5722_volume_set,
+			   tas5722_dac_tlv),
 	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
 		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),
 };
@@ -527,6 +568,23 @@ static const struct snd_soc_component_driver soc_component_dev_tas5720 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver soc_component_dev_tas5722 = {
+	.probe = tas5720_codec_probe,
+	.remove = tas5720_codec_remove,
+	.suspend = tas5720_suspend,
+	.resume = tas5720_resume,
+	.controls = tas5722_snd_controls,
+	.num_controls = ARRAY_SIZE(tas5722_snd_controls),
+	.dapm_widgets = tas5720_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tas5720_dapm_widgets),
+	.dapm_routes = tas5720_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(tas5720_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 /* PCM rates supported by the TAS5720 driver */
 #define TAS5720_RATES	(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
 			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
@@ -613,9 +671,23 @@ static int tas5720_probe(struct i2c_client *client,
 
 	dev_set_drvdata(dev, data);
 
-	ret = devm_snd_soc_register_component(&client->dev,
-				     &soc_component_dev_tas5720,
-				     tas5720_dai, ARRAY_SIZE(tas5720_dai));
+	switch (id->driver_data) {
+	case TAS5720:
+		ret = devm_snd_soc_register_component(&client->dev,
+					&soc_component_dev_tas5720,
+					tas5720_dai,
+					ARRAY_SIZE(tas5720_dai));
+		break;
+	case TAS5722:
+		ret = devm_snd_soc_register_component(&client->dev,
+					&soc_component_dev_tas5722,
+					tas5720_dai,
+					ARRAY_SIZE(tas5720_dai));
+		break;
+	default:
+		dev_err(dev, "unexpected private driver data\n");
+		return -EINVAL;
+	}
 	if (ret < 0) {
 		dev_err(dev, "failed to register component: %d\n", ret);
 		return ret;
-- 
2.18.0

