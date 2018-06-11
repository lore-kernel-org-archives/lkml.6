Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rK/pH4JWHltLdAAAmS7hNA
	; Mon, 11 Jun 2018 11:01:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7555260792; Mon, 11 Jun 2018 11:01:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E5D20601C3;
	Mon, 11 Jun 2018 11:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5D20601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932780AbeFKLBU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:01:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932263AbeFKLBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:01:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D87BAF1E;
        Mon, 11 Jun 2018 11:01:17 +0000 (UTC)
Message-ID: <1528714451.31911.15.camel@suse.com>
Subject: Re: [PATCH] usb: cdc_acm: Add quirk for Uniden UBC125 scanner
From: Oliver Neukum <oneukum@suse.com>
To: Houston Yaroschoff <hstn@4ever3.net>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date: Mon, 11 Jun 2018 12:54:11 +0200
In-Reply-To: <20180611103909.24753-1-hstn@4ever3.net>
References: <20180611103909.24753-1-hstn@4ever3.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2018-06-11 at 12:39 +0200, Houston Yaroschoff wrote:
> Uniden UBC125 radio scanner has USB interface which fails to work
> with cdc_acm driver:
>   usb 1-1.5: new full-speed USB device number 4 using xhci_hcd
>   cdc_acm 1-1.5:1.0: Zero length descriptor references
>   cdc_acm: probe of 1-1.5:1.0 failed with error -22
> 
> Adding the NO_UNION_NORMAL quirk for the device fixes the issue:
>   usb 1-4: new full-speed USB device number 15 using xhci_hcd
>   usb 1-4: New USB device found, idVendor=1965, idProduct=0018
>   usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>   usb 1-4: Product: UBC125XLT
>   usb 1-4: Manufacturer: Uniden Corp.
>   usb 1-4: SerialNumber: 0001
>   cdc_acm 1-4:1.0: ttyACM0: USB ACM device
> 
> `lsusb -v` of the device:
> 
>   Bus 001 Device 015: ID 1965:0018 Uniden Corporation
>   Device Descriptor:
>     bLength                18
>     bDescriptorType         1
>     bcdUSB               2.00
>     bDeviceClass            2 Communications
>     bDeviceSubClass         0
>     bDeviceProtocol         0
>     bMaxPacketSize0        64
>     idVendor           0x1965 Uniden Corporation
>     idProduct          0x0018
>     bcdDevice            0.01
>     iManufacturer           1 Uniden Corp.
>     iProduct                2 UBC125XLT
>     iSerial                 3 0001
>     bNumConfigurations      1
>     Configuration Descriptor:
>       bLength                 9
>       bDescriptorType         2
>       wTotalLength           48
>       bNumInterfaces          2
>       bConfigurationValue     1
>       iConfiguration          0
>       bmAttributes         0x80
>         (Bus Powered)
>       MaxPower              500mA
>       Interface Descriptor:
>         bLength                 9
>         bDescriptorType         4
>         bInterfaceNumber        0
>         bAlternateSetting       0
>         bNumEndpoints           1
>         bInterfaceClass         2 Communications
>         bInterfaceSubClass      2 Abstract (modem)
>         bInterfaceProtocol      0 None
>         iInterface              0
>         Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType         5
>           bEndpointAddress     0x87  EP 7 IN
>           bmAttributes            3
>             Transfer Type            Interrupt
>             Synch Type               None
>             Usage Type               Data
>           wMaxPacketSize     0x0008  1x 8 bytes
>           bInterval              10
>       Interface Descriptor:
>         bLength                 9
>         bDescriptorType         4
>         bInterfaceNumber        1
>         bAlternateSetting       0
>         bNumEndpoints           2
>         bInterfaceClass        10 CDC Data
>         bInterfaceSubClass      0 Unused
>         bInterfaceProtocol      0
>         iInterface              0
>         Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType         5
>           bEndpointAddress     0x81  EP 1 IN
>           bmAttributes            2
>             Transfer Type            Bulk
>             Synch Type               None
>             Usage Type               Data
>           wMaxPacketSize     0x0040  1x 64 bytes
>           bInterval               0
>         Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType         5
>           bEndpointAddress     0x02  EP 2 OUT
>           bmAttributes            2
>             Transfer Type            Bulk
>             Synch Type               None
>             Usage Type               Data
>           wMaxPacketSize     0x0040  1x 64 bytes
>           bInterval               0
>   Device Status:     0x0000
>     (Bus Powered)
> 
> Signed-off-by: Houston Yaroschoff <hstn@4ever3.net>
Acked-by: Oliver Neukum <oneukum@suse.com>
