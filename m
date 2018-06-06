Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVENQxzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6CC3605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeFFQvv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:51:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36209 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeFFQvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:51:48 -0400
X-Google-Smtp-Source: ADUXVKLV8RG9oQdJcP1sHcXFcYqhFtoe/Er4DY403dVi740ANYAomuOHHz2ylkP45CPIEp8BYXet5g9QdSPtuaIBgYo=
MIME-Version: 1.0
In-Reply-To: <20180606095156.72628-4-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606095156.72628-1-giulio.benetti@micronovasrl.com> <20180606095156.72628-4-giulio.benetti@micronovasrl.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Jun 2018 19:51:46 +0300
Message-ID: <CAHp75VfgYmX5WiG5HpN7hLiW1CfhDYV2gya58OGYyBQwVGTY2A@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: 8250_dw: add em485 support
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ed Blake <ed.blake@sondrel.com>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 12:51 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> Need to use rs485 transceiver so let's use existing em485 485 emulation
> layer on top of 8250.
>
> Add rs485_config callback to port.

Besides the fact the series lacks of cover letter, I think it should
be postponed until we get a clear understanding how RS485 is supposed
to be initialized and what exact problems you are trying to address.

>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 6fcdb90f616a..45366e6e5411 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -314,6 +314,36 @@ static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
>         serial8250_do_set_ldisc(p, termios);
>  }
>
> +static int dw8250_rs485_config(struct uart_port *p,
> +                              struct serial_rs485 *rs485)
> +{
> +       struct uart_8250_port *up = up_to_u8250p(p);
> +
> +       /* Clamp the delays to [0, 100ms] */
> +       rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
> +       rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
> +
> +       p->rs485 = *rs485;
> +
> +       /*
> +        * Both serial8250_em485_init and serial8250_em485_destroy
> +        * are idempotent
> +        */
> +       if (rs485->flags & SER_RS485_ENABLED) {
> +               int ret = serial8250_em485_init(up);
> +
> +               if (ret) {
> +                       rs485->flags &= ~SER_RS485_ENABLED;
> +                       p->rs485.flags &= ~SER_RS485_ENABLED;
> +               }
> +               return ret;
> +       }
> +
> +       serial8250_em485_destroy(up);
> +
> +       return 0;
> +}
> +
>  /*
>   * dw8250_fallback_dma_filter will prevent the UART from getting just any free
>   * channel on platforms that have DMA engines, but don't have any channels
> @@ -449,6 +479,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         p->serial_out   = dw8250_serial_out;
>         p->set_ldisc    = dw8250_set_ldisc;
>         p->set_termios  = dw8250_set_termios;
> +       p->rs485_config = dw8250_rs485_config;
>
>         p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
>         if (!p->membase)
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
