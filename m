Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CCEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4BF223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyVtJ/lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4BF223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeKLTJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:09:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40016 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeKLTJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:09:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so5619124lfe.7;
        Mon, 12 Nov 2018 01:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUxzGvRCkWdcKejoL+2aA4B96whZZp8toJDHjAK1AF0=;
        b=EyVtJ/lWHTNZwFd66RGsq9SmKWzudvOG7Wmt3AtEjTCAdAf2K+VtkJOKoUU47u8OV6
         1V5dZ/uYnmRhp9LZYXjj6GUhxuBrhaATX7LqfaG3s7mtQY5obcboiEs/V9rF2Y5UiVBu
         Th0wk0gcC16TPiXhjwZz/ordcQUQxv+vu4n4N3pAHYNPb/D1MMfkGC5HdjbUWXvXj3AC
         2q1k43cBRcRQkeuLd3yZ2QCXA19vbZbtAejMmqWME73lG9zUo2YfquC/Uh5r1j7NQwLo
         DEaHGpEIzRlINDp8LVn9m3MiKrnIWL5uq2WPue8fo21MquQ5g7SHn12nX70+TzZfTVQJ
         +jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUxzGvRCkWdcKejoL+2aA4B96whZZp8toJDHjAK1AF0=;
        b=LlOzFQCiqjFrWqtqJBA7seCLCCMCOUOrbJDpRx+FF9zsrXgdbqk4OTZYtvMAeDT8Ky
         /rxDRGSQOjnEIukmKwnb3snApQ2GOoYYVCduseM2FqVS1q1UrLMAEdl6xHyWg9dX/0mo
         DSv3MMimxgfmlR/S7deUKbFZW6OxA4a1N6GS8Y55Zp2JSnJLN8vktU33nc347mKweMyP
         PkZVqi5eB7ZsFbcmAnskOzQCqnNHOi3x6Ql1zMulTFXkczFREYbHFGiKnEaQjI63Ky6U
         jxo96ldBdwJ9rNoARHBSGL0NhN/9IdEklUz3OL1vY5HmwfYe94Wd6WCbgva044ukAKFs
         gvIA==
X-Gm-Message-State: AGRZ1gJYOx0E8VZZDrnQyBeDxQFrW7qqx8B8vgwN1SUSLHDO3bS0ev6q
        0/kQAzO4oekN9rS6Qw5FBD0=
X-Google-Smtp-Source: AJdET5fYcEqtVlaUGOL4eiyD/ghgJk0kQWhBz0wb568D3kqHyDEmxmCpyjDDBwfzmXOeZ+Qa5SWgHA==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr95486lff.141.1542014245643;
        Mon, 12 Nov 2018 01:17:25 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m21sm2649185lfl.97.2018.11.12.01.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:17:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gM8LQ-0005BB-6Z; Mon, 12 Nov 2018 10:17:20 +0100
Date:   Mon, 12 Nov 2018 10:17:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dashi Cao <dscao999@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] Add support of TI ICDI to USB simple serial device
Message-ID: <20181112091720.GC13311@localhost>
References: <20181026113807.20735-1-dscao999@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026113807.20735-1-dscao999@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 07:38:07PM +0800, Dashi Cao wrote:
> TI In-Circuit Debug Interface (ICDI) is a debugging interface for TI ARM microcontrollers. It has four USB interfaces and the first two of them are presented as standard ACM serial device. The 3rd interface is the debugging interface and it can be driven as a Linux USB simple serial device. With it, debugging sessions and firmware up/down loading are supported on Linux.

Please break your lines at 72 column or so.

And use the common subject prefix (e.g. "USB: serial: add support
of TI ICD...").

> Signed-off-by: Dashi Cao <dscao999@gmail.com>

You never replied to Felipe's question whether you had verified that this
doesn't break OpenOCD?

> ---
>  drivers/usb/serial/usb-serial-simple.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> index 4d0273508043..ae43088b659e 100644
> --- a/drivers/usb/serial/usb-serial-simple.c
> +++ b/drivers/usb/serial/usb-serial-simple.c
> @@ -109,6 +109,11 @@ DEVICE(suunto, SUUNTO_IDS);
>  	{ USB_DEVICE(0x908, 0x0004) }
>  DEVICE(siemens_mpi, SIEMENS_IDS);
>  
> +/* TI In-Circuit Debug Interface */
> +#define ICDI_IDS()              \
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1cbe, 0x00fd, USB_CLASS_VENDOR_SPEC) }
> +DEVICE(ti_icdi, ICDI_IDS);

Please use a TI_ prefix for ICDI_IDS as well.

Can you post the lsusb -v output (or usb-devices) for the device for
reference?

> +
>  /* All of the above structures mushed into two lists */
>  static struct usb_serial_driver * const serial_drivers[] = {
>  	&carelink_device,
> @@ -124,6 +129,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  	&hp4x_device,
>  	&suunto_device,
>  	&siemens_mpi_device,
> +	&ti_icdi_device,
>  	NULL
>  };
>  
> @@ -141,6 +147,7 @@ static const struct usb_device_id id_table[] = {
>  	HP4X_IDS(),
>  	SUUNTO_IDS(),
>  	SIEMENS_IDS(),
> +	ICDI_IDS(),
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);

Thanks,
Johan
