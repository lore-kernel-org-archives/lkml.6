Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D737C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ED22077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ED22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbeICViG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:38:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeICViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:38:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 23463D09;
        Mon,  3 Sep 2018 17:17:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 020/165] usb: gadget: u_audio: update hw_ptr in iso_complete after data copied
Date:   Mon,  3 Sep 2018 18:55:06 +0200
Message-Id: <20180903165656.049523890@linuxfoundation.org>
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

From: Joshua Frkuska <joshua_frkuska@mentor.com>

[ Upstream commit 6b37bd78d30c890e575a1bda22978d1d2a233362 ]

In u_audio_iso_complete, the runtime hw_ptr is updated before the
data is actually copied over to/from the buffer/dma area. When
ALSA uses this hw_ptr, the data may not actually be available to
be used. This causes trash/stale audio to play/record. This
patch updates the hw_ptr after the data has been copied to avoid
this.

Fixes: 132fcb460839 ("usb: gadget: Add Audio Class 2.0 Driver")
Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_audio.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -152,7 +152,6 @@ static void u_audio_iso_complete(struct
 		update_alsa = true;
 
 	hw_ptr = prm->hw_ptr;
-	prm->hw_ptr = (prm->hw_ptr + req->actual) % prm->dma_bytes;
 
 	spin_unlock_irqrestore(&prm->lock, flags);
 
@@ -177,6 +176,11 @@ static void u_audio_iso_complete(struct
 		}
 	}
 
+	spin_lock_irqsave(&prm->lock, flags);
+	/* update hw_ptr after data is copied to memory */
+	prm->hw_ptr = (hw_ptr + req->actual) % prm->dma_bytes;
+	spin_unlock_irqrestore(&prm->lock, flags);
+
 exit:
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		dev_err(uac->card->dev, "%d Error!\n", __LINE__);


