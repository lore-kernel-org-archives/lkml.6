Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ADC218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dSos5kKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfADTFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:05:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43607 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfADTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:05:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so33231421lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyAe13DOlANw7H6whxKFqtmXBOPgz9zf8ARt9hcttfk=;
        b=dSos5kKdZWjWQ6rh+LdrVFXo/kq1Iof4lpLKcWu2CjuUY+e79E8YHsSI3BlMhKQqN8
         gdN/oGBFbwV81vOjmupxGUiritArPYJ0wh9RQMKXsLYtiLDvh0z+expR8IRK3t5/UbTY
         zP3gkf4qBnUMKDvHnLrbDmMwFyOCM0YKz5t8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyAe13DOlANw7H6whxKFqtmXBOPgz9zf8ARt9hcttfk=;
        b=imyMg4E7CwUy+0vde785BaGvT9WU1avvMDLn2BFEn3q/RVeUtPO4B1SgBenU6PTxWd
         GzVaZs6A7DHGFHDBg00cDMGycE5PryGSG2l3vYRTuEveSgmfbIde4xHS/C7JK43z66do
         HdB8+tD16O9hy/zQG9Kkb/PuJRtWcPJDTRvaX8fMhANWRT+Ae03G6kKrfreYnITqyWew
         kf4SpNh4p+C2rwJEdKFQcnVSIIGgNv2S2bFucC2524KU3mOvhnqmR9jg6nu8/WH7Sjgh
         LCtqFy+H57S4Ribpg+x6jD+NOaVyn8bqxXm0QZFcEUgJS85ah8KR3uZgpjpI4VY9kzV0
         iYDg==
X-Gm-Message-State: AJcUukdh4qca2/e/Wx9eBgWSjkyBxYR8Ky8GWD/N8kWq+6WCIZKlq6VS
        sczejB+jDvvcOvooYE4jkDTz1s7NAug=
X-Google-Smtp-Source: ALg8bN6fxivtgs/kWGKqAkfuQcm2ITeFVt48sOh6S1dsUIHb5HOOfD+gxLclMzJ0Y68icWuUGryrKg==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr29613380lji.112.1546628722276;
        Fri, 04 Jan 2019 11:05:22 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r29-v6sm12279209ljd.44.2019.01.04.11.05.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 11:05:21 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id u18so26100092lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:05:21 -0800 (PST)
X-Received: by 2002:a19:1019:: with SMTP id f25mr25200194lfi.54.1546628720858;
 Fri, 04 Jan 2019 11:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-4-ryandcase@chromium.org>
In-Reply-To: <20190102213636.40866-4-ryandcase@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 4 Jan 2019 11:04:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft5Af_y20a1Vh4oTVcizMz6RB_UkuA3CwLWvWwTqRRoNhA@mail.gmail.com>
Message-ID: <CAE=gft5Af_y20a1Vh4oTVcizMz6RB_UkuA3CwLWvWwTqRRoNhA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tty: serial: qcom_geni_serial: Remove xfer_mode variable
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
> The driver only supports FIFO mode so setting and checking this variable
> is unnecessary. If DMA support is ever addedd then such checks can be

s/addedd/added/

> introduced.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 66 ++++++++++-----------------
>  1 file changed, 24 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 5521ed4a0708..3103aa0adc86 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -105,7 +105,6 @@ struct qcom_geni_serial_port {
>         u32 tx_fifo_depth;
>         u32 tx_fifo_width;
>         u32 rx_fifo_depth;
> -       enum geni_se_xfer_mode xfer_mode;
>         bool setup;
>         int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
>         unsigned int baud;
> @@ -555,29 +554,20 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>  static void qcom_geni_serial_start_tx(struct uart_port *uport)
>  {
>         u32 irq_en;
> -       struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>         u32 status;
>
> -       if (port->xfer_mode == GENI_SE_FIFO) {
> -               /*
> -                * readl ensures reading & writing of IRQ_EN register
> -                * is not re-ordered before checking the status of the
> -                * Serial Engine.
> -                */
> -               status = readl(uport->membase + SE_GENI_STATUS);
> -               if (status & M_GENI_CMD_ACTIVE)
> -                       return;
> +       status = readl(uport->membase + SE_GENI_STATUS);
> +       if (status & M_GENI_CMD_ACTIVE)
> +               return;
>
> -               if (!qcom_geni_serial_tx_empty(uport))
> -                       return;
> +       if (!qcom_geni_serial_tx_empty(uport))
> +               return;
>
> -               irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -               irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> +       irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> +       irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
>
> -               writel(DEF_TX_WM, uport->membase +
> -                                               SE_GENI_TX_WATERMARK_REG);
> -               writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       }
> +       writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
> +       writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
>
>  static void qcom_geni_serial_stop_tx(struct uart_port *uport)
> @@ -588,11 +578,8 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>
>         irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en &= ~M_CMD_DONE_EN;
> -       if (port->xfer_mode == GENI_SE_FIFO) {
> -               irq_en &= ~M_TX_FIFO_WATERMARK_EN;
> -               writel(0, uport->membase +
> -                                    SE_GENI_TX_WATERMARK_REG);
> -       }
> +       irq_en &= ~M_TX_FIFO_WATERMARK_EN;

This could be further coalesced into irq_en &= ~(M_CMD_DONE_EN |
M_TX_FIFO_WATERMARK_EN);

Reviewed-by: Evan Green <evgreen@chromium.org>
