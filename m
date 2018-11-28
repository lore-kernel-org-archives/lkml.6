Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6828C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C2720851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+cYqftv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C2720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeK1NEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:04:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44947 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeK1NEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:04:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so9348674pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 18:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=AbH+FYzoIRbXx2BNyctyObI8XbY0kxw355SDW4Ev9IA=;
        b=A+cYqftvoeQyasjPOxr6hLNnErGbIVw+QpDldpETOyZyC4LL1vjDNZf6HftsVwQNP8
         7n0slAaozOYq2lRdbFm/puIdMGFK35MlYDj1cwYL2V6UQC6DbZkz4QnE+cQuhzFRGCVs
         Mn1TekgA+p7lfL1Fzzo+tSGxEgnX/VDSB76SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=AbH+FYzoIRbXx2BNyctyObI8XbY0kxw355SDW4Ev9IA=;
        b=VaJ1QkaIA7Pak1L8Psx7w7OIGTkz2qkMrz9nCbFAWPCSAhaadcPV2iaO1tl/bInIBr
         jlyuWqBEis1c732EQWIJWjQunVkVodH7fITbwRI1Qv2KVU2axbg3OIEzh6uHwHQt8PrW
         a7aGM9Gq8tH/0/iYUq7ORLRWAGMJrSanSkYbk3rSOWvWau8cB3wfSGREFMRGiQmQB6/e
         dWYS91RDPvKK3C8CuYidfwGRVDg7QH+1NH5XtxmIEXWIB4gm6Smjb13vj9yPHTm2JMS5
         9Hm+94z1F65RL3B3Ewfq85v91uj+nntF32xWxgo57SqNj+qQw0QZtdOk4HLGlrDHSZtX
         WoFg==
X-Gm-Message-State: AA+aEWaNDuSi4HMsRF7X7/poOJSefYzlAPy5SPdbrnKtQUUfLbAboIlf
        0HZwriA94HQ12pCUYZMmEV7NGw==
X-Google-Smtp-Source: AFSGD/UNUu7zODu5KTPXaod5L1Xz4H5CkgRkqJTdvdEpIA7nEKzQQ682W9ib6GNjAwibpFr2vvpabA==
X-Received: by 2002:a62:3ac1:: with SMTP id v62mr31134681pfj.87.1543370690585;
        Tue, 27 Nov 2018 18:04:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id i4sm6988508pfj.82.2018.11.27.18.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 18:04:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CACjz--n6eXtT6-CDhVEStSD_59yJ-fdmfHzo9SH_da5ZzL_mDw@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20181127022536.104663-1-ryandcase@chromium.org>
 <154336440880.88331.11610393939844825622@swboyd.mtv.corp.google.com>
 <CACjz--n6eXtT6-CDhVEStSD_59yJ-fdmfHzo9SH_da5ZzL_mDw@mail.gmail.com>
Message-ID: <154337068886.88331.5708018437286125025@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
Date:   Tue, 27 Nov 2018 18:04:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-11-27 17:24:44)
> On Tue, Nov 27, 2018 at 4:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Ryan Case (2018-11-26 18:25:36)
> > > Transfers were being divided into device FIFO sized (64 byte max)
> > > operations which would poll for completion within a spin_lock_irqsave=
 /
> > > spin_unlock_irqrestore block. This both made things slow by waiting f=
or
> > > the FIFO to completely drain before adding further data and would also
> > > result in softlocks on large transmissions.
> > >
> > > This patch allows larger transfers with continuous FIFO additions as
> > > space becomes available and removes polling from the interrupt handle=
r.
> > >
> > > Signed-off-by: Ryan Case <ryandcase@chromium.org>
> > > Version: 1
> >
> > I've never seen a Version tag before. Did you manually add this?
> =

> I submitted with patman, this should have been Series-version:

Hmm ok. I'm not aware of this being a kernel idiom so I would remove
this tag before sending.

> =

