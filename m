Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbeCEMeW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:34:22 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34574 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932864AbeCEMeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:34:20 -0500
X-Google-Smtp-Source: AG47ELsiROYT8FuhgHyH790JIVqPy4O6Bt3nL3ECfUaT8fHHAFMVlliDJaQNsfAE8V9/XBubotwipg==
From: srinivas.kandagatla@linaro.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
Date: Mon,  5 Mar 2018 12:32:13 +0000
Message-Id: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Purpose of having pinctrl dapm is to dynamically put the pins in
low power state when they are not actively used by the audio and
saving power.

Without this each driver has to set the pinctrl states, either
during probe or dynamically depending on the callbacks received
from ASoC core.

This patch adds a single macro SND_SOC_DAPM_PINCTRL which takes, 
widget, active and sleep state names, and the dapm would use active
and sleep state pinctrl names to put the pins in active and sleep
state respectively.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Hi All, 

Purpose of this patch is to discuss the idea of having pinctrl part of dapm.

As an example on Qualcomm SoCs there are multiple I2S Interfaces, each of
these interfaces have there own pinctrls setting, It does not make sense
for the machine/platform/componet driver to put them in default/active
state durning probe/init as it would waste power. If we make these pinctrl
part of the dapm sequence, these would only become active when the
stream is active which would save power.

This patch adds a single macro SND_SOC_DAPM_PINCTRL which takes, 
widget, active and sleep state names, and the dapm would use active
and sleep state pinctrl names to put the pins in active and sleep state
respectively.

Thanks,
Srini

 include/sound/soc-dapm.h | 16 ++++++++++++++++
 sound/soc/soc-dapm.c     | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 344b96c206a3..a6ce2de4e20a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -269,6 +269,13 @@ struct device;
 	.reg = SND_SOC_NOPM, .shift = wdelay, .event = dapm_regulator_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD, \
 	.on_val = wflags}
+#define SND_SOC_DAPM_PINCTRL(wname, active, sleep) \
+{	.id = snd_soc_dapm_pinctrl, .name = wname, \
+	.priv = (&(struct snd_soc_dapm_pinctrl_priv) \
+		{ .active_state = active, .sleep_state = sleep,}), \
+	.reg = SND_SOC_NOPM, .event = dapm_pinctrl_event, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
+
 
 
 /* dapm kcontrol types */
@@ -374,6 +381,8 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
 int dapm_clock_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
+int dapm_pinctrl_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event);
 
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
@@ -500,6 +509,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_pre,			/* machine specific pre widget - exec first */
 	snd_soc_dapm_post,			/* machine specific post widget - exec last */
 	snd_soc_dapm_supply,		/* power/clock supply */
+	snd_soc_dapm_pinctrl,		/* pinctrl */
 	snd_soc_dapm_regulator_supply,	/* external regulator */
 	snd_soc_dapm_clock_supply,	/* external clock */
 	snd_soc_dapm_aif_in,		/* audio interface input */
@@ -581,6 +591,7 @@ struct snd_soc_dapm_widget {
 
 	void *priv;				/* widget specific data */
 	struct regulator *regulator;		/* attached regulator */
+	struct pinctrl *pinctrl;		/* attached pinctrl */
 	const struct snd_soc_pcm_stream *params; /* params for dai links */
 	unsigned int num_params; /* number of params for dai links */
 	unsigned int params_select; /* currently selected param for dai link */
@@ -683,6 +694,11 @@ struct snd_soc_dapm_stats {
 	int neighbour_checks;
 };
 
+struct snd_soc_dapm_pinctrl_priv {
+	const char *active_state;
+	const char *sleep_state;
+};
+
 /**
  * snd_soc_dapm_init_bias_level() - Initialize DAPM bias level
  * @dapm: The DAPM context to initialize
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 40085a4c8f92..babff1cd2849 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -35,6 +35,7 @@
 #include <linux/debugfs.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -72,6 +73,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 static int dapm_up_seq[] = {
 	[snd_soc_dapm_pre] = 0,
 	[snd_soc_dapm_regulator_supply] = 1,
+	[snd_soc_dapm_pinctrl] = 1,
 	[snd_soc_dapm_clock_supply] = 1,
 	[snd_soc_dapm_supply] = 2,
 	[snd_soc_dapm_micbias] = 3,
@@ -119,6 +121,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_dai_link] = 11,
 	[snd_soc_dapm_supply] = 12,
 	[snd_soc_dapm_clock_supply] = 13,
+	[snd_soc_dapm_pinctrl] = 13,
 	[snd_soc_dapm_regulator_supply] = 13,
 	[snd_soc_dapm_post] = 14,
 };
@@ -1287,6 +1290,33 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(dapm_regulator_event);
 
+/*
+ * Handler for pinctrl widget.
+ */
+int dapm_pinctrl_event(struct snd_soc_dapm_widget *w,
+		       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_dapm_pinctrl_priv *priv = w->priv;
+	struct pinctrl *p = w->pinctrl;
+	struct pinctrl_state *s;
+
+	if (!p || !priv)
+		return -EIO;
+
+	soc_dapm_async_complete(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		s = pinctrl_lookup_state(p, priv->active_state);
+	else
+		s = pinctrl_lookup_state(p, priv->sleep_state);
+
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	return pinctrl_select_state(p, s);
+}
+EXPORT_SYMBOL_GPL(dapm_pinctrl_event);
+
 /*
  * Handler for clock supply widget.
  */
@@ -1900,6 +1930,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 				break;
 			case snd_soc_dapm_supply:
 			case snd_soc_dapm_regulator_supply:
+			case snd_soc_dapm_pinctrl:
 			case snd_soc_dapm_clock_supply:
 			case snd_soc_dapm_micbias:
 				if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
@@ -2313,6 +2344,7 @@ static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
 		case snd_soc_dapm_mixer_named_ctl:
 		case snd_soc_dapm_supply:
 		case snd_soc_dapm_regulator_supply:
+		case snd_soc_dapm_pinctrl:
 		case snd_soc_dapm_clock_supply:
 			if (w->name)
 				count += sprintf(buf + count, "%s: %s\n",
@@ -3462,6 +3494,17 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 					 w->name, ret);
 		}
 		break;
+	case snd_soc_dapm_pinctrl:
+		w->pinctrl = devm_pinctrl_get(dapm->dev);
+		if (IS_ERR_OR_NULL(w->pinctrl)) {
+			ret = PTR_ERR(w->pinctrl);
+			if (ret == -EPROBE_DEFER)
+				return ERR_PTR(ret);
+			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
+				w->name, ret);
+			return NULL;
+		}
+		break;
 	case snd_soc_dapm_clock_supply:
 #ifdef CONFIG_CLKDEV_LOOKUP
 		w->clk = devm_clk_get(dapm->dev, w->name);
@@ -3541,6 +3584,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		break;
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_pinctrl:
 	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_kcontrol:
 		w->is_supply = 1;
-- 
2.15.1
