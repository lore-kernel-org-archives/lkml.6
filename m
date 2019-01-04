Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5AFC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6EF218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E1bYJUqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfADTEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:04:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45134 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfADTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:04:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so33219819ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mD1St28TEa35LiqE64OuB3NqDVD6oKPNkm5AbEwJ5K8=;
        b=E1bYJUqY2BeEEz5wXO2zK8l1doJ1irTpm6iJ0Oqo3HgoyVE6ts8Wne1gQ4JQ4JyDfC
         2arnpqsF01FmeqVw80yGMmArvNPeKeUWZ9AYH7gppVDl6hQTDUS5V5w2AuaGug7DegYZ
         nsEL0OFPgfkCG50zN/M6h5vbzCgkoVQw8dh6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mD1St28TEa35LiqE64OuB3NqDVD6oKPNkm5AbEwJ5K8=;
        b=NY+1Kqde5XuNPGxChOgAYmw1HY99uJbpt+JxJ+/emSgTvmd0molvOrOtVJ36emCv6d
         onOiXDtrOTGBjeLU3mSLgFWwjF3LJgS+6bFZ8gC5AjkvkcC5JQuMU5VmjjFL4aFD7Xvf
         h4JHmEFXyAT+cIGY6otUmPh6SSC9Fk3w8hpfE6ZXNpIM0KZIz87zrZIccQF5JPv2PVle
         CIG4IlyhTu4Ih1B9lJSYbMbCoXKzZkPC5KVQxvJSE62k121UL7YlAbOaZbBPLAzeJnMt
         nCsBqSUw5Pbjl1vzw+DqGBtNWeXm/MIa2Ok65mRV8txKUIsP8KDBWVbfPoXlORWGU+5T
         AaoA==
X-Gm-Message-State: AJcUukfrAHew9h6KGKC6Gfn0d5Gmqrsqs4lCESTFQdjx7BTxuJxKH07n
        n2kcVI1mPtMbcIBiupEXbWAArAZcPQc=
X-Google-Smtp-Source: ALg8bN5App2QJM0Uqk60mXzxDXJoMVN6/2OJGHIg7VQsSUSUmlyHY7HFuFtl4Tb1LZPL1vEfLe2s3Q==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr28432042ljb.153.1546628682492;
        Fri, 04 Jan 2019 11:04:42 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 67-v6sm12491856ljc.26.2019.01.04.11.04.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 11:04:41 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id v5so26081817lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:04:41 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr24256651lff.16.1546628681406;
 Fri, 04 Jan 2019 11:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-3-ryandcase@chromium.org>
In-Reply-To: <20190102213636.40866-3-ryandcase@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 4 Jan 2019 11:04:05 -0800
X-Gmail-Original-Message-ID: <CAE=gft4h0bD8yVoQzOenwyL3mjymBDrnpYAwU_p8-nJiDG7RRg@mail.gmail.com>
Message-ID: <CAE=gft4h0bD8yVoQzOenwyL3mjymBDrnpYAwU_p8-nJiDG7RRg@mail.gmail.com>
Subject: Re: [PATCH 2/4] tty: serial: qcom_geni_serial: Remove set_rfr_wm()
 and related variables
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
> The variables of tx_wm and rx_wm were set to the same define value in
> all cases, never updated, and the define was sometimes used
> interchangably. Remove the variables/function and use the fixed value.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index dc95b96148ed..5521ed4a0708 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -105,9 +105,6 @@ struct qcom_geni_serial_port {
>         u32 tx_fifo_depth;
>         u32 tx_fifo_width;
>         u32 rx_fifo_depth;
> -       u32 tx_wm;
> -       u32 rx_wm;
> -       u32 rx_rfr;
>         enum geni_se_xfer_mode xfer_mode;
>         bool setup;
>         int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
> @@ -365,9 +362,7 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
>  static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>                                                         unsigned char c)
>  {
> -       struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> -
> -       writel(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         qcom_geni_serial_setup_tx(uport, 1);
>         WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
>                                                 M_TX_FIFO_WATERMARK_EN, true));
> @@ -579,7 +574,7 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
>                 irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>                 irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
>
> -               writel(port->tx_wm, uport->membase +
> +               writel(DEF_TX_WM, uport->membase +
>                                                 SE_GENI_TX_WATERMARK_REG);
>                 writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>         }
> @@ -852,17 +847,6 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
>                 (port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
>  }
>
> -static void set_rfr_wm(struct qcom_geni_serial_port *port)
> -{
> -       /*
> -        * Set RFR (Flow off) to FIFO_DEPTH - 2.
> -        * RX WM level at 10% RX_FIFO_DEPTH.
> -        * TX WM level at 10% TX_FIFO_DEPTH.
> -        */
> -       port->rx_rfr = port->rx_fifo_depth - 2;
> -       port->rx_wm = UART_CONSOLE_RX_WM;
> -       port->tx_wm = DEF_TX_WM;
> -}
>
>  static void qcom_geni_serial_shutdown(struct uart_port *uport)
>  {
> @@ -903,7 +887,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>
>         get_tx_fifo_size(port);
>
> -       set_rfr_wm(port);
>         writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
>         /*
>          * Make an unconditional cancel on the main sequencer to reset
> @@ -916,7 +899,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>                                                 false, true, false);
>         geni_se_config_packing(&port->se, BITS_PER_BYTE, port->rx_bytes_pw,
>                                                 false, false, true);
> -       geni_se_init(&port->se, port->rx_wm, port->rx_rfr);
> +       geni_se_init(&port->se, UART_CONSOLE_RX_WM, port->rx_fifo_depth - 2);

It looks like the CONSOLE part of the name was never really correct,
since this is also used by the regular uart_ops as well. You could
optionally fold in a rename of this define in this change.

I was also trying to reason about why that - 2 was there, and if that
should be - UART_CONSOLE_RX_WM. But I don't really get why it's there,
so I can't say for sure that it's conceptually the same value. So I
guess that's fine as is.

Reviewed-by: Evan Green <evgreen@chromium.org>
