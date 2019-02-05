Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BCF2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfBEQvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:51:44 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:51534 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbfBEQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:51:43 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id D437E13F8D2;
        Tue,  5 Feb 2019 17:51:29 +0100 (CET)
Subject: Re: msm8998: Hacking the USB3 controller (force controller to
 host/source mode)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <00358fd5-1702-ec4c-8400-3807d50614c6@free.fr>
 <420f7226-dfba-5197-145f-d31f89a465d2@free.fr>
Message-ID: <9a859310-156b-5e1d-1454-8bddc718fd9d@free.fr>
Date:   Tue, 5 Feb 2019 17:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <420f7226-dfba-5197-145f-d31f89a465d2@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I plug in a USB-to-Ethernet gadget, the kernel sees something:

usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci-hcd
usb 2-1: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 1.00
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1: Product: AX88179
usb 2-1: Manufacturer: ASIX Elec. Corp.
usb 2-1: SerialNumber: 00000000000012
ax88179_178a 2-1:1.0 eth0: register 'ax88179_178a' at usb-xhci-hcd.0.auto-1, ASIX AX88179 USB 3.0 Gigabit Ethernet, 00:0e:c6:fb:e2:41
usbcore: registered new interface driver ax88179_178a

# lsmod
Module                  Size  Used by    Not tainted
ax88179_178a           24576  0 
usbnet                 32768  1 ax88179_178a
mii                    20480  2 ax88179_178a,usbnet


But the eth LEDs don't turn on (or blink) when I plug in a cable.
Could it be a power/voltage issue?

# lsusb -v

Bus 002 Device 003: ID 0b95:1790  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass          255 
  bDeviceSubClass       255 
  bDeviceProtocol         0 
  bMaxPacketSize0         9
  idVendor           0x0b95 
  idProduct          0x1790 
  bcdDevice            1.00
  iManufacturer           1 ASIX Elec. Corp.
  iProduct                2 AX88179
  iSerial                 3 00000000000012
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0039
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              496mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 
      bInterfaceSubClass    255 
      bInterfaceProtocol      0 
      iInterface              4 Network_Interface
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              11
        bMaxBurst               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               3
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x0016
  bNumDeviceCaps          2
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      HIRD Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           1 micro seconds
    bU2DevExitLat         101 micro seconds
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
  (Bus Powered)

