Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeECHhA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:37:00 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:51789 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeECHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:36:58 -0400
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC: <dannenberg@ti.com>, <afd@ti.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v4] ASoC: tas6424: Allow disabling auto diagnostics for faster power-on
Date: Thu, 3 May 2018 09:36:27 +0200
Message-ID: <1525332987-5266-1-git-send-email-jjhiblot@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS6424 incorporates both DC-load and AC-load diagnostics which are
used to determine the status of the load. The DC diagnostics runs when any
channel is directed to leave the Hi-Z state and enter the MUTE or PLAY
state.
The DC diagnostics are turned on by default but, if a fast startup without
diagnostics is required, the diagnostics can be disabled using a dedicated
ALSA control.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---

changes in v4:
- rename the control "Auto Diagnostics Swicth" with a capital S on the Switch

 sound/soc/codecs/tas6424.c | 13 +++++++++++--
 sound/soc/codecs/tas6424.h |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 89fd0c1..14999b9 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -64,6 +64,8 @@ static const struct snd_kcontrol_new tas6424_snd_controls[] = {
 		       TAS6424_CH3_VOL_CTRL, 0, 0xff, 0, dac_tlv),
 	SOC_SINGLE_TLV("Speaker Driver CH4 Playback Volume",
 		       TAS6424_CH4_VOL_CTRL, 0, 0xff, 0, dac_tlv),
+	SOC_SINGLE_STROBE("Auto Diagnostics Switch", TAS6424_DC_DIAG_CTRL1,
+			  TAS6424_LDGBYPASS_SHIFT, 1),
 };
 
 static int tas6424_dac_event(struct snd_soc_dapm_widget *w,
@@ -297,6 +299,11 @@ static int tas6424_power_on(struct snd_soc_component *component)
 	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	int ret;
 	u8 chan_states;
+	int no_auto_diags = 0;
+	unsigned int reg_val;
+
+	if (!regmap_read(tas6424->regmap, TAS6424_DC_DIAG_CTRL1, &reg_val))
+		no_auto_diags = reg_val & TAS6424_LDGBYPASS_MASK;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
 				    tas6424->supplies);
@@ -327,9 +334,11 @@ static int tas6424_power_on(struct snd_soc_component *component)
 	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, chan_states);
 
 	/* any time we come out of HIZ, the output channels automatically run DC
-	 * load diagnostics, wait here until this completes
+	 * load diagnostics if autodiagnotics are enabled. wait here until this
+	 * completes.
 	 */
-	msleep(230);
+	if (!no_auto_diags)
+		msleep(230);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tas6424.h b/sound/soc/codecs/tas6424.h
index 4305883..b5958c4 100644
--- a/sound/soc/codecs/tas6424.h
+++ b/sound/soc/codecs/tas6424.h
@@ -111,6 +111,10 @@
 					 TAS6424_CH3_STATE_DIAG | \
 					 TAS6424_CH4_STATE_DIAG)
 
+/* TAS6424_DC_DIAG_CTRL1 */
+#define TAS6424_LDGBYPASS_SHIFT		0
+#define TAS6424_LDGBYPASS_MASK		BIT(TAS6424_LDGBYPASS_SHIFT)
+
 /* TAS6424_GLOB_FAULT1_REG */
 #define TAS6424_FAULT_CLOCK		BIT(4)
 #define TAS6424_FAULT_PVDD_OV		BIT(3)
-- 
2.7.4
