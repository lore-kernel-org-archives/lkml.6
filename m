Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE292C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q/vH3oaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0A82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeK1MYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:24:43 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37291 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeK1MYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:24:43 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so1757822iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 17:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrYZpIjfJ0dF0rQ5MnZA/6U9z+XGfUm+2P/kzbGeD3A=;
        b=Q/vH3oaP47H0RxERJrfjnQ40vxqbigC6s3Dn3J9NEXMuo/r9BFJOk5wKxtDHiQQewG
         EG1jkkEv9HWpAsrQgi50NsXLZnY77Y8MuOm43mx63jfprrzczSyJVQKF2HlKxXg/dnTn
         B7JeYeE2TEgMgGb6x98mDMO8fyPV1h/Q58lQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrYZpIjfJ0dF0rQ5MnZA/6U9z+XGfUm+2P/kzbGeD3A=;
        b=C45fdbtcUmNpLJSEcRa721Ax13NE4puljHjCgGDBTslcK2zbmTQ8Pr22TQfqQamUas
         dJba4JPe61YHnuVvQDzOrLkeY4QIDNnqoShSBA6SczDWTeNVyYp/Mi7IbqL7LMdoZs//
         iuEYCyzx7XcFOrN3RF2DUb+QUun+Za8BJ310z5tvORu9P+kVgfududSPOs6WlQChTkYH
         kRIlPWRwbKy5EacpexU2tgHS2qQBwYQGIIZKC9sPXAerZBxpX9jegG791dY3m7V/5P87
         TQ4FflqwnZyk9+9hS1sNByYpyJXS6TyELsJq2OrLEOlWEIK3Tw/d3/OQZs4E0FJN3yKy
         ZRNA==
X-Gm-Message-State: AA+aEWbgDbtav8L1Jk9h+Hexu2Ml4akqHtx4WhFvukqh0W4w0JZu8/8n
        DLmsGuD2ia8uJSeC3betbbCXUJ5QlreNcsqsJPtoNA==
X-Google-Smtp-Source: AFSGD/XRZCX6030pUZv+RvHJO39BsUZ8xHD49k1wmRp43fUakW/SzCgZ0ldwITOMc70cqy54pM08B96Yz70hlVpF634=
X-Received: by 2002:a24:a507:: with SMTP id k7mr1163511itf.98.1543368295463;
 Tue, 27 Nov 2018 17:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20181127022536.104663-1-ryandcase@chromium.org> <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
In-Reply-To: <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Tue, 27 Nov 2018 17:24:44 -0800
Message-ID: <CACjz--n6eXtT6-CDhVEStSD_59yJ-fdmfHzo9SH_da5ZzL_mDw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 4:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ryan Case (2018-11-26 18:25:36)
> > Transfers were being divided into device FIFO sized (64 byte max)
> > operations which would poll for completion within a spin_lock_irqsave /
> > spin_unlock_irqrestore block. This both made things slow by waiting for
> > the FIFO to completely drain before adding further data and would also
> > result in softlocks on large transmissions.
> >
> > This patch allows larger transfers with continuous FIFO additions as
> > space becomes available and removes polling from the interrupt handler.
> >
> > Signed-off-by: Ryan Case <ryandcase@chromium.org>
> > Version: 1
>
> I've never seen a Version tag before. Did you manually add this?

I submitted with patman, this should have been Series-version:

>
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 7ded51081add..835a184e0b7d 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -117,6 +117,8 @@ struct qcom_geni_serial_port {
> >         u32 *rx_fifo;
> >         u32 loopback;
> >         bool brk;
> > +
> > +       u32 cur_tx_remaining;
>
> Nitpick: Can it just be tx_remaining? And why u32? Why not unsigned int?

Sure, and unsigned int is fine.

>
> >  };
> >
> >  static const struct uart_ops qcom_geni_console_pops;
> > @@ -439,6 +441,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >         struct qcom_geni_serial_port *port;
> >         bool locked = true;
> >         unsigned long flags;
> > +       unsigned int geni_status;
>
> Nitpick: Use u32 for register reads.

will do.

