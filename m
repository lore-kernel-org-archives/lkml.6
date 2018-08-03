Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61EEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EDE2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAvwE2Ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EDE2175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeHCO2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:28:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36030 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeHCO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:28:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so6241064wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v/GtFxHV/J4St/87/nLRi7lLCQ/16Mmn4FOEnHnq8Rk=;
        b=MAvwE2Kut0x2t1/xU0l6h0VG5/KGg4Dl7vyt7SdU5oxowndt+nLrW7SbapjEUQOsdh
         46IJZKSpKLeEX0VntgSYppmTDFGVNTJNPODhtm/4q1AOnOfmEMIwvcrbX6HwfQuRrG9i
         v7h6YGLwRhhBS6+CSNCCc0blyRdU30P3PquCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v/GtFxHV/J4St/87/nLRi7lLCQ/16Mmn4FOEnHnq8Rk=;
        b=h7RUNxvASbgIjEacj4wksKg9us1cvUcnHRYlkjXomALhJguY5v4rzmyvwsW8XhIohj
         h1rdxG1ZqLUBx4l1dCpQmvqQOTnTKr1eRYGk1jQFiVsdEZxV5t+R5FbPQXqyL65UuHOV
         wdrbGhKxuR5vAW6yTfl6dFA7gqbWG9Y+lxzxTfi6iXzmX3fLTnr7SWvYX0yS/F31aNHe
         RE0IEz2Oe1nHaG4TrkiJ5Fn2Sqqi1YURGbgqk70D3uV2k4MhoAlI3/5tZq5l8iWP+WmN
         IbixwVvEHTAsYnLTF1d0wUnr4M+zC7Wi5Y3oO8hrd2EvneXJpXm6hMxXaHYjwqmghYrs
         B61w==
X-Gm-Message-State: AOUpUlEzfGMrh+rob8qHyPmlBTikTVskZwlNYWhsvHPvz/ZGImB5Dijx
        qheCKw77cmXVamI5wCSFe1pe4w==
X-Google-Smtp-Source: AAOMgpc5GZiq0OWta9khHAzHQO2ApLqVtGeFwlwhFq0/smNn6fuacLP/2bwpjm7oq2QyU9mufNZj+Q==
X-Received: by 2002:a1c:e304:: with SMTP id a4-v6mr4912681wmh.0.1533299553281;
        Fri, 03 Aug 2018 05:32:33 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 200-v6sm4020642wmv.6.2018.08.03.05.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 05:32:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, vkoul@kernel.org,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        namartax.kohli@intel.com, ramesh.babu@intel.com,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org, pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] ASoC: compress: make BE and FE order inline with dpcm
Date:   Fri,  3 Aug 2018 13:30:03 +0100
Message-Id: <20180803123003.13444-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason order of startup/hw_params/prepare are reversed
in dynamic compress usecase when compared to dpcm usecase. This is
a issue with platforms like QCOM where it expects the BE to be
initialized before FE.

Interestingly the compress trigger callback order is inline with dpcm.

Am not 100% sure why the compress audio case has been reversed.
This patch is making the order inline with dpcm.

If the reverse ordering is just co-incendental then this change
makes sense and will avoid inventing some new mechanism to cope
with ordering.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi All,

This patch is making the order of startup/hw_params/prepare in dynamic
compress usecase inline with dpcm case.

As I could not figure out the reason why this was done in reverse order.
So am sending this patch to get some insights of this.

It would be great If someone from Intel can test this patch to verify
if the new ordering is okay.

Without this patch, we have to come up with a new mechanism to enforce
ordering on QCom platform to get compress offload working.

