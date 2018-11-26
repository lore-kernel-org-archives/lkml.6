Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E05B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Csh8+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E05B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeKZV7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZV7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8DB2089F;
        Mon, 26 Nov 2018 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230359;
        bh=nZc7VLL9hjGORjCSgtLxD6+M5DNRc4G06zKyMHVxM0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1Csh8+qvGfStUeH9S7XdblWMZ/xe6HLlqfkRptmWjULZnCLSBAPNr9X+h2OqUe8o
         AMs739MTU7MHaxHwY1R4sXK6vsO3VVmMIfZ+4WP6xDzSJx+0TS1gGHQ5r5FX5Zfw3V
         Mw7/8gKhGr/XM465wgpQZL6MDxUntB4N29fjmYRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.19 105/118] USB: Wait for extra delay time after USB_PORT_FEAT_RESET for quirky hub
Date:   Mon, 26 Nov 2018 11:51:39 +0100
Message-Id: <20181126105105.912754478@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/admin-guide/kernel-parameters.txt |    2 ++
 drivers/usb/core/hub.c                          |   14 +++++++++++---
 drivers/usb/core/quirks.c                       |    6 ++++++
 include/linux/usb/quirks.h                      |    3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4687,6 +4687,8 @@
 					prevent spurious wakeup);
 				n = USB_QUIRK_DELAY_CTRL_MSG (Device needs a
 					pause after every control message);
+				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
+					delay after resetting its port);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2791,6 +2791,7 @@ static int hub_port_reset(struct usb_hub
 	int i, status;
 	u16 portchange, portstatus;
 	struct usb_port *port_dev = hub->ports[port1 - 1];
+	int reset_recovery_time;
 
 	if (!hub_is_superspeed(hub->hdev)) {
 		if (warm) {
@@ -2882,11 +2883,18 @@ static int hub_port_reset(struct usb_hub
 
 done:
 	if (status == 0) {
-		/* TRSTRCY = 10 ms; plus some extra */
 		if (port_dev->quirks & USB_PORT_QUIRK_FAST_ENUM)
 			usleep_range(10000, 12000);
-		else
-			msleep(10 + 40);
+		else {
+			/* TRSTRCY = 10 ms; plus some extra */
+			reset_recovery_time = 10 + 40;
+
+			/* Hub needs extra delay after resetting its port. */
+			if (hub->hdev->quirks & USB_QUIRK_HUB_SLOW_RESET)
+				reset_recovery_time += 100;
+
+			msleep(reset_recovery_time);
+		}
 
 		if (udev) {
 			struct usb_hcd *hcd = bus_to_hcd(udev->bus);
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -128,6 +128,9 @@ static int quirks_param_set(const char *
 			case 'n':
 				flags |= USB_QUIRK_DELAY_CTRL_MSG;
 				break;
+			case 'o':
+				flags |= USB_QUIRK_HUB_SLOW_RESET;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -380,6 +383,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Terminus Technology Inc. Hub */
+	{ USB_DEVICE(0x1a40, 0x0101), .driver_info = USB_QUIRK_HUB_SLOW_RESET },
+
 	/* Corsair K70 RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
 
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -66,4 +66,7 @@
 /* Device needs a pause after every control message. */
 #define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
 
+/* Hub needs extra delay after resetting its port. */
+#define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
+
 #endif /* __LINUX_USB_QUIRKS_H */


