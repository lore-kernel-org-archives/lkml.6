Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BAEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A3F2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1bNWxHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A3F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeKLUdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:33:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43574 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeKLUdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:33:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id g26-v6so7128272lja.10;
        Mon, 12 Nov 2018 02:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pkHn4UzoxdE46JJXKjXG/YzynWv85GLf8d7cvwmEPnk=;
        b=N1bNWxHhxxfzeTAAB+kIN00d5INood4n/n3WEWAwMxUwc/MFjeXc1UyiByT+cotuLI
         BOCv9B9CTXHuSPg3I9pnV0s8Sqo6UkuVKMBrnlYEqXozT2raaSTm/yEZsXVsjf4wWyML
         QLubd80vRvIOktgYjNwV5wIoRTnSIlDIDRfFJgmMTpuD+9SJsOYBfwzt8SA7scv2XTee
         nGwNJSohIjAkVbfLZ0hfAAAvK79jMRisdn5fSD3sJRRDn4pTcjEO+kKd1+r6DzkOITuw
         Vd1sC+lVJRaeBsQrI4n6C5twtC39yJnLbgefUbBS41bcLh+ljbpeuRM9LBPJRH5no6RX
         8e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pkHn4UzoxdE46JJXKjXG/YzynWv85GLf8d7cvwmEPnk=;
        b=uezjqjqIRHYm0LfVfh1bnGBEkG7ITowynrvqhrhSMX808JAXIXL6QSkEAAbhULDjNP
         rNVnkydhf5UXZt/im797gNyCVO83RQ+CXjzdErJKicrWMtFQmJCVdbNDNRFmgLr5wcXd
         yYUxAB8NMdWdWhKhS9JBBF4n/HTWWF+SBU9bYJ/QMGIcNo2EmuMvJ61kBTBYe/cGXTgf
         Gz3Xf9+35Ei4O9JaJoQut/VET3mT9oARy+rzEExucinLZXxf4lo7U/k//D44u2V9QcNu
         KOowyCy/5O6BwNvR/SrsamGTlqruuwXx4+ZGbx+8+hH5LRelJqtz9u0S2YPB8fsGzBSN
         LjUw==
X-Gm-Message-State: AGRZ1gLD3KeT6wpw0GG1LQ93T8S7icAw8MslBHnIfdJ6YLI7lQ9Uu5MA
        PgecZ2ePquQXUqX+mhEXPIU=
X-Google-Smtp-Source: AJdET5cmKCOPn9b1tUJtMohvqJptvYhqpxRuxDDEqJVrbt8Mw12avI9NQs6kQ4X35YFWzOeONfFmmQ==
X-Received: by 2002:a2e:4819:: with SMTP id v25-v6mr370080lja.2.1542019257930;
        Mon, 12 Nov 2018 02:40:57 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r69sm3121373lfi.15.2018.11.12.02.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 02:40:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gM9eG-0006VO-KA; Mon, 12 Nov 2018 11:40:52 +0100
Date:   Mon, 12 Nov 2018 11:40:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jackychou <jackychou@asix.com.tw>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        louis@asix.com.tw
Subject: Re: [PATCH] USB: serial: mos7840: Add a product ID for the new
 product
