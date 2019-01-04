Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCFEC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D251C218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRFJFREi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfADTDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:03:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44098 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfADTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:03:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so26078826lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPMPcjSjduar/1WGq0EP8HIcfM2+Uy6YB/5NK1D+jdI=;
        b=aRFJFREiKZy4ZXSVzNC5+2ClYnyGIr1iiyI3qnYbJbKt8dMrwtJVCzGvM6MciDr5JM
         hHEphocaJJZUeir7SbfNsJiWRl3zdIszSy5s5WRHAXOCGE9l6BBey3ZA2sh2vbTKyjtN
         qcbOeBHP7rn1H6MlHUtelMLpeFf1jrovzE/n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPMPcjSjduar/1WGq0EP8HIcfM2+Uy6YB/5NK1D+jdI=;
        b=oJC7j7j0GK9rpH5XALTRfW2SSqCwpuP5pPpad7zOXi7kOtRiR9MRuqzO1ONO2Hqo5y
         NJm2hmrREpXxSZ1xSh5QKAAWk4hO5ZR5t/YocDAKI48ilXtL9C3jJPNbPQhJzx83DjIa
         fbAHwxzCo8VQgzrNUYDml2rHuMxMWbm50xdl7o/sGXZOXLS1KiSuvOuabL3j4g7CkusA
         eUySZyzuVrvLQAV48nyoLX67k+wIns36FJCkch2M/3v61Ohij5SHdusaFaIBiXj/A9h0
         PDhgkg/suonXNReOUng03F6LL+IBbhybTcDGmMq5VkubIKZ1KsJds/jExsimh8Z8CAmm
         nzUw==
X-Gm-Message-State: AA+aEWYdcNIQ3VUtD6PaNqeSdA5jaOhCRAbNy/pmhO9SxMf7fGMyHoYx
        xwjLnMiPUSVu0KV7O+x39zkT2DQnffY=
X-Google-Smtp-Source: AFSGD/XdiQpTuYw9R6fYOxjQBMJrodpzXlaSDp36NKPHATHQuD2ydGzNStuB+2LOP3JqBDNiweSHjQ==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr25500125lfd.74.1546628623831;
        Fri, 04 Jan 2019 11:03:43 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y131sm10992589lfc.43.2019.01.04.11.03.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 11:03:42 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id n18-v6so33237636lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:03:42 -0800 (PST)
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr29610783lji.112.1546628622137;
 Fri, 04 Jan 2019 11:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-2-ryandcase@chromium.org>
In-Reply-To: <20190102213636.40866-2-ryandcase@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 4 Jan 2019 11:03:05 -0800
X-Gmail-Original-Message-ID: <CAE=gft4HEZtSDE4dP6Pr3WEoNHi2WS6PaZCDkSp9rAvAkox9Hw@mail.gmail.com>
Message-ID: <CAE=gft4HEZtSDE4dP6Pr3WEoNHi2WS6PaZCDkSp9rAvAkox9Hw@mail.gmail.com>
Subject: Re: [PATCH 1/4] tty: serial: qcom_geni_serial: Remove use of
 *_relaxed() and mb()
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 1:37 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> A frequent side comment has been to remove the use of writel_relaxed,
> readl_relaxed, and mb.

To provide a bit more motivation, you could add something to the
effect of "using the _relaxed variant introduces a significant amount
of complexity when reasoning about the code, and has not been shown to
provide a noticeable performance benefit in the case of this driver",
or something to that effect.

