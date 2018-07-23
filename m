Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF881ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7511720881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7511720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbeGWPJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:09:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbeGWPJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:09:29 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BAAF841C;
        Mon, 23 Jul 2018 14:08:03 +0000 (UTC)
Date:   Mon, 23 Jul 2018 16:08:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] option: Do not try to bind to ADB interfaces
Message-ID: <20180723140801.GA4835@kroah.com>
References: <20180723140220.7166-1-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723140220.7166-1-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:02:20PM +0200, Romain Izard wrote:
> Some modems now use the Android Debug Bridge to provide a debugging
> interface, and some phones can also export serial ports managed by the
> "option" driver.
> 
> The ADB daemon running in userspace tries to use USB interfaces with
> bDeviceClass=0xFF, bDeviceSubClass=0x42, bDeviceProtocol=1
> 
> Prevent the option driver from binding to those interfaces, as they
> will not be serial ports.
> 
> This can fix issues like:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=781256
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 664e61f16b6a..f98943a57ff0 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1987,6 +1987,12 @@ static int option_probe(struct usb_serial *serial,
>  	if (iface_desc->bInterfaceClass == USB_CLASS_MASS_STORAGE)
>  		return -ENODEV;
>  
> +	/* Do not bind Android Debug Bridge interfaces */
> +	if (iface_desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
> +		iface_desc->bInterfaceSubClass == 0x42 &&
> +		iface_desc->bInterfaceProtocol == 1)
> +		return -ENODEV;

Shouldn't you also check the vendor/product id as well?  Otherwise this
has the potential to match random devices that are not really adb
devices.

thanks,

greg k-h