> >
> > >
> > >         WARN_ON(co->index < 0 || co->index >=3D GENI_UART_CONS_PORTS);
> > >
> > > @@ -465,9 +470,17 @@ static void qcom_geni_serial_console_write(struc=
t console *co, const char *s,
> > >                 }
> > >                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
> > >                                                         SE_GENI_M_IRQ=
_CLEAR);
> > > -       }
> > > +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->cur_tx=
_remaining)
> > > +               /* It seems we can interrupt existing transfers unles=
s all data
> >
> > Nitpick: Have /* on a line by itself
> >
> > Is this comment supposed to say "we can't interrupt existing transfers"?
> =

> Nope, comment is correct as is.

Ok. I fail at parsing it then. Perhaps

"It seems we can interrupt existing transfers except for when all data
has been sent"

would make it easier for me to read.

> =

> >
> > >
> > >         __qcom_geni_serial_console_write(uport, s, count);
> > > +
> > > +       if (port->cur_tx_remaining)
> > > +               qcom_geni_serial_setup_tx(uport, port->cur_tx_remaini=
ng);
> >
> > Does this happen? Is the console being used as a tty at the same time?
> =

> Yup, happens quite a bit.

So its being used in both modes at the same time?

> =

> >
> > > +
> > >         if (locked)
> > >                 spin_unlock_irqrestore(&uport->lock, flags);
> > >  }
> > > @@ -701,40 +714,47 @@ static void qcom_geni_serial_handle_rx(struct u=
art_port *uport, bool drop)
> > >         port->handle_rx(uport, total_bytes, drop);
> > >  }
> > >
> > > -static void qcom_geni_serial_handle_tx(struct uart_port *uport)
> > > +static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool=
 done,
> > > +               bool active)
> > >  {
> > >         struct qcom_geni_serial_port *port =3D to_dev_port(uport, upo=
rt);
> > >         struct circ_buf *xmit =3D &uport->state->xmit;
> > >         size_t avail;
> > >         size_t remaining;
> > > +       size_t pending;
> > >         int i;
> > >         u32 status;
> > >         unsigned int chunk;
> > >         int tail;
> > > -       u32 irq_en;
> > >
> > > -       chunk =3D uart_circ_chars_pending(xmit);
> > >         status =3D readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STA=
TUS);
> > > -       /* Both FIFO and framework buffer are drained */
> > > -       if (!chunk && !status) {
> > > +
> > > +       /* Complete the current tx command before taking newly added =
data */
> > > +       if (active)
> > > +               pending =3D port->cur_tx_remaining;
> > > +       else
> > > +               pending =3D uart_circ_chars_pending(xmit);
> > > +
> > > +       /* All data has been transmitted and acknowledged as received=
 */
> > > +       if (!pending && !status && done) {
> >
> > Nitpick: status is a poor variable name to test here. I don't understand
> > what this line is doing. Maybe it would help to have another local
> > variable like 'needs_attention'?
> =

> It could be renamed but since this isn't a general file cleanup patch
> I was avoiding non-functional changes. It is the TX_FIFO_STATUS
> register, if non-zero there is still data in the FIFO or related
> activity ongoing.

Ok.

> =

> >
> > >                 qcom_geni_serial_stop_tx(uport);
> > >                 goto out_write_wakeup;
> > >         }
> > >
> > > -       if (!uart_console(uport)) {
> > > -               irq_en =3D readl_relaxed(uport->membase + SE_GENI_M_I=
RQ_EN);
> > > -               irq_en &=3D ~(M_TX_FIFO_WATERMARK_EN);
> > > -               writel_relaxed(0, uport->membase + SE_GENI_TX_WATERMA=
RK_REG);
> > > -               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ=
_EN);
> > > -       }
> > > +       avail =3D port->tx_fifo_depth - (status & TX_FIFO_WC);
> > > +       avail *=3D port->tx_bytes_pw;
> > > +       if (avail < 0)
> > > +               avail =3D 0;
> >
> > How can 'avail' be less than 0? It's size_t which is unsigned? If
> > underflow is happening from that subtraction or overflow from the
> > multiply that could be bad but I hope that is impossible.
> =

> I hope underflow is impossible as well. However, if the hardware did
> wind up in a strange state I wanted to err on the side of not throwing
> away data and being able to resume later if things recovered. I can
> remove the defensive checks if that's the custom, otherwise I'll
> update the comparison logic accordingly.

Well it looks like impossible code because an unsigned value can't be
less than zero. So it's not about customs, more about dead code removal.

> =

> >
> > >
> > > -       avail =3D (port->tx_fifo_depth - port->tx_wm) * port->tx_byte=
s_pw;
> > >         tail =3D xmit->tail;
> > > -       chunk =3D min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail)=
, avail);
> > > +       chunk =3D min3((size_t)pending, (size_t)(UART_XMIT_SIZE - tai=
l), avail);
> >
> > Nitpick: If we made 'avail' unsigned int would we be able to drop the
> > casts on this min3() call? This line is quite hard to read.
> =

> Seems they can go away without any changes.

Ok!