Message-ID: <20181112104052.GF13311@localhost>
References: <20181112071605.7014-1-jackychou@asix.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112071605.7014-1-jackychou@asix.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:16:05PM +0800, Jackychou wrote:
> From: JackyChou <jackychou@asix.com.tw>
> 
> Add a new PID 0x7843 to the driver.
> Let the new products be able to set up 3 serial ports with the driver.
> 
> Signed-off-by: JackyChou <jackychou@asix.com.tw>
> ---
>  drivers/usb/serial/mos7840.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
> index b42bad85097a..7667b22fa2f7 100644
> --- a/drivers/usb/serial/mos7840.c
> +++ b/drivers/usb/serial/mos7840.c
> @@ -94,6 +94,7 @@
>  /* The native mos7840/7820 component */
>  #define USB_VENDOR_ID_MOSCHIP           0x9710
>  #define MOSCHIP_DEVICE_ID_7840          0x7840
> +#define MOSCHIP_DEVICE_ID_7843          0x7843
>  #define MOSCHIP_DEVICE_ID_7820          0x7820
>  #define MOSCHIP_DEVICE_ID_7810          0x7810
>  /* The native component can have its vendor/device id's overridden
> @@ -176,6 +177,7 @@ enum mos7840_flag {
>  
>  static const struct usb_device_id id_table[] = {
>  	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7840)},
> +	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7843)},
>  	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7820)},
>  	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7810)},
>  	{USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_2)},
> @@ -298,7 +300,7 @@ static int mos7840_set_uart_reg(struct usb_serial_port *port, __u16 reg,
>  	val = val & 0x00ff;
>  	/* For the UART control registers, the application number need
>  	   to be Or'ed */
> -	if (port->serial->num_ports == 4) {
> +	if (port->serial->num_ports == 4 || port->serial->num_ports == 3) {

Please use num_ports > 2 here.

>  		val |= ((__u16)port->port_number + 1) << 8;
>  	} else {
>  		if (port->port_number == 0) {
> @@ -332,7 +334,7 @@ static int mos7840_get_uart_reg(struct usb_serial_port *port, __u16 reg,
>  		return -ENOMEM;
>  
>  	/* Wval  is same as application number */
> -	if (port->serial->num_ports == 4) {
> +	if (port->serial->num_ports == 4 || port->serial->num_ports == 3) {

Same here.

>  		Wval = ((__u16)port->port_number + 1) << 8;
>  	} else {
>  		if (port->port_number == 0) {
> @@ -2071,9 +2073,12 @@ static int mos7840_probe(struct usb_serial *serial,
>  			VENDOR_READ_LENGTH, MOS_WDR_TIMEOUT);
>  
>  	/* For a MCS7840 device GPIO0 must be set to 1 */
> -	if (buf[0] & 0x01)
> -		device_type = MOSCHIP_DEVICE_ID_7840;
> -	else if (mos7810_check(serial))
> +	if (buf[0] & 0x01) {
> +		if (product == MOSCHIP_DEVICE_ID_7843)
> +			device_type = MOSCHIP_DEVICE_ID_7843;

What about 7843 devices that use a different PID? Is there a reliable
way to detect the type without relying on PID?

Otherwise, there's no point in verifying GPIO0 for these ones.

> +		else
> +			device_type = MOSCHIP_DEVICE_ID_7840;
> +	} else if (mos7810_check(serial))

Nit: if you add braces to one of the branches you need to add it to all
of them.

>  		device_type = MOSCHIP_DEVICE_ID_7810;
>  	else
>  		device_type = MOSCHIP_DEVICE_ID_7820;
> @@ -2091,7 +2096,10 @@ static int mos7840_calc_num_ports(struct usb_serial *serial,
>  	int device_type = (unsigned long)usb_get_serial_data(serial);
>  	int num_ports;
>  
> -	num_ports = (device_type >> 4) & 0x000F;
> +	if (device_type == MOSCHIP_DEVICE_ID_7843)
> +		num_ports = 3;
> +	else
> +		num_ports = (device_type >> 4) & 0x000F;
>  
>  	/*
>  	 * num_ports is currently never zero as device_type is one of
> @@ -2146,7 +2154,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
>  		mos7840_port->SpRegOffset = 0x0;
>  		mos7840_port->ControlRegOffset = 0x1;
>  		mos7840_port->DcrRegOffset = 0x4;
> -	} else if ((mos7840_port->port_num == 2) && (serial->num_ports == 4)) {
> +	} else if ((mos7840_port->port_num == 2) &&
> +		   ((serial->num_ports == 4) || (serial->num_ports == 3))) {
>  		mos7840_port->SpRegOffset = 0x8;
>  		mos7840_port->ControlRegOffset = 0x9;
>  		mos7840_port->DcrRegOffset = 0x16;
> @@ -2154,7 +2163,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
>  		mos7840_port->SpRegOffset = 0xa;
>  		mos7840_port->ControlRegOffset = 0xb;
>  		mos7840_port->DcrRegOffset = 0x19;
> -	} else if ((mos7840_port->port_num == 3) && (serial->num_ports == 4)) {
> +	} else if ((mos7840_port->port_num == 3) &&
> +		   ((serial->num_ports == 4) || (serial->num_ports == 3))) {
>  		mos7840_port->SpRegOffset = 0xa;
>  		mos7840_port->ControlRegOffset = 0xb;
>  		mos7840_port->DcrRegOffset = 0x19;

This is getting rather ugly. Can't you clean up the current code so that
it covers your device without the need of such changes first? 

From the looks of it, the only reason for the above is to map the
offsets for port 2 in the 2-port case to the offsets of port 3. It would
be more straight-forward to handle that particular case separately.

This also relates to the set/get_uart_reg functions above, which also
should handle the 2-port case specifically instead.

Thanks,
Johan
