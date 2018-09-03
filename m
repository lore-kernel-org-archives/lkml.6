Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C382C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C229B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C229B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeICVio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:38:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeICVim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:38:42 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87E75D12;
        Mon,  3 Sep 2018 17:17:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 021/165] usb: gadget: u_audio: remove caching of stream buffer parameters
Date:   Mon,  3 Sep 2018 18:55:07 +0200
Message-Id: <20180903165656.098169851@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

[ Upstream commit 96afb54ece0ee903d23a7ac04ddc461413b972c4 ]

There is no necessity to copy PCM stream ring buffer area and size
properties to UAC private data structure, these values can be got
from substream itself.

The change gives more control on substream and avoid stale caching.

Fixes: 132fcb460839 ("usb: gadget: Add Audio Class 2.0 Driver")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_audio.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -41,9 +41,6 @@ struct uac_req {
 struct uac_rtd_params {
 	struct snd_uac_chip *uac; /* parent chip */
 	bool ep_enabled; /* if the ep is enabled */
-	/* Size of the ring buffer */
-	size_t dma_bytes;
-	unsigned char *dma_area;
 
 	struct snd_pcm_substream *ss;
 
@@ -99,6 +96,7 @@ static void u_audio_iso_complete(struct
 	int status = req->status;
 	struct uac_req *ur = req->context;
 	struct snd_pcm_substream *substream;
+	struct snd_pcm_runtime *runtime;
 	struct uac_rtd_params *prm = ur->pp;
 	struct snd_uac_chip *uac = prm->uac;
 
@@ -120,6 +118,7 @@ static void u_audio_iso_complete(struct
 	if (!substream)
 		goto exit;
 
+	runtime = substream->runtime;
 	spin_lock_irqsave(&prm->lock, flags);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -156,29 +155,31 @@ static void u_audio_iso_complete(struct
 	spin_unlock_irqrestore(&prm->lock, flags);
 
 	/* Pack USB load in ALSA ring buffer */
-	pending = prm->dma_bytes - hw_ptr;
+	pending = runtime->dma_bytes - hw_ptr;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (unlikely(pending < req->actual)) {
-			memcpy(req->buf, prm->dma_area + hw_ptr, pending);
-			memcpy(req->buf + pending, prm->dma_area,
+			memcpy(req->buf, runtime->dma_area + hw_ptr, pending);
+			memcpy(req->buf + pending, runtime->dma_area,
 			       req->actual - pending);
 		} else {
-			memcpy(req->buf, prm->dma_area + hw_ptr, req->actual);
+			memcpy(req->buf, runtime->dma_area + hw_ptr,
+			       req->actual);
 		}
 	} else {
 		if (unlikely(pending < req->actual)) {
-			memcpy(prm->dma_area + hw_ptr, req->buf, pending);
-			memcpy(prm->dma_area, req->buf + pending,
+			memcpy(runtime->dma_area + hw_ptr, req->buf, pending);
+			memcpy(runtime->dma_area, req->buf + pending,
 			       req->actual - pending);
 		} else {
-			memcpy(prm->dma_area + hw_ptr, req->buf, req->actual);
+			memcpy(runtime->dma_area + hw_ptr, req->buf,
+			       req->actual);
 		}
 	}
 
 	spin_lock_irqsave(&prm->lock, flags);
 	/* update hw_ptr after data is copied to memory */
-	prm->hw_ptr = (hw_ptr + req->actual) % prm->dma_bytes;
+	prm->hw_ptr = (hw_ptr + req->actual) % runtime->dma_bytes;
 	spin_unlock_irqrestore(&prm->lock, flags);
 
 exit:
@@ -260,11 +261,8 @@ static int uac_pcm_hw_params(struct snd_
 
 	err = snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
-	if (err >= 0) {
-		prm->dma_bytes = substream->runtime->dma_bytes;
-		prm->dma_area = substream->runtime->dma_area;
+	if (err >= 0)
 		prm->period_size = params_period_bytes(hw_params);
-	}
 
 	return err;
 }
@@ -279,8 +277,6 @@ static int uac_pcm_hw_free(struct snd_pc
 	else
 		prm = &uac->c_prm;
 
-	prm->dma_area = NULL;
-	prm->dma_bytes = 0;
 	prm->period_size = 0;
 
 	return snd_pcm_lib_free_pages(substream);


