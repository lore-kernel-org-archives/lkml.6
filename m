Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF223E65
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBF223E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933798AbeGCKDI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:08 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42927 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933565AbeGCKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:05 -0400
Received: by mail-ua0-f196.google.com with SMTP id x18-v6so837910uaj.9;
        Tue, 03 Jul 2018 03:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAS3rZP/ttINYp8QMal3PWWrDPD01eHFrDiG1j+9jDY=;
        b=KGqgph9JHgfQpuI7n8zty8kOxWkjPmjpxe5XFm2gIqBpMm3SnW/Y+4oReVoZmIAhLT
         jX/dC8zjiaDavgY0Vx6i2yNN6Zhoi9ewSUCCHJHir2HSXBrq16fvePMlV8XEwrMpTKmj
         zjjT6sK5KX6HOSdStRNTCikXaLGARZdB4fw4W0lb4UTvuIUhRvhw4efsY4hJjjKI7XtM
         pb3npcoLELXIBFop+VFrErcFvCbmIBFsuwKmldxo6kwSOGxWkSN0pJ7JRou/vUstikVV
         9V/wY50CSeDdk8CE+TeFeBdynfmgJgY8zmd2C0YYDLUSWXDaJqC6NXJAEIxvMoAlFx/g
         U7bA==
X-Gm-Message-State: APt69E0FrJxJfoH4Fbt1mVU/xJIhS4/Lp4N4IrvM6O60apsI2C+XH0+j
        GKDLvtFAMw6QUvo2HWODf+wMV168j0Ix3pyO/Tw=
X-Google-Smtp-Source: AAOMgpd4L+tE5A5XmCGOvxn23P9WxG/z7tm5itaJMppiP0SJixP17ASfkCv4KVmGG2H4+iSPemB9OfpaAoQ0SZuqiDM=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr19398838uas.26.1530612184296;
 Tue, 03 Jul 2018 03:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180619144141.8506-1-jbrunet@baylibre.com> <CAMuHMdVTZOS91UUK2zqq019xMPfLUVgDPD8EAWSHntza0-ShVw@mail.gmail.com>
 <1530611858.2900.201.camel@baylibre.com>
In-Reply-To: <1530611858.2900.201.camel@baylibre.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jul 2018 12:02:53 +0200
Message-ID: <CAMuHMdUpj7+to7ry1OQGN4-0v8o4+jBjHf+41z8PjGvJnHmG0Q@mail.gmail.com>
Subject: Re: [PATCH v4] clk: add duty cycle support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jul 3, 2018 at 11:58 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Tue, 2018-07-03 at 11:27 +0200, Geert Uytterhoeven wrote:
> > On Tue, Jun 19, 2018 at 4:42 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > Add the possibility to apply and query the clock signal duty cycle ratio.
> > >
> > > This is useful when the duty cycle of the clock signal depends on some
> > > other parameters controlled by the clock framework.
> > >
> > > For example, the duty cycle of a divider may depends on the raw divider
> > > setting (ratio = N / div) , which is controlled by the CCF. In such case,
> > > going through the pwm framework to control the duty cycle ratio of this
> > > clock would be a burden.
> > >
> > > A clock provider is not required to implement the operation to set and get
> > > the duty cycle. If it does not implement .get_duty_cycle(), the ratio is
> > > assumed to be 50%.
> > >
> > > This change also adds a new flag, CLK_DUTY_CYCLE_PARENT. This flag should
> > > be used to indicate that a clock, such as gates and muxes, may inherit
> > > the duty cycle ratio of its parent clock. If a clock does not provide a
> > > get_duty_cycle() callback and has CLK_DUTY_CYCLE_PARENT, then the call
> > > will be directly forwarded to its parent clock, if any. For
> > > set_duty_cycle(), the clock should also have CLK_SET_RATE_PARENT for the
> > > call to be forwarded
> > >
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >
> > Thanks for your patch!
> >
> > > ---
> > > The series has been developed to handled the sample clocks provided by
> > > audio clock controller of amlogic's A113 SoC. To support i2s modes, this
> > > clock need to have a 50% duty cycle ratio, while it should be just one
> > > pulse of the parent clock in dsp modes.
> >
> > "one pulse" means num = 1, den = the clock rate, right?
>
> No, it would be num = 1, den = divider

Right, thanks for correcting me!

> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -66,6 +68,17 @@ struct clk_rate_request {
> > >         struct clk_hw *best_parent_hw;
> > >  };
> > >
> > > +/**
> > > + * struct clk_duty - Struture encoding the duty cycle ratio of a clock
> > > + *
> > > + * @num:       Numerator of the duty cycle ratio
> > > + * @den:       Denominator of the duty cycle ratio
> > > + */
> > > +struct clk_duty {
> > > +       unsigned int num;
> > > +       unsigned int den;
> >
> > So shouldn't both fields be "unsigned long" instead, to match clock rates?
> > (Yes, I do know we don't support +4.3 GHz clock rates on 32-bit yet ;-)
>
> Not sure we need to match clock rates, long seems a bit too much.
> In the end, all we want a ratio, so a [0 - 1] number. Fraction using unsigned
> int already provide a pretty good precision (around 0.0002 ppm with 32bit)
>
> Do you have a use case where you need more than that ?

No, if den = divider, "unsigned int" is fine.
I wrongly assumed it could be equal to the clock rate.

> > Also, you may want to have a higher precision than degrees for the
> > phase property when handling pulses.
>
> Is this comment related to this patch ?

It's something to consider for the future, in case den > 360,
Probably its rare for divider values to be that large, though.
Again, I wrongly assumed den could be equal to the clock rate.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
