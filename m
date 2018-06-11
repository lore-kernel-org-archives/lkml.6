Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id H1WTDoZTHluVWQAAmS7hNA
	; Mon, 11 Jun 2018 10:49:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3FF1E607A4; Mon, 11 Jun 2018 10:49:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=4ever3.net header.i=@4ever3.net header.b="Dz6M92AE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9C73E600D0;
	Mon, 11 Jun 2018 10:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C73E600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=4ever3.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeFKKtE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:49:04 -0400
Received: from 4ever3.net ([89.221.215.179]:60591 "EHLO 4ever3.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932700AbeFKKtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:49:03 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2018 06:49:02 EDT
Received: by hq.local (Postfix, from userid 1000)
        id 2F1706640E; Mon, 11 Jun 2018 12:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=4ever3.net;
        s=2d4d2fbba390015ca44f11e3679c96e1a2d7262a; t=1528713586;
        bh=eeOp53S6U4tVjqgB/NXUdFHLo/qvazqEN3CHcI6flm8=;
        h=From:To:Cc:Subject:Date:From;
        b=Dz6M92AE7+rN5PKhFM1tmv40wdrZVE1B2VX+ib2pCG1c3VEszX/NcB+zecfxdLplK
         +RJ2F4MUjrefTJuQBIapVnxGBxZtEjtjn4l6A37O4sMtLd3EDvDSsvPGkEVGpLDfqk
         BpNmEAHOaQwhzMwypP/WpkdF0+fiLzJ3eN5m1Oho=
From: Houston Yaroschoff <hstn@4ever3.net>
To: oneukum@suse.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Houston Yaroschoff <hstn@4ever3.net>
Subject: [PATCH] usb: cdc_acm: Add quirk for Uniden UBC125 scanner
Date: Mon, 11 Jun 2018 12:39:09 +0200
Message-Id: <20180611103909.24753-1-hstn@4ever3.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uniden UBC125 radio scanner has USB interface which fails to work
with cdc_acm driver:
  usb 1-1.5: new full-speed USB device number 4 using xhci_hcd
  cdc_acm 1-1.5:1.0: Zero length descriptor references
  cdc_acm: probe of 1-1.5:1.0 failed with error -22

Adding the NO_UNION_NORMAL quirk for the device fixes the issue:
  usb 1-4: new full-speed USB device number 15 using xhci_hcd
  usb 1-4: New USB device found, idVendor=1965, idProduct=0018
  usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
  usb 1-4: Product: UBC125XLT
  usb 1-4: Manufacturer: Uniden Corp.
  usb 1-4: SerialNumber: 0001
  cdc_acm 1-4:1.0: ttyACM0: USB ACM device

`lsusb -v` of the device:

  Bus 001 Device 015: ID 1965:0018 Uniden Corporation
  Device Descriptor:
    bLength                18
    bDescriptorType         1
    bcdUSB               2.00
    bDeviceClass            2 Communications
    bDeviceSubClass         0
    bDeviceProtocol         0
    bMaxPacketSize0        64
    idVendor           0x1965 Uniden Corporation
    idProduct          0x0018
    bcdDevice            0.01
    iManufacturer           1 Uniden Corp.
    iProduct                2 UBC125XLT
    iSerial                 3 0001
    bNumConfigurations      1
    Configuration Descriptor:
      bLength                 9
      bDescriptorType         2
      wTotalLength           48
      bNumInterfaces          2
      bConfigurationValue     1
      iConfiguration          0
      bmAttributes         0x80
        (Bus Powered)
      MaxPower              500mA
      Interface Descriptor:
        bLength                 9
        bDescriptorType         4
        bInterfaceNumber        0
        bAlternateSetting       0
        bNumEndpoints           1
        bInterfaceClass         2 Communications
        bInterfaceSubClass      2 Abstract (modem)
        bInterfaceProtocol      0 None
        iInterface              0
        Endpoint Descriptor:
          bLength                 7
          bDescriptorType         5
          bEndpointAddress     0x87  EP 7 IN
          bmAttributes            3
            Transfer Type            Interrupt
            Synch Type               None
            Usage Type               Data
          wMaxPacketSize     0x0008  1x 8 bytes
          bInterval              10
      Interface Descriptor:
        bLength                 9
        bDescriptorType         4
        bInterfaceNumber        1
        bAlternateSetting       0
        bNumEndpoints           2
        bInterfaceClass        10 CDC Data
        bInterfaceSubClass      0 Unused
        bInterfaceProtocol      0
        iInterface              0
        Endpoint Descriptor:
          bLength                 7
          bDescriptorType         5
          bEndpointAddress     0x81  EP 1 IN
          bmAttributes            2
            Transfer Type            Bulk
            Synch Type               None
            Usage Type               Data
          wMaxPacketSize     0x0040  1x 64 bytes
          bInterval               0
        Endpoint Descriptor:
          bLength                 7
          bDescriptorType         5
          bEndpointAddress     0x02  EP 2 OUT
          bmAttributes            2
            Transfer Type            Bulk
            Synch Type               None
            Usage Type               Data
          wMaxPacketSize     0x0040  1x 64 bytes
          bInterval               0
  Device Status:     0x0000
    (Bus Powered)

Signed-off-by: Houston Yaroschoff <hstn@4ever3.net>
---
 drivers/usb/class/cdc-acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7b366a6c0b49..998b32d0167e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1758,6 +1758,9 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
 	.driver_info = SINGLE_RX_URB,
 	},
+	{ USB_DEVICE(0x1965, 0x0018), /* Uniden UBC125XLT */
+	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
+	},
 	{ USB_DEVICE(0x22b8, 0x7000), /* Motorola Q Phone */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
-- 
2.11.0
