Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178D32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOX2irIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178D32089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeJQBE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbeJQBEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:25 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16D421476;
        Tue, 16 Oct 2018 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709982;
        bh=t978E6s2SRxQj6wJozsEtKa7Qjnr+8U4Mff5pv35i9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOX2irIuH0yfafT5VQbgo8nwXL3L7TMH5SJJAeriemEkYuuv1YmV5s60Yga7GvIyI
         0gHpdrgWKr6LSyXrZ8YYLiTjctC5FIr8s/xqR/KgylUoIeOGmMIL7r/jAWWEYTrt7Q
         jftYPjNqM4K59w8iLXeH2LrMHH4SvOY25l6JKlmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 063/135] ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs
Date:   Tue, 16 Oct 2018 19:04:53 +0200
Message-Id: <20181016170518.857570207@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-core.c     |    4 ++--
 sound/soc/soc-dapm.c     |    4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -410,6 +410,7 @@ int snd_soc_dapm_new_dai_widgets(struct
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 struct snd_soc_pcm_runtime *rtd,
 			 const struct snd_soc_pcm_stream *params,
 			 unsigned int num_params,
 			 struct snd_soc_dapm_widget *source,
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1430,7 +1430,7 @@ static int soc_link_dai_widgets(struct s
 	sink = codec_dai->playback_widget;
 	source = cpu_dai->capture_widget;
 	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
 					   dai_link->num_params,
 					   source, sink);
 		if (ret != 0) {
@@ -1443,7 +1443,7 @@ static int soc_link_dai_widgets(struct s
 	sink = cpu_dai->playback_widget;
 	source = codec_dai->capture_widget;
 	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
 					   dai_link->num_params,
 					   source, sink);
 		if (ret != 0) {
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3658,6 +3658,7 @@ static int snd_soc_dai_link_event(struct
 {
 	struct snd_soc_dapm_path *source_p, *sink_p;
 	struct snd_soc_dai *source, *sink;
+	struct snd_soc_pcm_runtime *rtd = w->priv;
 	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
 	struct snd_pcm_substream substream;
 	struct snd_pcm_hw_params *params = NULL;
@@ -3717,6 +3718,7 @@ static int snd_soc_dai_link_event(struct
 		goto out;
 	}
 	substream.runtime = runtime;
+	substream.private_data = rtd;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3901,6 +3903,7 @@ outfree_w_param:
 }
 
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 struct snd_soc_pcm_runtime *rtd,
 			 const struct snd_soc_pcm_stream *params,
 			 unsigned int num_params,
 			 struct snd_soc_dapm_widget *source,
@@ -3969,6 +3972,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_
 
 	w->params = params;
 	w->num_params = num_params;
+	w->priv = rtd;
 
 	ret = snd_soc_dapm_add_path(&card->dapm, source, w, NULL, NULL);
 	if (ret)


