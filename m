Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA847C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95F920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95F920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeLIWX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:23:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35092 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbeLIVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:19 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002io-Rq; Sun, 09 Dec 2018 21:55:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003S5-Og; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "D. Ziesche" <dziesche@zes.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.635235091@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 172/328] USB: net2280: Fix erroneous synchronization
 change
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.16:
 - Drop inapplicable change to disconnection handling in handle_stat1_irqs()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -1399,11 +1399,14 @@ static int net2280_pullup(struct usb_gad
 		writel(tmp | BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
 	} else {
 		writel(tmp & ~BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
-		stop_activity(dev, dev->driver);
+		stop_activity(dev, NULL);
 	}
 
 	spin_unlock_irqrestore (&dev->lock, flags);
 
+	if (!is_on && dev->driver)
+		dev->driver->disconnect(&dev->gadget);
+
 	return 0;
 }
 
@@ -1948,8 +1951,11 @@ stop_activity (struct net2280 *dev, stru
 		nuke (&dev->ep [i]);
 
 	/* report disconnect; the driver is already quiesced */
-	if (driver)
+	if (driver) {
+		spin_unlock(&dev->lock);
 		driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+	}
 
 	usb_reinit (dev);
 }
@@ -2452,6 +2458,8 @@ next_endpoints:
 		| (1 << PCI_RETRY_ABORT_INTERRUPT))
 
 static void handle_stat1_irqs (struct net2280 *dev, u32 stat)
+__releases(dev->lock)
+__acquires(dev->lock)
 {
 	struct net2280_ep	*ep;
 	u32			tmp, num, mask, scratch;
@@ -2494,6 +2502,7 @@ static void handle_stat1_irqs (struct ne
 	tmp = (1 << SUSPEND_REQUEST_CHANGE_INTERRUPT);
 	if (stat & tmp) {
 		writel (tmp, &dev->regs->irqstat1);
+		spin_unlock(&dev->lock);
 		if (stat & (1 << SUSPEND_REQUEST_INTERRUPT)) {
 			if (dev->driver->suspend)
 				dev->driver->suspend (&dev->gadget);
@@ -2504,6 +2513,7 @@ static void handle_stat1_irqs (struct ne
 				dev->driver->resume (&dev->gadget);
 			/* at high speed, note erratum 0133 */
 		}
+		spin_lock(&dev->lock);
 		stat &= ~tmp;
 	}
 

