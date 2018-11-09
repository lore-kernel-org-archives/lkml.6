Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E55C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ECF2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ECF2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeKJFAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:00:44 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44699 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeKJFAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:00:44 -0500
Received: by mail-ua1-f67.google.com with SMTP id d19so1004949uaq.11;
        Fri, 09 Nov 2018 11:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XICA14UI71g5WSSzu52+pvjsWPsZjVA4DkvDIrZNcq8=;
        b=cIu1PmEEndbK5Vw6CksL19DFK3VS4INAAAG4iUSyGbagM0ouAJ5fSE24DqGMH1MWNN
         3UDFwqRGffnEz20m7pCTZs10StkA7VMUhpYpKkrrOXFw2hTZc3bt55QG2kynhN8gx47p
         eA0pbLJnyKRmpE0y18vDotxqJVjkBK+83WTp410xwKHVTydVhufNTD0Yq+c+WRWn+sRN
         m3FqwYUYyzSY/pJM9OFkkYh1CFR/sLtqb4E7ZTdKj8nCo8Xtr1l3tZayZfgjMp054HlB
         zOfgGNbbSw28G3y1CLpWNgilzTx4j1+8DJSmW0yUvfxmLWE6pYK65hj2AofY4HC9X3HS
         xZwQ==
X-Gm-Message-State: AGRZ1gIgnO/LfCAud5Epx/VRkpzga3Smupek9tByMtp1PSWdPe2eHi1f
        bhkhb1RZcuIRgK9N149A4bwJdhJ/F0XMQvkmwK8=
X-Google-Smtp-Source: AJdET5ety9RP1kOu/TmLSP5bdi2hQABCKfHYNZ//KjG0M6PZ2jWWwLN6T+cIQ0VnBfx2VdxEKcmsR/kYCr88C5p1iwg=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr4717819ual.20.1541791126402;
 Fri, 09 Nov 2018 11:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20181106183609.207702-1-sboyd@kernel.org> <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
 <CAMuHMdUTwUTdbKAWCNxH72-tvJuY-LtRO2Dh8izdEOKrFOSwLQ@mail.gmail.com> <154178275324.88331.16237880990995819011@swboyd.mtv.corp.google.com>
In-Reply-To: <154178275324.88331.16237880990995819011@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Nov 2018 20:18:33 +0100
Message-ID: <CAMuHMdXTTCo6Fsr9eYstT6AFLOQ-_sKkhjw7cP8XdFabVqdJWw@mail.gmail.com>
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

On Fri, Nov 9, 2018 at 5:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-11-09 01:56:01)
> > On Wed, Nov 7, 2018 at 7:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Rob Herring (2018-11-06 12:44:52)
> > > > On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >         int (*probe)(struct platform_device *pdev);
> > >   };
> > >
> > >   struct of_platform_driver_probe_func mtk_probes[] = {
> > >         mtk_probe1,
> > >         mtk_probe2,
> > >         mtk_probe3,
> > >   };
> > >
> > >   struct platform_driver mtk_driver = {
> > >         .of_probes = &mtk_probes;
> > >         .driver = {
> > >                 .name = "mtk-foo";
> > >                 .of_match_table = mtk_match_table,
> > >         },
> > >   };
> >
> > This looks worse to me: people tend to be very good at keeping multiple
> > arrays in sync :-(
>
> To be _not_ very good? Agreed, and so specifying the probe function as
> another member in struct of_device_id seems to be the way to go.

Correct, sometimes sarcasm doesn't arrive well at the other end of the
electronic tunnel...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