>
> >
> >         WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
> >
> > @@ -465,9 +470,17 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >                 }
> >                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
> >                                                         SE_GENI_M_IRQ_CLEAR);
> > -       }
> > +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->cur_tx_remaining)
> > +               /* It seems we can interrupt existing transfers unless all data
>
> Nitpick: Have /* on a line by itself
>
> Is this comment supposed to say "we can't interrupt existing transfers"?

Nope, comment is correct as is.

>
> > +                * has been sent, in which case we need to look for done first.
> > +                */
> > +               qcom_geni_serial_poll_tx_done(uport);
>
> Another nitpick: Please put braces around multi-line if branches for
> greater code clarity.

will do.

>
> >
> >         __qcom_geni_serial_console_write(uport, s, count);
> > +
> > +       if (port->cur_tx_remaining)
> > +               qcom_geni_serial_setup_tx(uport, port->cur_tx_remaining);
>
> Does this happen? Is the console being used as a tty at the same time?

Yup, happens quite a bit.

>
> > +
> >         if (locked)
> >                 spin_unlock_irqrestore(&uport->lock, flags);
> >  }
> > @@ -701,40 +714,47 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
> >         port->handle_rx(uport, total_bytes, drop);
> >  }
> >
> > -static void qcom_geni_serial_handle_tx(struct uart_port *uport)
> > +static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
> > +               bool active)
> >  {
> >         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> >         struct circ_buf *xmit = &uport->state->xmit;
> >         size_t avail;
> >         size_t remaining;
> > +       size_t pending;
> >         int i;
> >         u32 status;
> >         unsigned int chunk;
> >         int tail;
> > -       u32 irq_en;
> >
> > -       chunk = uart_circ_chars_pending(xmit);
> >         status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
> > -       /* Both FIFO and framework buffer are drained */
> > -       if (!chunk && !status) {
> > +
> > +       /* Complete the current tx command before taking newly added data */
> > +       if (active)
> > +               pending = port->cur_tx_remaining;
> > +       else
> > +               pending = uart_circ_chars_pending(xmit);
> > +
> > +       /* All data has been transmitted and acknowledged as received */
> > +       if (!pending && !status && done) {
>
> Nitpick: status is a poor variable name to test here. I don't understand
> what this line is doing. Maybe it would help to have another local
> variable like 'needs_attention'?

It could be renamed but since this isn't a general file cleanup patch
I was avoiding non-functional changes. It is the TX_FIFO_STATUS
register, if non-zero there is still data in the FIFO or related
activity ongoing.

>
> >                 qcom_geni_serial_stop_tx(uport);
> >                 goto out_write_wakeup;
> >         }
> >
> > -       if (!uart_console(uport)) {
> > -               irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
> > -               irq_en &= ~(M_TX_FIFO_WATERMARK_EN);
> > -               writel_relaxed(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
> > -               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> > -       }
> > +       avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
> > +       avail *= port->tx_bytes_pw;
> > +       if (avail < 0)
> > +               avail = 0;
>
> How can 'avail' be less than 0? It's size_t which is unsigned? If
> underflow is happening from that subtraction or overflow from the
> multiply that could be bad but I hope that is impossible.

I hope underflow is impossible as well. However, if the hardware did
wind up in a strange state I wanted to err on the side of not throwing
away data and being able to resume later if things recovered. I can
remove the defensive checks if that's the custom, otherwise I'll
update the comparison logic accordingly.

>
> >
> > -       avail = (port->tx_fifo_depth - port->tx_wm) * port->tx_bytes_pw;
> >         tail = xmit->tail;
> > -       chunk = min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail), avail);
> > +       chunk = min3((size_t)pending, (size_t)(UART_XMIT_SIZE - tail), avail);
>
> Nitpick: If we made 'avail' unsigned int would we be able to drop the
> casts on this min3() call? This line is quite hard to read.

Seems they can go away without any changes.

>
> >         if (!chunk)
> >                 goto out_write_wakeup;
> >
> > -       qcom_geni_serial_setup_tx(uport, chunk);
> > +       if (!port->cur_tx_remaining) {
> > +               qcom_geni_serial_setup_tx(uport, pending);
> > +               port->cur_tx_remaining = pending;
> > +       }
> >
> >         remaining = chunk;
> >         for (i = 0; i < chunk; ) {
> > @@ -767,6 +786,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
> >  {
> >         unsigned int m_irq_status;
> >         unsigned int s_irq_status;
> > +       unsigned int geni_status;
>
> Nitpick: I guess this driver isn't using u32 for registers already.
> Would be nice to mop this up in another patch.
>
> >         struct uart_port *uport = dev;
> >         unsigned long flags;
> >         unsigned int m_irq_en;
> >
