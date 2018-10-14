Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2272BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5520835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F5520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeJNXNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36395 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728258AbeJNXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cZ-Aa; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000SS-GG; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.177812110@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 219/366] ALSA: hdspm: Hardening for potential Spectre v1
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 10513142a7114d251670361ad40cba2c61403406 upstream.

As recently Smatch suggested, a couple of places in HDSP MADI driver
may expand the array directly from the user-space value with
speculation:
  sound/pci/rme9652/hdspm.c:5717 snd_hdspm_channel_info() warn: potential spectre issue 'hdspm->channel_map_out' (local cap)
  sound/pci/rme9652/hdspm.c:5734 snd_hdspm_channel_info() warn: potential spectre issue 'hdspm->channel_map_in' (local cap)

This patch puts array_index_nospec() for hardening against them.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/rme9652/hdspm.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -137,6 +137,7 @@
 #include <linux/pci.h>
 #include <linux/math64.h>
 #include <asm/io.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -5724,40 +5725,43 @@ static int snd_hdspm_channel_info(struct
 		struct snd_pcm_channel_info *info)
 {
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
+	unsigned int channel = info->channel;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (snd_BUG_ON(info->channel >= hdspm->max_channels_out)) {
+		if (snd_BUG_ON(channel >= hdspm->max_channels_out)) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: output channel out of range (%d)\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		if (hdspm->channel_map_out[info->channel] < 0) {
+		channel = array_index_nospec(channel, hdspm->max_channels_out);
+		if (hdspm->channel_map_out[channel] < 0) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: output channel %d mapped out\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		info->offset = hdspm->channel_map_out[info->channel] *
+		info->offset = hdspm->channel_map_out[channel] *
 			HDSPM_CHANNEL_BUFFER_BYTES;
 	} else {
-		if (snd_BUG_ON(info->channel >= hdspm->max_channels_in)) {
+		if (snd_BUG_ON(channel >= hdspm->max_channels_in)) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: input channel out of range (%d)\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		if (hdspm->channel_map_in[info->channel] < 0) {
+		channel = array_index_nospec(channel, hdspm->max_channels_in);
+		if (hdspm->channel_map_in[channel] < 0) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: input channel %d mapped out\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
 
-		info->offset = hdspm->channel_map_in[info->channel] *
+		info->offset = hdspm->channel_map_in[channel] *
 			HDSPM_CHANNEL_BUFFER_BYTES;
 	}
 

