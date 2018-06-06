Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98BB660767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeFFMBM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:01:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:25822 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeFFMBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:01:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="61740375"
Message-ID: <ce3d52a202f39f9f342ceb70da24729bab538f11.camel@linux.intel.com>
Subject: Re: [PATCH 2/4] serial: 8250: Copy mctrl when register port.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Wed, 06 Jun 2018 15:01:05 +0300
In-Reply-To: <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
         <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
> RS485 can modify mctrl on startup, especially when RTS_AFTER_SEND is
> on
> TIOCM_RTS is set, then need to keep it set when registering port.
> 
> Copy mctrl to new port too.
> 

Not sure if it would be useful.
Seems the only em485 user, i.e. OMAP, does survive without that.

Moreover, often individual drivers override ->set_mctrl() callback.

So, real example is needed to explain why.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c
> b/drivers/tty/serial/8250/8250_core.c
> index c8c2b260c681..c8e62fbd6570 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -993,6 +993,7 @@ int serial8250_register_8250_port(struct
> uart_8250_port *up)
>  		uart->port.unthrottle	= up->port.unthrottle;
>  		uart->port.rs485_config	= up-
> >port.rs485_config;
>  		uart->port.rs485	= up->port.rs485;
> +		uart->port.mctrl	= up->port.mctrl;
>  		uart->dma		= up->dma;
>  		uart->em485		= up->em485;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
