Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D21FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1671B218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeLRRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:18:38 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.214]:31664 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbeLRRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:18:37 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 7B2B87BF6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:18:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZJ0ugrUX34FKpZJ0ugN4bc; Tue, 18 Dec 2018 11:18:36 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=59076 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZJ0t-001lnJ-7S; Tue, 18 Dec 2018 11:18:35 -0600
Date:   Tue, 18 Dec 2018 11:18:34 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: rme9652: Fix potential Spectre v1 vulnerability
Message-ID: <20181218171834.GA14211@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZJ0t-001lnJ-7S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:59076
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

info->channel is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/pci/rme9652/hdsp.c:4100 snd_hdsp_channel_info() warn: potential spectre issue 'hdsp->channel_map' [r] (local cap)

Fix this by sanitizing info->channel before using it to index hdsp->channel_map

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

Also, notice that I refactored the code a bit in order to get rid of the
following checkpatch warning:

ERROR: do not use assignment in if condition
FILE: sound/pci/rme9652/hdsp.c:4103:
	if ((mapped_channel = hdsp->channel_map[info->channel]) < 0)


[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/rme9652/hdsp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 1bff4b1b39cd..ba99ff0e93e0 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -30,6 +30,7 @@
 #include <linux/math64.h>
 #include <linux/vmalloc.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -4092,15 +4093,16 @@ static int snd_hdsp_channel_info(struct snd_pcm_substream *substream,
 				    struct snd_pcm_channel_info *info)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	int mapped_channel;
+	unsigned int channel = info->channel;
 
-	if (snd_BUG_ON(info->channel >= hdsp->max_channels))
+	if (snd_BUG_ON(channel >= hdsp->max_channels))
 		return -EINVAL;
+	channel = array_index_nospec(channel, hdsp->max_channels);
 
-	if ((mapped_channel = hdsp->channel_map[info->channel]) < 0)
+	if (hdsp->channel_map[channel] < 0)
 		return -EINVAL;
 
-	info->offset = mapped_channel * HDSP_CHANNEL_BUFFER_BYTES;
+	info->offset = hdsp->channel_map[channel] * HDSP_CHANNEL_BUFFER_BYTES;
 	info->first = 0;
 	info->step = 32;
 	return 0;
-- 
2.19.2

