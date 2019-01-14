Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A73206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Hs4YDnIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfANQjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:39:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37116 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfANQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:39:15 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so284740iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4eMAoM3dueu9tdN2alk+e9naC0qCTwzhI+dbVx9zeuM=;
        b=Hs4YDnINzRcBymtgkH1QjDkRRKyjvdS5hg31F7QmIex88RXSDaogmf35wwbz5GbqbL
         LJr0WBRI/oCxHhMswne/U0LVhC2gc8omHqgavlFzSJo2zl7ByYSUjSBEHfGbqVZwuffo
         BXD0sYbrDKSsB523hSAWzEgm1d06IBvOwmYpg8gODvSzOm53CFABMzFk4Dpevlz38jDO
         tVpstyf75J6/lim2xRvcxLKWIIHKI01Q46wW2J9KtR8Tok+7LgyVm0KqVaW/OMXez8v/
         dEDOtoT6SAYAzX2LtJIQnlSn7PmwEEgHfs3B5TcKQNjYcSJ2dL3Y3J2kTvrpIe6z/Z98
         HSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4eMAoM3dueu9tdN2alk+e9naC0qCTwzhI+dbVx9zeuM=;
        b=RORSdI7BnaH4wzq3NqjRmliIeKtqeu0stqAeLqipA1F2ZnV1Kr4rrIcngmuJCodSwy
         7bE1yAlPWfPHbn7ula343kx63AyRalDbjOLcQoGL+Pt1gPT73RNtBPDLUmp2hkocfWnF
         /o41zd0qhYKQ/DYha7rTvfR00MRewOIk/Wt3Q39Lc+/0AAQaP/Wn+IfhYJFpv0OLYvQm
         tcqYVaaw1BgqvZrhtYXDSB3mSrs4wlIpLTnW+2eiSQEadOQ9mRYPOTIxz05+zOBYJIbW
         xgc1ov4tmRcZBzVnLzhEnOKx/5KiGEdBBdBH9IIIkAezxQrquksSYUQZ6eDUNfRKwEgg
         WhMw==
X-Gm-Message-State: AJcUukf8/fDbCdl69f4ithJI4sTn6eTsdY40JEVpFzWMO5FT7OsndSds
        ePfJUkdpa8nQANGIxIVWIoDGdhSTORbhtGSbtrtMPg==
X-Google-Smtp-Source: ALg8bN5tcnmDdiIhUssiiqYEaqTx2Ak6DZXtkaUHCjh/XhooSc7fj9HDS3Cld/xcZY5YqzyuojgR8k3Y8nZm5IB2h28=
X-Received: by 2002:a24:f909:: with SMTP id l9mr22116ith.74.1547483954668;
 Mon, 14 Jan 2019 08:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20190111172134.30147-1-brgl@bgdev.pl> <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
In-Reply-To: <08200de1-fde5-c525-c874-c7872259067b@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Jan 2019 17:39:03 +0100
Message-ID: <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 14 sty 2019 o 13:20 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> Hi Bartosz,
>
> On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Currently the clocksource and clockevent support for davinci platforms
> > lives in mach-davinci. It hard-codes many things, used global variables=
,
> > implements functionalities unused by any platform and has code fragment=
s
> > scattered across many (often unrelated) files.
> >
> > Implement a new, modern and simplified timer driver and put it into
> > drivers/clocksource. We still need to support legacy board files so
> > export a config structure and a function that allows machine code to
> > register the timer.
> >
> > We don't check the return values of regmap reads and writes since with
> > mmio it's only likely to fail due to programmer's errors.
> >
> > We also don't bother freeing resources on errors in
> > davinci_timer_register() as the system won't boot without a timer anywa=
y.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> With this series, DA830 fails to boot. Rest of the devices are okay from
> boot perspective.
>
> DA830 is pretty unique because it uses the same timer-half for both
> clocksource and clockevent. May be you can set the same configuration on
> your DA850 to see the same issue? Else, I will enable low-level debug
> and try to provide more debug data.
>

I can't boot da850 with the same config as da830 (0x60 compare
register, compare irq 74) even with the old timer code. Just to make
sure: does da830 boot fine with mainline v5.0-rc2?

> Some minor comments below from quick look:
>
> > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/=
timer-davinci.c
> > new file mode 100644
> > index 000000000000..7282a1fda80f
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-davinci.c
> > @@ -0,0 +1,415 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * TI DaVinci clocksource driver
> > + *
> > + * Copyright (C) 2019 Texas Instruments
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + * (with some parts adopted from code by Kevin Hilman <khilman@baylibr=
e.com>)
>
> Did you really intend GPL v2 or later? The original code referred to
> above is marked 2.0 only.
>

I'm not sure. Should it be GPLv2 only? I'm not well versed with licensing.

Bart

> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sched_clock.h>
> > +
> > +#include <clocksource/timer-davinci.h>
> > +
> > +#define DAVINCI_TIMER_REG_TIM12                      0x10
> > +#define DAVINCI_TIMER_REG_TIM34                      0x14
> > +#define DAVINCI_TIMER_REG_PRD12                      0x18
> > +#define DAVINCI_TIMER_REG_PRD34                      0x1c
> > +#define DAVINCI_TIMER_REG_TCR                        0x20
> > +#define DAVINCI_TIMER_REG_TGCR                       0x24
> > +
> > +#define DAVINCI_TIMER_TIMMODE_MASK           0x0000000c
> > +#define DAVINCI_TIMER_RESET_MASK             0x00000003
> > +#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED        0x00000004
> > +#define DAVINCI_TIMER_UNRESET                        0x00000003
>
> I think these are more readable if using BIT() and GENMASK()
>
> Thanks,
> Sekhar
