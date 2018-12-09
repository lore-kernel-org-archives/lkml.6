Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40569C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E1220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E1220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeLIWXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:23:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35074 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbeLIVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002il-Rm; Sun, 09 Dec 2018 21:55:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003S0-NB; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Felipe Balbi" <balbi@ti.com>,
        "Mian Yousaf Kaukab" <yousaf.kaukab@intel.com>,
        "Ricardo Ribalda Delgado" <ricardo.ribalda@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.233106953@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 171/328] usb: gadget: net2280: fix pullup handling
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

From: Mian Yousaf Kaukab <yousaf.kaukab@intel.com>

commit 11bece5e063ca567e631c6ea3b1611c10dbc3282 upstream.

Gadget must be informed about disconnection when pullup is removed.

Tested-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -139,6 +139,10 @@ static char *type_string (u8 bmAttribute
 #define valid_bit	cpu_to_le32 (1 << VALID_BIT)
 #define dma_done_ie	cpu_to_le32 (1 << DMA_DONE_INTERRUPT_ENABLE)
 
+static void stop_activity(struct net2280 *dev,
+					struct usb_gadget_driver *driver);
+static void ep0_start(struct net2280 *dev);
+
 /*-------------------------------------------------------------------------*/
 
 static int
@@ -1390,11 +1394,14 @@ static int net2280_pullup(struct usb_gad
 	spin_lock_irqsave (&dev->lock, flags);
 	tmp = readl (&dev->usb->usbctl);
 	dev->softconnect = (is_on != 0);
-	if (is_on)
-		tmp |= (1 << USB_DETECT_ENABLE);
-	else
-		tmp &= ~(1 << USB_DETECT_ENABLE);
-	writel (tmp, &dev->usb->usbctl);
+	if (is_on) {
+		ep0_start(dev);
+		writel(tmp | BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
+	} else {
+		writel(tmp & ~BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
+		stop_activity(dev, dev->driver);
+	}
+
 	spin_unlock_irqrestore (&dev->lock, flags);
 
 	return 0;

