Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369B7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3A220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3A220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbeGTN3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:29:38 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36754 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388863AbeGTN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:29:38 -0400
Received: by mail-ua0-f194.google.com with SMTP id y8-v6so7378992uan.3;
        Fri, 20 Jul 2018 05:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTfpafMlco3ewluiNtKxVRpaSEkeF9WHkab90rrrCmY=;
        b=SNrgkx5E5nl2HvHMOfebDnquXAOIxCZSB1AUQRKNcq4bJ+B7m+bbhnvpVjw4k2hGjF
         jytaEDkNS99VP330lSr6jZXzpnawnNkroep/zXUNezK7sM/lRd5j4RYdAlgVyxzUCsEQ
         dmtRBA2Hc9JNRRbJMOJT9+OnxhVeHQY+CKpMVisv/XY7T3V7kpjw//CfrB9E7yynp7Nz
         RUGbxKr3ORJHMkqiIRA7KBdhWu5u+QY8GlwNY6Qd5cAmOduuSRBlUMvOf3HGz2/WLo7J
         7k9EO675x8YD/KbPLGhaQdyNFYSX01R2WtT7HDyyOLdI68D9oSeOZ22snP1NXPjM+XzK
         eFcA==
X-Gm-Message-State: AOUpUlF6hd9heff1Z0KYUk8GJkkfKmveD82JYQaf+lFB0BYmZk4522Vm
        o+uoHFu+UP7kIEZWjGPV9SfV8+9aHEgx+zGqg+Dc/+3v
X-Google-Smtp-Source: AAOMgpcvRLIHlOHwn0Ag4gWd8DxHNetdMtyjQtf9VXWh9+Pe+ALCdZ7GdjDIf2OKnsgEOyq5B9HAcDfzlI0vwMSw4XQ=
X-Received: by 2002:ab0:221:: with SMTP id 30-v6mr1334284uas.26.1532090493119;
 Fri, 20 Jul 2018 05:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com>
 <TY1PR01MB1769588F9C53755C0FD56D98F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdWqdg9KV4h_U-VZGVdOL6upUpDgqO7kwQh8tFQjDFh-Ug@mail.gmail.com> <TY1PR01MB17697FBCBDC6296E7B2589C9F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB17697FBCBDC6296E7B2589C9F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Jul 2018 14:41:20 +0200
Message-ID: <CAMuHMdVMGWWcFZvjgBWZAabxWXdtBeH4XLYaXZVkQ=rOaeCH0g@mail.gmail.com>
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

On Fri, Jul 20, 2018 at 2:26 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 20 July 2018 13:12, Geert Uytterhoeven wrote:
> > On Fri, Jul 20, 2018 at 2:06 PM Phil Edworthy  wrote:
> > > On 20 July 2018 12:21, Geert Uytterhoeven wrote:
> > > > On Wed, Jul 18, 2018 at 4:34 PM Phil Edworthy wrote:
> > > > > To avoid all SoC peripheral drivers deferring their probes, both
> > > > > clock and pinctrl drivers should already be probed. Since the
> > > > > pinctrl driver requires a clock to access the registers, the clock
> > > > > driver should be probed before the pinctrl driver.
> > > > >
> > > > > Therefore, move the clock driver from subsys_initcall to core_initcall.
> > > > >
> > > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > >
> > > > Thanks for your patch!
> > > Thanks for your review!
> > >
> > > > The (not yet upstreamed) pinctrl driver uses postcore_initcall(), right?
> > > No, the pinctrl driver uses subsys_initcall, but postcore_initcall or
> > > arch_initcall may be better to make it clear about the dependencies.
> >
> > if the pinctrl driver uses subsys_initcall(), ...

> > > > > -subsys_initcall(r9a06g032_clocks_init);
> > > > > +core_initcall(r9a06g032_clocks_init);
> >
> > ... using postcore_initcall() or arch_initcall() here, should work with
> > platform_driver_probe()?
> Nope, you have to use platform_driver_register() for DT based drivers.
> subsys_initcall is the earliest you can use platform_driver_probe().

So drivers/misc/atmel_tclib.c and drivers/pinctrl/pinctrl-coh901.c, which
use arch_initcall(), cannot work?

If that is really true, you can still use subsys_initcall() in the clock driver,
and subsys_initcall_sync() in the pinctrl driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
