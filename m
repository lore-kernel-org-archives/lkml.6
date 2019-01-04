Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C3EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5267218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9JA5Qi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfADTFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:05:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44194 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfADTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:05:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so26082720lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9JT0wG09tFs9KXgX4qnMNkq6ImEUpuxztWg4HtAXE8=;
        b=C9JA5Qi6nFYfER0gZ/gmC9xfyT/emSFomGnKjngUDROr/qL0WgO9AoQ5LHCcmi63/v
         MRnjwt05yyL/Z3ASydL4iVn+AdujT5uYK87snf0cFY95ZFvkjOaw0b/iTX2IxqVvEHJe
         jFaOiB76s8cNykuIJ3SUIJLGBr+RFmD/Y27WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9JT0wG09tFs9KXgX4qnMNkq6ImEUpuxztWg4HtAXE8=;
        b=pQnyY1WzxsCBdsbq3u9TPNgpiQcEdbsm7U2vKTFv/Ks6hWshM24puJ5C6qHwpUi5fD
         d+ZBIz5c3AfFdkPyPJ5hJA0mSd/9d1Ft1NGEOuVFcFrJfEEXgruULnrRM+v29WEgA3Vp
         rFIJPLHDgWq5mlJZduo/p5wmOto9YUCta2bU+q3yVvRz9V+Sh8wIxHOl7uM5unqC6SNA
         PeKBtbhPPYS1IdHFAYxsfEUyQB/Uc2rpTTiDf46KzNkqMYjkwwiWGJza2OzqMd65Hdxj
         Lt53f6Rx+vJp6hQ6gSvrrgTqhCf5BmXFDgu6gVZdQtScWrL+URcfcTIdmQHRrTBVe5sN
         EGyA==
X-Gm-Message-State: AA+aEWYe/S1ioZ2toHCbrvydsdeHIPEjEph1CJi8Bqr5tdVyy127Soh+
        XTvRbT7SwZIn9NstaqekUe7194tvtkc=
X-Google-Smtp-Source: AFSGD/W5rFXGnKiS2LBSxwjMgY91Cdp+ZH7LdbA+Oazs+znArpqJhVKqqQNH0XUARiIEFeTKRIqQ8w==
X-Received: by 2002:a19:aace:: with SMTP id t197mr25420558lfe.7.1546628747946;
        Fri, 04 Jan 2019 11:05:47 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q10-v6sm8854115ljj.3.2019.01.04.11.05.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 11:05:47 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t18-v6so33249124ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:05:47 -0800 (PST)
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr29613999lji.112.1546628746671;
 Fri, 04 Jan 2019 11:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-5-ryandcase@chromium.org>
In-Reply-To: <20190102213636.40866-5-ryandcase@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 4 Jan 2019 11:05:10 -0800
X-Gmail-Original-Message-ID: <CAE=gft7X=bjjNivhOWTM3Y0MSXQJ0rFG4jkPrRKHJZaJ3g8mYQ@mail.gmail.com>
Message-ID: <CAE=gft7X=bjjNivhOWTM3Y0MSXQJ0rFG4jkPrRKHJZaJ3g8mYQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Use u32 for register variables
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
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3103aa0adc86..fa67a2ced420 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -765,12 +765,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>
>  static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  {
> -       unsigned int m_irq_status;
> -       unsigned int s_irq_status;
> -       unsigned int geni_status;
> +       u32 m_irq_en;
> +       u32 m_irq_status;
> +       u32 s_irq_status;
> +       u32 geni_status;
>         struct uart_port *uport = dev;
>         unsigned long flags;
> -       unsigned int m_irq_en;
>         bool drop_rx = false;
>         struct tty_port *tport = &uport->state->port;
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> @@ -948,14 +948,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>                                 struct ktermios *termios, struct ktermios *old)
>  {
>         unsigned int baud;
> -       unsigned int bits_per_char;
> -       unsigned int tx_trans_cfg;
> -       unsigned int tx_parity_cfg;
> -       unsigned int rx_trans_cfg;
> -       unsigned int rx_parity_cfg;
> -       unsigned int stop_bit_len;
> +       u32 bits_per_char;
> +       u32 tx_trans_cfg;
> +       u32 tx_parity_cfg;
> +       u32 rx_trans_cfg;
> +       u32 rx_parity_cfg;
> +       u32 stop_bit_len;
>         unsigned int clk_div;
> -       unsigned long ser_clk_cfg;
> +       u32 ser_clk_cfg;
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>         unsigned long clk_rate;
>
> --
> 2.20.1.415.g653613c723-goog
>

I did a brief search tour of unsigned in this file, and also found
rxstale in qcom_geni_serial_port_setup. Other than that and the commit
message:

Reviewed-by: Evan Green <evgreen@chromium.org>
