Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC86C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336E920854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336E920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeIJTiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:38:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728439AbeIJTiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:38:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7D4A401EF36;
        Mon, 10 Sep 2018 14:43:35 +0000 (UTC)
Received: from ovpn-112-55.rdu2.redhat.com (ovpn-112-55.rdu2.redhat.com [10.10.112.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B4E210EE78E;
        Mon, 10 Sep 2018 14:43:35 +0000 (UTC)
Message-ID: <f1d9e72eb9afb5762918358e3321742120b78528.camel@redhat.com>
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
From:   Dan Williams <dcbw@redhat.com>
To:     Kristian Evensen <kristian.evensen@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Sep 2018 09:43:34 -0500
In-Reply-To: <20180908125754.1947-1-kristian.evensen@gmail.com>
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 14:43:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 14:43:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dcbw@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-09-08 at 14:57 +0200, Kristian Evensen wrote:
> The Quectel EP06 (and EM06/EG06) LTE modem supports updating the USB
> configuration, without the VID/PID or configuration number changing.
> When the configuration is updated and interfaces are added/removed,
> the
> interface numbers are updated. This causes our current code for
> matching
> EP06 not to work as intended, as the assumption about reserved
> interfaces no longer holds. If for example the diagnostic (first)
> interface is removed, option will (try to) bind to the QMI interface.
> 
> This patch improves EP06 detection by replacing the current match
> with
> two matches, and those matches check class, subclass and protocol as
> well as VID and PID. The diag interface exports class, subclass and
> protocol as 0xff. For the other serial interfaces, class is 0xff and
> subclass and protocol are both 0x0.
> 
> The modem can export the following devices and always in this order:
> diag, nmea, at, ppp. qmi and adb. This means that diag can only ever
> be
> interface 0, and interface numbers 1-5 should be marked as reserved.
> The
> three other serial devices can have interface numbers 0-3, but I have
> not marked any interfaces as reserved. The reason is that the serial
> devices are the only interfaces exported by the device where subclass
> and protocol is 0x0.
> 
> QMI exports the same class, subclass and protocol values as the diag
> interface. However, the two interfaces have different number of
> endpoints, QMI has three and diag two. I have added a check for
> number
> of interfaces if VID/PID matches the EP06, and we ignore the device
> if
> number of interfaces equals three (and subclass is set).

I double-checked the permutations & logic and it makes sense to me.

Acked-by: Dan Williams <dcbw@redhat.com>

> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
> ---
>  drivers/usb/serial/option.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/option.c
> b/drivers/usb/serial/option.c
> index 0215b70c4efc..835dcd2875a7 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1081,8 +1081,9 @@ static const struct usb_device_id option_ids[]
> = {
>  	  .driver_info = RSVD(4) },
>  	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
>  	  .driver_info = RSVD(4) },
> -	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06),
> -	  .driver_info = RSVD(4) | RSVD(5) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID,
> QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
> +	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) |
> RSVD(5) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID,
> QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6003),
> @@ -1985,6 +1986,7 @@ static int option_probe(struct usb_serial
> *serial,
>  {
>  	struct usb_interface_descriptor *iface_desc =
>  				&serial->interface->cur_altsetting-
> >desc;
> +	struct usb_device_descriptor *dev_desc = &serial->dev-
> >descriptor;
>  	unsigned long device_flags = id->driver_info;
>  
>  	/* Never bind to the CD-Rom emulation interface	*/
> @@ -1999,6 +2001,17 @@ static int option_probe(struct usb_serial
> *serial,
>  	if (device_flags & RSVD(iface_desc->bInterfaceNumber))
>  		return -ENODEV;
>  
> +	/*
> +	 * Don't bind to the QMI device of the Quectel
> EP06/EG06/EM06. Class,
> +	 * subclass and protocol is 0xff for both the diagnostic
> port and the
> +	 * QMI interface, but the diagnostic port only has two
> endpoints (QMI
> +	 * has three).
> +	 */
> +	if (dev_desc->idVendor == cpu_to_le16(QUECTEL_VENDOR_ID) &&
> +	    dev_desc->idProduct == cpu_to_le16(QUECTEL_PRODUCT_EP06)
> &&
> +	    iface_desc->bInterfaceSubClass && iface_desc-
> >bNumEndpoints == 3)
> +		return -ENODEV;
> +
>  	/* Store the device flags so we can use them during attach.
> */
>  	usb_set_serial_data(serial, (void *)device_flags);
>  
