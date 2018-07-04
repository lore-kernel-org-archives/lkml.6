Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69468C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F321244CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F321244CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeGDKAT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:00:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:51736 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932399AbeGDKAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:00:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 03:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="213347918"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 04 Jul 2018 03:00:12 -0700
Message-ID: <8d29c0ab0c3a6bc3e9bdf3d4bc54d47e7db8cc94.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] serial: 8250: let serial8250_get_divisor() get
 uart_port * as param
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 04 Jul 2018 13:00:11 +0300
In-Reply-To: <20180704170040.39ac9cf3@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
         <20180704170040.39ac9cf3@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 17:00 +0800, Jisheng Zhang wrote:
> Align serial8250_get_divisor() with serial8250_set_divisor() to accept
> uart_port pointer as the first parameter. No functionality changes.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index cf541aab2bd0..709fe6b4265c 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2498,11 +2498,11 @@ static unsigned int npcm_get_divisor(struct
> uart_8250_port *up,
>  	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
>  }
>  
> -static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
> +static unsigned int serial8250_get_divisor(struct uart_port *port,
>  					   unsigned int baud,
>  					   unsigned int *frac)
>  {
> -	struct uart_port *port = &up->port;
> +	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned int quot;
>  
>  	/*
> @@ -2636,7 +2636,7 @@ serial8250_do_set_termios(struct uart_port
> *port, struct ktermios *termios,
>  	cval = serial8250_compute_lcr(up, termios->c_cflag);
>  
>  	baud = serial8250_get_baud_rate(port, termios, old);
> -	quot = serial8250_get_divisor(up, baud, &frac);
> +	quot = serial8250_get_divisor(port, baud, &frac);
>  
>  	/*
>  	 * Ok, we're now changing the port state.  Do it with
> @@ -3197,7 +3197,7 @@ static void serial8250_console_restore(struct
> uart_8250_port *up)
>  		termios.c_cflag = port->state->port.tty-
> >termios.c_cflag;
>  
>  	baud = serial8250_get_baud_rate(port, &termios, NULL);
> -	quot = serial8250_get_divisor(up, baud, &frac);
> +	quot = serial8250_get_divisor(port, baud, &frac);
>  
>  	serial8250_set_divisor(port, baud, quot, frac);
>  	serial_port_out(port, UART_LCR, up->lcr);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
