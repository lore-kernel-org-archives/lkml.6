Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C17C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FA92145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FA92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeJRPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:42:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJRPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:42:37 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gD2xH-0001q0-DZ; Thu, 18 Oct 2018 07:42:51 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] USB: Wait for extra delay time after USB_PORT_FEAT_RESET for quirky hub
Date:   Thu, 18 Oct 2018 15:42:47 +0800
Message-Id: <20181018074247.6858-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 drivers/usb/core/hub.c                          | 5 +++++
 drivers/usb/core/quirks.c                       | 6 ++++++
 include/linux/usb/quirks.h                      | 3 +++
 4 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f42240d..626bb7892ab3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4683,6 +4683,8 @@
 					prevent spurious wakeup);
 				n = USB_QUIRK_DELAY_CTRL_MSG (Device needs a
 					pause after every control message);
+				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
+					delay after resetting its port);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 462ce49f683a..4d7e6f8dd40a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2891,6 +2891,11 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 		if (udev) {
 			struct usb_hcd *hcd = bus_to_hcd(udev->bus);
 
+			/* Hub needs extra delay after resetting its port. */
+			if (udev->parent &&
+			    udev->parent->quirks & USB_QUIRK_HUB_SLOW_RESET)
+				msleep(100);
+
 			update_devnum(udev, 0);
 			/* The xHC may think the device is already reset,
 			 * so ignore the status.
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 178d6c6063c0..4d7d948eae63 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -128,6 +128,9 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 			case 'n':
 				flags |= USB_QUIRK_DELAY_CTRL_MSG;
 				break;
+			case 'o':
+				flags |= USB_QUIRK_HUB_SLOW_RESET;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -380,6 +383,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Terminus Technology Inc. Hub */
+	{ USB_DEVICE(0x1a40, 0x0101), .driver_info = USB_QUIRK_HUB_SLOW_RESET },
+
 	/* Corsair K70 RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
 
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index b7a99ce56bc9..a1be64c9940f 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -66,4 +66,7 @@
 /* Device needs a pause after every control message. */
 #define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
 
+/* Hub needs extra delay after resetting its port. */
+#define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.19.1

