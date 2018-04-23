Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754523AbeDWIst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:48:49 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43427 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754261AbeDWIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:48:45 -0400
X-Google-Smtp-Source: AIpwx49zbmyvDTOwxFnuRU5dGFEAcZAkR3C/o4+2AjFOw0FNl+9mRAJ6z5nKJolo3W9okI2vAQoxuHAjWBcHfvZN4y8=
MIME-Version: 1.0
In-Reply-To: <S1753929AbeDWBDQ/20180423010320Z+1320@vger.kernel.org>
References: <S1753929AbeDWBDQ/20180423010320Z+1320@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Apr 2018 10:48:44 +0200
X-Google-Sender-Auth: WYAkvzFgv57qfTmQdQcbt8s1H4Y
Message-ID: <CAK8P3a2Qt3AO_FF_J8px9KoCoNGkPrn-+k1aj-xrySb-0wYx0Q@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, linux-m68k@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 3:02 AM, Finn Thain <fthain@telegraphics.com.au> wrote:

> diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
> index 97dd4e26f234..6b4389a6e8ea 100644
> --- a/arch/m68k/kernel/time.c
> +++ b/arch/m68k/kernel/time.c
> @@ -74,17 +74,17 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
>  void read_persistent_clock(struct timespec *ts)
>  {
>         struct rtc_time time;
> +
>         ts->tv_sec = 0;
>         ts->tv_nsec = 0;
>
> -       if (mach_hwclk) {
> -               mach_hwclk(0, &time);
> +       if (!mach_hwclk)
> +               return;
> +
> +       mach_hwclk(0, &time);
>
> -               if ((time.tm_year += 1900) < 1970)
> -                       time.tm_year += 100;
> -               ts->tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
> -                                     time.tm_hour, time.tm_min, time.tm_sec);
> -       }
> +       ts->tv_sec = mktime(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> +                           time.tm_hour, time.tm_min, time.tm_sec);
>  }

This clashes with a patch I had planned to submit today, but otherwise
looks correct and. I'll respin my patch on top of yours. Since I've taken
a good look at your changes in the meantime

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
