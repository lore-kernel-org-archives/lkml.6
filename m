Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75A121486
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ya8+j0HT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75A121486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeJEXNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:13:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F233020834;
        Fri,  5 Oct 2018 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756067;
        bh=A5qQqjHMfEx5aGAnDCa9HRTzrR0MlDCiwRKwSdt4SEA=;
        h=From:To:Cc:Subject:Date:From;
        b=ya8+j0HTViD8rX5/lV0o8moxpIosrK4ZjAimL6Osi/24c9winnISFwoRRIp0zBoIl
         CYGuFXAeePqdnwz6bCzIMHMXXD2AQ7SJ6D8aAW0tN1sueAh6/VklUOxFu2fvN58CGZ
         BhKZrhSk4xLuGC58fXNOgQFzmUbzRRl4yrdEUtjU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 01/48] ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs
Date:   Fri,  5 Oct 2018 12:13:37 -0400
Message-Id: <20181005161424.20521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 249dc49576fc953a7378b916c6a6d47ea81e4da2 ]

Commit a655de808cbde ("ASoC: core: Allow topology to override
machine driver FE DAI link config.") caused soc_dai_hw_params to
be come dependent on the substream private_data being set with
a pointer to the snd_soc_pcm_runtime. Currently, CODEC to CODEC
links don't set this, which causes a NULL pointer dereference:

[<4069de54>] (soc_dai_hw_params) from
[<40694b68>] (snd_soc_dai_link_event+0x1a0/0x380)

Since the ASoC core in general assumes that the substream
private_data will be set to a pointer to the snd_soc_pcm_runtime,
update the CODEC to CODEC links to respect this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/sound/soc-dapm.h | 1 +
 sound/soc/soc-core.c     | 4 ++--
 sound/soc/soc-dapm.c     | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a6ce2de4e20a..be3bee1cf91f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -410,6 +410,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 struct snd_soc_pcm_runtime *rtd,
 			 const struct snd_soc_pcm_stream *params,
 			 unsigned int num_params,
 			 struct snd_soc_dapm_widget *source,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4663de3cf495..0b4896d411f9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1430,7 +1430,7 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	sink = codec_dai->playback_widget;
 	source = cpu_dai->capture_widget;
 	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
 					   dai_link->num_params,
 					   source, sink);
 		if (ret != 0) {
@@ -1443,7 +1443,7 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	sink = cpu_dai->playback_widget;
 	source = codec_dai->capture_widget;
 	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
 					   dai_link->num_params,
 					   source, sink);
 		if (ret != 0) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a099c3e45504..577f6178af57 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3658,6 +3658,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_dapm_path *source_p, *sink_p;
 	struct snd_soc_dai *source, *sink;
+	struct snd_soc_pcm_runtime *rtd = w->priv;
 	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
 	struct snd_pcm_substream substream;
 	struct snd_pcm_hw_params *params = NULL;
@@ -3717,6 +3718,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		goto out;
 	}
 	substream.runtime = runtime;
+	substream.private_data = rtd;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3901,6 +3903,7 @@ snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
 }
 
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 struct snd_soc_pcm_runtime *rtd,
 			 const struct snd_soc_pcm_stream *params,
 			 unsigned int num_params,
 			 struct snd_soc_dapm_widget *source,
@@ -3969,6 +3972,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 
 	w->params = params;
 	w->num_params = num_params;
+	w->priv = rtd;
 
 	ret = snd_soc_dapm_add_path(&card->dapm, source, w, NULL, NULL);
 	if (ret)
-- 
2.17.1

