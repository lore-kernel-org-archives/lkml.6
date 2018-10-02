Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691AC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECD12082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SfIcEq+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECD12082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJCDrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:47:05 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39850 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCDrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:47:05 -0400
Received: by mail-ua1-f66.google.com with SMTP id g18-v6so1279499uam.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zf2V439GYzJK2T5Zb1ekhih+h1St90s2/rvzerh7pZI=;
        b=SfIcEq+81xqBpagBGKBULxA7Cbm8UZjBcYahJW+UYaA+ZQz3VBGydRWDHEnIo5jhkv
         HU6Op5uX4oenVGsEm/i8iTskMDX9a4l4vGW9T9uCkz5zCvq3HpgTeQbzUmXy45kUK8Yg
         8f5vKYqAHshqkUKkirZqIJfHkCVASeY8r75Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zf2V439GYzJK2T5Zb1ekhih+h1St90s2/rvzerh7pZI=;
        b=Ak9UHtHVxw21imCsHDdlvTr9xLxdNZdF9PGpQ4YV0OqSc10c/jPV8bmhuexLDnT1tp
         vOq/Ie2DeArANXdWAZlTddc4ifuD41Se86+TNKziC7HKQyy6G1rUjpIl9DSKz2MR6rQu
         X/rMYsLQv/ff4TuxMIvxe0ivBebgZ26BD+wmPBd2ICX73YChVsAsDFgO+Yp3VIjYI722
         u+yynU91SHjAEUuR5hJRjEadwHomutMAf40yKlGHJm9y3iMmSYx9je9c9OfqIQ3ZUqmr
         3+4bczoI+sjA807e69lbnCUudA938LYDTLPmxrUwpnIc4vjqIXVeIcsD6YcLGelx/FgA
         LE5g==
X-Gm-Message-State: ABuFfohEY+vleFAIQx9kGGjP4cyOcVs9skNdI6WymYN1zfU9bY22DwHY
        ePaoQOFSI06S8ZxGA2l6vxIxp1oLjiU=
X-Google-Smtp-Source: ACcGV614KphhmklR4Ob02K/nbcsuAuP0xS7s8pxzqv1uH0ci14olkt+CsT3YPFkrmmUkDG4qCcGdbQ==
X-Received: by 2002:ab0:5b19:: with SMTP id u25-v6mr7715779uae.12.1538514109180;
        Tue, 02 Oct 2018 14:01:49 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 195-v6sm4128781vkz.13.2018.10.02.14.01.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:01:48 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id e128-v6so1939941vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:01:47 -0700 (PDT)
X-Received: by 2002:a67:83d5:: with SMTP id f204-v6mr6468659vsd.6.1538514107421;
 Tue, 02 Oct 2018 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
 <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Oct 2018 14:01:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com>
Message-ID: <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
To:     rafael@kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dilip Kota <dkota@codeaurora.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 2, 2018 at 1:29 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 2, 2018 at 10:05 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > In general Linux doesn't behave super great if you get an error while
> > > executing a device's resume handler.  Nothing will come along later
> > > and and try again to resume the device (and all devices that depend on
> > > it), so pretty much you're left with a non-functioning device and
> > > that's not good.
> > >
> > > However, even though you'll end up with a non-functioning device we
> > > still don't consider resume failures to be fatal to the system.  We'll
> > > keep chugging along and just hope that the device that failed to
> > > resume wasn't too critical.  This establishes the precedent that we
> > > should at least try our best not to fully bork the system after a
> > > resume failure.
> > >
> > > I will argue that the best way to keep the system in the best shape is
> > > to assume that if a resume callback failed that it did as close to
> > > no-op as possible.  Because of this we should consider the device
> > > still suspended and shouldn't try to suspend the device again next
> > > time around.  Today that's not what happens.  AKA if you have a
> > > device
> >
> > I don't think there are many guarantees when device resume fail. It
> > may have done nothing, and it may have resumed the device almost
> > fully.

With today's drivers you're probably right.  I don't think too many
drivers properly undo everything when they fail in the resume path.

...but it makes sense to have some sort of standard for how drivers
ought to behave.  IMO the most sane thing to do (and what we do in
probe--which is why EPROBE_DEFER mostly works) is that if a function
returns an error then it should try its best to undo everything it
did.  Then you can always try calling it again later.


> > I guess the best option would be to refuse system suspend after some
> > device failed like that.

Yeah, I thought about that.  I think we sometimes end up in that
situation today (without my patch) because the suspend callback
doesn't always work so great if the previous resume failed, so it's
entirely likely it'll return an error and block suspend...

 ...another thing I thought about was possibly trying to forcibly
unbind the device.  AKA: it's misbehaving so kick it out of the
system...  Of course if "resume" failed perhaps "remove" won't be so
happy...


> > That leaves user possibility to debug it...

You mean they wouldn't notice that some peripheral failed to resume
but they'd notice that their computer doesn't suspend any more?  Maybe
they'd notice, but it'd probably because they pulled their laptop out
of their bag and it was hot and had a dead batter.


> I guess so.
>
> Doing that in all cases is kind of risky IMO, because we haven't taken
> the return values of the ->resume* callbacks into account so far
> (except for printing the information that is), so there may be
> non-lethal cases when that happens and the $subject patch would make
> them not work any more.

I think you're arguing that the best option is to leave the code / API
exactly as-is because someone could be relying on the existing
behavior?  That is certainly the least likely to introduce any new
bugs.  ;-P

...would you accept a patch adding a comment codifying the existing
behavior (AKA suspend will be called again even if resume failed) as
the officially documented behavior?  Then we can start making new
drivers behave correctly at least.  If nothing else I can add a
boolean inside my driver data that says "resume failed, ignore the
next suspend".

...or if the official word is that if your resume fails you're totally
unrecoverable then I can start simplifying the error handling in
resume.  AKA instead of:

  hypothetical_resume(...) {
    ret = clk_enable(...);
    if (ret)
      return ret;
    ret = regulator_enable(...);
    if (ret)
      clk_disable(...);
    return ret;

...I can just change it to:

  hypothetical_resume(...) {
    ret = clk_enable(...);
    if (ret)
      return ret;
    return regulator_enable(...);

...the above would leave no way to recover the system because if
hypothetical_resume() returned an error we'd have no idea if the clock
was left enabled or not.  ...but if we're unrecoverable anyway why not
save the code?


-Doug
