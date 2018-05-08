Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525761901; cv=none;
        d=google.com; s=arc-20160816;
        b=boS6Ye1/unPFtmBfWXg75xGSgaGgIJaaCUgm/VCIPlWFcKZbzV7RSFziqEYlsqCJz0
         ppno7aGmK1ZyhtpEjbpANAjxRQtCEa+YucJ5/9BN/zZWaItQBxtBuNDVpu1DHUdWlvux
         qtB21Vgm5j4zWaSo2SGhJCvUyeb+EjdKQalX69tIPvmivKYirR6Hv1aSda5TM6ooLUF/
         sLB+02JtygGMvmDcFukZ8ww22UZPmu8WYYB73XoLgm8SZXVFTfhC4L+RDlvRlnKD/V5f
         UJ9Mxi1V6tKGjXfILhSFIPOLuek7XPzCo7B+cEVTvNKgCRmjb074iu+lPo/HuJRp7YvN
         8d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bWTvOrmkiEo41fi1ZxZs8fzTjbwhpvUvhdvAMut74so=;
        b=VM6qQ7ly14nSufAIzbZmQ6YdRZoS/S+p71UvDMmrSvo/fRXihYaNZKM39QuCD/Vw97
         MUAZICu5b7xYvMO1WfsNIsvVemzSxPiqzuV7zHqfxcbe1v+bq+jnkLIOKV6oEbWg0c0E
         Qxq+qt5U7Yf0odPw6uPt7RNqYC9SoDHZ60RrpHnPcve0IVk78XD1q9w48HfzKWdhwCAh
         20k46taxk06OszdsMKzmqmXI1HAl9Rufl1Y5f2/IuN9l0q3JvzrbQI1iR7ji5HmTuTla
         dS3qqoYuvP1VtIRgFzd8XfSu5eXyEVE/j+H3RMS07YBsbV5zFLw1UaWd/agP8MniqzX6
         EjYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ly46Sfwk;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ly46Sfwk;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZoixFDXhK1JIn53wE2PFJUTlzSRIcTlEgso02mWuUpm91GqOqY3adjeCEBYqah5+5umwuo/zeGEgUnqqmPg9JQ=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
References: <20180504132731.14574-1-brgl@bgdev.pl> <20180504132731.14574-3-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 08:45:01 +0200
X-Google-Sender-Auth: Vou791H-HjiFoJBQvRHMWl_2AKs
Message-ID: <CAMuHMdXbTkOHAGFBAz16zV1NKmejzy1SpO7LuqZUmsasVf0-jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform: move the early platform device support
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
	Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599540264442967177?=
X-GMAIL-MSGID: =?utf-8?q?1599877312016794252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bartosz,

On Fri, May 4, 2018 at 3:27 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
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

>  drivers/clocksource/sh_cmt.c           |   7 +
>  drivers/clocksource/sh_mtu2.c          |   7 +
>  drivers/clocksource/sh_tmu.c           |   8 +
>  drivers/tty/serial/sh-sci.c            |   7 +-
>  include/linux/platform_device.h        |  64 +----

The parts used on contemporary ARM/ARM64 Renesas SoCs look fine to me, so
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
