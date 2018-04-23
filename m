Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeDWJHH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:07:07 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36863 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeDWJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:07:03 -0400
X-Google-Smtp-Source: AIpwx4+FqCRBotS8BZ2uKExLEU367ekBAieCOzdwqHMPVzVKbb6EBBCALY8I/ZLguRpk90+0FXZQYIcK/XQAYTXLn38=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a15stj5Yurd7rM7278cYPtM6kufs=QL2GihCOxRUCHRSQ@mail.gmail.com>
References: <0ca46228311ec615947e199def9fed62d70c1f07.1524118799.git.baolin.wang@linaro.org>
 <CAK8P3a15stj5Yurd7rM7278cYPtM6kufs=QL2GihCOxRUCHRSQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 11:07:01 +0200
X-Google-Sender-Auth: KchIfb5xZSaBmuootlhnUVXjdPA
Message-ID: <CAMuHMdVQea-tQ4vQF=SrkCCqaRCRyo=aBiAuyv7p0z0FEi3r2g@mail.gmail.com>
Subject: Re: [PATCH] m68k: Remove read_persistent_clock()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Apr 20, 2018 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 19, 2018 at 8:22 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> The read_persistent_clock() uses a timespec, which is not year 2038 safe
>> on 32bit systems. Moreover on m68k architecture, we have implemented generic
>> RTC drivers that can be used to compensate the system suspend time. So
>> we can remove the obsolete read_persistent_clock().
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> I'm not sure about this one: it's still possible to turn off
> CONFIG_RTC_DRV_GENERIC
> on M68KCLASSIC, and in that case we still need a read_persistent_clock64()
> implementation. Or we use your patch but make CONFIG_RTC_DRV_GENERIC
> mandatory.

Typically (in the defconfigs) CONFIG_RTC_DRV_GENERIC is either "m",
or not set.

And in both cases, a platform-specific RTC class driver may or may not be
builtin or loaded. We have them for some Amigas (RTC_DRV_MSM6242 or
RTC_DRV_RP5C01).

I've never been an expert of timekeeping code...

Should we get rid of ARCH_USES_GETTIMEOFFSET?
it seems m68k and two ARM platforms are the last users.
What needs to be done?

> See below for a version I did a while ago (but never submitted as I got
> distracted).

Thanks, I can apply it, if it is deemed correct ;-)

> commit 13ddf5a33a195e9b7a7a6ed10481363b5259c1d4
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Jan 25 15:30:50 2018 +0100
>
>     m68k: use read_persistent_clock64 consistently
>
>     We have two ways of getting the current time from a platform at boot
>     or during suspend: either using read_persistent_clock() or the rtc
>     class operation. We never need both, so I'm hiding the
>     read_persistent_clock variant when the generic RTC is enabled.
>
>     Since read_persistent_clock() and mktime() are deprecated because of
>     the y2038 overflow of time_t, we should use the time64_t based
>     replacements here.
>
>     Finally, the dependency on CONFIG_ARCH_USES_GETTIMEOFFSET looks
>     completely bogus in this case, so let's remove that. It was
>     added in commit b13b3f51ff7b ("m68k: fix inclusion of
>     arch_gettimeoffset for non-MMU 68k classic CPU types") to deal
>     with arch_gettimeoffset(), which has since been removed from
>     this file and is unrelated to the RTC functions.
>
>     The rtc accessors are only used by classic machines, while
>     coldfire uses proper RTC drivers, so we can put the old
>     ifdef back around both functions.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
> index 97dd4e26f234..edcf3855d8b0 100644
> --- a/arch/m68k/kernel/time.c
> +++ b/arch/m68k/kernel/time.c
> @@ -71,7 +71,9 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
>         return IRQ_HANDLED;
>  }
>
> -void read_persistent_clock(struct timespec *ts)
> +#ifdef CONFIG_M68KCLASSIC
> +#if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
> +void read_persistent_clock64(struct timespec64 *ts)
>  {
>         struct rtc_time time;
>         ts->tv_sec = 0;
> @@ -82,12 +84,13 @@ void read_persistent_clock(struct timespec *ts)
>
>                 if ((time.tm_year += 1900) < 1970)
>                         time.tm_year += 100;
> -               ts->tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
> +               ts->tv_sec = mktime64(time.tm_year, time.tm_mon, time.tm_mday,
>                                       time.tm_hour, time.tm_min, time.tm_sec);
>         }
>  }
> +#endif
>
> -#if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) &&
> IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
> +#if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
>  static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
>  {
>         mach_hwclk(0, tm);
> @@ -145,8 +148,8 @@ static int __init rtc_init(void)
>  }
>
>  module_init(rtc_init);
> -
> -#endif /* CONFIG_ARCH_USES_GETTIMEOFFSET */
> +#endif /* CONFIG_RTC_DRV_GENERIC */
> +#endif /* CONFIG M68KCLASSIC */
>
>  void __init time_init(void)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
