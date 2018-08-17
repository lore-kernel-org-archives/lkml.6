Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D853AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951B12188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951B12188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHQSj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:39:56 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19105 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQSjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:39:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b76eb500001>; Fri, 17 Aug 2018 08:35:44 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Aug 2018 08:36:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 Aug 2018 08:36:06 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 17 Aug
 2018 15:36:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 17 Aug 2018 15:36:05 +0000
Received: from moonraker.nvidia.com (Not Verified[10.2.171.150]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b76eb640001>; Fri, 17 Aug 2018 08:36:05 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ASoC: core: Don't schedule DAPM work if already in target state
Date:   Fri, 17 Aug 2018 16:35:43 +0100
Message-ID: <1534520143-29266-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dapm_power_widgets() is called, the dapm_pre_sequence_async() and
dapm_post_sequence_async() functions are scheduled for all DAPM contexts
(apart from the card DAPM context) regardless of whether the DAPM
context is already in the desired state. The overhead of this is not
insignificant and the more DAPM contexts there are the more overhead
there is.

For example, on the Tegra124 Jetson TK1, when profiling the time taken
to execute the dapm_power_widgets() the following times were observed.

  Times for function dapm_power_widgets() are (us):
     Min 23, Ave 190, Max 434, Count 39

Here 'Count' is the number of times that dapm_power_widgets() has been
called. Please note that the above time were measured using ktime_get()
to log the time on entry and exit from dapm_power_widgets(). So it
should be noted that these times may not be purely the time take to
execute this function if it is preempted. However, after applying this
patch and measuring the time taken to execute dapm_power_widgets() again
a significant improvement is seen as shown below.

  Times for function dapm_power_widgets() are (us):
     Min 4, Ave 16, Max 82, Count 39

Therefore, optimise the dapm_power_widgets() function by only scheduling
the dapm_pre/post_sequence_async() work if the DAPM context is not in
the desired state.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 461d951917c0..2e9231aeabb9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1953,7 +1953,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 	dapm_pre_sequence_async(&card->dapm, 0);
 	/* Run other bias changes in parallel */
 	list_for_each_entry(d, &card->dapm_list, list) {
-		if (d != &card->dapm)
+		if (d != &card->dapm && d->bias_level != d->target_bias_level)
 			async_schedule_domain(dapm_pre_sequence_async, d,
 						&async_domain);
 	}
@@ -1977,7 +1977,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 
 	/* Run all the bias changes in parallel */
 	list_for_each_entry(d, &card->dapm_list, list) {
-		if (d != &card->dapm)
+		if (d != &card->dapm && d->bias_level != d->target_bias_level)
 			async_schedule_domain(dapm_post_sequence_async, d,
 						&async_domain);
 	}
-- 
2.7.4

