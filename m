Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524842001; cv=none;
        d=google.com; s=arc-20160816;
        b=Rze2RdmTbgmL/ML8jcnleuQEhFobMQiGoZuAx0UmlHGcsy2uyCIVoAvrw0sbqVDDam
         pVzk0X1goi2FMAnp11cfJZuBZXCdG7AE4RgP275DpgR7xF5nJdMsawK4hp86pTY+xsOe
         Fsuq7FjaSt+FmbJlQ1VD03PT9WdA0ynncca+m3qCjbTa9IvzHdtKxNYuEYRt1KPn2gjF
         qRxoTsamoclrgJb2ZMKWYxz10ZNIY6hQK7jC024AYHowXDI15B3LLsPnW2X50z/YeSwx
         T8U4Qu++zY7Xj9StRzw6Xtyzq7RLsJ0c4XQO11/JoPRbEyfg84gBmExr7zqIELPBM2AA
         sdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=NjJKmtt/RSfTClXBIhNc6sUtmQufDm4UGUetKhzu67o=;
        b=Q3GIgZfUNKN06WZEfIcP/QfQ8/0QbiQapxngE5cHFgU1OcjBR0p+5H4vDdUQyDjQ7X
         69eZ4/JjF+CfF0QYMyBvRJI/YLfD/vL4KBz/8Qf+Y5mqzQ/Oi/ZUwfn2cZLSdXkkex9y
         konXQxZ7cFhN3PhKAmbqAAhXl+yXIId9kyBXngaNFJ0vHRDob45QwEEQKSmf9PTCY7vt
         nkJJPnyLI9hKWXtqCPxEIUbM8nyM0uYXq7RyRKV1rcIC+z5+pb1gnkjaqfcpngKTyKaS
         Fkf2idSGEv5I3rWCSUSFKPaSymXyD0q9365sEbJ5xwr1RZAmpmbOmisZJ058huYUlVxe
         WJNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ua8+okZF;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ua8+okZF;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZpvdVl4ofA/VUrQ4Gun8msp3CBaUiUm3fQkLuSVd07QJY+4tBEqc7jS9Q1pWCeJVdCu7e0OfKP5sUZj2rVjG4M=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180426152920.21569-2-brgl@bgdev.pl>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426152920.21569-2-brgl@bgdev.pl>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 17:13:20 +0200
X-Google-Sender-Auth: 7TNELFCJK-y2iKHzZWzS51JwfH8
Message-ID: <CAK8P3a13wiATdYDGXnmEMfpoKzXqWA-umKLgO7hFaJj3MF4w1Q@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 1/2] earlydev: implement a new way to probe
 platform devices early
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin <peda@axentia.se>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823153159386390?=
X-GMAIL-MSGID: =?utf-8?q?1598912726013130130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 5:29 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> +/*
> + * REVISIT: early_initcall may be still too late for some timers and critical
> + * clocks. We should probably have a separate section with callbacks that can
> + * be invoked at each architecture's discretion.
> + */
> +#define earlydev_platform_driver(_drv)                                 \
> +       static int _drv##_register(void)                                \
> +       {                                                               \
> +               earlydev_driver_register(&(_drv));                      \
> +               return 0;                                               \
> +       }                                                               \
> +       early_initcall(_drv##_register)
> +
> +#endif /* __EARLYDEV_H__ */

No full review, just one comment: this would really need to fit into the
existing callbacks for clk, timer, earlycon etc that we use with OF_DECLARE.
A lot of code makes assumptions about the order in which they are
called, and the current early_platform infrastructure does the same
thing using its "earlyprintk" and "earlytimer" classes.

       Arnd
