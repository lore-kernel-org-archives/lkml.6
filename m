Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A402121A8F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CKgJBXPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A402121A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeHIMjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:39:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHIMjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sf65d/bGqb0PQqQhtSR3PhamSwaozrQE8kltgDLe73Y=; b=CKgJBXPkASmu
        5swkdHUDsrXsK3eI26FIwnMH2pF2t42nBbqJiBBxMBcpwU3H2mqGeMyEFMrX8WFVfwr6U9lTO7tH6
        0ViYbJlskOPpidUFbjYzanFfl7oNRwaNw6heg++41AB64GEd8xR3wsqIFzOAuop8pPcGQWBjM6CeP
        t/gbU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnhyZ-0003Cl-LR; Thu, 09 Aug 2018 10:15:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6168A1124347; Thu,  9 Aug 2018 11:15:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7219: Add delays to capture path to remove DC offset noise" to the asoc tree
In-Reply-To:  <20180809094850.F1B623FB9D@swsrvapps-01.diasemi.com>
Message-Id: <20180809101527.6168A1124347@debutante.sirena.org.uk>
Date:   Thu,  9 Aug 2018 11:15:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Add delays to capture path to remove DC offset noise

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 17c81d2f5a59929c73a2a19fd49fe0b068fda76f Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 9 Aug 2018 10:48:50 +0100
Subject: [PATCH] ASoC: da7219: Add delays to capture path to remove DC offset
 noise

On some platforms it has been noted that a pop noise can be
witnessed when capturing audio, mainly for first time after a
headset jack has been inserted. This is due to a DC offset in the
Mic PGA and so to avoid this delays are required when powering
up the capture path.

This commit rectifies the problem by adding delays post Mic PGA and
post Mixin PGA. The post Mic PGA delay is determined based on
Mic Bias voltage, and is only applied the first time after a
headset jack is inserted.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219-aad.c |  5 ++++
 sound/soc/codecs/da7219.c     | 44 ++++++++++++++++++++++++++++++-----
 sound/soc/codecs/da7219.h     |  8 +++++--
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index a49ab751a036..2c7d5088e6f2 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -59,6 +59,7 @@ static void da7219_aad_btn_det_work(struct work_struct *work)
 		container_of(work, struct da7219_aad_priv, btn_det_work);
 	struct snd_soc_component *component = da7219_aad->component;
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 statusa, micbias_ctrl;
 	bool micbias_up = false;
 	int retries = 0;
@@ -86,6 +87,8 @@ static void da7219_aad_btn_det_work(struct work_struct *work)
 	if (retries >= DA7219_AAD_MICBIAS_CHK_RETRIES)
 		dev_warn(component->dev, "Mic bias status check timed out");
 
+	da7219->micbias_on_event = true;
+
 	/*
 	 * Mic bias pulse required to enable mic, must be done before enabling
 	 * button detection to prevent erroneous button readings.
@@ -439,6 +442,8 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
 					    DA7219_BUTTON_CONFIG_MASK, 0);
 
+			da7219->micbias_on_event = false;
+
 			/* Disable mic bias */
 			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
 			snd_soc_dapm_sync(dapm);
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c0144f2f8174..e46e9f4bc994 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -768,6 +768,30 @@ static const struct snd_kcontrol_new da7219_st_out_filtr_mix_controls[] = {
  * DAPM Events
  */
 
+static int da7219_mic_pga_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (da7219->micbias_on_event) {
+			/*
+			 * Delay only for first capture after bias enabled to
+			 * avoid possible DC offset related noise.
+			 */
+			da7219->micbias_on_event = false;
+			msleep(da7219->mic_pga_delay);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
@@ -937,12 +961,12 @@ static const struct snd_soc_dapm_widget da7219_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("MIC"),
 
 	/* Input PGAs */
-	SND_SOC_DAPM_PGA("Mic PGA", DA7219_MIC_1_CTRL,
-			 DA7219_MIC_1_AMP_EN_SHIFT, DA7219_NO_INVERT,
-			 NULL, 0),
-	SND_SOC_DAPM_PGA("Mixin PGA", DA7219_MIXIN_L_CTRL,
-			 DA7219_MIXIN_L_AMP_EN_SHIFT, DA7219_NO_INVERT,
-			 NULL, 0),
+	SND_SOC_DAPM_PGA_E("Mic PGA", DA7219_MIC_1_CTRL,
+			   DA7219_MIC_1_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			   NULL, 0, da7219_mic_pga_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_E("Mixin PGA", DA7219_MIXIN_L_CTRL,
+			   DA7219_MIXIN_L_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			   NULL, 0, da7219_settling_event, SND_SOC_DAPM_POST_PMU),
 
 	/* Input Filters */
 	SND_SOC_DAPM_ADC("ADC", NULL, DA7219_ADC_L_CTRL, DA7219_ADC_L_EN_SHIFT,
@@ -1847,6 +1871,14 @@ static void da7219_handle_pdata(struct snd_soc_component *component)
 
 		snd_soc_component_write(component, DA7219_MICBIAS_CTRL, micbias_lvl);
 
+		/*
+		 * Calculate delay required to compensate for DC offset in
+		 * Mic PGA, based on Mic Bias voltage.
+		 */
+		da7219->mic_pga_delay =  DA7219_MIC_PGA_BASE_DELAY +
+					(pdata->micbias_lvl *
+					 DA7219_MIC_PGA_OFFSET_DELAY);
+
 		/* Mic */
 		switch (pdata->mic_amp_in_sel) {
 		case DA7219_MIC_AMP_IN_SEL_DIFF:
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 1b00023e33cd..3a006862f0e7 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -781,8 +781,10 @@
 #define DA7219_SYS_STAT_CHECK_DELAY	50
 
 /* Power up/down Delays */
-#define DA7219_SETTLING_DELAY	40
-#define DA7219_MIN_GAIN_DELAY	30
+#define DA7219_SETTLING_DELAY		40
+#define DA7219_MIN_GAIN_DELAY		30
+#define DA7219_MIC_PGA_BASE_DELAY	100
+#define DA7219_MIC_PGA_OFFSET_DELAY	40
 
 enum da7219_clk_src {
 	DA7219_CLKSRC_MCLK = 0,
@@ -828,6 +830,8 @@ struct da7219_priv {
 
 	bool master;
 	bool alc_en;
+	bool micbias_on_event;
+	unsigned int mic_pga_delay;
 	u8 gain_ramp_ctrl;
 };
 
-- 
2.18.0

