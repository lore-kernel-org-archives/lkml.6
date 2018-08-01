Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DD8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0429B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0429B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbeHATs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:48:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405850AbeHATIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17947117E;
        Wed,  1 Aug 2018 17:06:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 254/336] ASoC: compress: Only call free for components which have been opened
Date:   Wed,  1 Aug 2018 18:49:49 +0200
Message-Id: <20180801165038.779824740@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 572e6c8dd174bc6fc7ba5d9b6935e9ec8d2660f5 ]

The core should only call free on a component if said component has
already had open called on it. This is not presently the case and most
compressed drivers in the kernel assume it will be. This causes null
pointer dereferences in the drivers as they attempt clean up for stuff
that was never put in place.

This is fixed by aborting calling open callbacks once a failure is
encountered and then during clean up only iterating through the
component list to that point.

This is a fairly quick fix to the issue, to allow backporting. There
is more refactoring to follow to tidy the code up a little.

Fixes: 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-compress.c |   52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -33,7 +33,7 @@ static int soc_compr_open(struct snd_com
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -68,16 +68,15 @@ static int soc_compr_open(struct snd_com
 		    !component->driver->compr_ops->open)
 			continue;
 
-		__ret = component->driver->compr_ops->open(cstream);
-		if (__ret < 0) {
+		ret = component->driver->compr_ops->open(cstream);
+		if (ret < 0) {
 			dev_err(component->dev,
 				"Compress ASoC: can't open platform %s: %d\n",
-				component->name, __ret);
-			ret = __ret;
+				component->name, ret);
+			goto machine_err;
 		}
 	}
-	if (ret < 0)
-		goto machine_err;
+	component = NULL;
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->startup) {
 		ret = rtd->dai_link->compr_ops->startup(cstream);
@@ -97,17 +96,20 @@ static int soc_compr_open(struct snd_com
 
 machine_err:
 	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
+		struct snd_soc_component *err_comp = rtdcom->component;
+
+		if (err_comp == component)
+			break;
 
 		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
+		if (platform && (err_comp == &platform->component))
 			continue;
 
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
+		if (!err_comp->driver->compr_ops ||
+		    !err_comp->driver->compr_ops->free)
 			continue;
 
-		component->driver->compr_ops->free(cstream);
+		err_comp->driver->compr_ops->free(cstream);
 	}
 
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
@@ -132,7 +134,7 @@ static int soc_compr_open_fe(struct snd_
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list;
 	int stream;
-	int ret = 0, __ret;
+	int ret;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -172,16 +174,15 @@ static int soc_compr_open_fe(struct snd_
 		    !component->driver->compr_ops->open)
 			continue;
 
-		__ret = component->driver->compr_ops->open(cstream);
-		if (__ret < 0) {
+		ret = component->driver->compr_ops->open(cstream);
+		if (ret < 0) {
 			dev_err(component->dev,
 				"Compress ASoC: can't open platform %s: %d\n",
-				component->name, __ret);
-			ret = __ret;
+				component->name, ret);
+			goto machine_err;
 		}
 	}
-	if (ret < 0)
-		goto machine_err;
+	component = NULL;
 
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->startup) {
 		ret = fe->dai_link->compr_ops->startup(cstream);
@@ -236,17 +237,20 @@ fe_err:
 		fe->dai_link->compr_ops->shutdown(cstream);
 machine_err:
 	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
+		struct snd_soc_component *err_comp = rtdcom->component;
+
+		if (err_comp == component)
+			break;
 
 		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
+		if (platform && (err_comp == &platform->component))
 			continue;
 
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
+		if (!err_comp->driver->compr_ops ||
+		    !err_comp->driver->compr_ops->free)
 			continue;
 
-		component->driver->compr_ops->free(cstream);
+		err_comp->driver->compr_ops->free(cstream);
 	}
 
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)


