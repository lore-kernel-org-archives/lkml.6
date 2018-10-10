Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE242087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NKv2kd8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE242087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeJJIlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:41:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38897 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeJJIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:41:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so1685053plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=0R2ZEYs8mcnmKsrDE/Wcut83OmNFs/kPv+xCZo/6axo=;
        b=NKv2kd8hXoabImMq7Ax55oaIrHLWc0xjlvtz+o4fEagI2omjGDwQoFycZuYKvnDH41
         g1U55JOVO7s1fkDhZG8Kqn6HuxWS7vJ2Jr5Nhpq/SZE55n0b0q0EpnWK0//sdCWG6B1S
         QTPx8Ogc1294eC8qg4bz6tW0woCte3i6S97JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=0R2ZEYs8mcnmKsrDE/Wcut83OmNFs/kPv+xCZo/6axo=;
        b=QanFXbyoYwcdcPk99mMY77e4EtpmGxfUtY/+gBFAMwJQEnuC98bo65fyLG5JurU2xC
         15T2hmkt+SlhQhMbIZzZlxi6vJlZsmIb6mE2lXwFTbCt+kJkAGIEAoUT0Oygwdml5470
         jgkDaO5BiCxqjLuJvIT3Jf98oGaLtC9n97V2fqGh3bk1kW7webwD50V6M63sVdsSuw0H
         EvBaMCqEarIop6NrjBSYglCUE9i6/rYcLRUzo69OPMU8M7PvuMQ4lYGanqPmvpt3G2+b
         W/rdEj0jQOOyE6l+UuwlZRZ4JxKcSX4JsrbSBfbT1OOWbweR5P8duU2obNa/LIiMtUJK
         hfTA==
X-Gm-Message-State: ABuFfojyw7fPa0kupfHIR9Yfa62WU+26TEeFFLg0XjEH7v3rd/AAeDye
        3K2petY0uVwnfOVYlz3qHPTmAA==
X-Google-Smtp-Source: ACcGV60HXgdJg/GJ32r1eWf9HqSwshGY+DDNTqQ9WXGYRG0+IriytO/4vuai8+kQYuHl5PmbLg+/ew==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34-v6mr31257645pld.244.1539134523865;
        Tue, 09 Oct 2018 18:22:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id j19-v6sm10039341pfi.137.2018.10.09.18.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 18:22:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=UAfF2rcqdJv30Vd6WXz1qciNVKj2aGq6YTO3+NLVE7yA@mail.gmail.com>
Cc:     alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
 <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
 <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
 <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com>
 <153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com>
 <CAD=FV=UAfF2rcqdJv30Vd6WXz1qciNVKj2aGq6YTO3+NLVE7yA@mail.gmail.com>
Message-ID: <153913452169.119890.11450124419228013575@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date:   Tue, 09 Oct 2018 18:22:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-10-09 14:18:26)
> Hi,
> On Tue, Oct 9, 2018 at 12:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Doug Anderson (2018-10-09 10:48:55)
> > >
> > > Ah, you're suggesting separating the platform_get_irq() and the
> > > request_irq() so that we call platform_get_irq() as the first thing in
> > > the function but don't do the request_irq() until later.  Yeah, that
> > > could be done and I guess if you feel strongly about it I wouldn't
> > > object to the change, but I don't feel it buys us a lot and I kind of
> > > like keeping the two next to each other.  Specifically why I don't
> > > think it buys us a lot:
> > >
> > > 1. You still need the "dev_err" print, right?  platform_get_irq()
> > > doesn't automatically print errors for you I think.
> >
> > I usually leave it out. Who cares? Maybe we should throw a dev_err()
> > into platform_get_irq() on failure so we can keep drivers cleaner and
> > reduce a bunch of "can't find my IRQ" messages throughout the kernel.
> =

> Yeah, all the boilerplate code is annoying.  ...of course by hoisting
> it up then you get a whole bunch of people that have "optional" IRQs
> suddenly getting error messages spewed which is also no good.  IMO the
> convention of Linux drivers I've always reviewed is to print errors
> like this, so unless that changes my vote is to follow convention.
> =

> =

> > > 2. You now need a local variable "irq".  By putting the
> > > platform_get_irq() before the memory allocation you now can't store it
> > > directly in mas->irq.  We could try using "ret" as a temporary
> > > variable but that seems worse in this case since it'd be a bit
> > > fragile.
> > >
> > > 3. You don't get rid of any error labels / error handling so we don't
> > > really save any code
> > >
> > > When I tried this my diffstat says 8 lines added and 7 removed, so a
> > > net increase in LOC FWIW.  I'm relying in gmail so my patch will be
> > > whitespace-damaged (sigh), but you can find a clean one at:
> > >
> > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/e03=
25d618e209c22379e3a4269c14627b19243a8%5E%21/#F0
> > >
> > > ...the basic idea is this though:
> > >
> >
> > Thanks! Here's an updated patch that I haven't compile tested in any way
> > that hoists up the IO mapping part too, which shows that the 'se' local
> > variable is almost entirely useless.
> =

> Yeah, I'd be all for getting rid of "se".  I'm still not really seeing
> the benefit of hoisting all the rest of the stuff up.  Do you feel
> strongly about it?
> =

> In any case I think we've both said that all of our comments so far
> are just nits and could be addressed in a followup patch.  Unless Mark
> Brown wants these nits fixed ahead of time or has other changes he'd
> like, I don't think we're expecting another spin of this patch from
> Alok or Dilip, right?  We'd just expect them to post some follow-up
> patches after Mark lands it?
> =

> =


Yes this is all nits territory. I don't really care too much, but the
patch is already written, so might as well roll it all in and make
things shiny.

Time to get back to real work :P

