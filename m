Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeENJaA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:30:00 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32864 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeENJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:29:58 -0400
X-Google-Smtp-Source: AB8JxZokUo/zaWSVAyPQ9Xh6/s63xSP8OlFrfPieFokf1QjTGj7yEZjYJRp4n8uFMVtgZEoaVWcIELTqDm1Q383MvAY=
MIME-Version: 1.0
In-Reply-To: <20180513140212.3961-1-boris.brezillon@bootlin.com>
References: <20180513140212.3961-1-boris.brezillon@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 11:29:57 +0200
X-Google-Sender-Auth: 6T3ZfPszfdtYxfgwp2dzEbcfZ4E
Message-ID: <CAMuHMdVdteVYjXkmZW+PouVsvPehT_GMfvEKo7OKqs4XYdiSpA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Implement ndelay() as an inline function to force
 type checking/casting
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Sun, May 13, 2018 at 4:02 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> ndelay() is supposed to take an unsigned long, but if you define
> ndelay() as a macro and the caller pass an unsigned long long instead
> of an unsigned long, the unsigned long long to unsigned long cast is
> not done and we end up with an "undefined reference to `__udivdi3'"
> error at link time.
>
> Fix that by making ndelay() an inline function and then defining dummy
> ndelay() macro that redirects to the ndelay() function (it's how most
> archs do to implement ndelay()).
>
> Fixes: c8ee038bd148 ("m68k: Implement ndelay() based on the existing udelay() logic")
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Hello Geert,
>
> This patch is fixing the bug reported by kbuild test robot here [1].
> I could have patched the PSEC_TO_NSEC() macro to cast the result of
> the division on a u32, but I thought making m68k consistent with what
> other archs do would be preferable.
>
> Let me know if don't like the solution, and I'll patch the ndelay()
> caller instead.

Thanks for your patch!

With the comment a few lines above removed:

    - * This is a macro so that the const version can factor out the first
    - * multiply and shift.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>
> Regards,
>
> Boris
>
> [1]https://lkml.org/lkml/2018/5/13/72
> ---
>  arch/m68k/include/asm/delay.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/m68k/include/asm/delay.h b/arch/m68k/include/asm/delay.h
> index 7f474121e4ca..66ba159002a3 100644
> --- a/arch/m68k/include/asm/delay.h
> +++ b/arch/m68k/include/asm/delay.h
> @@ -115,6 +115,13 @@ static inline void __udelay(unsigned long usecs)
>   */
>  #define        HZSCALE         (268435456 / (1000000 / HZ))
>
> -#define ndelay(n) __delay(DIV_ROUND_UP((n) * ((((HZSCALE) >> 11) * (loops_per_jiffy >> 11)) >> 6), 1000))
> +static inline void ndelay(unsigned long nsec)
> +{
> +       __delay(DIV_ROUND_UP(nsec *
> +                            ((((HZSCALE) >> 11) *
> +                              (loops_per_jiffy >> 11)) >> 6),
> +                            1000));
> +}
> +#define ndelay(n) ndelay(n)
>
>  #endif /* defined(_M68K_DELAY_H) */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
