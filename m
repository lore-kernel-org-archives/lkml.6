Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2851C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473E82170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473E82170D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeHCOxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:53:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10981 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeHCOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:53:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6451210000>; Fri, 03 Aug 2018 05:57:05 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Aug 2018 05:57:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Aug 2018 05:57:17 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 Aug
 2018 12:57:16 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 Aug
 2018 12:57:16 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 3 Aug 2018 12:57:16 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.122]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b64512b0000>; Fri, 03 Aug 2018 05:57:16 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH] ASoC: core: Optimise suspend/resume of DAPM widgets
Date:   Fri, 3 Aug 2018 13:57:05 +0100
Message-ID: <1533301025-19980-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For soundcards that have several DAI links and many DAPM widgets the
time taken for snd_soc_suspend to execute has been observed to be
several milliseconds. The time is largely spent executing
dapm_power_widgets() for each for the DAI links that need to be
suspended. Given that dapm_power_widgets() is called again after
suspending/resuming the DAI links, one way to optimise the
suspend/resume time is to avoid calling dapm_power_widgets() for
each DAI link and reduces the suspend time significantly.

Please note that this has been observed on the Tegra210 Jetson TX1
platform which is not currently supported in the mainline for audio
but has been tested with out-of-tree patches to enable I2S audio.
For Tegra210 the audio drivers (for I2S, etc) are implemented as
component drivers to offer greater flexibility with dynamic audio
routing within the Tegra Audio Processing Engine (APE) from userspace.
The downside of this flexibility is that now there are a lof more DAI
links and so the time to suspend the soundcard can take several
milliseconds.

In the resume path, it is not clear if there could be any issues from
not sync'ing the DAPM power state until after unmuting and resuming
the CPU DAI drivers, because this will happen later with this change.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---

It is not 100% clear to me if there are any downsides to this approach
but I am looking to find away to avoid calling dapm_power_widgets() so
many times in the suspend path when there are many DAI links.
Unfortunately, I don't think that I can simply mark some of the DAI
links with 'ignore_suspend' because it could be possible that they are
active.

 include/sound/soc-dapm.h |  2 ++
 sound/soc/soc-core.c     | 18 ++++--------------
 sound/soc/soc-dapm.c     | 43 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index af9ef16cc34d..5dbd601154c4 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -427,6 +427,8 @@ void snd_soc_dapm_reset_cache(struct snd_soc_dapm_context *dapm);
 /* dapm events */
 void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	int event);
+void snd_soc_dapm_stream_suspend(struct snd_soc_pcm_runtime *rtd, int stream);
+void snd_soc_dapm_stream_resume(struct snd_soc_pcm_runtime *rtd, int stream);
 void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* external DAPM widget events */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 81b27923303d..03c5fa95afb8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -519,13 +519,8 @@ int snd_soc_suspend(struct device *dev)
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		snd_soc_dapm_stream_event(rtd,
-					  SNDRV_PCM_STREAM_PLAYBACK,
-					  SND_SOC_DAPM_STREAM_SUSPEND);
-
-		snd_soc_dapm_stream_event(rtd,
-					  SNDRV_PCM_STREAM_CAPTURE,
-					  SND_SOC_DAPM_STREAM_SUSPEND);
+		snd_soc_dapm_stream_suspend(rtd, SNDRV_PCM_STREAM_PLAYBACK);
+		snd_soc_dapm_stream_suspend(rtd, SNDRV_PCM_STREAM_CAPTURE);
 	}
 
 	/* Recheck all endpoints too, their state is affected by suspend */
@@ -637,13 +632,8 @@ static void soc_resume_deferred(struct work_struct *work)
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		snd_soc_dapm_stream_event(rtd,
-					  SNDRV_PCM_STREAM_PLAYBACK,
-					  SND_SOC_DAPM_STREAM_RESUME);
-
-		snd_soc_dapm_stream_event(rtd,
-					  SNDRV_PCM_STREAM_CAPTURE,
-					  SND_SOC_DAPM_STREAM_RESUME);
+		snd_soc_dapm_stream_resume(rtd, SNDRV_PCM_STREAM_PLAYBACK);
+		snd_soc_dapm_stream_resume(rtd, SNDRV_PCM_STREAM_CAPTURE);
 	}
 
 	/* unmute any active DACs */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7e96793050c9..7d4f75d29d55 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4201,7 +4201,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 }
 
 static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
-	int event)
+	int event, bool power_widgets)
 {
 	int i;
 
@@ -4209,7 +4209,8 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	for (i = 0; i < rtd->num_codecs; i++)
 		soc_dapm_dai_stream_event(rtd->codec_dais[i], stream, event);
 
-	dapm_power_widgets(rtd->card, event);
+	if (power_widgets)
+		dapm_power_widgets(rtd->card, event);
 }
 
 /**
@@ -4229,7 +4230,43 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	struct snd_soc_card *card = rtd->card;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	soc_dapm_stream_event(rtd, stream, event);
+	soc_dapm_stream_event(rtd, stream, event, true);
+	mutex_unlock(&card->dapm_mutex);
+}
+
+/**
+ * snd_soc_dapm_stream_suspend - send a suspend stream event to the dapm core
+ * @rtd: PCM runtime data
+ * @stream: stream name
+ *
+ * Sends a suspend stream event to the dapm core.
+ *
+ * Returns 0 for success else error.
+ */
+void snd_soc_dapm_stream_suspend(struct snd_soc_pcm_runtime *rtd, int stream)
+{
+	struct snd_soc_card *card = rtd->card;
+
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	soc_dapm_stream_event(rtd, stream, SND_SOC_DAPM_STREAM_SUSPEND, false);
+	mutex_unlock(&card->dapm_mutex);
+}
+
+/**
+ * snd_soc_dapm_stream_resume - send a resume stream event to the dapm core
+ * @rtd: PCM runtime data
+ * @stream: stream name
+ *
+ * Sends a resume stream event to the dapm core.
+ *
+ * Returns 0 for success else error.
+ */
+void snd_soc_dapm_stream_resume(struct snd_soc_pcm_runtime *rtd, int stream)
+{
+	struct snd_soc_card *card = rtd->card;
+
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	soc_dapm_stream_event(rtd, stream, SND_SOC_DAPM_STREAM_RESUME, false);
 	mutex_unlock(&card->dapm_mutex);
 }
 
-- 
2.7.4

