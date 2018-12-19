Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A26C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE8E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeLSXbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:31:46 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.206]:30506 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727703AbeLSXbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:31:46 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 09C725D45
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 17:31:45 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZlJZgt2lLiQerZlJZgyV15; Wed, 19 Dec 2018 17:31:45 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=35388 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZlJY-000lVx-C7; Wed, 19 Dec 2018 17:31:44 -0600
Date:   Wed, 19 Dec 2018 17:31:43 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1 vulnerabilities
Message-ID: <20181219233143.GA14518@embeddedor>
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
X-Exim-ID: 1gZlJY-000lVx-C7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:35388
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

header->number is indirectly controlled by user-space, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/isa/wavefront/wavefront_synth.c:792 wavefront_send_patch() warn: potential spectre issue 'dev->patch_status' [w] (local cap)
sound/isa/wavefront/wavefront_synth.c:819 wavefront_send_program() warn: potential spectre issue 'dev->prog_status' [w] (local cap)
sound/isa/wavefront/wavefront_synth.c:1197 wavefront_send_alias() warn: potential spectre issue 'dev->sample_status' [w]
sound/isa/wavefront/wavefront_synth.c:1248 wavefront_send_multisample() warn: potential spectre issue 'dev->sample_status' [w]
sound/isa/wavefront/wavefront_synth.c:1548 wavefront_synth_control() warn: potential spectre issue 'dev->sample_status' [r] (local cap)

Fix this by sanitizing header->number before using it to index
dev->patch_status, dev->prog_status and dev->sample_status.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/wavefront/wavefront_synth.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 0b1e4b34b299..80196a533a36 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -31,6 +31,7 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <sound/core.h>
 #include <sound/snd_wavefront.h>
 #include <sound/initval.h>
@@ -788,7 +789,8 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	if (header->number >= ARRAY_SIZE(dev->patch_status))
 		return -EINVAL;
-
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->patch_status));
 	dev->patch_status[header->number] |= WF_SLOT_FILLED;
 
 	bptr = buf;
@@ -815,7 +817,8 @@ wavefront_send_program (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	if (header->number >= ARRAY_SIZE(dev->prog_status))
 		return -EINVAL;
-
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->prog_status));
 	dev->prog_status[header->number] = WF_SLOT_USED;
 
 	/* XXX need to zero existing SLOT_USED bit for program_status[i]
@@ -1194,6 +1197,10 @@ wavefront_send_alias (snd_wavefront_t *dev, wavefront_patch_info *header)
 		return -EIO;
 	}
 
+	if (header->number >= ARRAY_SIZE(dev->sample_status))
+		return -EINVAL;
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->sample_status));
 	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_ALIAS);
 
 	return (0);
@@ -1245,6 +1252,10 @@ wavefront_send_multisample (snd_wavefront_t *dev, wavefront_patch_info *header)
 		return -EIO;
 	}
 
+	if (header->number >= ARRAY_SIZE(dev->sample_status))
+		return -EINVAL;
+	header->number = array_index_nospec(header->number,
+					    ARRAY_SIZE(dev->sample_status));
 	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_MULTISAMPLE);
 
 	kfree(msample_hdr);
@@ -1539,12 +1550,13 @@ wavefront_synth_control (snd_wavefront_card_t *acard,
 
 	case WFC_IDENTIFY_SLOT_TYPE:
 		i = wc->wbuf[0] | (wc->wbuf[1] << 7);
-		if (i <0 || i >= WF_MAX_SAMPLE) {
+		if (i < 0 || i >= WF_MAX_SAMPLE) {
 			snd_printk ("invalid slot ID %d\n",
 				i);
 			wc->status = EINVAL;
 			return -EINVAL;
 		}
+		i = array_index_nospec(i, WF_MAX_SAMPLE);
 		wc->rbuf[0] = dev->sample_status[i];
 		wc->status = 0;
 		return 0;
-- 
2.20.1

