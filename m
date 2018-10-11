Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30055C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5152086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5152086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeJKOuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:50:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35497 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:50:02 -0400
Received: by mail-vs1-f65.google.com with SMTP id c10so7587967vsk.2;
        Thu, 11 Oct 2018 00:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InkG2wRiAjpkT0+LPRKp7SOX8QSYe8BRdarKT7AYGVM=;
        b=HaDRtg6KCt4likz+G+EFYZEQdbZzl5qEYk9nHaHQg+G1GPkEtKBrwA/lFXYU7HjlbV
         ND9XaE0pj3hTPuJUCzxUd8MiPzGgIFT3kT8gb/CryxUJH0zWvtXekJUPmnzxnfCqjIiN
         xxpOgcIeVm6XbLa9AhMfKGIbNbyUq2aWLUl7GGQPgMM23MgV+4AhkTjpiT9jBbVMgeCD
         wKOlFTt8K4UShEW0LN41f/Fd9pjpjc4Qh5mfp94UvHT+ZaIKx120rVSi1w333M/uaUlN
         V+oMcmk4FI7VOQGiNWzbEJL4UohgmnmHBheSVWMNvrJbGKio2WQekrUZxPeWnJCZ1MMY
         Q7bw==
X-Gm-Message-State: ABuFfohRnUQbwj6ELVVLgYXZqKgQgVOwhcezO8jMeYSOoxVttNkisntV
        SVAN5ygl8preHqyLS6PnLf9QX4Cd41tW2rTt3Zc=
X-Google-Smtp-Source: ACcGV63phkeXseWI+wlP2lubqbb6W/kD/9AmM1eq4oQgjPXbixOEPJTdL7+mwue3a4qIDYMDORcz309qAPWVECt3Yxg=
X-Received: by 2002:a9f:31e2:: with SMTP id w31mr198835uad.0.1539242642381;
 Thu, 11 Oct 2018 00:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181010170936.316862-1-lkundrak@v3.sk> <20181010170936.316862-8-lkundrak@v3.sk>
In-Reply-To: <20181010170936.316862-8-lkundrak@v3.sk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Oct 2018 09:23:49 +0200
Message-ID: <CAMuHMdXht0icaRCaJWy2GcVny=EVZ2FOfXW7s=hKFizi6sE-8g@mail.gmail.com>
Subject: Re: [PATCH 07/11] spi: Deal with slaves that return from
 transfer_one() unfinished
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Some drivers, such as spi-pxa2xx return from the transfer_one callback
> immediately, idicating that the transfer will be finished asynchronously.
>
> Normally, spi_transfer_one_message() synchronously waits for the
> transfer to finish with wait_for_completion_timeout(). For slaves, we
> don't want the transaction to time out as it can complete in a long time
> in future. Use wait_for_completion_interruptible() instead.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks for your patch!

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -993,6 +993,44 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>         return __spi_map_msg(ctlr, msg);
>  }
>
> +static int spi_transfer_wait(struct spi_controller *ctlr,
> +                            struct spi_message *msg,
> +                            struct spi_transfer *xfer)
> +{
> +       struct spi_statistics *statm = &ctlr->statistics;
> +       struct spi_statistics *stats = &msg->spi->statistics;
> +       unsigned long long ms = 1;
> +
> +       if (spi_controller_is_slave(ctlr)) {
> +               if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
> +                       dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
> +                       return -EINTR;

Why not setting msg->status = -EINTR here, but returning an error? ...

> +               }
> +       } else {
> +               ms = 8LL * 1000LL * xfer->len;
> +               do_div(ms, xfer->speed_hz);
> +               ms += ms + 200; /* some tolerance */
> +
> +               if (ms > UINT_MAX)
> +                       ms = UINT_MAX;
> +
> +               ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> +                                                msecs_to_jiffies(ms));
> +
> +               if (ms == 0) {
> +                       SPI_STATISTICS_INCREMENT_FIELD(statm,
> +                                                      timedout);
> +                       SPI_STATISTICS_INCREMENT_FIELD(stats,
> +                                                      timedout);
> +                       dev_err(&msg->spi->dev,
> +                               "SPI transfer timed out\n");
> +                       msg->status = -ETIMEDOUT;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * spi_transfer_one_message - Default implementation of transfer_one_message()
>   *
> @@ -1006,7 +1044,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>         struct spi_transfer *xfer;
>         bool keep_cs = false;
>         int ret = 0;
> -       unsigned long long ms = 1;
>         struct spi_statistics *statm = &ctlr->statistics;
>         struct spi_statistics *stats = &msg->spi->statistics;
>
> @@ -1035,28 +1072,11 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>                                 goto out;
>                         }
>
> -                       if (ret > 0) {
> -                               ret = 0;
> -                               ms = 8LL * 1000LL * xfer->len;
> -                               do_div(ms, xfer->speed_hz);
> -                               ms += ms + 200; /* some tolerance */
> -
> -                               if (ms > UINT_MAX)
> -                                       ms = UINT_MAX;
> +                       if (ret > 0)
> +                               ret = spi_transfer_wait(ctlr, msg, xfer);
>
> -                               ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> -                                                                msecs_to_jiffies(ms));
> -                       }
> -
> -                       if (ms == 0) {
> -                               SPI_STATISTICS_INCREMENT_FIELD(statm,
> -                                                              timedout);
> -                               SPI_STATISTICS_INCREMENT_FIELD(stats,
> -                                                              timedout);
> -                               dev_err(&msg->spi->dev,
> -                                       "SPI transfer timed out\n");
> -                               msg->status = -ETIMEDOUT;
> -                       }
> +                       if (ret < 0)
> +                               return ret;

... which will return here, skipping all finalization and cleanup below?

>                 } else {
>                         if (xfer->len)
>                                 dev_err(&msg->spi->dev,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
