Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DB4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DFF20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DFF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeGTNAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:00:39 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44112 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeGTNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:00:39 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so5951423vke.11;
        Fri, 20 Jul 2018 05:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezACFng6wnNK/UZDF+TEnLrEQ27l/0mTQzufK1GgAVA=;
        b=amnx2mBZgO5pSMOHOd17DWhdvWU+Eu668++ObVEYoT5LrrurG7CAwduk/kO4qYFKMD
         QRinhQj8ZrcrxnAzkVMIcsO0032/QAD/HoG2OP63FtyQGZKFUAQlJiUi/WizxfkfE5nI
         ohWK2bRBvj+gsJllJofzmz/60PfJNX6MsnfC08FNUgy/7g//iTC2MQfGibxel+pnhrpG
         D7rB+UxHs37aSt3f0LJMbSGLycvmOq78w545Pca5z2dNx1MMWHZATt3Y1RcgHdftG+qf
         RIfNuFCaPi1ZUKP/kbx5ohtvu6p+AmSrZ76Uoq+3OWqsOlSFugrIhwp70DbxSyKST7XN
         6enw==
X-Gm-Message-State: AOUpUlGwZE8yfjSxd65IqRN6KgwyduX06JagALro0BzUxhez0ljzPW0r
        YXM2FrCkODCMSpwO35DI4pa/ZgEnvBixJxH8u9g=
X-Google-Smtp-Source: AAOMgpeMyMYEGnaK1R8WByoNn287y0KKF8M+rokWKLYdO1HN7VT5ZjREL39EhHpjesIoOs4S6uDmtNKOU5q3G0M3FA4=
X-Received: by 2002:a1f:6b11:: with SMTP id g17-v6mr989639vkc.82.1532088762104;
 Fri, 20 Jul 2018 05:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com> <TY1PR01MB1769588F9C53755C0FD56D98F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769588F9C53755C0FD56D98F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Jul 2018 14:12:29 +0200
Message-ID: <CAMuHMdWqdg9KV4h_U-VZGVdOL6upUpDgqO7kwQh8tFQjDFh-Ug@mail.gmail.com>
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

On Fri, Jul 20, 2018 at 2:06 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 20 July 2018 12:21, Geert Uytterhoeven wrote:
> > On Wed, Jul 18, 2018 at 4:34 PM Phil Edworthy wrote:
> > > To avoid all SoC peripheral drivers deferring their probes, both clock
> > > and pinctrl drivers should already be probed. Since the pinctrl driver
> > > requires a clock to access the registers, the clock driver should be
> > > probed before the pinctrl driver.
> > >
> > > Therefore, move the clock driver from subsys_initcall to core_initcall.
> > >
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >
> > Thanks for your patch!
> Thanks for your review!
>
> > The (not yet upstreamed) pinctrl driver uses postcore_initcall(), right?
> No, the pinctrl driver uses subsys_initcall, but postcore_initcall or
> arch_initcall may be better to make it clear about the dependencies.

if the pinctrl driver uses subsys_initcall(), ...

> > > --- a/drivers/clk/renesas/r9a06g032-clocks.c
> > > +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> > > @@ -877,17 +877,18 @@ static const struct of_device_id
> > r9a06g032_match[] = {
> > >         { }
> > >  };
> > >
> > > -static struct platform_driver r9a06g032_clock_driver = {
> > > +static struct platform_driver r9a06g032_clock_driver __refdata = {
> > >         .driver         = {
> > >                 .name   = "renesas,r9a06g032-sysctrl",
> > >                 .of_match_table = r9a06g032_match,
> > >         },
> > > +       .probe = r9a06g032_clocks_probe,
> > >  };
> > >
> > >  static int __init r9a06g032_clocks_init(void)  {
> > > -       return platform_driver_probe(&r9a06g032_clock_driver,
> > > -                       r9a06g032_clocks_probe);
> > > +       platform_driver_register(&r9a06g032_clock_driver);
> > > +       return 0;
> That should be:
> +       return platform_driver_register(&r9a06g032_clock_driver);
>
> > >  }
> >
> > Why are all of the above changes needed?
> > Shouldn't the platform_driver_probe() keep on working?
> > If it does not, it means the clock driver has some other dependency, and
> > cannot be bound immediately.  This is potentially a dangerous situation, as
> > r9a06g032_clocks_probe() is __init, but can still be called at any time later.
> > Hence using platform_driver_probe() is the safe thing to do, possibly with a
> > different reshuffling of the clock and pinctrl initcall priorities.
> No, you cannot call platform_driver_probe() from core_initcall.
> All drivers that are in core_initcall call platform_driver_register().

Hence they cannot have their probe function __init.

>
> Thanks
> Phil
>
> > > -subsys_initcall(r9a06g032_clocks_init);
> > > +core_initcall(r9a06g032_clocks_init);

... using postcore_initcall() or arch_initcall() here, should work with
platform_driver_probe()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
