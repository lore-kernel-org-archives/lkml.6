Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25455C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FB720868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="M5YoFu2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FB720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeICSjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:39:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54864 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeICSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QryCjMJAqafj6P5SNs4jQHYP47JVtrkRsYMYmjAo5zY=; b=M5YoFu2Suwtr
        z0Tj2kpRHxpEWPT+hzbZ8p9fX3/twkTLZ5E/Mo35pa1VcgNeby7SfOa5vI0dL2oW0e2RZAzlGKylW
        6J4PYEYcdMOxgHMZPydTC1PyGEq/hXjbtzHVdcCHQq6KbcnGkc/ZDxZj8YewGVGCsAZThk//30ERt
        budyw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwph1-0000Lc-JE; Mon, 03 Sep 2018 14:19:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5AA7811227AE; Mon,  3 Sep 2018 15:19:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: core: Don't schedule DAPM work if already in target state" to the asoc tree
In-Reply-To:  <1534520143-29266-1-git-send-email-jonathanh@nvidia.com>
Message-Id: <20180903141903.5AA7811227AE@debutante.sirena.org.uk>
Date:   Mon,  3 Sep 2018 15:19:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: Don't schedule DAPM work if already in target state

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

From e03546ddd3db5352a74dec247dbdaa29889e93f7 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Fri, 17 Aug 2018 16:35:43 +0100
Subject: [PATCH] ASoC: core: Don't schedule DAPM work if already in target
 state

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
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d7be3981f026..9feccd2e7c11 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1952,7 +1952,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 	dapm_pre_sequence_async(&card->dapm, 0);
 	/* Run other bias changes in parallel */
 	list_for_each_entry(d, &card->dapm_list, list) {
-		if (d != &card->dapm)
+		if (d != &card->dapm && d->bias_level != d->target_bias_level)
 			async_schedule_domain(dapm_pre_sequence_async, d,
 						&async_domain);
 	}
@@ -1976,7 +1976,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 
 	/* Run all the bias changes in parallel */
 	list_for_each_entry(d, &card->dapm_list, list) {
-		if (d != &card->dapm)
+		if (d != &card->dapm && d->bias_level != d->target_bias_level)
 			async_schedule_domain(dapm_post_sequence_async, d,
 						&async_domain);
 	}
-- 
2.19.0.rc1

