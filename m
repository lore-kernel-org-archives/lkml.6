Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A51C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D1C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MM14MWZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D1C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeLMRgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:36:37 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42233 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeLMRgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:36:37 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so1670065vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hcnbEc4kGXOG5LKamiEGBnahMZZ5sKiUiIKI5mE9LE=;
        b=MM14MWZwKX9QmpwRRGQO7ZtYyX9gjWmx9XGPTNtpeRPurIEYmfR8764leZsvM5mR97
         ZrE0UbhRg4y49mKinGAkCSicDr5XB2000nDTRCASZy2MlMVu5cAGYnFqZ19bm4afZlOp
         ZmRHwvN9vCKeyl6Y/EsYxVOUbDElmyey7WNk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hcnbEc4kGXOG5LKamiEGBnahMZZ5sKiUiIKI5mE9LE=;
        b=q2rc+WRyLKf1IxEVer1n0lDl52j4OTUF69PleT04Rk8OcOYJZpD/ebF3eD0ELkH9OF
         nLkFXQLSYm9WDxWxZw+JNHOSgxRk/MLzBU9hKCI8UHUIaT42TJvch0qhY3Doap62k7o5
         3Iuh9jxHvSZxim7zpw2Uyb/cmNW6T5ktXoDAjbh2yciKehuU79XfJDOUIKv/wGLCvJzR
         frv9/xlMe8ZK6I/WJdKLqTVRk48an7RyTLO7u5xG9+l6qpPLPFdYdZFQS5hN8g2TCOg3
         tBBhTbG/b8vy6ed2KlUshZS1JYCquwLYWFeUvcbiV2RVow8Mw8P51VtHAEH+hPoY52mq
         1pRA==
X-Gm-Message-State: AA+aEWapeVkAWzXOrl7uXLsqPKzjEojLjQyb3HG6uWiSZ1RO8PpqTyl8
        UGMVX72TKecvzDcNsolKUDZ/R28MknI=
X-Google-Smtp-Source: AFSGD/UnXF9+buUuNXKUsYve828TQB7C/N4mkayeyt8Bb19HRSKsIloD6rTX5BCjWw7f4qX6qaTe4A==
X-Received: by 2002:a67:7993:: with SMTP id u141mr12094989vsc.119.1544722594537;
        Thu, 13 Dec 2018 09:36:34 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id s11sm607277uao.15.2018.12.13.09.36.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:36:33 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id b74so1669972vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 09:36:33 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr10314309vsv.20.1544722592704;
 Thu, 13 Dec 2018 09:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20181212003522.239189-1-ryandcase@chromium.org>
In-Reply-To: <20181212003522.239189-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Dec 2018 09:36:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XyG0z3BvDyWiXTNz5mwf3cFH-U9=1fhury9+csW5TVjw@mail.gmail.com>
Message-ID: <CAD=FV=XyG0z3BvDyWiXTNz5mwf3cFH-U9=1fhury9+csW5TVjw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Remove interrupt storm
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 11, 2018 at 4:36 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> Disable M_TX_FIFO_WATERMARK_EN after we've sent all data for a given
> transaction so we don't continue to receive a flurry of free space
> interrupts while waiting for the M_CMD_DONE notification. Re-enable the
> watermark when establishing the next transaction.
>
> Also clear the watermark interrupt after filling the FIFO so we do not
> receive notification again prior to actually having free space.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 6e38498362ef..965aefa54114 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -724,10 +724,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>         size_t pending;
>         int i;
>         u32 status;
> +       u32 irq_en;
>         unsigned int chunk;
>         int tail;
>
>         status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
> +       irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
>
>         /* Complete the current tx command before taking newly added data */
>         if (active)
> @@ -752,6 +754,9 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>         if (!port->tx_remaining) {
>                 qcom_geni_serial_setup_tx(uport, pending);
>                 port->tx_remaining = pending;
> +
> +               irq_en |= M_TX_FIFO_WATERMARK_EN;
> +               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);

I notice other places that turn on the watermark only do so if
"xfer_mode == GENI_SE_FIFO".  ...but it looks as if the mode is always
FIFO mode, so you should be fine.  Probably the right thing to do is
that someone should do a future patch to kill all the "if xfer_mode ==
GENI_SE_FIFO" stuff and if/when someone wants to add DMA then they can
do it from scratch.


>         }
>
>         remaining = chunk;
> @@ -775,7 +780,15 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>         }
>
>         xmit->tail = tail & (UART_XMIT_SIZE - 1);
> +       writel_relaxed(M_TX_FIFO_WATERMARK_EN,
> +                       uport->membase + SE_GENI_M_IRQ_CLEAR);

Worth a comment saying that the watermark is "level-triggered and
latched" so it's obvious why it's not a race (because it will just
re-assert itself) and also why we need to ACK it at the end of the
function (because it'll keep re-latching itself until you put
something in the FIFO)?


> +
>  out_write_wakeup:
> +       if (!port->tx_remaining) {
> +               irq_en &= ~M_TX_FIFO_WATERMARK_EN;
> +               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);

I think you should change this (and probably the other write to
irq_en) to a read/modify/write rather than using the value you read at
the top of the function.  Specifically there are enough helper
functions called that might also be touching irq_en and I'd be worried
that the value you read at the top of the function might not be truth
anymore.  I also wonder if it's worth an "if" test to only do the
writel_relaxed() if the value wasn't already right since sometimes IO
writes can be slow.

If I followed the code correctly, doing the read/modify/write actually
might matter.  The code calls qcom_geni_serial_stop_tx() which _does_
modify irq_en.  Then the code does "goto out_write_wakeup" where it'll
clobber qcom_geni_serial_stop_tx()'s modifications.


> +       }
> +
>         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>                 uart_write_wakeup(uport);
>  }
> @@ -811,8 +824,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>                 tty_insert_flip_char(tport, 0, TTY_OVERRUN);
>         }
>
> -       if (m_irq_status & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN) &&
> -           m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
> +       if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))

Unrelated to everything else in this patch, but seems OK to me.


-Doug
