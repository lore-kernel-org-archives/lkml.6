Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F372C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC15027202
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tepm7AT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC15027202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeF1KUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:20:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbeF1KUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3lKyrRvhd+LYkaD3hjubb6wD0G8JrLKJKNwm37nBstI=; b=tepm7AT8nhfJ
        GKsVPrTjvnfqVhvU8LEYBNwPsNKR5nJlysv1rhxHeIUbAum/Q/DjxbbuwwbDVSCBOjvw08f2BKOMG
        I9EjVf1WjFy0Oci9llSi6pv/jqq0KHxPlFaDZ0WE2l3qfe1fEhpy8cqQRxWDfhYIgAOte8QJUUwVw
        79bvE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYU2Y-0005Er-Al; Thu, 28 Jun 2018 10:20:38 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYU2X-00049u-T3; Thu, 28 Jun 2018 11:20:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dpcm: improve runtime update predictability" to the asoc tree
In-Reply-To:  <20180626100725.6016-1-jbrunet@baylibre.com>
Message-Id: <E1fYU2X-00049u-T3@debutante>
Date:   Thu, 28 Jun 2018 11:20:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dpcm: improve runtime update predictability

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

From de15d7ff5bef98746fcb76a0db7ac46de48d3560 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 26 Jun 2018 12:07:25 +0200
Subject: [PATCH] ASoC: dpcm: improve runtime update predictability

As it is, dpcm_runtime_update() performs the old path and new path
update of a frontend before going on to the next frontend DAI.
Depending the order of the FEs within the rtd list, the result of
the update might be different.

For example:
 * Frontend A connected to backend C, with a 48kHz playback
 * Frontend B connected to backend D, with a 44.1kHz playback
 * FE A appears before FE B in the rtd list of the card.

If we reparent BE C to FE B (disconnecting BE D):
* old path update of FE A will run first, and BE C will get hw_free()
  and shutdown()
* new path update of FE B will run after and BE C, which is stopped,
  so it will be configured at 44.1kHz, as expected

If we reparent BE D to FE A (disconnecting BE C):
* new path update of FE A will run first but since BE D is still running
  at 44.1kHz, it won't be reconfigured (no call to startup() or
  hw_params())
* old path update of FE B runs after, nothing happens
* In this case, we end up with a BE playing at 44.1kHz a stream which is
  supposed to be played at 48Khz (too slow)

To improve this situation, this patch performs all the FE old paths update
before going on to update the new paths. With this, the result should
no longer depend on the order of the FE within the card rtd list.

Please note that there might be a small performance penalty since
dpcm_process_paths() is called twice per stream direction.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 165 +++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 79 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 19ebfc958b9d..63f96cde046a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2597,106 +2597,113 @@ static int dpcm_run_old_update(struct snd_soc_pcm_runtime *fe, int stream)
 	return ret;
 }
 
