Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C37C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F220855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5F220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeKITgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:36:06 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42856 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKITgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:36:05 -0500
Received: by mail-vs1-f68.google.com with SMTP id b74so679253vsd.9;
        Fri, 09 Nov 2018 01:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgR7TvkiA1mnZNGKKfCKW7uzKfmOp1yYkm3LUZfV3yo=;
        b=jbxKIeHjF/KVRr4QzqyoZfLsXntMOdcu8i/0z/BttbOFhvovPWpO0RoeH4I6cA0qtX
         sWQDjTS+Z5x8r3AiS0N8gbY4MwjlRz68twEb4FkSsZzDGdrxX2HS89wK/eaIQnoKpfOS
         EobygkQCJXMXastsjq0lqi3rZM430PXmj0IVzLJk3jeItS2CUsCjaEsKs20btnq2wTgk
         152X9A7NYDHjjDS4K3ThdfCPQblM+4uXa5eeAJ5ecOqHOiErtxhpn/E0b0KrCifDYetM
         s7Zd8EbzEaorg68zE1TeNZT328e5L/hMa3buZPqztIWMCYqPyTtYDEKfeWc9HrjJxlxP
         Iw1w==
X-Gm-Message-State: AGRZ1gLppnB7e2dYQcBJTC8xdBIFUqulYzkc/bpmP726fb2eu+EypDER
        q7kVIxDMuT3viXy7jW53j07z/rzFXPyA10qYbnE=
X-Google-Smtp-Source: AJdET5d41WJkcStufXArkBFec7D+YPkJ4oVxCgtxxDc/mPdo1cd5PKTP0yZmDGxz8Jji+2omjZTbria4kdkxGLKHUp4=
X-Received: by 2002:a67:f43:: with SMTP id 64mr3575840vsp.166.1541757374523;
 Fri, 09 Nov 2018 01:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20181106183609.207702-1-sboyd@kernel.org> <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com> <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
In-Reply-To: <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Nov 2018 10:56:01 +0100
Message-ID: <CAMuHMdUTwUTdbKAWCNxH72-tvJuY-LtRO2Dh8izdEOKrFOSwLQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ryder.lee@mediatek.com, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Nov 7, 2018 at 7:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Rob Herring (2018-11-06 12:44:52)
> > On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > We have a handful of clk drivers that have a collection of slightly
> > > variant device support keyed off of the compatible string. In each of
> > > these drivers, we demux the variant and then call the "real" probe
> > > function based on whatever is stored in the match data for that
> > > compatible string. Let's generalize this function so that it can be
> > > re-used as the platform_driver probe function directly.
> >
> > This looks really hacky to me. It sounds kind of general, but really
> > only works if we have match data that's a single function and we lose
> > any type checking on the function.
>
> I don't know what this means. Are you saying that we lose the ability to
> type check the function pointer stored in the data member? I don't have
> a good answer for this besides it's not any worse than the status quo
> for the mediatek drivers.

The .data field has always been void *, and is used for storing different
things, depending on the driver.
It's already up to the driver writer to get that right.

> One alternative is to add a DT only array to the platform_driver struct
> that has the platform driver probe function type and matches the index
> in the of_device_id table. Then we can add some logic into
> platform_drv_probe() to look for this table being set and find the probe
> function to call. Then we still have match data for anything that wants
> that (maybe it could be passed in to the probe function) at the cost of
> having another array. I don't have a use-case for this right now so I'm
> not sure this is a great idea.
>
>   struct of_platform_driver_probe_func {
>         int (*probe)(struct platform_device *pdev);
>   };
>
>   struct of_platform_driver_probe_func mtk_probes[] = {
>         mtk_probe1,
>         mtk_probe2,
>         mtk_probe3,
>   };
>
>   struct platform_driver mtk_driver = {
>         .of_probes = &mtk_probes;
>         .driver = {
>                 .name = "mtk-foo";
>                 .of_match_table = mtk_match_table,
>         },
>   };

This looks worse to me: people tend to be very good at keeping multiple
arrays in sync :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
