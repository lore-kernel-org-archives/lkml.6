Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B12C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F5720665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dK38a88z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeK1LTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:19:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43204 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1LTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:19:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so16445336plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=NHbSv6uT60CLENDAoNqJwNosmxG9BQF9K4orEElZrQw=;
        b=dK38a88zD71ixFYKRpIFgEA8hp50b9TsjiSzPOSfJs9T01eTJdzcqmhfhDAUc6V9FU
         0uCtpMp8UdcFpIZhahvJUDUS0rL6pO95sNRu5qchxDaELlaktdOboYklTaA6yraqn3eP
         Kz97N/FarSrASSSIBZYI/lURNSALrP7z+c1pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=NHbSv6uT60CLENDAoNqJwNosmxG9BQF9K4orEElZrQw=;
        b=fB0lYpqCRSVT9sJ0JdHew+QyVh29RiCa+siSiakpRIHSaAw7W+3OtO9ZrPLOUtw+t8
         g1Upr0jGGKE62NJ+2Ad7yIUwrKD9mXZN1Ra68E4Esi9hB7z1xZUTir9w4EB3zQD3bI7F
         kLD0BoXwKBcSqnVQRhMd2B4I0epeJ6rQydaGnjdIKLII/AvIjPheHlhlbSQRlakx42ZO
         fkWhvgHs3rxsv6zuSvt8TFw17SAAyRn14pJrITJ+ps+/BNsUno9JP0gToKMca5nDbdKI
         eMw/kuylwEjiyPM0IeOf6hfksB0/AdcOWgw4+RhyhprCpWvqudevrd154+G8oBeVT7Rd
         P6hQ==
X-Gm-Message-State: AA+aEWb8mKwBvxixYkdM8OsBuEAch+YjA40IW+g9F4hsI8GV/LVk8WsS
        Ter3E6wefrqWz0mpbRR6OujaqQ==
X-Google-Smtp-Source: AFSGD/UCsLUK7ZJ2L8E8ZXdVqlYSZmVi0AsV2P7nOZ6CU4jdfwFzEAaC15Sbl80P4IRNWIUjLZziAQ==
X-Received: by 2002:a17:902:b903:: with SMTP id bf3mr34005730plb.289.1543364410097;
        Tue, 27 Nov 2018 16:20:10 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 125sm1188870pfg.39.2018.11.27.16.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 16:20:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181127022536.104663-1-ryandcase@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Ryan Case <ryandcase@chromium.org>
References: <20181127022536.104663-1-ryandcase@chromium.org>
Message-ID: <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
Date:   Tue, 27 Nov 2018 16:20:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-11-26 18:25:36)
> Transfers were being divided into device FIFO sized (64 byte max)
> operations which would poll for completion within a spin_lock_irqsave /
> spin_unlock_irqrestore block. This both made things slow by waiting for
> the FIFO to completely drain before adding further data and would also
> result in softlocks on large transmissions.
> =

> This patch allows larger transfers with continuous FIFO additions as
> space becomes available and removes polling from the interrupt handler.
> =

> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> Version: 1

I've never seen a Version tag before. Did you manually add this?

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 7ded51081add..835a184e0b7d 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -117,6 +117,8 @@ struct qcom_geni_serial_port {
>         u32 *rx_fifo;
>         u32 loopback;
>         bool brk;
> +
> +       u32 cur_tx_remaining;

Nitpick: Can it just be tx_remaining? And why u32? Why not unsigned int?

>  };
>  =

>  static const struct uart_ops qcom_geni_console_pops;
> @@ -439,6 +441,7 @@ static void qcom_geni_serial_console_write(struct con=
sole *co, const char *s,
>         struct qcom_geni_serial_port *port;
>         bool locked =3D true;
>         unsigned long flags;
> +       unsigned int geni_status;

Nitpick: Use u32 for register reads.

>  =

>         WARN_ON(co->index < 0 || co->index >=3D GENI_UART_CONS_PORTS);
>  =

> @@ -465,9 +470,17 @@ static void qcom_geni_serial_console_write(struct co=
nsole *co, const char *s,
>                 }
>                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLE=
AR);
> -       }
> +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->cur_tx_rem=
aining)
> +               /* It seems we can interrupt existing transfers unless al=
l data

Nitpick: Have /* on a line by itself

Is this comment supposed to say "we can't interrupt existing transfers"?

> +                * has been sent, in which case we need to look for done =
first.
> +                */
> +               qcom_geni_serial_poll_tx_done(uport);