-/* Called by DAPM mixer/mux changes to update audio routing between PCMs and
- * any DAI links.
- */
-int soc_dpcm_runtime_update(struct snd_soc_card *card)
+static int soc_dpcm_fe_runtime_update(struct snd_soc_pcm_runtime *fe, int new)
 {
-	struct snd_soc_pcm_runtime *fe;
-	int old, new, paths;
+	struct snd_soc_dapm_widget_list *list;
+	int count, paths;
 
-	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
-	list_for_each_entry(fe, &card->rtd_list, list) {
-		struct snd_soc_dapm_widget_list *list;
+	if (!fe->dai_link->dynamic)
+		return 0;
 
-		/* make sure link is FE */
-		if (!fe->dai_link->dynamic)
-			continue;
+	/* only check active links */
+	if (!fe->cpu_dai->active)
+		return 0;
 
-		/* only check active links */
-		if (!fe->cpu_dai->active)
-			continue;
+	/* DAPM sync will call this to update DSP paths */
+	dev_dbg(fe->dev, "ASoC: DPCM %s runtime update for FE %s\n",
+		new ? "new" : "old", fe->dai_link->name);
 
-		/* DAPM sync will call this to update DSP paths */
-		dev_dbg(fe->dev, "ASoC: DPCM runtime update for FE %s\n",
-			fe->dai_link->name);
+	/* skip if FE doesn't have playback capability */
+	if (!fe->cpu_dai->driver->playback.channels_min ||
+	    !fe->codec_dai->driver->playback.channels_min)
+		goto capture;
 
-		/* skip if FE doesn't have playback capability */
-		if (!fe->cpu_dai->driver->playback.channels_min
-		    || !fe->codec_dai->driver->playback.channels_min)
-			goto capture;
-
-		/* skip if FE isn't currently playing */
-		if (!fe->cpu_dai->playback_active
-		    || !fe->codec_dai->playback_active)
-			goto capture;
-
-		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
-		if (paths < 0) {
-			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
-					fe->dai_link->name,  "playback");
-			mutex_unlock(&card->mutex);
-			return paths;
-		}
+	/* skip if FE isn't currently playing */
+	if (!fe->cpu_dai->playback_active || !fe->codec_dai->playback_active)
+		goto capture;
 
-		/* update any new playback paths */
-		new = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, 1);
-		if (new) {
-			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
-		}
+	paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
+	if (paths < 0) {
+		dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
+			 fe->dai_link->name,  "playback");
+		return paths;
+	}
 
-		/* update any old playback paths */
-		old = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, 0);
-		if (old) {
+	/* update any playback paths */
+	count = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, new);
+	if (count) {
+		if (new)
+			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
+		else
 			dpcm_run_old_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
-		}
 
-		dpcm_path_put(&list);
+		dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
+		dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
+	}
+
+	dpcm_path_put(&list);
+
 capture:
-		/* skip if FE doesn't have capture capability */
-		if (!fe->cpu_dai->driver->capture.channels_min
-		    || !fe->codec_dai->driver->capture.channels_min)
-			continue;
+	/* skip if FE doesn't have capture capability */
+	if (!fe->cpu_dai->driver->capture.channels_min ||
+	    !fe->codec_dai->driver->capture.channels_min)
+		return 0;
 
-		/* skip if FE isn't currently capturing */
-		if (!fe->cpu_dai->capture_active
-		    || !fe->codec_dai->capture_active)
-			continue;
+	/* skip if FE isn't currently capturing */
+	if (!fe->cpu_dai->capture_active || !fe->codec_dai->capture_active)
+		return 0;
 
-		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
-		if (paths < 0) {
-			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
-					fe->dai_link->name,  "capture");
-			mutex_unlock(&card->mutex);
-			return paths;
-		}
+	paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
+	if (paths < 0) {
+		dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
+			 fe->dai_link->name,  "capture");
+		return paths;
+	}
 
-		/* update any new capture paths */
-		new = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, 1);
-		if (new) {
+	/* update any old capture paths */
+	count = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, new);
+	if (count) {
+		if (new)
 			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
-		}
-
-		/* update any old capture paths */
-		old = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, 0);
-		if (old) {
+		else
 			dpcm_run_old_update(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
-		}
 
-		dpcm_path_put(&list);
+		dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
+		dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
 	}
 
-	mutex_unlock(&card->mutex);
+	dpcm_path_put(&list);
+
 	return 0;
 }
+
+/* Called by DAPM mixer/mux changes to update audio routing between PCMs and
+ * any DAI links.
+ */
+int soc_dpcm_runtime_update(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *fe;
+	int ret = 0;
+
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	/* shutdown all old paths first */
+	list_for_each_entry(fe, &card->rtd_list, list) {
+		ret = soc_dpcm_fe_runtime_update(fe, 0);
+		if (ret)
+			goto out;
+	}
+
+	/* bring new paths up */
+	list_for_each_entry(fe, &card->rtd_list, list) {
+		ret = soc_dpcm_fe_runtime_update(fe, 1);
+		if (ret)
+			goto out;
+	}
+
+out:
+	mutex_unlock(&card->mutex);
+	return ret;
+}
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 {
 	struct snd_soc_dpcm *dpcm;
-- 
2.18.0.rc2

