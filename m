Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E9EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6022089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6022089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJCPhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:37:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42864 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJCPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:37:20 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 3733e642accb7c62; Wed, 3 Oct 2018 10:49:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     rafael@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Dilip Kota <dkota@codeaurora.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns an error
Date:   Wed, 03 Oct 2018 10:46:52 +0200
Message-ID: <1820725.IoyLWzYgSM@aspire.rjw.lan>
In-Reply-To: <CAD=FV=XU45z=kvO48Cwhi2NxuOBermbnEdxov5kZtt-VdMB4GA@mail.gmail.com>
References: <20180927203523.60856-1-dianders@chromium.org> <CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com> <CAD=FV=XU45z=kvO48Cwhi2NxuOBermbnEdxov5kZtt-VdMB4GA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 3, 2018 12:16:51 AM CEST Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 2, 2018 at 2:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Oct 2, 2018 at 11:01 PM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Oct 2, 2018 at 1:29 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > [cut]
> >
> > > > I guess so.
> > > >
> > > > Doing that in all cases is kind of risky IMO, because we haven't taken
> > > > the return values of the ->resume* callbacks into account so far
> > > > (except for printing the information that is), so there may be
> > > > non-lethal cases when that happens and the $subject patch would make
> > > > them not work any more.
> > >
> > > I think you're arguing that the best option is to leave the code / API
> > > exactly as-is because someone could be relying on the existing
> > > behavior?  That is certainly the least likely to introduce any new
> > > bugs.  ;-P
> > >
> > > ...would you accept a patch adding a comment codifying the existing
> > > behavior (AKA suspend will be called again even if resume failed) as
> > > the officially documented behavior?
> >
> > It is documented already IIRC, but yes.
> 
> Ah ha!  I'm guessing this is the documentation you're talking about in pm.h?
> 
>  * All of the above callbacks, except for @complete(), return error codes.
>  * However, the error codes returned by @resume(), @thaw(), @restore(),
>  * @resume_noirq(), @thaw_noirq(), and @restore_noirq(), do not cause the PM
>  * core to abort the resume transition during which they are returned.  The
>  * error codes returned in those cases are only printed to the system logs for
>  * debugging purposes.  Still, it is recommended that drivers only return error
>  * codes from their resume methods in case of an unrecoverable failure (i.e.
>  * when the device being handled refuses to resume and becomes unusable) to
>  * allow the PM core to be modified in the future, so that it can avoid
>  * attempting to handle devices that failed to resume and their children.
> 
> To me the above reads as "the behavior of the kernel right now isn't
> quite right, but we'll fix it in the future".

This is just a recommendation due to a possible change in the core in future,
not a FIXME comment or similar.

And this recommendation hasn't been universally followed AFAICS.

> It also don't explicitly state that the next "suspend" will still be called.

It also doesn't explicitly state that the next "suspend" will not be called. :-)

> That's implicit in the "all we do is print a message" but the "we'll fix it
> in the future" makes me feel like that might change.

It might, but it didn't. :-)

> ...if there's some other documentation you're thinking of then I'm
> happy to keep looking.

There is the more detailed suspend and resume description in
Documentation/driver-api/pm/devices.rst (but that doesn't say what
will happen on the next suspend if the current resume fails too, which
basically means to expect it to be carried out as usual).

> > > ...or if the official word is that if your resume fails you're totally
> > > unrecoverable then I can start simplifying the error handling in
> > > resume.  AKA instead of:
> > >
> > >   hypothetical_resume(...) {
> > >     ret = clk_enable(...);
> > >     if (ret)
> > >       return ret;
> > >     ret = regulator_enable(...);
> > >     if (ret)
> > >       clk_disable(...);
> > >     return ret;
> > >
> > > ...I can just change it to:
> > >
> > >   hypothetical_resume(...) {
> > >     ret = clk_enable(...);
> > >     if (ret)
> > >       return ret;
> > >     return regulator_enable(...);
> > >
> > > ...the above would leave no way to recover the system because if
> > > hypothetical_resume() returned an error we'd have no idea if the clock
> > > was left enabled or not.  ...but if we're unrecoverable anyway why not
> > > save the code?
> >
> > This really depends on the particular case.
> >
> > If you deal with clocks directly, then you pretty much know whether or
> > not things are recoverable after a failing device resume, but if AML
> > tells you that it failed (say), you don't really know what happened.
> > In many cases the device that failed to resume will not work correctly
> > in the working state, but attempting to suspend it again may be fine.
> > It may recover after the next suspend-resume cycle even sometimes.  So
> > IMO drivers can do "smart" things if they really want to and know
> > enough, but there really is too much variation to handle it in the
> > core in a uniform way.
> 
> Got it.  Right that every driver will be different and we can't
> possibly magically "fix the world" and universally recover from all
> errors.  ...and putting too much smarts in the drivers doesn't make a
> lot of sense since really we're in a mostly unrecoverable place
> anyway.
> 
> In any case, if I don't hear anything else I'll assume that the
> officially documented suggestion is to assume that suspend() will
> still be called after a failed resume() (AKA today's behavior) and I
> should code drivers to that standard until I hear otherwise.

Yes, that's the current behavior and there are no plans to change it.

Thanks,
Rafael

