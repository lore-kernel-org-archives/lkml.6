Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD4D21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD4D21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeHBQSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:18:50 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.84]:19225 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732272AbeHBQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:18:49 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id E077213B74E7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 09:18:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lEPsfUvtIbXuJlEQOfuqxM; Thu, 02 Aug 2018 09:18:16 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=44676 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1flEPs-003k7z-Be; Thu, 02 Aug 2018 09:17:24 -0500
Date:   Thu, 2 Aug 2018 09:17:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: usb-audio: Fix wrong sizeof argument
Message-ID: <20180802141723.GA7258@embeddedor.com>
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
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1flEPs-003k7z-Be
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:44676
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct argument to be passed to kzalloc is sizeof(*pd)

Addresses-Coverity-ID: 1472224 ("Wrong sizeof argument")
Fixes: 7edf3b5e6a45 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8fe3b0e..67cf849 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1037,7 +1037,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		fp->rate_max = UAC3_BADD_SAMPLING_RATE;
 		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
 
-		pd = kzalloc(sizeof(pd), GFP_KERNEL);
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
 			kfree(fp->rate_table);
 			kfree(fp);
-- 
2.7.4

