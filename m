Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C667C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563F42083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pukU/fJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563F42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937442AbeFSJQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:16:03 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46022 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756382AbeFSJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:16:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id a13-v6so8910587lfk.12;
        Tue, 19 Jun 2018 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZzhhYtx/AxGE+eCWQ/rH02iOjnII9TU6FsFXviERoY=;
        b=pukU/fJAeaOQ4vN+SLvLBHs2PSZvPyfel8FNNK3WPUOuBTe0cJrATwBa4rzeo4HEmC
         yh1StQvw/0Ia6B+Lc7PO+w7uH+aO7Z4lCTCl/0fzcTsZCQPCQuKF5cdlKUedzNo4oKny
         pbcppdEhJRA4EH+li+kWYzEbig9rtXJZhiVmKWo6SEqf6krAxj4LMsadJJxJVaPKoB3V
         MzQgx8qQooRJPioco+8caB7EddmbEjhCfsrKTela/inAR5pSo+cIZq2PnKXctVjbCSDd
         4EiGDPkFu+hnGio5vg9aj8P8LE3pqHLThqgOuVsJ5SaA1+ErQm2nNEHXwUB8oGTAmx63
         b3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZzhhYtx/AxGE+eCWQ/rH02iOjnII9TU6FsFXviERoY=;
        b=gzIw5T1EEEq9cM+xDUm9roUrhy9IVYWXW1o5LnLaiQcqsNGMI0jkteLnkqc/EleA90
         cKjb0MDc1E1RpBRHZ4vu3C5/ASL+1ug8u1d8/oDBdiD/+fFYS1cg0tzqO5V96fzYyflh
         mXWGWcrvYkbXRmdjh072xWuXCplvqoNFTDzg2pqggoRexEyWKYbOYnDOhA7b4VR1ZIIk
         2P5G67NlOx80Nto1XHNT//GwAU5VIduPKIsWpQ6+85iblG1QWnLfoZvQgKOXVRyxefk4
         D0BpH3K8qEGC6DozX+VqVcgCpdNSIRtu6UbbwzHAz1P5QxFsvnGofxfLr3gC9sBmGeHg
         wfDw==
X-Gm-Message-State: APt69E1ZIPpCmjIoKUU2YRPuY3EV8q8ByY/kab8YrGx9zYnFiAEWfsnJ
        PbjoZmccJuIPTyNyxp+vImjfgsWS
X-Google-Smtp-Source: ADUXVKJ0t12n6SgpK+FtVYqNfMH8u1I3naf6+dLCI0aDj/HTk9y08C+zyVrY1+Cax8tJpYf2o1eIDQ==
X-Received: by 2002:a2e:6588:: with SMTP id e8-v6mr10257455ljf.50.1529399758617;
        Tue, 19 Jun 2018 02:15:58 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id q10-v6sm87095lfq.52.2018.06.19.02.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 02:15:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fVCjY-0005pv-MP; Tue, 19 Jun 2018 11:15:28 +0200
Date:   Tue, 19 Jun 2018 11:15:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Improve baudrate support for CP2102N
Message-ID: <20180619091528.GN32411@localhost>
References: <20180615212957.26539-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615212957.26539-1-pados@pados.hu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:29:57PM +0200, Karoly Pados wrote:
> The CP2102N supports more baudrates than earlier chips by SiLabs.
> This patch adds support for all rates documented in the datasheet
> of this device.
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
>  drivers/usb/serial/cp210x.c | 39 ++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index b1849f657e01..793b86252c46 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -357,6 +357,9 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  #define CP210X_PARTNUM_CP2104	0x04
>  #define CP210X_PARTNUM_CP2105	0x05
>  #define CP210X_PARTNUM_CP2108	0x08
> +#define CP210X_PARTNUM_CP2102N_QFN28	0x20
> +#define CP210X_PARTNUM_CP2102N_QFN24	0x21
> +#define CP210X_PARTNUM_CP2102N_QFN20	0x22
>  #define CP210X_PARTNUM_UNKNOWN	0xFF
>  
>  /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
> @@ -758,8 +761,12 @@ static int cp210x_get_line_ctl(struct usb_serial_port *port, u16 *ctl)
>  /*
>   * cp210x_quantise_baudrate
>   * Quantises the baud rate as per AN205 Table 1
> + * The CP2102N is fully (except for baud rate aliasing) software-
> + * compatible, but supports some additional baudrates. However, there is
> + * no quantitisation table available for this model, so in this case we
> + * take the supported baudrate which is closest to the requested one.
>   */
> -static unsigned int cp210x_quantise_baudrate(unsigned int baud)
> +static unsigned int cp210x_quantise_baudrate(unsigned int baud, bool cp2102n)

Pass in a struct usb_serial (or port) as a first argument instead which
allows for more readable code as well as for this to be reused to handle
other device type differences (e.g. only 2108 besides 2102n handles
baudrates over 921.6k).

>  {
>  	if (baud <= 300)
>  		baud = 300;
> @@ -790,10 +797,17 @@ static unsigned int cp210x_quantise_baudrate(unsigned int baud)
>  	else if (baud <= 491520)   baud = 460800;
>  	else if (baud <= 567138)   baud = 500000;
>  	else if (baud <= 670254)   baud = 576000;
> -	else if (baud < 1000000)
> -		baud = 921600;
> -	else if (baud > 2000000)
> -		baud = 2000000;
> +	else if (cp2102n) {

Add a static helper (looks like you add a define in the gpio patch)
cp210x_is_cp2102n(serial) here. You can even test for bit 0x20 in the
helper if you prefer (we can always change that later if needed).

> +		if (baud <= 960800)        baud = 921600;
> +		else if (baud <= 1100000)  baud = 1000000;
> +		else if (baud <= 1350000)  baud = 1200000;
> +		else if (baud <= 1750000)  baud = 1500000;
> +		else if (baud <= 2500000)  baud = 2000000;
> +		else                       baud = 3000000;

And even if the current code uses this odd formatting, your amendments
should not.

> +	} else {
> +		if (baud < 1000000)        baud = 921600;
> +		else if (baud > 2000000)   baud = 2000000;
> +	}
>  	return baud;
>  }
>  
> @@ -1045,16 +1059,19 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  static void cp210x_change_speed(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
> -	u32 baud;
> -
> -	baud = tty->termios.c_ospeed;
> +	bool is_cp2102n;
> +	u32 baud = tty->termios.c_ospeed;
> +	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
>  
> -	/* This maps the requested rate to a rate valid on cp2102 or cp2103,
> -	 * or to an arbitrary rate in [1M,2M].
> +	/* This maps the requested rate to a rate valid on cp2102(n) or
> +	 * cp2103 or to an arbitrary rate in [1M,2M].
>  	 *
>  	 * NOTE: B0 is not implemented.
>  	 */
> -	baud = cp210x_quantise_baudrate(baud);
> +	is_cp2102n =	(priv->partnum == CP210X_PARTNUM_CP2102N_QFN28) ||
> +			(priv->partnum == CP210X_PARTNUM_CP2102N_QFN24) ||
> +			(priv->partnum == CP210X_PARTNUM_CP2102N_QFN20);
> +	baud = cp210x_quantise_baudrate(baud, is_cp2102n);

So most of these changes would not be needed. Just pass in port->serial
to cp210x_quantise_baudrate().

Thanks,
Johan
