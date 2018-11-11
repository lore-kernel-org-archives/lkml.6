Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BE120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BE120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbeKLFuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:50:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51226 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730746AbeKLFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:33 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsq-0000tu-L4; Sun, 11 Nov 2018 19:59:00 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001k6-0x; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Joshua Frkuska" <joshua_frkuska@mentor.com>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Eugeniu Rosca" <erosca@de.adit-jv.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.367979031@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 264/366] usb: gadget: u_audio: update hw_ptr in
 iso_complete after data copied
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Frkuska <joshua_frkuska@mentor.com>

commit 6b37bd78d30c890e575a1bda22978d1d2a233362 upstream.

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
[bwh: Backported to 3.16:
 - Don't use a local hw_ptr variable
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/gadget/f_uac2.c
+++ b/drivers/usb/gadget/f_uac2.c
@@ -229,12 +229,16 @@ agdev_iso_complete(struct usb_ep *ep, st
 	if (pending >= prm->period_size)
 		update_alsa = true;
 
-	prm->hw_ptr = (prm->hw_ptr + req->actual) % prm->dma_bytes;
-
 	spin_unlock_irqrestore(&prm->lock, flags);
 
 	/* Pack USB load in ALSA ring buffer */
 	memcpy(dst, src, req->actual);
+
+	spin_lock_irqsave(&prm->lock, flags);
+	/* update hw_ptr after data is copied to memory */
+	prm->hw_ptr = (prm->hw_ptr + req->actual) % prm->dma_bytes;
+	spin_unlock_irqrestore(&prm->lock, flags);
+
 exit:
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		dev_err(&uac2->pdev.dev, "%d Error!\n", __LINE__);

