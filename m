Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A03C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D878C21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfBST6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:58:43 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36750 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBST6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:58:43 -0500
Received: by mail-ua1-f67.google.com with SMTP id j3so7401532uap.3;
        Tue, 19 Feb 2019 11:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+aMzUnWXdxgHijRrHDVyvQFT6Va2vklZt1h5IHfAc4=;
        b=m0wsYjM6zSL9UISbzmH+tnLb2/JT3l4lfuZX6mJKSlgRL2VonNVFd5gK8GYKujIEHA
         OxFuIX9JRuE40UtLsY5Cja7ONRt0jkAqNmwhiVyxVf1dB9HJ1mw9ABDfVPxqUnA/d9oW
         DN1685wj6hBak3D1HvcwjoRsScPBUz0+x8xP8OdZkZTZnXPIJiNydrXGQlNjn2PzB5Ll
         gxS0f8mhMuaqVQ20/4X0DvkBerjJwRzICTwJn/hJDXlfchA/vsUWnguo2Swq2xmF0Zz2
         J2ZEbKCDflKV84pWSOV/zOGDaWl0l/dhenoIFUa45wy5/M/cf05oCIsOscPTTAaFUMrW
         nxLA==
X-Gm-Message-State: AHQUAuYL+wRLa/K8L/X9DuDPH4C8OV/EPLGSOEPjm52l43SP59sFNP42
        xagjUq0bDD4HgcPeUGQdK0iY0xP0OLPP3SrkdPf494TZ
X-Google-Smtp-Source: AHgI3IZ7iYuHtOkAWoceRqcw8YfPGZbCQQpkGjWd9k+Am7LIb7UrWOeVjReoS1uv1aefyFL+mkdpM8VC4fP/qre7II8=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr15827455uap.0.1550606322151;
 Tue, 19 Feb 2019 11:58:42 -0800 (PST)
MIME-Version: 1.0
References: <1550595636-23598-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1550595636-23598-1-git-send-email-stefan.popa@analog.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Feb 2019 20:58:27 +0100
Message-ID: <CAMuHMdWPoN8LVmDKv14eaGDmona096AVw=aPL6q5nSnSRUtt7Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: spi: core: Add optional stall delay between
 cs_change transfers
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thanks for your patch!

On Tue, Feb 19, 2019 at 6:02 PM Stefan Popa <stefan.popa@analog.com> wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> Some devices like the ADIS16460 IMU require a stall period between
> transfers.

This is not just about the period between transfers (which is handled by
delay_usecs), but about the period in between chipselect pulses if
cs_change is set.

> The default value of 10us are not enough. Introduce a per

... is not enough.

> transfer configurable delay.

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1144,7 +1144,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>                                 keep_cs = true;
>                         } else {
>                                 spi_set_cs(msg->spi, false);
> -                               udelay(10);
> +                               udelay(xfer->cs_change_stall_delay_us ?
> +                                      xfer->cs_change_stall_delay_us : 10);
>                                 spi_set_cs(msg->spi, true);
>                         }
>                 }
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 314d922..273774c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -702,6 +702,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
>   *      transfer. If 0 the default (from @spi_device) is used.
>   * @bits_per_word: select a bits_per_word other than the device default
>   *      for this transfer. If 0 the default (from @spi_device) is used.
> + * @cs_change_stall_delay_us: microseconds to delay between cs_change
> + *     transfers.

I think this needs some better wording, too.
Else it is hard to understand how this is different from delay_usecs,
without looking at the implementation.

>   * @cs_change: affects chipselect after this transfer completes
>   * @delay_usecs: microseconds to delay after this transfer before
>   *     (optionally) changing the chipselect status, then starting
> @@ -788,6 +790,7 @@ struct spi_transfer {
>  #define        SPI_NBITS_DUAL          0x02 /* 2bits transfer */
>  #define        SPI_NBITS_QUAD          0x04 /* 4bits transfer */
>         u8              bits_per_word;
> +       u8              cs_change_stall_delay_us;
>         u16             delay_usecs;
>         u32             speed_hz;
>         u16             word_delay;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
