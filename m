Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E1320817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQRiAjGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E1320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeK1C0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:26:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40771 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeK1C0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:26:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so8022481pgp.7;
        Tue, 27 Nov 2018 07:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+GArsCKof7FWZRpm0G5/ReU2W8kPgmB3GMustsyMlJg=;
        b=QQRiAjGtOz32sjZCXXLmivGTomCNtG0xntJNugRk3RPgm+q/flTwh9dStWgysiykbm
         hfPU4mHzuxm3nJmCkV8omPg+K/8XX8yUBYQ7l8M6+7fbEJI7m2ANmBaDF01cqbfVCyWa
         2k203fwqKT3BUp5iEXRxYYddUT7k3WkofXbLgNG0Nur891f/ITKWsA7EFFOc3NWFTcVi
         Bkv+cBvpekts5N1NlGp3Mn4HkP+uWomSOd36xFS9DWczC2DXNuKJtVJiYcX1I/bX257A
         aEdTQvtMdC/FTXDc1QFLbbfZnJdQToQTVNHRIuMRy2X4n+EU4MXxGySBL+Cx45EfmQtP
         ZlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+GArsCKof7FWZRpm0G5/ReU2W8kPgmB3GMustsyMlJg=;
        b=BRTep3jb0Th0uvDc6vOAudCg4OkFsi/rf0SrSFgDixMmUVkrQgjQ5LuySLEXfPuD0U
         j5ZOc20kmlW3cDVAjiV03lWEW7hXRW5VaurR/kPH6S6WerPKPHKJQgkrvKNfIePPAK1a
         LuZRVe+Nq3GN6scRMZcntp2ModTxk0S0mZ5M2zCZGH48FAXwArVk6z4GEo7CUag8BD5a
         AtKrR55v/J+9Wb8wqZ5i/MeVGfRjwycsg3hk0HDc4zZRXZBb367ckwIAEM6KdXprr9Pt
         gSDvskR5fYg6rBW/JE8OwiZOJcMo/cGpGp7RTDHaZF6wsZilIcP5Z63GZ01X47uwkjC4
         z3qw==
X-Gm-Message-State: AA+aEWakpfQaK4k8PYgPzaEd2LlLHeis2EIWPjbqvOcTWR3jiwtX+EBm
        lG1//SIRgQj3PzzWP4+iFrSoqA93oiI=
X-Google-Smtp-Source: AFSGD/Vnl6nmsvulSj2eSfqiGwDkrjq2d2F3wAh8hQJFw5Fq39ImknEtWutE7hq3hxdG/3421MEMRQ==
X-Received: by 2002:a63:441e:: with SMTP id r30mr30022967pga.128.1543332469988;
        Tue, 27 Nov 2018 07:27:49 -0800 (PST)
Received: from pi ([12.219.193.5])
        by smtp.gmail.com with ESMTPSA id 8sm5965966pfr.55.2018.11.27.07.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 07:27:49 -0800 (PST)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.91)
        (envelope-from <johan@pi>)
        id 1gRfG4-0003GS-8M; Tue, 27 Nov 2018 07:26:40 -0800
Date:   Tue, 27 Nov 2018 07:26:40 -0800
From:   Johan Hovold <johan@kernel.org>
To:     JackyChou <jackychou@asix.com.tw>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        louis@asix.com.tw
Subject: Re: [PATCHv3] USB: serial: mos7840: Add a product ID for the new
 product
Message-ID: <20181127152640.GT2403@localhost>
References: <000a01d48239$68dda550$3a98eff0$@asix.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01d48239$68dda550$3a98eff0$@asix.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:00:17PM +0800, JackyChou wrote:
> 
> From: JackyChou <jackychou@asix.com.tw>

Thanks for the update. This patch appears to have been corrupted (tabs
replaced with spaces) so it cannot be applied. Try sending the patch to
yourself first and make sure you can apply it with git am (and/or run
checkpatch on the result).

> For now, pause to add PID 0x7843 in the driver.

This doesn't belong in the commit message. But there's no reason not to
include the patch adding the PID in the same series. Just send a
two-part series with this patch as the first patch, and the PID one as
the second patch (depending on the first).

Take a look at git-format-patch and git-send-email which can simply the
process.

Also make sure each commit message is self-contained, and that the patch
summary (Subject) reflects what each patch does.
 
> Simplify the processes of some functions.

Please be a bit more specific.

> Such modifications will not affect the old devices and will make
> the addition of new product (0x7843) more flexible in the future.

This can still stay here.

> Signed-off-by: JackyChou <jackychou@asix.com.tw>
> ---
>  drivers/usb/serial/mos7840.c | 48 ++++++++++++------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
> index b42bad85097a..0ca945dce377 100644
> --- a/drivers/usb/serial/mos7840.c
> +++ b/drivers/usb/serial/mos7840.c
> @@ -298,15 +298,10 @@ static int mos7840_set_uart_reg(struct usb_serial_port
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

Perhaps this would be more readable if you used a port offset here as
well, and only make sure to map the second port in the two-port case to
port offset three.

Thanks,
Johan
