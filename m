Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE72027201
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Jzw20XJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE72027201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeF1KUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:20:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeF1KUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bV8L6Q7DGo6U+Kj0chrQopfpr0PsIWgzgNaVmWmjnTk=; b=Jzw20XJK+Vju
        CRK1/VDYVQqN++HkdeIcwV6P0iMo/hBu6CUu7EKdqIfz381cVhxh2XgvGfSBj2mhZvYUw9Yi6g0Tb
        61gZ5OtuQdB7LNQIiPPPIETfZz5KYGojwOrjHbk4NDNgz6gLN/3GgCaHagnHhj8NOsU9+T5fOwkya
        JW8q4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYU2U-0005Eb-0I; Thu, 28 Jun 2018 10:20:34 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYU2T-00047k-IT; Thu, 28 Jun 2018 11:20:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dpcm: extend channel merging to the backend cpu dai" to the asoc tree
In-Reply-To:  <20180627094818.5885-1-jbrunet@baylibre.com>
Message-Id: <E1fYU2T-00047k-IT@debutante>
Date:   Thu, 28 Jun 2018 11:20:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dpcm: extend channel merging to the backend cpu dai

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

From 4f2bd18b191a10660782f2f1ccc989b000b2be63 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 27 Jun 2018 11:48:18 +0200
Subject: [PATCH] ASoC: dpcm: extend channel merging to the backend cpu dai

Extend dpcm_merge_chan to also check backend cpu dai channels
capabilities. Apply the same policy as soc_pcm_init_runtime_hw() for
multicodec links and only check cpu dai in this case.

Cc: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 63f96cde046a..6ee4131941df 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1736,12 +1736,26 @@ static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
 
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
 		struct snd_soc_dai_driver *codec_dai_drv;
 		struct snd_soc_pcm_stream *codec_stream;
-		int i;
+		struct snd_soc_pcm_stream *cpu_stream;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			cpu_stream = &cpu_dai_drv->playback;
+		else
+			cpu_stream = &cpu_dai_drv->capture;
+
+		*channels_min = max(*channels_min, cpu_stream->channels_min);
+		*channels_max = min(*channels_max, cpu_stream->channels_max);
+
+		/*
+		 * chan min/max cannot be enforced if there are multiple CODEC
+		 * DAIs connected to a single CPU DAI, use CPU DAI's directly
+		 */
+		if (be->num_codecs == 1) {
+			codec_dai_drv = be->codec_dais[0]->driver;
 
-		for (i = 0; i < be->num_codecs; i++) {
-			codec_dai_drv = be->codec_dais[i]->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
-- 
2.18.0.rc2

