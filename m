Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE8CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463E8208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feHO7csa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463E8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbeKPUHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:07:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39224 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeKPUHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:07:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so16181604lfh.6;
        Fri, 16 Nov 2018 01:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HI6/rNhmT6bEe/jT6YuPa/Yn8gKcer2u/m4J+Kx7DiU=;
        b=feHO7csaBwG5FDBfWAry0r0CbKlZMMA9x78tRap9U0n8wqMIXbto3+MHwQGvBQwjyh
         tBqZMs2XpIAYkN69GFIb4pOHUvVYtIiiPQH58HuUAPmX6mOSnTFysHXXeD9ugTBOzwNi
         fwmG1+tL79p45kgL7ejEj/Cd3bIo9TXz547+u+11sorG4AB4ndocQ2/k1BukG6cLgO1l
         fqMUfe77i3IgwfF+860g62gWBPPS/Vni4wjn7ZOzMDL1fDkIn3GHOL1963Gmbsp/LgYD
         YC2yZ8g4y38lXoy2dNwugEgrgH4eOOkVcbDhf91UmxWoCTYJqqylW/puG1DdGc7UrH3P
         vovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HI6/rNhmT6bEe/jT6YuPa/Yn8gKcer2u/m4J+Kx7DiU=;
        b=nhLjQGCQCYQY1bS2duoIg360WatlHX1ys2qWZR562pmbqQ/O8Qk4s+Yk1CZhzMdtMZ
         0k0ksS/sijpMMwJT2FiWxTCoJwYXWkbuwfiO0+VyC2jKbid0FqnpKWiXXfqVGFLmTB3t
         omZvLT4bjkuS0tzlKWYjenSC1mibKS7/14vRl3Keoa0vzWNJY+KvY33CCtf1sf4I34X/
         RzjtGNquXZgS/nMLvoCDHWkngA/JDUM9CGO14jU+bHx6D5SwC4p5s3674acJySVZ+Yra
         nzKazaHaACNmypkiRMPNGIPwWzInVLXDBmMjfFvUSeIK0sxS2KT+JNfDVa5wQduSueGr
         YbdA==
X-Gm-Message-State: AGRZ1gKDGJSxhuU80BarcGdPbHLzDj5r/v0XUJF9LBTWIm1YNtDEwrpN
        SIY82zaT9VdyeRznVL3ysDg=
X-Google-Smtp-Source: AJdET5fyXK5r5uCS0i+wgYn2GBfWGjLxe10jy+SEL2j76U498p4cz8Jg6C5xMqzF6YJt0l+QCh0v3g==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr5627739lfe.63.1542362152408;
        Fri, 16 Nov 2018 01:55:52 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x11sm5176290lfd.81.2018.11.16.01.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 01:55:51 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gNaqv-0002aF-N6; Fri, 16 Nov 2018 10:55:53 +0100
Date:   Fri, 16 Nov 2018 10:55:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     JackyChou <jackychou@asix.com.tw>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        louis@asix.com.tw
Subject: Re: [PATCH] USB: serial: mos7840: Add a product ID for the new
 product
Message-ID: <20181116095553.GP19900@localhost>
References: <20181116063016.10360-1-jackychou@asix.com.tw>
 <002201d47d76$c5a45080$50ecf180$@asix.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002201d47d76$c5a45080$50ecf180$@asix.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 02:36:56PM +0800, JackyChou wrote:
> From: JackyChou <jackychou@asix.com.tw>
> 
> Add a new PID 0x7843 to the driver.
> Let the new products be able to set up 3 serial ports with the driver.
> 
> Because the development of new product is based on 4 serial ports, 
> but some users only need 3 serial ports. There is no way to set it from 
> the hardware, so let the driver set 3 serial ports with PID 0x7843.
> 
> Signed-off-by: JackyChou <jackychou@asix.com.tw>
> ---

Thanks for the update.

Always include a short changelog here so we know what has changed since
earlier versions.

Also include the patch revision in the Subject (i.e. "[PATCH v2] USB: ...").

