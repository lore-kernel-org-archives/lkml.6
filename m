Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55EAC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6653B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKtbE9Bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6653B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeK3M7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:59:40 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51817 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeK3M7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:59:40 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so6935813itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 17:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwKmuygAxGMGHSUtaB7XKREacaY2G4ENMasbAQ+ggHg=;
        b=DKtbE9BiuTiIFJMb3NSypZJfhv8U6MEpYNafZnS9oLo7VuLfSk3cTk9ouJbW4ZfTS1
         x6dd7RC3fpGBPAKwHxe9FiJMYdZZP3myUGi30A88oprKSI8jdA63ics4mAonVOF3lu9B
         f+prAV0SeLxLJCojUgFVfDM91Dxu94RCrTFFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwKmuygAxGMGHSUtaB7XKREacaY2G4ENMasbAQ+ggHg=;
        b=np7UH2WUNfvo6k4lb8WLvyZoUGoutn9ywLGzA30RrhsZF9+Ffb1cMuB/bMmuv4TfJF
         44kp2SLnz7BJmc1nPurAOP3/39GNuOrXCO82wIDRnUo6pQz742DWmSqLgT0tMah/mK7n
         TnpvuOrlAKYf4sFNNaMJ2GpEUbJHcqUYKM1pVdRgXBZ6/WDBJEcOz0N3hYR93E5nCI62
         6H/AXaJDkBCAk5/Tb6/j0TXisDQR4rojvTfIZzYWS+vy7vqClnMI3rKZFnrK7ZxUas5k
         1zcsb4mGFl2sDmHuG3DtreK1hsbmMd885Y23ESnnCbPKRXaH+DFKqRZ4of9sYQ3NHse5
         UlDQ==
X-Gm-Message-State: AA+aEWZwdTK9wCJYH3kxiFGtkI8x/6CNJ8B/YpwaxKKVyprsOsQtp/8q
        6Viw2gbOUJrcFbNhwpCnj3B+qUfogpZiuGnA+LOD7w==
X-Google-Smtp-Source: AFSGD/U+oaiPelQmUH2g5Z0SyAbKe0R3JiLgj7/AuchR2KSjt6uKUkTUb25MRvpctjC42CP/sLaoOwzQRr2lyDswBy4=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr3629472jah.130.1543542724697;
 Thu, 29 Nov 2018 17:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20181128235459.180940-1-ryandcase@chromium.org> <CAD=FV=VTkM+mWZX4jS96E0JdpYpW40q_EkGPfvLxWKW==e+JMw@mail.gmail.com>
In-Reply-To: <CAD=FV=VTkM+mWZX4jS96E0JdpYpW40q_EkGPfvLxWKW==e+JMw@mail.gmail.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Thu, 29 Nov 2018 17:51:53 -0800
Message-ID: <CACjz--kkZ-23J9FM0YEiG15kGnOgu0T0gpTsX9X=JJXA3FC=7Q@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: qcom_geni_serial: Fix softlock
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 2:12 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Nov 28, 2018 at 3:55 PM Ryan Case <ryandcase@chromium.org> wrote:
> > @@ -465,9 +470,19 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >                 }
> >                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
> >                                                         SE_GENI_M_IRQ_CLEAR);
> > +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
> > +               /*
> > +                * It seems we can interrupt existing transfers unless all data
>
> s/It seems we can interrupt/It seems we can't interrupt/

Comment is correct as is, but will reword to make things clearer.

>
>
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
> > +               pending = port->tx_remaining;
>
> I almost feel like this should be:
>
> if (port->tx_remaining)
>   pending = port->tx_remaining
>
> I could imagine active being false but "port->tx_remaining" being
> non-zero if we happened to take a long time to handle the interrupt
> for some reason.  Presumably you could simulator this and see what
> breaks.  I think what would happen would be "pending" will be larger
> than you expect and you could write a few extra bytes into the FIFO
> causing it to go beyond the length of the transfer you setup.  ...so I
> guess you'd drop some bytes?
>
>
> If it's somehow important for "pending" to be 0 still when we're
> active but port->tx_remaining is non-zero, then I guess you could also
> write it as:
>
> if (active || port->tx_remaining)
>   pending = port->tx_remaining
>
>
> Maybe I'm misunderstanding though.

Yeah, this flag has different behavior on the hardware than you're
expecting. Active will be set for the duration of the command no
matter the size of the transfer or across how many interrupts the
transfer takes, including after we're done on our side
(port->tx_remaining is zero).

>
>
> -Doug
