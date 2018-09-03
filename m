Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA673C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9262077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9262077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbeICVjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:39:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbeICVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:39:13 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3961BD09;
        Mon,  3 Sep 2018 17:18:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 022/165] usb: gadget: u_audio: remove cached period bytes value
Date:   Mon,  3 Sep 2018 18:55:08 +0200
Message-Id: <20180903165656.142748421@linuxfoundation.org>
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

[ Upstream commit 773e53d50e227b0c03d0bb434c1636f6c49c75b2 ]

Substream period size potentially can be changed in runtime, however
this is not accounted in the data copying routine, the change replaces
the cached value with an actual value from substream runtime.

As a side effect the change also removes a potential division by zero
in u_audio_iso_complete() function, if there is a race with
uac_pcm_hw_free(), which sets prm->period_size to 0.

Fixes: 132fcb460839 ("usb: gadget: Add Audio Class 2.0 Driver")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_audio.c |   40 ++++------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -49,8 +49,6 @@ struct uac_rtd_params {
 
 	void *rbuf;
 
-	size_t period_size;
-
 	unsigned max_psize;	/* MaxPacketSize of endpoint */
 	struct uac_req *ureq;
 
@@ -92,7 +90,6 @@ static void u_audio_iso_complete(struct
 	unsigned pending;
 	unsigned long flags;
 	unsigned int hw_ptr;
-	bool update_alsa = false;
 	int status = req->status;
 	struct uac_req *ur = req->context;
 	struct snd_pcm_substream *substream;
@@ -145,11 +142,6 @@ static void u_audio_iso_complete(struct
 		req->actual = req->length;
 	}
 
-	pending = prm->hw_ptr % prm->period_size;
-	pending += req->actual;
-	if (pending >= prm->period_size)
-		update_alsa = true;
-
 	hw_ptr = prm->hw_ptr;
 
 	spin_unlock_irqrestore(&prm->lock, flags);
@@ -180,14 +172,15 @@ static void u_audio_iso_complete(struct
 	spin_lock_irqsave(&prm->lock, flags);
 	/* update hw_ptr after data is copied to memory */
 	prm->hw_ptr = (hw_ptr + req->actual) % runtime->dma_bytes;
+	hw_ptr = prm->hw_ptr;
 	spin_unlock_irqrestore(&prm->lock, flags);
 
+	if ((hw_ptr % snd_pcm_lib_period_bytes(substream)) < req->actual)
+		snd_pcm_period_elapsed(substream);
+
 exit:
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		dev_err(uac->card->dev, "%d Error!\n", __LINE__);
-
-	if (update_alsa)
-		snd_pcm_period_elapsed(substream);
 }
 
 static int uac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
@@ -250,35 +243,12 @@ static snd_pcm_uframes_t uac_pcm_pointer
 static int uac_pcm_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_uac_chip *uac = snd_pcm_substream_chip(substream);
-	struct uac_rtd_params *prm;
-	int err;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		prm = &uac->p_prm;
-	else
-		prm = &uac->c_prm;
-
-	err = snd_pcm_lib_malloc_pages(substream,
+	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
-	if (err >= 0)
-		prm->period_size = params_period_bytes(hw_params);
-
-	return err;
 }
 
 static int uac_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	struct snd_uac_chip *uac = snd_pcm_substream_chip(substream);
-	struct uac_rtd_params *prm;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		prm = &uac->p_prm;
-	else
-		prm = &uac->c_prm;
-
-	prm->period_size = 0;
-
 	return snd_pcm_lib_free_pages(substream);
 }
 


