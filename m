Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UwuNItlSGVu9GQAAmS7hNA
	; Thu, 07 Jun 2018 15:45:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 047DE607E7; Thu,  7 Jun 2018 15:45:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 362CD601B4;
	Thu,  7 Jun 2018 15:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 362CD601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934803AbeFGPo7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:44:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40557 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934505AbeFGOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:37 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbT-0005Zv-Kr; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003Br-Oj; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Danilo Krummrich" <danilokrummrich@dk-develop.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.636131999@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 327/410] usb: quirks: add control message delay for
 1b1c:1b20
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <danilokrummrich@dk-develop.de>

commit cb88a0588717ba6c756cb5972d75766b273a6817 upstream.

Corsair Strafe RGB keyboard does not respond to usb control messages
sometimes and hence generates timeouts.

Commit de3af5bf259d ("usb: quirks: add delay init quirk for Corsair
Strafe RGB keyboard") tried to fix those timeouts by adding
USB_QUIRK_DELAY_INIT.

Unfortunately, even with this quirk timeouts of usb_control_msg()
can still be seen, but with a lower frequency (approx. 1 out of 15):

[   29.103520] usb 1-8: string descriptor 0 read error: -110
[   34.363097] usb 1-8: can't set config #1, error -110

Adding further delays to different locations where usb control
messages are issued just moves the timeouts to other locations,
e.g.:

[   35.400533] usbhid 1-8:1.0: can't add hid device: -110
[   35.401014] usbhid: probe of 1-8:1.0 failed with error -110

The only way to reliably avoid those issues is having a pause after
each usb control message. In approx. 200 boot cycles no more timeouts
were seen.

Addionaly, keep USB_QUIRK_DELAY_INIT as it turned out to be necessary
to have the delay in hub_port_connect() after hub_port_init().

The overall boot time seems not to be influenced by these additional
delays, even on fast machines and lightweight distributions.

Fixes: de3af5bf259d ("usb: quirks: add delay init quirk for Corsair Strafe RGB keyboard")
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/message.c | 4 ++++
 drivers/usb/core/quirks.c  | 3 ++-
 include/linux/usb/quirks.h | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -147,6 +147,10 @@ int usb_control_msg(struct usb_device *d
 
 	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
 
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
+
 	kfree(dr);
 
 	return ret;
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -226,7 +226,8 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* Corsair Strafe RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -56,4 +56,7 @@
  */
 #define USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL	BIT(11)
 
+/* Device needs a pause after every control message. */
+#define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
+
 #endif /* __LINUX_USB_QUIRKS_H */
