Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F655C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546F520877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546F520877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeIXSGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:06:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeIXSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:06:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8B9E107A;
        Mon, 24 Sep 2018 12:04:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        "D. Ziesche" <dziesche@zes.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 062/111] USB: net2280: Fix erroneous synchronization change
Date:   Mon, 24 Sep 2018 13:52:29 +0200
Message-Id: <20180924113111.027987607@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit dec3c23c9aa1815f07d98ae0375b4cbc10971e13 upstream.

Commit f16443a034c7 ("USB: gadgetfs, dummy-hcd, net2280: fix locking
for callbacks") was based on a serious misunderstanding.  It
introduced regressions into both the dummy-hcd and net2280 drivers.

The problem in dummy-hcd was fixed by commit 7dbd8f4cabd9 ("USB:
dummy-hcd: Fix erroneous synchronization change"), but the problem in
net2280 remains.  Namely: the ->disconnect(), ->suspend(), ->resume(),
and ->reset() callbacks must be invoked without the private lock held;
otherwise a deadlock will occur when the callback routine tries to
interact with the UDC driver.

This patch largely is a reversion of the relevant parts of
f16443a034c7.  It also drops the private lock around the calls to
->suspend() and ->resume() (something the earlier patch forgot to do).
This is safe from races with device interrupts because it occurs
within the interrupt handler.

Finally, the patch changes where the ->disconnect() callback is
invoked when net2280_pullup() turns the pullup off.  Rather than
making the callback from within stop_activity() at a time when dropping
the private lock could be unsafe, the callback is moved to a point
after the lock has already been dropped.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: f16443a034c7 ("USB: gadgetfs, dummy-hcd, net2280: fix locking for callbacks")
Reported-by: D. Ziesche <dziesche@zes.com>
Tested-by: D. Ziesche <dziesche@zes.com>
CC: <stable@vger.kernel.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/net2280.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -1549,11 +1549,14 @@ static int net2280_pullup(struct usb_gad
 		writel(tmp | BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
 	} else {
 		writel(tmp & ~BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
-		stop_activity(dev, dev->driver);
+		stop_activity(dev, NULL);
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
+	if (!is_on && dev->driver)
+		dev->driver->disconnect(&dev->gadget);
+
 	return 0;
 }
 
@@ -2470,8 +2473,11 @@ static void stop_activity(struct net2280
 		nuke(&dev->ep[i]);
 
 	/* report disconnect; the driver is already quiesced */
-	if (driver)
+	if (driver) {
+		spin_unlock(&dev->lock);
 		driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+	}
 
 	usb_reinit(dev);
 }
@@ -3345,6 +3351,8 @@ next_endpoints:
 		BIT(PCI_RETRY_ABORT_INTERRUPT))
 
 static void handle_stat1_irqs(struct net2280 *dev, u32 stat)
+__releases(dev->lock)
+__acquires(dev->lock)
 {
 	struct net2280_ep	*ep;
 	u32			tmp, num, mask, scratch;
@@ -3385,12 +3393,14 @@ static void handle_stat1_irqs(struct net
 			if (disconnect || reset) {
 				stop_activity(dev, dev->driver);
 				ep0_start(dev);
+				spin_unlock(&dev->lock);
 				if (reset)
 					usb_gadget_udc_reset
 						(&dev->gadget, dev->driver);
 				else
 					(dev->driver->disconnect)
 						(&dev->gadget);
+				spin_lock(&dev->lock);
 				return;
 			}
 		}
@@ -3409,6 +3419,7 @@ static void handle_stat1_irqs(struct net
 	tmp = BIT(SUSPEND_REQUEST_CHANGE_INTERRUPT);
 	if (stat & tmp) {
 		writel(tmp, &dev->regs->irqstat1);
+		spin_unlock(&dev->lock);
 		if (stat & BIT(SUSPEND_REQUEST_INTERRUPT)) {
 			if (dev->driver->suspend)
 				dev->driver->suspend(&dev->gadget);
@@ -3419,6 +3430,7 @@ static void handle_stat1_irqs(struct net
 				dev->driver->resume(&dev->gadget);
 			/* at high speed, note erratum 0133 */
 		}
+		spin_lock(&dev->lock);
 		stat &= ~tmp;
 	}
 