>  drivers/usb/serial/mos7840.c | 45 ++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
> index b42bad85097a..57ef25a2f7bb 100644
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
> @@ -298,15 +300,10 @@ static int mos7840_set_uart_reg(struct usb_serial_port
> *port, __u16 reg,
>  	val = val & 0x00ff;
>  	/* For the UART control registers, the application number need
>  	   to be Or'ed */
> -	if (port->serial->num_ports == 4) {
> +	if (port->serial->num_ports == 2 && port->port_number != 0)
> +		val |= ((__u16)port->port_number + 2) << 8;
> +	else
>  		val |= ((__u16)port->port_number + 1) << 8;
> -	} else {
> -		if (port->port_number == 0) {
> -			val |= ((__u16)port->port_number + 1) << 8;
> -		} else {
> -			val |= ((__u16)port->port_number + 2) << 8;
> -		}
> -	}

This looks good, but please to this in a separate preparatory patch as
this is an independent change from adding support for you new device.

>  	dev_dbg(&port->dev, "%s application number is %x\n", __func__, val);
>  	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0), MCS_WRREQ,
>  			       MCS_WR_RTYPE, val, reg, NULL, 0, 
> @@ -332,15 +329,10 @@ static int mos7840_get_uart_reg(struct usb_serial_port
> *port, __u16 reg,
>  		return -ENOMEM;
>  
>  	/* Wval  is same as application number */
> -	if (port->serial->num_ports == 4) {
> +	if (port->serial->num_ports == 2 && port->port_number != 0)
> +		Wval = ((__u16)port->port_number + 2) << 8;
> +	else
>  		Wval = ((__u16)port->port_number + 1) << 8;
> -	} else {
> -		if (port->port_number == 0) {
> -			Wval = ((__u16)port->port_number + 1) << 8;
> -		} else {
> -			Wval = ((__u16)port->port_number + 2) << 8;
> -		}
> -	}

Same here.

>  	dev_dbg(&port->dev, "%s application number is %x\n", __func__,
> Wval);
>  	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), MCS_RDREQ,
>  			      MCS_RD_RTYPE, Wval, reg, buf,
> VENDOR_READ_LENGTH, 
> @@ -2071,12 +2063,16 @@ static int mos7840_probe(struct usb_serial *serial,
>  			VENDOR_READ_LENGTH, MOS_WDR_TIMEOUT);
>  
>  	/* For a MCS7840 device GPIO0 must be set to 1 */
> -	if (buf[0] & 0x01)
> -		device_type = MOSCHIP_DEVICE_ID_7840;
> -	else if (mos7810_check(serial))
> +	if (buf[0] & 0x01) {
> +		if (product == MOSCHIP_DEVICE_ID_7843)
> +			device_type = MOSCHIP_DEVICE_ID_7843;

And as I mentioned in my previous comments, if you're going to match in
PID, there's no need to check GPIO0. Just add code to handle 7843 to the
start of the function.

> +		else
> +			device_type = MOSCHIP_DEVICE_ID_7840;
> +	} else if (mos7810_check(serial)) {
>  		device_type = MOSCHIP_DEVICE_ID_7810;
> -	else
> +	} else {
>  		device_type = MOSCHIP_DEVICE_ID_7820;
> +	}
>  
>  	kfree(buf);
>  out:
> @@ -2091,7 +2087,10 @@ static int mos7840_calc_num_ports(struct usb_serial
> *serial,
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
> @@ -2146,7 +2145,7 @@ static int mos7840_port_probe(struct usb_serial_port
> *port)
>  		mos7840_port->SpRegOffset = 0x0;
>  		mos7840_port->ControlRegOffset = 0x1;
>  		mos7840_port->DcrRegOffset = 0x4;
> -	} else if ((mos7840_port->port_num == 2) && (serial->num_ports ==
> 4)) {
> +	} else if ((mos7840_port->port_num == 2) && (serial->num_ports > 2))
> {
>  		mos7840_port->SpRegOffset = 0x8;
>  		mos7840_port->ControlRegOffset = 0x9;
>  		mos7840_port->DcrRegOffset = 0x16;
> @@ -2154,7 +2153,7 @@ static int mos7840_port_probe(struct usb_serial_port
> *port)
>  		mos7840_port->SpRegOffset = 0xa;
>  		mos7840_port->ControlRegOffset = 0xb;
>  		mos7840_port->DcrRegOffset = 0x19;
> -	} else if ((mos7840_port->port_num == 3) && (serial->num_ports ==
> 4)) {
> +	} else if ((mos7840_port->port_num == 3) && (serial->num_ports > 2))
> {
>  		mos7840_port->SpRegOffset = 0xa;
>  		mos7840_port->ControlRegOffset = 0xb;
>  		mos7840_port->DcrRegOffset = 0x19;

Can't this be handled similarly to set_uart_reg() above? Looks like you
can calculate the offsets (and remove the if-else clause) and only make
sure to map port 2 in the two-port case to physical port 3.

This would also go in the preparatory first patch of a two-part series.

Thanks,
Johan
