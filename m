Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F4C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492BC2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="noOOovSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492BC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3JTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:19:44 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46093 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeK3JTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:19:43 -0500
Received: by mail-ua1-f66.google.com with SMTP id v24so1200262uap.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlF+FE3QTGVYbK2iC+cpaRNKT7/QyQS/1YiJabKOFRs=;
        b=noOOovSe1gq4q2eHcmzs6TxxTLYPpiY+FXNs2polTgVXBV77qwAig7HdYZI2F2kTm0
         qgfceP61Gs8foh+GBfwBEMRctPGCnVoXyL8WUSVjtpHdAvHoFW4mhFLuu7bz/tKBClF+
         V/b8r1w2xqhoENP2IxK5740k1jlQaQD2rW9/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlF+FE3QTGVYbK2iC+cpaRNKT7/QyQS/1YiJabKOFRs=;
        b=IH8O46wAtQA8jTNMa/3+XJwm1nYCijum7Ikt7LZnFQRzVQKaXCa2w7WZMlsAsjuTk4
         92EnF0yBjJr7RVS9zdFHFiujnkKqs2ZLGh/49Mj5S8zUcAJJFoiKMhNC5zwy3axQ048S
         uqg8C4zgbuftpG+CtKwKHjo7wN1ikaT+2WGVkRXCnaG57/YeQ39a5AqRdFjf33/HmNe7
         jUTTu7GCkpS3x+8XiB/z4Yn9g3twwqrE+g5KUa4lNEStFEbmZcQdmC83io4rzDqc9NSq
         Bo817UoqXEWevUxAO8ZzL1PYClRT2xo3P9YYjxY2B6vRLfK4vwntSygHrq3A0mIT0nAU
         n0XQ==
X-Gm-Message-State: AA+aEWa7s0h7qR1FQXEbFrINBxE828cdR/2T1V63MW2zvTqUSKACL6vX
        B4a+2zm51PQb3/j3juX4b4lW9CXhxM8=
X-Google-Smtp-Source: AFSGD/VakA2wduLjXLN63yxjADB8esy2EFz95rb0Mj/QE+egb2h+HehJDFBMjetffmJiLVkd3b1vjw==
X-Received: by 2002:a9f:3703:: with SMTP id z3mr1477840uad.86.1543529564494;
        Thu, 29 Nov 2018 14:12:44 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 2sm875781vsd.13.2018.11.29.14.12.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:12:44 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id n7so1209244uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:12:43 -0800 (PST)
X-Received: by 2002:ab0:1c12:: with SMTP id a18mr1380356uaj.15.1543529562133;
 Thu, 29 Nov 2018 14:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20181128235459.180940-1-ryandcase@chromium.org>
In-Reply-To: <20181128235459.180940-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Nov 2018 14:12:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VTkM+mWZX4jS96E0JdpYpW40q_EkGPfvLxWKW==e+JMw@mail.gmail.com>
Message-ID: <CAD=FV=VTkM+mWZX4jS96E0JdpYpW40q_EkGPfvLxWKW==e+JMw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: qcom_geni_serial: Fix softlock
To:     ryandcase@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 28, 2018 at 3:55 PM Ryan Case <ryandcase@chromium.org> wrote:
> @@ -465,9 +470,19 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>                 }
>                 writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
>                                                         SE_GENI_M_IRQ_CLEAR);
> +       } else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
> +               /*
> +                * It seems we can interrupt existing transfers unless all data

s/It seems we can interrupt/It seems we can't interrupt/


> +static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
> +               bool active)
>  {
>         struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>         struct circ_buf *xmit = &uport->state->xmit;
>         size_t avail;
>         size_t remaining;
> +       size_t pending;
>         int i;
>         u32 status;
>         unsigned int chunk;
>         int tail;
> -       u32 irq_en;
>
> -       chunk = uart_circ_chars_pending(xmit);
>         status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
> -       /* Both FIFO and framework buffer are drained */
> -       if (!chunk && !status) {
> +
> +       /* Complete the current tx command before taking newly added data */
> +       if (active)
> +               pending = port->tx_remaining;

I almost feel like this should be:

if (port->tx_remaining)
  pending = port->tx_remaining

I could imagine active being false but "port->tx_remaining" being
non-zero if we happened to take a long time to handle the interrupt
for some reason.  Presumably you could simulator this and see what
breaks.  I think what would happen would be "pending" will be larger
than you expect and you could write a few extra bytes into the FIFO
causing it to go beyond the length of the transfer you setup.  ...so I
guess you'd drop some bytes?


If it's somehow important for "pending" to be 0 still when we're
active but port->tx_remaining is non-zero, then I guess you could also
write it as:

if (active || port->tx_remaining)
  pending = port->tx_remaining


Maybe I'm misunderstanding though.


-Doug
