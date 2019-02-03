Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D900CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB402177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfBCOXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:23:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55892 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbfBCOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:39 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeQ-0006Sr-Ax; Sun, 03 Feb 2019 14:21:38 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9c-00075I-Cv; Sun, 03 Feb 2019 14:49:48 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.769576034@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 151/305] USB: Wait for extra delay time after
 USB_PORT_FEAT_RESET for quirky hub
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 781f0766cc41a9dd2e5d118ef4b1d5d89430257b upstream.

Devices connected under Terminus Technology Inc. Hub (1a40:0101) may
fail to work after the system resumes from suspend:
[  206.063325] usb 3-2.4: reset full-speed USB device number 4 using xhci_hcd
[  206.143691] usb 3-2.4: device descriptor read/64, error -32
[  206.351671] usb 3-2.4: device descriptor read/64, error -32

Info for this hub:
T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=480 MxCh= 4
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1a40 ProdID=0101 Rev=01.11
S:  Product=USB 2.0 Hub
C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub

Some expirements indicate that the USB devices connected to the hub are
innocent, it's the hub itself is to blame. The hub needs extra delay
time after it resets its port.

Hence wait for extra delay, if the device is connected to this quirky
hub.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Drop module parameter changes
 - We don't have a USB_PORT_QUIRK_FAST_ENUM quirk]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2671,6 +2671,7 @@ static int hub_port_reset(struct usb_hub
 	int i, status;
 	u16 portchange, portstatus;
 	struct usb_port *port_dev = hub->ports[port1 - 1];
+	int reset_recovery_time;
 
 	if (!hub_is_superspeed(hub->hdev)) {
 		if (warm) {
@@ -2760,7 +2761,14 @@ static int hub_port_reset(struct usb_hub
 done:
 	if (status == 0) {
 		/* TRSTRCY = 10 ms; plus some extra */
-		msleep(10 + 40);
+		reset_recovery_time = 10 + 40;
+
+		/* Hub needs extra delay after resetting its port. */
+		if (hub->hdev->quirks & USB_QUIRK_HUB_SLOW_RESET)
+			reset_recovery_time += 100;
+
+		msleep(reset_recovery_time);
+
 		if (udev) {
 			struct usb_hcd *hcd = bus_to_hcd(udev->bus);
 
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -229,6 +229,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Terminus Technology Inc. Hub */
+	{ USB_DEVICE(0x1a40, 0x0101), .driver_info = USB_QUIRK_HUB_SLOW_RESET },
+
 	/* Corsair K70 RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
 
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -59,4 +59,7 @@
 /* Device needs a pause after every control message. */
 #define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
 
+/* Hub needs extra delay after resetting its port. */
+#define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
+
 #endif /* __LINUX_USB_QUIRKS_H */

