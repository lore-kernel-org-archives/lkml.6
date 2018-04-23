Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754770AbeDWKdP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:33:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37716 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754442AbeDWKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:33:11 -0400
X-Google-Smtp-Source: AIpwx49Hf2wI/OI89BFZIJpCAv/NfRIJDZs+yntvg4cnWZ9JpvFMYONcKIv/CzmhY5zkNgPohL/BywT4mgI4dSLUZUw=
MIME-Version: 1.0
In-Reply-To: <20180423085242.3140416-1-arnd@arndb.de>
References: <20180423085242.3140416-1-arnd@arndb.de>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 23 Apr 2018 18:33:09 +0800
Message-ID: <CAMz4kuLqH7KCEkyq=RkfSbWZ7HabX8u2hF_K0nJRLL-N-L-YvQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: use read_persistent_clock64 consistently
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>, Sam Creasey <sammy@sammy.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2018 at 16:52, Arnd Bergmann <arnd@arndb.de> wrote:
> We have two ways of getting the current time from a platform at boot
> or during suspend: either using read_persistent_clock() or the rtc
> class operation. We never need both, so I'm hiding the
> read_persistent_clock variant when the generic RTC is enabled.
>
> Since read_persistent_clock() and mktime() are deprecated because of
> the y2038 overflow of time_t, we should use the time64_t based
> replacements here.
>
> Finally, the dependency on CONFIG_ARCH_USES_GETTIMEOFFSET looks
> completely bogus in this case, so let's remove that. It was
> added in commit b13b3f51ff7b ("m68k: fix inclusion of
> arch_gettimeoffset for non-MMU 68k classic CPU types") to deal
> with arch_gettimeoffset(), which has since been removed from
> this file and is unrelated to the RTC functions.
>
> The rtc accessors are only used by classic machines, while
> coldfire uses proper RTC drivers, so we can put the old
> ifdef back around both functions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for correct my mistake. Please add my tag if it helps.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  arch/m68k/kernel/time.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
> index 6b4389a6e8ea..3a8b47f8f97b 100644
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
>
> @@ -83,11 +85,12 @@ void read_persistent_clock(struct timespec *ts)
>
>         mach_hwclk(0, &time);
>
> -       ts->tv_sec = mktime(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> -                           time.tm_hour, time.tm_min, time.tm_sec);
> +       ts->tv_sec = mktime64(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> +                             time.tm_hour, time.tm_min, time.tm_sec);
>  }
> +#endif
>
> -#if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
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
> --
> 2.9.0
>



-- 
Baolin.wang
Best Regards
