Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C64223C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C64223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeKLSya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:54:30 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39420 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeKLSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:54:30 -0500
Received: by mail-vs1-f65.google.com with SMTP id h78so4652246vsi.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FI96f/QiRAl7mcgh6YM+M4riGclTfraQs4QqFLvAsU=;
        b=F1BTWTxqHiuycASscBrBkpHm6hifFQJAOGgH1Q6+/p77zYYLJc3Y+qdV2GncIfZaOy
         ygkAhh+u19raYfOH6FpMNTVYJo9zFhACKPfUpN5hkCwtGiTJVoisjuiiVlH5NVrQ+F1V
         fEEt6myx2jYoQz2dAc3Jxj7cUftnyR1oo7Z3vy5dz97wraUHmQIuoTeuSeoTrMPD5wZz
         1GnlrOvTiyx+KL6T6f8Nn1XpJJz7aO27+CMPtI3AA0hyuKmPJMGPvcrMrv2gV6r7Kw8S
         Qr3PokfIc/v06cBjo5Fyc1F1RAaRM8fill8U5ZpW3Hrd5S3zvE907eYIMkY1NldJIFGe
         3tyg==
X-Gm-Message-State: AGRZ1gKtronG/c86Giv/TYx3cCZ9csVuMlyvXmKmjrVyKtC45y5sSW2f
        40jKsT1zMxVHcqtFxVzWc+sQELGw77vlEH6//y4=
X-Google-Smtp-Source: AJdET5fjTJ/Ljp6McOWsVIx/9Cc8rPynqACEZTIh3teK+qbZ676rh57UE5G1qg05Avvst5DUrN+3W7lnKlXgDJ9NMw8=
X-Received: by 2002:a67:f43:: with SMTP id 64mr54905vsp.166.1542013334742;
 Mon, 12 Nov 2018 01:02:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541995959.git.fthain@telegraphics.com.au> <cbfa6a4e8a1a36e22969e63b703015007abe8593.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <cbfa6a4e8a1a36e22969e63b703015007abe8593.1541995959.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Nov 2018 10:02:02 +0100
Message-ID: <CAMuHMdU15gaEcwG4JCFxDwsA-dm0uHzZe_EmtoSLgOV2XAgWbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] m68k: amiga: Convert to clocksource API
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Mon, Nov 12, 2018 at 5:46 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Add a platform clocksource by adapting the existing arch_gettimeoffset
> implementation.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

> --- a/arch/m68k/amiga/config.c
> +++ b/arch/m68k/amiga/config.c
> @@ -17,6 +17,7 @@
>  #include <linux/mm.h>
>  #include <linux/seq_file.h>
>  #include <linux/tty.h>
> +#include <linux/clocksource.h>
>  #include <linux/console.h>
>  #include <linux/rtc.h>
>  #include <linux/init.h>
> @@ -461,7 +462,30 @@ void __init config_amiga(void)
>                 *(unsigned char *)ZTWO_VADDR(0xde0002) |= 0x80;
>  }
>
> +static u64 amiga_read_clk(struct clocksource *cs);
> +
> +static struct clocksource amiga_clk = {
> +       .name   = "ciab",
> +       .rating = 250,
> +       .read   = amiga_read_clk,
> +       .mask   = CLOCKSOURCE_MASK(32),
> +       .flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
>  static unsigned short jiffy_ticks;
> +static u32 clk_total;

Shouldn't clk_total be u64?

> +
> +static irqreturn_t ciab_timer_handler(int irq, void *data)
> +{
> +       irq_handler_t timer_routine = data;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       clk_total += jiffy_ticks;
> +       local_irq_restore(flags);
> +
> +       return timer_routine(irq, data);
> +}

[...]

> -static u32 amiga_gettimeoffset(void)
> +static u64 amiga_read_clk(struct clocksource *cs)
>  {
>         unsigned long flags;
>         unsigned short hi, lo, hi2;
> @@ -512,14 +537,13 @@ static u32 amiga_gettimeoffset(void)
>         if (ticks > jiffy_ticks / 2)
>                 /* check for pending interrupt */
>                 if (cia_set_irq(&ciab_base, 0) & CIA_ICR_TA)
> -                       offset = 10000;
> +                       offset = jiffy_ticks;
>
>         local_irq_restore(flags);
>
>         ticks = jiffy_ticks - ticks;
> -       ticks = (10000 * ticks) / jiffy_ticks;
>
> -       return (ticks + offset) * 1000;
> +       return clk_total + ticks + offset;

... to return a full 64-bit value here?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
