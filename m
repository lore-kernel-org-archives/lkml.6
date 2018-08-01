Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E758EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915C02083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915C02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbeHAOVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:21:09 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45079 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbeHAOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:21:07 -0400
Received: by mail-vk0-f68.google.com with SMTP id b78-v6so9196655vka.12;
        Wed, 01 Aug 2018 05:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faaQ+DwaSkYvyfZQ2R8ChvatiKIGz1SC2HH7ZkalCfo=;
        b=ZpmcykHepdTwN31jUEDVLH95VPczlKEWPXMJ3R1xmEK8MXwmAO85gODODWhsS5dKY7
         Ilq3EECV7JUNwW3u6tUxN9vqM+tHgUYj4Z93C80blsCOybGDATGYns0rotqGZHLY3Sec
         D7kHiPCFE4y0+tt4OqtAdx7VBVx8WhwPcthYuG+47/RmMCYJBu6+Weqzdts4KCd9Bk+r
         BtwgF5b4cnRap0y7JPMX1GO79vQhpFGr4lgLIbXSfAbZ+L1OO+kehEzKhaM/QKGlrDRe
         f6/Qs1MoF00aVVHrWPu1uiKzrpn7z4NIa9GB4Mi7dRWIAlYjyDwdKWBC4XShfignH/bU
         WatQ==
X-Gm-Message-State: AOUpUlGLh5PhVG/xQRhR/qCuiSBLRy/uqez+eNAut7kRhqRm+wv/TBTu
        wuLtGEwPFmahAmDtD1Axf2hYPvu58i6DHJgd1Nc=
X-Google-Smtp-Source: AAOMgpf6ucuf/yiT5pXx4NVdRe6c42EWqdc91AgNKQWgNR88Al3QtfKF7Cvy2jbejmwuBWq0Y6wJz0SXbkC+0N8XY7s=
X-Received: by 2002:a1f:dd47:: with SMTP id u68-v6mr15777203vkg.137.1533126931568;
 Wed, 01 Aug 2018 05:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com>
 <TY1PR01MB1769588F9C53755C0FD56D98F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdWqdg9KV4h_U-VZGVdOL6upUpDgqO7kwQh8tFQjDFh-Ug@mail.gmail.com>
 <TY1PR01MB17697FBCBDC6296E7B2589C9F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdVMGWWcFZvjgBWZAabxWXdtBeH4XLYaXZVkQ=rOaeCH0g@mail.gmail.com> <TY1PR01MB176963BDA18D948161AAD264F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB176963BDA18D948161AAD264F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Aug 2018 14:35:19 +0200
Message-ID: <CAMuHMdX4tyo5VyZ+-P-+os91-WR67wen=eoL1XAGdCe=KPEjNg@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

CC Jacopo

On Fri, Jul 20, 2018 at 3:57 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 20 July 2018 13:41, Geert Uytterhoeven wrote:
> > On Fri, Jul 20, 2018 at 2:26 PM Phil Edworthy wrote:
> > > On 20 July 2018 13:12, Geert Uytterhoeven wrote:
> > > > On Fri, Jul 20, 2018 at 2:06 PM Phil Edworthy  wrote:
> > > > > On 20 July 2018 12:21, Geert Uytterhoeven wrote:
> > > > > > On Wed, Jul 18, 2018 at 4:34 PM Phil Edworthy wrote:
> > > > > > > To avoid all SoC peripheral drivers deferring their probes,
> > > > > > > both clock and pinctrl drivers should already be probed. Since
> > > > > > > the pinctrl driver requires a clock to access the registers,
> > > > > > > the clock driver should be probed before the pinctrl driver.
> > > > > > >
> > > > > > > Therefore, move the clock driver from subsys_initcall to
> > core_initcall.
> > > > > > >
> > > > > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > > >
> > > > > > Thanks for your patch!
> > > > > Thanks for your review!
> > > > >
> > > > > > The (not yet upstreamed) pinctrl driver uses postcore_initcall(), right?
> > > > > No, the pinctrl driver uses subsys_initcall, but postcore_initcall
> > > > > or arch_initcall may be better to make it clear about the dependencies.
> > > >
> > > > if the pinctrl driver uses subsys_initcall(), ...
> >
> > > > > > > -subsys_initcall(r9a06g032_clocks_init);
> > > > > > > +core_initcall(r9a06g032_clocks_init);
> > > >
> > > > ... using postcore_initcall() or arch_initcall() here, should work
> > > > with platform_driver_probe()?
> > > Nope, you have to use platform_driver_register() for DT based drivers.
> > > subsys_initcall is the earliest you can use platform_driver_probe().
> >
> > So drivers/misc/atmel_tclib.c and drivers/pinctrl/pinctrl-coh901.c, which use
> > arch_initcall(), cannot work?
> How those drivers work I do not know. However, I tried with the rzn1 clock
> driver and it does not work.
>
> > If that is really true, you can still use subsys_initcall() in the clock driver, and
> > subsys_initcall_sync() in the pinctrl driver.
> True, I'm not sure how people decide which initcall to use and whether the
> _sync variants of the initcalls have a special meaning or intention. As far as
> I know they were introduced for threaded probes, so are we supposed to
> use them for driver dependencies like this?
>
> Do you know why the rza1 pinctrl driver is running from core_initcall()?

Probably because it can?
Note that drivers/clk/renesas/clk-rz.c uses CLK_OF_DECLARE().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
