Return-Path: <kernel-hardening-return-12788-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+pdGBWFDb1oDZXv8RJqnM7xLXQxZzkdT/jVjsAySYzZG6kaZ6CLTJryHzr/Lzn/g0y1Vfl
ARC-Seal: i=1; a=rsa-sha256; t=1522222064; cv=none;
        d=google.com; s=arc-20160816;
        b=J7W8VE1TO4YNpPc3b+t1CY9jPF6GC+zTqdm/v+0Jqw5LQ83IAlJzqlZ/jsZ1sUP0Vl
         Trm94Fi2HOVKw4+GEe4zZKYCJIGdFLPSKRIWx+BS3cSh8efIoYYZ/xo+K476C74/xSym
         8NgyGg21++/msS8c6RUfgDFutvpmMduVHJ6bN3sJ2qXpTjtlGGEobtD9Xy82xiEvGCVR
         UmX6c9jg8s4zkJae4MkMeQ4Le3JUkViWD8YWnvDHqcfSSVteFtcNIcV9wBVbyqU5PPmr
         GQY0bJk6O/Bks0RzXIt1t1g/FMuW3cjHtm501KsKrHgThkM6cx3PaDH0azH+dEsnvncy
         A+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Z6m0r3wW2hbgtlne8Is0zoCpbTii4sVmz0mZKjfZl48=;
        b=w4B1tz2EmOP7eQoGqjdlzng+2JZBlCkgd9okA6ZPt9wtVrxchls6XvQpF6nxrH4qkN
         eJK9D//2UwFq2psKNcImBzwNL95aHM5MSvGISe7V8uJyIYhsozAbhYW4w/ZrXA0nOfQO
         GoJnMS/aba4PqO0DpWGlXPDZoG7/uhMvrtDEPRMJsfGo0v/jwDlCaKBcW/n4khAaJXnK
         o85f/RhTSCNIrmDw/jS5iKuhmV1LCmBwZ5K/xC+yfPTlIDYXlK8zR14zT7gHjq3SRNuk
         J0ZUiPNJReJ6hI3RjER/WwQM9H+z0up3CVc1gKKLFjIPxfLnlwraDnrfhFso3ROimtuQ
         nlsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CZE42eWm;
       spf=pass (google.com: domain of kernel-hardening-return-12788-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12788-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CZE42eWm;
       spf=pass (google.com: domain of kernel-hardening-return-12788-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12788-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180310001021.6437-4-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com> <20180310001021.6437-4-labbott@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Mar 2018 09:27:22 +0200
X-Google-Sender-Auth: zYy_xSutjutW0wlt81310gJ1dEg
Message-ID: <CAMuHMdUfGp_rn_fMWdOfWxPvyE1Y9oemm2piXszFTvBi9sQ5Eg@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: Remove VLA from xra1403 driver
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
	Nandor Han <nandor.han@ge.com>, Semi Malinen <semi.malinen@ge.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507318656304803?=
X-GMAIL-MSGID: =?utf-8?q?1596165523323941584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laura,

On Sat, Mar 10, 2018 at 1:10 AM, Laura Abbott <labbott@redhat.com> wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
>
> This patch replaces a VLA with an appropriate call to kmalloc_array.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Thanks for your patch!

> --- a/drivers/gpio/gpio-xra1403.c
> +++ b/drivers/gpio/gpio-xra1403.c
> @@ -126,11 +126,16 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>  {
>         int reg;
>         struct xra1403 *xra = gpiochip_get_data(chip);
> -       int value[xra1403_regmap_cfg.max_register];

Apparently xra1403_regmap_cfg.max_register is always 0x15?

What about adding

        #define XRA_LAST 15

at the top, and replacing both "XRA_IFR | 0x01" and
xra1403_regmap_cfg.max_register by XRA_LAST instead?
That would avoid doing yet another memory allocation over and over.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
