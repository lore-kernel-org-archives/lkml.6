Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D1C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4BF206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B1eg7ZdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4BF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeKUCfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:35:08 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40328 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUCfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:35:07 -0500
Received: by mail-ua1-f66.google.com with SMTP id n7so825416uao.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwbsCL5JXdLbbUc53sNOY7ajzSp0r0XJT9ZRI24D9TY=;
        b=B1eg7ZdLafGW4ZLJvTy7Exe8ELBibczbJ76JwAZOoA+PFsp1K0Ojd1yYOZAWB28geS
         6QTeMuATxHEvsowCI8c4LadgG3GtM73IMzv78NcxLxUVrEzlhgLceuQQyP8KsqCd9yvn
         4j1/PjXBgHhrReYmggIP5GF001wFOFqcDvUL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwbsCL5JXdLbbUc53sNOY7ajzSp0r0XJT9ZRI24D9TY=;
        b=jMHaqy+lQE9Ilifii7HOQ99/eZxN1B8mEirirhqVDW0FD/csuldf3a9FrDZOPFINg9
         WY6+I2Wivsa1EDWTIFh5OtYOzEjHT91ObxlVvEI7gbdEYA1Hzf0SDWa3CSCLzyKsCd/f
         0gmUOCs1JP0veQvlIzy46w6VtfzIZs8WS5FF3MkU56f05Om4kuPwf1FA/SkItAFQ9xrN
         t9kDe5utWsF8dW2KYHFfKI9LLum3y8xPN2Dc0iqvXWNPDVDqRlc/fvLbCYQmT31v6wz8
         ZfflRZ46ZMs0b4iMw3B/aAb7ZhzMKZ6Naxk1aLn/LBXMr9lh/9RpiaYMkY9AMG2nqivJ
         gbag==
X-Gm-Message-State: AA+aEWapSgPhecgdNlKOaVV12FoW2yDPY7aCuI6o7aY05lyK58Bj1D5U
        1IVmAhIXtyNiXlOj+xmQsd9mwFq3D+c=
X-Google-Smtp-Source: AFSGD/XCipAEainJBimOoVxAVufwmLmF5O9AkSI419gbtHLNOsnLFUHnqOWI4oR09eIbQOdnCFFHjA==
X-Received: by 2002:ab0:aa:: with SMTP id 39mr1131049uaj.120.1542729916338;
        Tue, 20 Nov 2018 08:05:16 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id f88sm12079957vsa.7.2018.11.20.08.05.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:05:13 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id t8so834364uap.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:05:12 -0800 (PST)
X-Received: by 2002:ab0:146b:: with SMTP id c40mr1120893uae.9.1542729911453;
 Tue, 20 Nov 2018 08:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-7-dianders@chromium.org>
 <20181120155458.GG3894@sirena.org.uk>
In-Reply-To: <20181120155458.GG3894@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 08:04:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UHiwjt2a8GFZKG3ZrRfjTgQDWD_mZu_qZP7Ve-HNTMYg@mail.gmail.com>
Message-ID: <CAD=FV=UHiwjt2a8GFZKG3ZrRfjTgQDWD_mZu_qZP7Ve-HNTMYg@mail.gmail.com>
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in regulator_force_disable()
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, digetx@gmail.com,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 7:55 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 19, 2018 at 04:26:54PM -0800, Douglas Anderson wrote:
> > In regulator_force_disable() there was a strange loop that looked like:
> >
> >   while (rdev->open_count--)
> >     regulator_disable(rdev->supply);
> >
> > I'm not totally sure what the goal was for this loop, but it seems
> > wrong to me.  If anything I think maybe we should have been looping
> > over our use_count, but even that might be a little strange.  For now
> > let's just remove the code and we can add something back in if someone
> > can explain what's expected.
>
> This should be using use_count, what that loop is doing is dropping all
> the enables that the regulator being force disabled had propagated up
> all the enables it passed up the chain of supplies.

OK, that makes much more sense then.  I can adjust it to do that.
I'll wait to see what happens with the rest of the patches in this
series and then post up a v2 of this one.  The number of disables
needed depends on how many of the patches in my series you like.  ;-)

In general it's hard for me to reason about how the system in general
should behave after regulator_force_disable() is called.  Is it
basically expected that the system will panic soon after?
Specifically other consumers of the same regulator will think it's on
but it won't actually be on.  What should happen if one of those other
consumers calls disable/enable?  Should the regulator turn back on?
...or is the regulator permanently off until the system reboots?

-Doug
