Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F39BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF49C2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF49C2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933427AbeGJN4d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:56:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:55191 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933255AbeGJN4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:56:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 06:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="scan'208";a="55780622"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 10 Jul 2018 06:56:28 -0700
Message-ID: <ee2443ab6b413e9d7f0148e8916b0bd0d4924375.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/3] serial: 8250: export serial8250_do_set_divisor()
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Tue, 10 Jul 2018 16:56:28 +0300
In-Reply-To: <20180710111327.072584c0@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
         <20180710111327.072584c0@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 11:13 +0800, Jisheng Zhang wrote:
> Some drivers could call serial8250_do_set_divisor() to complete its
> own set_divisor routine. Export this symbol for code reusing.
> 

I dunno Greg's preferences here, but it could be merged with patch 1.

In any case,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for this part.

> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 5 +++--
>  include/linux/serial_8250.h         | 3 +++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index ce0dc17f18ee..945f8dc2d50f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2580,8 +2580,8 @@ static unsigned char
> serial8250_compute_lcr(struct uart_8250_port *up,
>  	return cval;
>  }
>  
> -static void serial8250_do_set_divisor(struct uart_port *port,
> unsigned int baud,
> -			    unsigned int quot, unsigned int
> quot_frac)
> +void serial8250_do_set_divisor(struct uart_port *port, unsigned int
> baud,
> +			       unsigned int quot, unsigned int
> quot_frac)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  
> @@ -2612,6 +2612,7 @@ static void serial8250_do_set_divisor(struct
> uart_port *port, unsigned int baud,
>  		serial_port_out(port, 0x2, quot_frac);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(serial8250_do_set_divisor);
>  
>  static void serial8250_set_divisor(struct uart_port *port, unsigned
> int baud,
>  				   unsigned int quot, unsigned int
> quot_frac)
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 76b9db71e489..18e21427bce4 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -160,6 +160,9 @@ extern void serial8250_do_shutdown(struct
> uart_port *port);
>  extern void serial8250_do_pm(struct uart_port *port, unsigned int
> state,
>  			     unsigned int oldstate);
>  extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned
> int mctrl);
> +extern void serial8250_do_set_divisor(struct uart_port *port,
> unsigned int baud,
> +				      unsigned int quot,
> +				      unsigned int quot_frac);
>  extern int fsl8250_handle_irq(struct uart_port *port);
>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
>  unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned
> char lsr);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
