Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0ABECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31A220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31A220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeGTMJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:09:00 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33589 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeGTMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:09:00 -0400
Received: by mail-ua0-f194.google.com with SMTP id i4-v6so7236379uak.0;
        Fri, 20 Jul 2018 04:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghSroxoWTK03RFoqcvvCJU54uWCsfJ2cPVLLv+hH8PI=;
        b=BzYXUncmbvdTKTmCz9t6iBG0wsjjm6WOCiMb01bR0JrHgI0g515H6uTuI/Ao9MNYrA
         zJXsZAi2e5EWv87TzyOr1e/AiHLeYOB+zq+AdlQt6Z8lLgQo/2TGutTibhs+pJPfxwUZ
         1qqDu7Vib5bFz7FmfLZ+xLBZ17fL9O94E+D6WS2nLcR5KoBVDOXnL1L/yAif7qMTjNxT
         IDwB9tKK6TAYN09hYtqjr8BZPKPK+qX/OKAMpLgiwh+ZIL54fI0S6sIHDgLKHEa8qpyK
         /BbhyCWfMYDi8MmCqAvjSRuhUOuzPxlX2LhgWu1eZrf4pskFF2zv3a9XEZIclCO3h9Sj
         JZ7w==
X-Gm-Message-State: AOUpUlEOs8p6M+VbZ50pLjhV7QToQdwOT7GK4Y8p+TuLe9YqgqDjUOxE
        gompklvq/KqKKUhR5SsKkyRL789EommhfDpJXUlDx78Q
X-Google-Smtp-Source: AAOMgpe9dbDIg+lyavqItk2HOdq2Ku72r8zTUxMOW8biZOUwnRSR07s54easWQwfPlTzU1Tny5E0VVTzEKgMILwLPlc=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr1034526uad.12.1532085673173;
 Fri, 20 Jul 2018 04:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Jul 2018 13:21:01 +0200
Message-ID: <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Jul 18, 2018 at 4:34 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> To avoid all SoC peripheral drivers deferring their probes, both clock and
> pinctrl drivers should already be probed. Since the pinctrl driver requires
> a clock to access the registers, the clock driver should be probed before
> the pinctrl driver.
>
> Therefore, move the clock driver from subsys_initcall to core_initcall.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks for your patch!

The (not yet upstreamed) pinctrl driver uses postcore_initcall(), right?

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -877,17 +877,18 @@ static const struct of_device_id r9a06g032_match[] = {
>         { }
>  };
>
> -static struct platform_driver r9a06g032_clock_driver = {
> +static struct platform_driver r9a06g032_clock_driver __refdata = {
>         .driver         = {
>                 .name   = "renesas,r9a06g032-sysctrl",
>                 .of_match_table = r9a06g032_match,
>         },
> +       .probe = r9a06g032_clocks_probe,
>  };
>
>  static int __init r9a06g032_clocks_init(void)
>  {
> -       return platform_driver_probe(&r9a06g032_clock_driver,
> -                       r9a06g032_clocks_probe);
> +       platform_driver_register(&r9a06g032_clock_driver);
> +       return 0;
>  }

Why are all of the above changes needed?
Shouldn't the platform_driver_probe() keep on working?
If it does not, it means the clock driver has some other dependency, and
cannot be bound immediately.  This is potentially a dangerous situation,
as r9a06g032_clocks_probe() is __init, but can still be called at any time
later.  Hence using platform_driver_probe() is the safe thing to do,
possibly with a different reshuffling of the clock and pinctrl initcall
priorities.

> -subsys_initcall(r9a06g032_clocks_init);
> +core_initcall(r9a06g032_clocks_init);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
