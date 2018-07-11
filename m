Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1381BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D6420864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="f+/vvekP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D6420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbeGKLCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:02:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40906 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGKLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PKlV3UmxnyX/+iv455k/YVarVlqE+TO9cHog9f4lEH8=; b=f+/vvekPgUyD
        FoMxAn5rmbhXeGoRkjcf1eoHRyIapV8rIAtMywWY97044BBUZjirgbOiHM6lcHGFR1HaZ1gYKk+Tq
        OI/F6Ufepgnd8o3M99nokR56RKZKRQNO9UBOkG9cSdelgCMsqob2vqSM+hN5S9A4n0VBZxtFMfgWX
        ziQvs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdCpt-0002qA-VJ; Wed, 11 Jul 2018 10:59:06 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdCps-0007xT-OS; Wed, 11 Jul 2018 11:59:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dpcm: rework runtime stream merge" to the asoc tree
In-Reply-To:  <20180705101349.7520-2-jbrunet@baylibre.com>
Message-Id: <E1fdCps-0007xT-OS@debutante>
Date:   Wed, 11 Jul 2018 11:59:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dpcm: rework runtime stream merge

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

From 435ffb76f8b35be108a52bf1c43233a57b3c72b4 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 5 Jul 2018 12:13:48 +0200
Subject: [PATCH] ASoC: dpcm: rework runtime stream merge

The goal of this patch is to simplify a bit dpcm runtime stream merge
by removing several local variables.

ATM, merge functions return the BE 'filter' values which should then be
filtered against the FE stream values. This create a lot of local
variable and unnecessary init of min and max.

Instead of this, we can pass the FE stream values directly and let the
BE filtering functions perform the merge 'in-place'

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b7e67b871c0c..114e6c060cae 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1672,29 +1672,28 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 }
 
 static void dpcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
-				 struct snd_soc_pcm_stream *stream,
-				 u64 formats)
+				 struct snd_soc_pcm_stream *stream)
 {
 	runtime->hw.rate_min = stream->rate_min;
 	runtime->hw.rate_max = stream->rate_max;
 	runtime->hw.channels_min = stream->channels_min;
 	runtime->hw.channels_max = stream->channels_max;
 	if (runtime->hw.formats)
-		runtime->hw.formats &= formats & stream->formats;
+		runtime->hw.formats &= stream->formats;
 	else
-		runtime->hw.formats = formats & stream->formats;
+		runtime->hw.formats = stream->formats;
 	runtime->hw.rates = stream->rates;
 }
 
-static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
+static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
+				      u64 *formats)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	struct snd_soc_dpcm *dpcm;
-	u64 formats = ULLONG_MAX;
 	int stream = substream->stream;
 
 	if (!fe->dai_link->dpcm_merged_format)
-		return formats;
+		return;
 
 	/*
 	 * It returns merged BE codec format
@@ -1714,16 +1713,14 @@ static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
 			else
 				codec_stream = &codec_dai_drv->capture;
 
-			formats &= codec_stream->formats;
+			*formats &= codec_stream->formats;
 		}
 	}
-
-	return formats;
 }
 
-static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
-				   unsigned int *channels_min,
-				   unsigned int *channels_max)
+static void dpcm_runtime_merge_chan(struct snd_pcm_substream *substream,
+				    unsigned int *channels_min,
+				    unsigned int *channels_max)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	struct snd_soc_dpcm *dpcm;
@@ -1732,9 +1729,6 @@ static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
 	if (!fe->dai_link->dpcm_merged_chan)
 		return;
 
-	*channels_min = 0;
-	*channels_max = UINT_MAX;
-
 	/*
 	 * It returns merged BE codec channel;
 	 * if FE want to use it (= dpcm_merged_chan)
@@ -1781,18 +1775,15 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
-	u64 format = dpcm_runtime_base_format(substream);
-	unsigned int channels_min = 0, channels_max = UINT_MAX;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback, format);
+		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback);
 	else
-		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture, format);
-
-	dpcm_runtime_base_chan(substream, &channels_min, &channels_max);
+		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture);
 
-	runtime->hw.channels_min = max(channels_min, runtime->hw.channels_min);
-	runtime->hw.channels_max = min(channels_max, runtime->hw.channels_max);
+	dpcm_runtime_merge_format(substream, &runtime->hw.formats);
+	dpcm_runtime_merge_chan(substream, &runtime->hw.channels_min,
+				&runtime->hw.channels_max);
 }
 
 static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);
-- 
2.18.0.rc2

