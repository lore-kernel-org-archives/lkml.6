Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9568C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E648208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E648208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbeGJS1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732961AbeGJS1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44781EA8;
        Tue, 10 Jul 2018 18:26:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Houston Yaroschoff <hstn@4ever3.net>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.4 01/47] usb: cdc_acm: Add quirk for Uniden UBC125 scanner
Date:   Tue, 10 Jul 2018 20:24:25 +0200
Message-Id: <20180710182337.102832752@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Houston Yaroschoff <hstn@4ever3.net>

commit 4a762569a2722b8a48066c7bacf0e1dc67d17fa1 upstream.

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
Cc: stable <stable@vger.kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1698,6 +1698,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
 	.driver_info = SINGLE_RX_URB,
 	},
+	{ USB_DEVICE(0x1965, 0x0018), /* Uniden UBC125XLT */
+	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
+	},
 	{ USB_DEVICE(0x22b8, 0x7000), /* Motorola Q Phone */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},


