Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeEUPsm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:48:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55292 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbeEUPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:48:35 -0400
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown" to the asoc tree
In-Reply-To: <1524741374-13523-8-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <E1fKn32-0007IT-Qu@debutante>
Date: Mon, 21 May 2018 16:48:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown

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

>From e9716ff3dcd052d8640047860a78c948629c6c70 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Tue, 8 May 2018 10:17:50 +0530
Subject: [PATCH] ASoC: AMD: Move clk enable from hw_params/free to
 startup/shutdown

hw_param can be called multiple times and thus we can have
more clk enable. The clk may not get diabled due to refcounting.
startup/shutdown ensures single clk enable/disable call.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 49 ++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 215b06bf2039..6495eedc3d4c 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -91,8 +91,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -106,11 +105,9 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
+static void da7219_clk_disable(void)
 {
 	clk_disable_unprepare(da7219_dai_clk);
-
-	return 0;
 }
 
 static const unsigned int channels[] = {
@@ -133,7 +130,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int cz_fe_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -147,23 +144,47 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	return 0;
+	return da7219_clk_enable(substream);
+}
+
+static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_max_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_max_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_dmic_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
 }
 
 static struct snd_soc_ops cz_da7219_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
-	.startup = cz_fe_startup,
+	.startup = cz_da7219_startup,
+	.shutdown = cz_da7219_shutdown,
 };
 
 static struct snd_soc_ops cz_max_play_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_max_startup,
+	.shutdown = cz_max_shutdown,
 };
 
 static struct snd_soc_ops cz_dmic_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_dmic_startup,
+	.shutdown = cz_dmic_shutdown,
 };
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
-- 
2.17.0
