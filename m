Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0A72176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0A72176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeHCPjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:39:17 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.214]:21274 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729367AbeHCPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:39:17 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 97407118885C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 08:42:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id laLOfQKvibXuJlaLkfq68V; Fri, 03 Aug 2018 08:42:51 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=49916 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1flaLN-001l1F-Hz; Fri, 03 Aug 2018 08:42:13 -0500
Date:   Fri, 3 Aug 2018 08:42:11 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Rohit kumar <rohitkr@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: smd845: fix memory leak
Message-ID: <20180803134211.GA24593@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1flaLN-001l1F-Hz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:49916
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for *card* were allocated, release them before
return.

Addresses-Coverity-ID: 1472244 ("Resource leak")
Fixes: 6b1687bf76ef ("ASoC: qcom: add sdm845 sound card support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
NOTE: Notice that there are many places in which the return values of
      functions snd_soc_dai_set_sysclk() and snd_soc_dai_set_fmt() are
      not being checked. I wonder if this is intentional. Otherwise, I
      can send a patch for that. Please, confirm. Thanks!

 sound/soc/qcom/sdm845.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index be0cb11..c1adb77 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -222,8 +222,10 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 
 	/* Allocate the private data */
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto data_alloc_fail;
+	}
 
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
@@ -248,6 +250,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	kfree(card->dai_link);
 parse_dt_fail:
 	kfree(data);
+data_alloc_fail:
 	kfree(card);
 	return ret;
 }
-- 
2.7.4

