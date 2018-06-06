Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF2B9601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeFFMCs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:02:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:7585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeFFMCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:02:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="230368535"
Message-ID: <e78531f74f7f885b0d8dae0c4f0de6d30399805d.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] serial: 8250: Make em485_rts_after_send() set mctrl
 according to rts state.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>, Sean Young <sean@mess.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Rafael Gago <rafael.gago@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Wed, 06 Jun 2018 15:02:42 +0300
In-Reply-To: <20180606094942.71190-2-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
         <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
         <20180606094942.71190-2-giulio.benetti@micronovasrl.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
> When rs485 enabled and RTS_AFTER_SEND set on startup, need to preserve
> mctrl status, because later functions will call set_mctrl passing
> port->mctrl=0 overriding rts status, resulting in rts pin in
> transmission when idle.
> 
> Make mctrl reflect rts pin state.
> 

This might make sense, I leave it to Matwey to Ack / NAK / etc.
But it also feels that patch 2/4 should be part of this change.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index 95833cbc4338..c8c10b5ec6d6 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -562,10 +562,13 @@ static inline void
> serial8250_em485_rts_after_send(struct uart_8250_port *p)
>  {
>  	unsigned char mcr = serial8250_in_MCR(p);
>  
> -	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
>  		mcr |= UART_MCR_RTS;
> -	else
> +		p->port.mctrl |= TIOCM_RTS;
> +	} else {
>  		mcr &= ~UART_MCR_RTS;
> +		p->port.mctrl &= ~TIOCM_RTS;
> +	}
>  	serial8250_out_MCR(p, mcr);
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
