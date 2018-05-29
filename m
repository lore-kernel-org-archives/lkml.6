Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965046AbeE2O7e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:59:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41212 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935773AbeE2O73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:59:29 -0400
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, spatakok@qti.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe-dai: use q6afe_dai_prepare() for MI2S" to the asoc tree
In-Reply-To: <20180529101833.30489-4-srinivas.kandagatla@linaro.org>
Message-Id: <E1fNg5s-00062B-N9@debutante>
Date: Tue, 29 May 2018 15:59:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe-dai: use q6afe_dai_prepare() for MI2S

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

>From b916449c5e0129858320e313bbcfff05ae4cde6d Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 29 May 2018 11:18:30 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: use q6afe_dai_prepare() for MI2S

Use common q6afe_dai_prepare() for MI2S dais, this will remove
some code duplication. Also make the if statement to switch to
make the code look neater.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 53 +++++++++++---------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 4378e29a95c5..e529edfd8001 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -144,38 +144,6 @@ static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
 
 }
 
-static int q6afe_mi2s_prepare(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
-	int rc;
-
-	if (dai_data->is_port_started[dai->id]) {
-		/* stop the port and restart with new port config */
-		rc = q6afe_port_stop(dai_data->port[dai->id]);
-		if (rc < 0) {
-			dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
-			return rc;
-		}
-	}
-
-	rc = q6afe_i2s_port_prepare(dai_data->port[dai->id],
-			       &dai_data->port_config[dai->id].i2s_cfg);
-	if (rc < 0) {
-		dev_err(dai->dev, "fail to prepare AFE port %x\n", dai->id);
-		return rc;
-	}
-
-	rc = q6afe_port_start(dai_data->port[dai->id]);
-	if (rc < 0) {
-		dev_err(dai->dev, "fail to start AFE port %x\n", dai->id);
-		return rc;
-	}
-	dai_data->is_port_started[dai->id] = true;
-
-	return 0;
-}
-
 static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -191,12 +159,27 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (dai->id == HDMI_RX)
+	switch (dai->id) {
+	case HDMI_RX:
 		q6afe_hdmi_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].hdmi);
-	else if (dai->id >= SLIMBUS_0_RX && dai->id <= SLIMBUS_6_TX)
+		break;
+	case SLIMBUS_0_RX ... SLIMBUS_6_TX:
 		q6afe_slim_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].slim);
+		break;
+	case PRIMARY_MI2S_RX ... QUATERNARY_MI2S_TX:
+		rc = q6afe_i2s_port_prepare(dai_data->port[dai->id],
+			       &dai_data->port_config[dai->id].i2s_cfg);
+		if (rc < 0) {
+			dev_err(dai->dev, "fail to prepare AFE port %x\n",
+				dai->id);
+			return rc;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	rc = q6afe_port_start(dai_data->port[dai->id]);
 	if (rc < 0) {
@@ -289,7 +272,7 @@ static struct snd_soc_dai_ops q6hdmi_ops = {
 };
 
 static struct snd_soc_dai_ops q6i2s_ops = {
-	.prepare	= q6afe_mi2s_prepare,
+	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6i2s_hw_params,
 	.set_fmt	= q6i2s_set_fmt,
 	.shutdown	= q6afe_dai_shutdown,
-- 
2.17.0
