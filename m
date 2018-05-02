Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525294897; cv=none;
        d=google.com; s=arc-20160816;
        b=mzzg4DDYn88Q3ZUsj+p27pQ9jkyKh31EJ78OcUYIgynJaOp6vhcu7ui2wfzpgOGwfP
         ODdTpgD4pi9QOFMNwrjO2Oyv6Q1mmTYecPTslhbyIdI41yQeeJGEAe+qoEXbL9H+Waga
         ANasVglD2Y3/LBPQ8Ph4OO99yQd/gm6EoZ8pzTJ5GnGt6Ji0p5U9xXRTVM3otiIg7l2T
         DEycBZ5Zq4cp0qN7lWx1rzyNaTZ+rh844VdMrElX6lwwbQsq8ALsGO3hMtTd5pza3W17
         Ixq9RGY9icQRp1ktQj99H3KpdBqRQuwH+1QqTBSd8k/haXmMW5WSr64o8r+baGfOPCvK
         sI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=KfIpTwgTkq9vorpJDw9neNGw9tZ2EFM6+e7ynWKsoVI=;
        b=t6QKtcAlkBlvwe+Amg3YRyJ0wGJVsP9U/AruiZQ7Qx99aXsPqjT+QDTL92VpTV+E4H
         1YwvCYf4IBLQ0/BAG7yZ+Ielp/ZT/16K8sKGm2Amb7f8hRYL5+y0JUxc89F4mroT9VMv
         5xneMjPnZQsVBTK80WbT+8n2lqagLL6J+ea7bL4Xve3BqlmoFcZvOFKNt8+z3Cx7Wku1
         hOXxScQFu7JmQNQtarPA6SaicjdLCJnsHAgXG0WKxeZt/rQcJHq4fjsmElUzAfX3n3uA
         H1UKM2pbRzQ3CXncy4UTTjOosUyZBSfn9xAmlOybyCos/SKSgIpQBu2iWhQ1CwOBMb5H
         q3bg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=llljw1O3;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=llljw1O3;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZpTkDwrtMal0Vi69YQ3SQ2t0uvZOz9apwy2W4EWNwwWemp3frAKqIKvDpYxBou8DUOIv5Q7ZqzCXiX+NEnOhMU=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180502094821.2907-3-brgl@bgdev.pl>
References: <20180502094821.2907-1-brgl@bgdev.pl> <20180502094821.2907-3-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 23:01:36 +0200
X-Google-Sender-Auth: Irx1c2BqoL1nu0By5xRiq2L4EmE
Message-ID: <CAMuHMdUAaJbZH2nFpBOCYz_xqBfdjRP=PZW8qtk6Zp1mKd61VA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform: move the early platform device support
 to arch/sh
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>,
	Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599345273881560979?=
X-GMAIL-MSGID: =?utf-8?q?1599387622517540035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bartosz,

On Wed, May 2, 2018 at 11:48 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
>
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks for your patch!

> --- a/drivers/clocksource/sh_cmt.c
> +++ b/drivers/clocksource/sh_cmt.c

> @@ -1043,10 +1047,12 @@ static int sh_cmt_probe(struct platform_device *pdev)
>         struct sh_cmt_device *cmt = platform_get_drvdata(pdev);
>         int ret;
>
> +#ifdef CONFIG_SUPERH
>         if (!is_early_platform_device(pdev)) {
>                 pm_runtime_set_active(&pdev->dev);
>                 pm_runtime_enable(&pdev->dev);
>         }
> +#endif

I think the above is not correct: on ARM/ARM64, is_early_platform_device()
used to return false, so the pm_runtime_*() functions must be called.

Perhaps you should keep a dummy is_early_platform_device(), always
returning false on !SUPERH? That would reduce the number of #ifdefs you
have to add, too.

> --- a/drivers/clocksource/sh_mtu2.c
> +++ b/drivers/clocksource/sh_mtu2.c
> @@ -450,10 +454,12 @@ static int sh_mtu2_probe(struct platform_device *pdev)
>         struct sh_mtu2_device *mtu = platform_get_drvdata(pdev);
>         int ret;
>
> +#ifdef CONFIG_SUPERH
>         if (!is_early_platform_device(pdev)) {
>                 pm_runtime_set_active(&pdev->dev);
>                 pm_runtime_enable(&pdev->dev);
>         }
> +#endif

Likewise.

> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -606,10 +610,12 @@ static int sh_tmu_probe(struct platform_device *pdev)
>         struct sh_tmu_device *tmu = platform_get_drvdata(pdev);
>         int ret;
>
> +#ifdef CONFIG_SUPERH
>         if (!is_early_platform_device(pdev)) {
>                 pm_runtime_set_active(&pdev->dev);
>                 pm_runtime_enable(&pdev->dev);
>         }
> +#endif

Likewise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
