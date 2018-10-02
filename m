Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B1C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CA120684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CA120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeJCEBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:01:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37487 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCEBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:01:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so2770172oib.4;
        Tue, 02 Oct 2018 14:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtr/7CzJDyZIRjK+YUaNxhiQXpttkuG1NyC6n8XBz7Y=;
        b=ARohDp0H7Iikj/gDSFCt6cgHJx07WMoeXqCkzDLWwGwwnv3eVAdsa5tXHlLpQeEaxS
         5fEKQ25BaXzrDiUS9KYV+uhfVTd+vtCVa7u1FE1vkVtjeLaoJFAlndZK5sGHhaALJ4T+
         slCWChFvZLveULwnINVlOr7plm1RDHErtIt9tQfXbHTrN5RHV4LjwZLwn50kC4KOQMzL
         Gg37X0a7z8tW+9B2UmTpskbIOMirwgDpUeNxmgn6JSwLybYdM/yKde+d+Mlb5oM1Nu9R
         WCrGJFr5mazk67jvUN9MhwPn2BqMKNHwShi0X/zxwNP6jkINKU5kYa8MnnkCGoIarhr7
         fKKw==
X-Gm-Message-State: ABuFfojdEZzC+wRQORq//3YB3eqdofI6K1jaWJRagHCAM6xfwWLsidJV
        NmkkQmOsdmZLTDuFaZE1Sk3tY5c64DsXl8ItBws=
X-Google-Smtp-Source: ACcGV617kHih1SlT+Y89LL93v7fOVinfovqIm4vIeIfJ8GvZjTweJHBjM2CZ6BPw0BemDaKWXv/YjRkRV1ir2rDJtL8=
X-Received: by 2002:aca:c444:: with SMTP id u65-v6mr8607408oif.8.1538514994917;
 Tue, 02 Oct 2018 14:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
 <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com> <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com>
In-Reply-To: <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Oct 2018 23:16:23 +0200
Message-ID: <CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, dkota@codeaurora.org,
        Dmitry Torokhov <dtor@chromium.org>, swboyd@chromium.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 11:01 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Oct 2, 2018 at 1:29 AM Rafael J. Wysocki <rafael@kernel.org> wrote:

[cut]

> > I guess so.
> >
> > Doing that in all cases is kind of risky IMO, because we haven't taken
> > the return values of the ->resume* callbacks into account so far
> > (except for printing the information that is), so there may be
> > non-lethal cases when that happens and the $subject patch would make
> > them not work any more.
>
> I think you're arguing that the best option is to leave the code / API
> exactly as-is because someone could be relying on the existing
> behavior?  That is certainly the least likely to introduce any new
> bugs.  ;-P
>
> ...would you accept a patch adding a comment codifying the existing
> behavior (AKA suspend will be called again even if resume failed) as
> the officially documented behavior?

It is documented already IIRC, but yes.

> Then we can start making new
> drivers behave correctly at least.  If nothing else I can add a
> boolean inside my driver data that says "resume failed, ignore the
> next suspend".

Or maybe "fail the next suspend" even?

> ...or if the official word is that if your resume fails you're totally
> unrecoverable then I can start simplifying the error handling in
> resume.  AKA instead of:
>
>   hypothetical_resume(...) {
>     ret = clk_enable(...);
>     if (ret)
>       return ret;
>     ret = regulator_enable(...);
>     if (ret)
>       clk_disable(...);
>     return ret;
>
> ...I can just change it to:
>
>   hypothetical_resume(...) {
>     ret = clk_enable(...);
>     if (ret)
>       return ret;
>     return regulator_enable(...);
>
> ...the above would leave no way to recover the system because if
> hypothetical_resume() returned an error we'd have no idea if the clock
> was left enabled or not.  ...but if we're unrecoverable anyway why not
> save the code?

This really depends on the particular case.

If you deal with clocks directly, then you pretty much know whether or
not things are recoverable after a failing device resume, but if AML
tells you that it failed (say), you don't really know what happened.
In many cases the device that failed to resume will not work correctly
in the working state, but attempting to suspend it again may be fine.
It may recover after the next suspend-resume cycle even sometimes.  So
IMO drivers can do "smart" things if they really want to and know
enough, but there really is too much variation to handle it in the
core in a uniform way.

Thanks,
Rafael