Another nitpick: Please put braces around multi-line if branches for
greater code clarity.

>  =

>         __qcom_geni_serial_console_write(uport, s, count);
> +
> +       if (port->cur_tx_remaining)
> +               qcom_geni_serial_setup_tx(uport, port->cur_tx_remaining);

Does this happen? Is the console being used as a tty at the same time?

> +
>         if (locked)
>                 spin_unlock_irqrestore(&uport->lock, flags);
>  }
> @@ -701,40 +714,47 @@ static void qcom_geni_serial_handle_rx(struct uart_=
port *uport, bool drop)
>         port->handle_rx(uport, total_bytes, drop);
>  }
>  =

> -static void qcom_geni_serial_handle_tx(struct uart_port *uport)
> +static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool don=
e,
> +               bool active)
>  {
>         struct qcom_geni_serial_port *port =3D to_dev_port(uport, uport);
>         struct circ_buf *xmit =3D &uport->state->xmit;
>         size_t avail;
>         size_t remaining;
> +       size_t pending;
>         int i;
>         u32 status;
>         unsigned int chunk;
>         int tail;
> -       u32 irq_en;
>  =

> -       chunk =3D uart_circ_chars_pending(xmit);
>         status =3D readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
> -       /* Both FIFO and framework buffer are drained */
> -       if (!chunk && !status) {
> +
> +       /* Complete the current tx command before taking newly added data=
 */
> +       if (active)
> +               pending =3D port->cur_tx_remaining;
> +       else
> +               pending =3D uart_circ_chars_pending(xmit);
> +
> +       /* All data has been transmitted and acknowledged as received */
> +       if (!pending && !status && done) {

Nitpick: status is a poor variable name to test here. I don't understand
what this line is doing. Maybe it would help to have another local
variable like 'needs_attention'?

>                 qcom_geni_serial_stop_tx(uport);
>                 goto out_write_wakeup;
>         }
>  =

> -       if (!uart_console(uport)) {
> -               irq_en =3D readl_relaxed(uport->membase + SE_GENI_M_IRQ_E=
N);
> -               irq_en &=3D ~(M_TX_FIFO_WATERMARK_EN);
> -               writel_relaxed(0, uport->membase + SE_GENI_TX_WATERMARK_R=
EG);
> -               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       }
> +       avail =3D port->tx_fifo_depth - (status & TX_FIFO_WC);
> +       avail *=3D port->tx_bytes_pw;
> +       if (avail < 0)
> +               avail =3D 0;

How can 'avail' be less than 0? It's size_t which is unsigned? If
underflow is happening from that subtraction or overflow from the
multiply that could be bad but I hope that is impossible.

>  =

> -       avail =3D (port->tx_fifo_depth - port->tx_wm) * port->tx_bytes_pw;
>         tail =3D xmit->tail;
> -       chunk =3D min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail), av=
ail);
> +       chunk =3D min3((size_t)pending, (size_t)(UART_XMIT_SIZE - tail), =
avail);

Nitpick: If we made 'avail' unsigned int would we be able to drop the
casts on this min3() call? This line is quite hard to read.

>         if (!chunk)
>                 goto out_write_wakeup;
>  =

> -       qcom_geni_serial_setup_tx(uport, chunk);
> +       if (!port->cur_tx_remaining) {
> +               qcom_geni_serial_setup_tx(uport, pending);
> +               port->cur_tx_remaining =3D pending;
> +       }
>  =

>         remaining =3D chunk;
>         for (i =3D 0; i < chunk; ) {
> @@ -767,6 +786,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void=
 *dev)
>  {
>         unsigned int m_irq_status;
>         unsigned int s_irq_status;
> +       unsigned int geni_status;

Nitpick: I guess this driver isn't using u32 for registers already.
Would be nice to mop this up in another patch.

>         struct uart_port *uport =3D dev;
>         unsigned long flags;
>         unsigned int m_irq_en;
>=20
