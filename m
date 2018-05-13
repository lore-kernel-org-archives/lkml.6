Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeEMWiS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:38:18 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:38175 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeEMWiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:38:16 -0400
X-Google-Smtp-Source: AB8JxZobc2C3bytn5goKbVHmYMVdhK4CLaSyD8EmHhqim+vGn6toSTGsjNl2J/GL9B7wRZFaA8wVjX9CD6Zl6mHH7ro=
MIME-Version: 1.0
In-Reply-To: <20180513140212.3961-1-boris.brezillon@bootlin.com>
References: <20180513140212.3961-1-boris.brezillon@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 01:38:15 +0300
Message-ID: <CAHp75Veu2Uapp-=ATL7v7uscsP+46eYcRi7MEoLt_QPR4BLZOQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Implement ndelay() as an inline function to force
 type checking/casting
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 5:02 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> ndelay() is supposed to take an unsigned long, but if you define
> ndelay() as a macro and the caller pass an unsigned long long instead
> of an unsigned long, the unsigned long long to unsigned long cast is
> not done and we end up with an "undefined reference to `__udivdi3'"
> error at link time.

> -#define ndelay(n) __delay(DIV_ROUND_UP((n) * ((((HZSCALE) >> 11) * (loops_per_jiffy >> 11)) >> 6), 1000))
> +static inline void ndelay(unsigned long nsec)
> +{
> +       __delay(DIV_ROUND_UP(nsec *
> +                            ((((HZSCALE) >> 11) *

One pair of parens is redundant.

> +                              (loops_per_jiffy >> 11)) >> 6),
> +                            1000));

Can't you keep as one line as in original?

> +}
> +#define ndelay(n) ndelay(n)
>
>  #endif /* defined(_M68K_DELAY_H) */
> --
> 2.14.1
>



-- 
With Best Regards,
Andy Shevchenko