>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 187 +++++++++++---------------
>  1 file changed, 80 insertions(+), 107 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 2b1e73193dad..dc95b96148ed 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -230,7 +230,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
>         if (uart_console(uport) || !uart_cts_enabled(uport)) {
>                 mctrl |= TIOCM_CTS;
>         } else {
> -               geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> +               geni_ios = readl(uport->membase + SE_GENI_IOS);
>                 if (!(geni_ios & IO2_DATA_IN))
>                         mctrl |= TIOCM_CTS;
>         }
> @@ -248,7 +248,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>
>         if (!(mctrl & TIOCM_RTS))
>                 uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
> -       writel_relaxed(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
> +       writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
>  }
>
>  static const char *qcom_geni_serial_get_type(struct uart_port *uport)
> @@ -277,9 +277,6 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
>         unsigned int fifo_bits;
>         unsigned long timeout_us = 20000;
>
> -       /* Ensure polling is not re-ordered before the prior writes/reads */
> -       mb();
> -
>         if (uport->private_data) {
>                 port = to_dev_port(uport, uport);
>                 baud = port->baud;
> @@ -299,7 +296,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
>          */
>         timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
>         while (timeout_us) {
> -               reg = readl_relaxed(uport->membase + offset);
> +               reg = readl(uport->membase + offset);
>                 if ((bool)(reg & field) == set)
>                         return true;
>                 udelay(10);
> @@ -312,7 +309,7 @@ static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
>  {
>         u32 m_cmd;
>
> -       writel_relaxed(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
> +       writel(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
>         m_cmd = UART_START_TX << M_OPCODE_SHFT;
>         writel(m_cmd, uport->membase + SE_GENI_M_CMD0);
>  }
> @@ -325,13 +322,13 @@ static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
>         done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_CMD_DONE_EN, true);
>         if (!done) {
> -               writel_relaxed(M_GENI_CMD_ABORT, uport->membase +
> +               writel(M_GENI_CMD_ABORT, uport->membase +
>                                                 SE_GENI_M_CMD_CTRL_REG);
>                 irq_clear |= M_CMD_ABORT_EN;
>                 qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                         M_CMD_ABORT_EN, true);
>         }
> -       writel_relaxed(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +       writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  }
>
>  static void qcom_geni_serial_abort_rx(struct uart_port *uport)
> @@ -341,8 +338,8 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
>         writel(S_GENI_CMD_ABORT, uport->membase + SE_GENI_S_CMD_CTRL_REG);
>         qcom_geni_serial_poll_bit(uport, SE_GENI_S_CMD_CTRL_REG,
>                                         S_GENI_CMD_ABORT, false);
> -       writel_relaxed(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
> -       writel_relaxed(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
> +       writel(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +       writel(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
>  }
>
>  #ifdef CONFIG_CONSOLE_POLL
> @@ -351,19 +348,13 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
>         u32 rx_fifo;
>         u32 status;
>
> -       status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
> -       writel_relaxed(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
> -
> -       status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
> -       writel_relaxed(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +       status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
> +       writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
>
> -       /*
> -        * Ensure the writes to clear interrupts is not re-ordered after
> -        * reading the data.
> -        */
> -       mb();
> +       status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> +       writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
>
> -       status = readl_relaxed(uport->membase + SE_GENI_RX_FIFO_STATUS);
> +       status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
>         if (!(status & RX_FIFO_WC_MSK))
>                 return NO_POLL_CHAR;
>
> @@ -376,12 +367,12 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>  {
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>
> -       writel_relaxed(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         qcom_geni_serial_setup_tx(uport, 1);
>         WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_TX_FIFO_WATERMARK_EN, true));
> -       writel_relaxed(c, uport->membase + SE_GENI_TX_FIFOn);
> -       writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
> +       writel(c, uport->membase + SE_GENI_TX_FIFOn);
> +       writel(M_TX_FIFO_WATERMARK_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);

I think this could fit on one line now.

>         qcom_geni_serial_poll_tx_done(uport);
>  }
> @@ -390,7 +381,7 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>  #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
>  static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
>  {
> -       writel_relaxed(ch, uport->membase + SE_GENI_TX_FIFOn);
> +       writel(ch, uport->membase + SE_GENI_TX_FIFOn);
>  }
>
>  static void
> @@ -409,7 +400,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                         bytes_to_send++;
>         }
>
> -       writel_relaxed(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         qcom_geni_serial_setup_tx(uport, bytes_to_send);
>         for (i = 0; i < count; ) {
>                 size_t chars_to_write = 0;
> @@ -427,7 +418,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                 chars_to_write = min_t(size_t, count - i, avail / 2);
>                 uart_console_write(uport, s + i, chars_to_write,
>                                                 qcom_geni_serial_wr_char);
> -               writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
> +               writel(M_TX_FIFO_WATERMARK_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);
>                 i += chars_to_write;
>         }
> @@ -456,7 +447,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>         else
>                 spin_lock_irqsave(&uport->lock, flags);
>
> -       geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
> +       geni_status = readl(uport->membase + SE_GENI_STATUS);
>
>         /* Cancel the current write to log the fault */
>         if (!locked) {
> @@ -466,10 +457,10 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>                         geni_se_abort_m_cmd(&port->se);
>                         qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                         M_CMD_ABORT_EN, true);
> -                       writel_relaxed(M_CMD_ABORT_EN, uport->membase +
> +                       writel(M_CMD_ABORT_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);
>                 }
> -               writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
> +               writel(M_CMD_CANCEL_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);

This one would also fit on one line now.

>         } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
>                 /*
> @@ -479,9 +470,9 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>                 qcom_geni_serial_poll_tx_done(uport);
>
>                 if (uart_circ_chars_pending(&uport->state->xmit)) {
> -                       irq_en = readl_relaxed(uport->membase +
> +                       irq_en = readl(uport->membase +
>                                         SE_GENI_M_IRQ_EN);

This one too.

> -                       writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
> +                       writel(irq_en | M_TX_FIFO_WATERMARK_EN,
>                                         uport->membase + SE_GENI_M_IRQ_EN);
>                 }
>         }
> @@ -585,12 +576,12 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
>                 if (!qcom_geni_serial_tx_empty(uport))
>                         return;
>
> -               irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
> +               irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>                 irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
>
> -               writel_relaxed(port->tx_wm, uport->membase +
> +               writel(port->tx_wm, uport->membase +
>                                                 SE_GENI_TX_WATERMARK_REG);

This one too, though it looks like you fix that up in a later commit.

> -               writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> +               writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>         }
>  }
>
> @@ -600,35 +591,29 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>         u32 status;
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>
> -       irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
> +       irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en &= ~M_CMD_DONE_EN;
>         if (port->xfer_mode == GENI_SE_FIFO) {
>                 irq_en &= ~M_TX_FIFO_WATERMARK_EN;
> -               writel_relaxed(0, uport->membase +
> +               writel(0, uport->membase +
>                                      SE_GENI_TX_WATERMARK_REG);

Here too, though it also appears fixed up by a later commit.

>         }
> -       writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       status = readl_relaxed(uport->membase + SE_GENI_STATUS);
> +       writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> +       status = readl(uport->membase + SE_GENI_STATUS);
>         /* Possible stop tx is called multiple times. */
>         if (!(status & M_GENI_CMD_ACTIVE))
>                 return;
>
> -       /*
> -        * Ensure cancel command write is not re-ordered before checking
> -        * the status of the Primary Sequencer.
> -        */
> -       mb();
> -
>         geni_se_cancel_m_cmd(&port->se);
>         if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_CMD_CANCEL_EN, true)) {
>                 geni_se_abort_m_cmd(&port->se);
>                 qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_CMD_ABORT_EN, true);
> -               writel_relaxed(M_CMD_ABORT_EN, uport->membase +
> +               writel(M_CMD_ABORT_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);

Here too.

>         }
> -       writel_relaxed(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +       writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  }
>
>  static void qcom_geni_serial_start_rx(struct uart_port *uport)
> @@ -637,26 +622,20 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>         u32 status;
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>
> -       status = readl_relaxed(uport->membase + SE_GENI_STATUS);
> +       status = readl(uport->membase + SE_GENI_STATUS);
>         if (status & S_GENI_CMD_ACTIVE)
>                 qcom_geni_serial_stop_rx(uport);
>
> -       /*
> -        * Ensure setup command write is not re-ordered before checking
> -        * the status of the Secondary Sequencer.
> -        */
> -       mb();
> -

mmm, good deletes.

With the minor line coalescing fixed you can add my:

Reviewed-by: Evan Green <evgreen@chromium.org>
