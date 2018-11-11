Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CD6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D6B2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D6B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeKLGFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53016 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbeKLGFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:00 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000l5-OC; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001TN-9U; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.945098252@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 085/366] usb: gadget: function: printer: avoid
 spinlock recursion
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 9ada8c582088d32bd5c071c17213bc6edf37443a upstream.

If usb_gadget_giveback_request() is called in usb_ep_queue(),
this printer_write() is possible to cause spinlock recursion. So,
this patch adds spin_unlock() before calls usb_ep_queue() to avoid it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/printer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/printer.c
+++ b/drivers/usb/gadget/printer.c
@@ -587,6 +587,7 @@ printer_write(struct file *fd, const cha
 	size_t			size;	/* Amount of data in a TX request. */
 	size_t			bytes_copied = 0;
 	struct usb_request	*req;
+	int			value;
 
 	DBG(dev, "printer_write trying to send %d bytes\n", (int)len);
 
@@ -666,7 +667,11 @@ printer_write(struct file *fd, const cha
 			return -EAGAIN;
 		}
 
-		if (usb_ep_queue(dev->in_ep, req, GFP_ATOMIC)) {
+		/* here, we unlock, and only unlock, to avoid deadlock. */
+		spin_unlock(&dev->lock);
+		value = usb_ep_queue(dev->in_ep, req, GFP_ATOMIC);
+		spin_lock(&dev->lock);
+		if (value) {
 			list_add(&req->list, &dev->tx_reqs);
 			spin_unlock_irqrestore(&dev->lock, flags);
 			mutex_unlock(&dev->lock_printer_io);

