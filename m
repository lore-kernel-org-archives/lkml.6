Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeECXTH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:19:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeECXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:19:05 -0400
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, afd@ti.com,
        dannenberg@ti.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tas6424: Allow disabling auto diagnostics for faster power-on" to the asoc tree
In-Reply-To: <1525332987-5266-1-git-send-email-jjhiblot@ti.com>
Message-Id: <20180503231848.2B7AD44007A@finisterre.ee.mobilebroadband>
Date: Fri,  4 May 2018 00:18:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas6424: Allow disabling auto diagnostics for faster power-on

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

>From 396888772ab738eca923d13fd3d55733091c5daf Mon Sep 17 00:00:00 2001
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Date: Thu, 3 May 2018 09:36:27 +0200
Subject: [PATCH] ASoC: tas6424: Allow disabling auto diagnostics for faster
 power-on

The TAS6424 incorporates both DC-load and AC-load diagnostics which are
used to determine the status of the load. The DC diagnostics runs when any
channel is directed to leave the Hi-Z state and enter the MUTE or PLAY
state.
The DC diagnostics are turned on by default but, if a fast startup without
diagnostics is required, the diagnostics can be disabled using a dedicated
ALSA control.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas6424.c | 13 +++++++++++--
 sound/soc/codecs/tas6424.h |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 89fd0c1b3903..14999b999fd3 100644
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
index 430588328a06..b5958c45ed0e 100644
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
2.17.0
