Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E258FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CAF20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbNcDz2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CAF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeINTWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:22:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39414 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeINTWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:22:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so7634053lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KLrzCOBB9jHUG3Q5lt9iHmm4G1+487Ju81T8ERng+xM=;
        b=nbNcDz2TuFE0iJsIYIzB3+J/4l1d4b2aNmjoS3tWHS6TC6yul0gATpwqjRHQTcdXRv
         YUuIXwqe+eHheNSzYvpEaA5K5/ER9WRozFFkrKQIcnPB033ezam4PXcMvUDsdExv5Ug0
         B/8OYBW0BUjpA4EVmYGlmCNQ0KYYfjdzAYKER/tfW6L0LCZe0K2EECFefhYzfU6yZpt0
         btqaVyzn+Dat4x6iqgiWMCQjLgniIaXlp0fOryT/e9g89InGSDLS/QMwuUupO12jqZ2O
         0EofT3N7h6B6Euq7+RQkytyh70/RY7DutYueeq8m8ZUrkGiUvNMUUjaiG2r9uRtHF7jT
         Y8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLrzCOBB9jHUG3Q5lt9iHmm4G1+487Ju81T8ERng+xM=;
        b=KMVRmw16Mbs1N49VCREw8lbHSm0dOTY1BxSH1dPJGYkj56QuBL3tyhIbD9CO+nV533
         BIfgvrZPxC8t+aCPfL8BpAR66hTCVQCcxPBzvFoQxQmXqcHhUujVTyEXp17TslQAseXH
         QRBXaNauRFVdp5G4TzznkKK+CNzxvOSO75jraFl6RjqZPNl7UIwHjzcC2mYgh5s2vojy
         0TsgT6Y4CJoeN6hjeNwMtxU8XIStC6Q00E6KwUdOkDgI9xz5xZiPIQ412QkaDOKi3vHz
         97Bpp4Khvx+iThJSpUlPhPd1ORGg7dLeSBPO7cBRdZNE8J2lBG3FjSjyewnioRkxIuC0
         Z7ng==
X-Gm-Message-State: APzg51DMWFI6dfI0xk6kUvx47LSZJZKxYaCHzr1cI0xkYtygJltJvLsU
        T9PXbZ+MHOlvTeJa6kmEHHQ=
X-Google-Smtp-Source: ANB0VdaTcjXom/CrDbB2JofUjBXXKz0e9x4jyEaK6tjfLilKImoxVJuA2K28v+yADD82u1+ZYZ4GGQ==
X-Received: by 2002:a2e:9198:: with SMTP id f24-v6mr7662037ljg.64.1536934055975;
        Fri, 14 Sep 2018 07:07:35 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q22-v6sm1240044lff.10.2018.09.14.07.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:07:33 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oky-0005pp-7g; Fri, 14 Sep 2018 16:07:36 +0200
Date:   Fri, 14 Sep 2018 16:07:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/50] mos7840: switch to ->get_serial()
Message-ID: <20180914140736.GN1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-26-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-26-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:25AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/usb/serial/mos7840.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
> index b42bad85097a..8d0b80e44191 100644
> --- a/drivers/usb/serial/mos7840.c
> +++ b/drivers/usb/serial/mos7840.c
> @@ -1931,27 +1931,27 @@ static int mos7840_get_lsr_info(struct tty_struct *tty,
>   *      function to get information about serial port
>   *****************************************************************************/
>  
> -static int mos7840_get_serial_info(struct moschip_port *mos7840_port,
> -				   struct serial_struct __user *retinfo)
> +static int mos7840_get_serial_info(struct tty_struct *tty,
> +				   struct serial_struct *ss)
>  {
> -	struct serial_struct tmp;
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct moschip_port *mos7840_port;
>  
> -	if (mos7840_port == NULL)
> +	if (mos7840_port_paranoia_check(port, __func__))
>  		return -1;

This really isn't necessary either even if you're just mimicking the
current ioctl code.

>  
> -	memset(&tmp, 0, sizeof(tmp));
> -
> -	tmp.type = PORT_16550A;
> -	tmp.line = mos7840_port->port->minor;
> -	tmp.port = mos7840_port->port->port_number;
> -	tmp.irq = 0;
> -	tmp.xmit_fifo_size = NUM_URBS * URB_TRANSFER_BUFFER_SIZE;
> -	tmp.baud_base = 9600;
> -	tmp.close_delay = 5 * HZ;
> -	tmp.closing_wait = 30 * HZ;
> +	mos7840_port = mos7840_get_port_private(port);
> +	if (mos7840_port == NULL)
> +		return -1;

Same here.

> -	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
> -		return -EFAULT;
> +	ss->type = PORT_16550A;
> +	ss->line = mos7840_port->port->minor;
> +	ss->port = mos7840_port->port->port_number;
> +	ss->irq = 0;
> +	ss->xmit_fifo_size = NUM_URBS * URB_TRANSFER_BUFFER_SIZE;
> +	ss->baud_base = 9600;
> +	ss->close_delay = 5 * HZ;
> +	ss->closing_wait = 30 * HZ;
>  	return 0;
>  }

Reviewed-by: Johan Hovold <johan@kernel.org>
