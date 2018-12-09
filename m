Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59929C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AB720661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AB720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeLIWXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:23:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35044 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbeLIVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002po-IL; Sun, 09 Dec 2018 21:55:15 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003Rv-M1; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Felipe Balbi" <balbi@ti.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.927412555@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 170/328] usb: gadget: udc: net2280: do not rely on
 'driver' argument
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

From: Felipe Balbi <balbi@ti.com>

commit bfd0ed576dbf9cc71af7dbe42841fc9246524961 upstream.

future patches will remove the extra 'driver'
argument to ->udc_stop(), in order to do that,
we must make sure that our UDC does not rely
on it first.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/net2280.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -1956,11 +1956,9 @@ static int net2280_stop(struct usb_gadge
 	dev = container_of (_gadget, struct net2280, gadget);
 
 	spin_lock_irqsave (&dev->lock, flags);
-	stop_activity (dev, driver);
+	stop_activity(dev, NULL);
 	spin_unlock_irqrestore (&dev->lock, flags);
 
-	dev->driver = NULL;
-
 	net2280_led_active (dev, 0);
 
 	/* Disable full-speed test mode */
@@ -1970,7 +1968,8 @@ static int net2280_stop(struct usb_gadge
 	device_remove_file (&dev->pdev->dev, &dev_attr_queues);
 
 	DEBUG(dev, "unregistered driver '%s'\n",
-			driver ? driver->driver.name : "");
+	      dev->driver ? dev->driver->driver.name : "");
+	dev->driver = NULL;
 
 	return 0;
 }