Thanks,
Srini


 sound/soc/soc-compress.c | 96 +++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b9e1673fea51..409d082e80d1 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -140,6 +140,30 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		stream = SNDRV_PCM_STREAM_CAPTURE;
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	fe->dpcm[stream].runtime = fe_substream->runtime;
+
+	ret = dpcm_path_get(fe, stream, &list);
+	if (ret < 0)
+		goto be_err;
+	else if (ret == 0)
+		dev_dbg(fe->dev, "Compress ASoC: %s no valid %s route\n",
+			fe->dai_link->name, stream ? "capture" : "playback");
+	/* calculate valid and active FE <-> BE dpcms */
+	dpcm_process_paths(fe, stream, &list, 1);
+	fe->dpcm[stream].runtime = fe_substream->runtime;
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	ret = dpcm_be_dai_startup(fe, stream);
+	if (ret < 0) {
+		/* clean up all links */
+		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
+
+		dpcm_be_disconnect(fe, stream);
+		fe->dpcm[stream].runtime = NULL;
+		goto out;
+	}
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
 		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
@@ -153,7 +177,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	ret = soc_compr_components_open(cstream, &component);
 	if (ret < 0)
-		goto machine_err;
+		goto open_err;
 
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->startup) {
 		ret = fe->dai_link->compr_ops->startup(cstream);
@@ -164,31 +188,6 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		}
 	}
 
-	fe->dpcm[stream].runtime = fe_substream->runtime;
-
-	ret = dpcm_path_get(fe, stream, &list);
-	if (ret < 0)
-		goto fe_err;
-	else if (ret == 0)
-		dev_dbg(fe->dev, "Compress ASoC: %s no valid %s route\n",
-			fe->dai_link->name, stream ? "capture" : "playback");
-
-	/* calculate valid and active FE <-> BE dpcms */
-	dpcm_process_paths(fe, stream, &list, 1);
-
-	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
-
-	ret = dpcm_be_dai_startup(fe, stream);
-	if (ret < 0) {
-		/* clean up all links */
-		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
-			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
-
-		dpcm_be_disconnect(fe, stream);
-		fe->dpcm[stream].runtime = NULL;
-		goto path_err;
-	}
-
 	dpcm_clear_pending_state(fe, stream);
 	dpcm_path_put(&list);
 
@@ -201,17 +200,14 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	return 0;
 
-path_err:
-	dpcm_path_put(&list);
-fe_err:
-	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
-		fe->dai_link->compr_ops->shutdown(cstream);
 machine_err:
 	soc_compr_components_free(cstream, component);
-
+open_err:
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
 out:
+	dpcm_path_put(&list);
+be_err:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 	mutex_unlock(&fe->card->mutex);
 	return ret;
@@ -551,6 +547,24 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
+	/*
+	 * Create an empty hw_params for the BE as the machine driver must
+	 * fix this up to match DSP decoder and ASRC configuration.
+	 * I.e. machine driver fixup for compressed BE is mandatory.
+	 */
+	memset(&fe->dpcm[fe_substream->stream].hw_params, 0,
+		sizeof(struct snd_pcm_hw_params));
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	ret = dpcm_be_dai_hw_params(fe, stream);
+	if (ret < 0)
+		goto out;
+
+	ret = dpcm_be_dai_prepare(fe, stream);
+	if (ret < 0)
+		goto out;
+
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->set_params) {
 		ret = cpu_dai->driver->cops->set_params(cstream, params, cpu_dai);
 		if (ret < 0)
@@ -577,24 +591,6 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 			goto out;
 	}
 
-	/*
-	 * Create an empty hw_params for the BE as the machine driver must
-	 * fix this up to match DSP decoder and ASRC configuration.
-	 * I.e. machine driver fixup for compressed BE is mandatory.
-	 */
-	memset(&fe->dpcm[fe_substream->stream].hw_params, 0,
-		sizeof(struct snd_pcm_hw_params));
-
-	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
-
-	ret = dpcm_be_dai_hw_params(fe, stream);
-	if (ret < 0)
-		goto out;
-
-	ret = dpcm_be_dai_prepare(fe, stream);
-	if (ret < 0)
-		goto out;
-
 	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_START);
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
 
-- 
2.16.2

