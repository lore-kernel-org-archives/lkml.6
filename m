Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD91C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CFF25C5C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CFF25C5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965544AbeGBKWj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:22:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:38416 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965469AbeGBKWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:22:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w62AMHVw019580;
        Mon, 2 Jul 2018 05:22:19 -0500
Message-ID: <280670daea92b750dd215d876ed2e400ce589a13.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Mon, 02 Jul 2018 20:22:17 +1000
In-Reply-To: <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
         <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
         <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
         <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
         <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
         <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
         <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 10:04 -0700, Linus Torvalds wrote:
> On Sun, Jul 1, 2018 at 12:16 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > I suspect you didn't read it my entire argument or I wasn't clear
> > enough :-) This is actually the crux of the problem:
> > 
> > Yes the object continues to exist. However, the *last* kobject_put to
> > it will no longer be done under whatever higher level locking the
> > subsystem provides (whatever prevents for example concurrent add and
> > removes).
> 
> Well, yes and no.
> 
> Why "no"?
> 
> The last dropping is actually not necessarily that interesting.
> Especially with the sysfs interface, we basically know that you can
> look up the object using RCU (since that's what the filesystem lookup
> does), and that basically means that the refcount is always the final
> serialization mechanism.There is nothing else that can possibly lock
> it.
> 
> So this is where we disagree:
> 
> > Thus in that scenario the "last minute" kobject_release() done by the
> > last kobject_put() will be effectively unprotected from for example the
> > gdp_mutex (in the case of the gluedirs) or whatever other locking the
> > subsystem owning the kobject is using to avoid making that "refount 0"
> > object "discoverable".
> 
> No. *Fundamentally*, there is only one thing that protects that
> object: the refcount.
> 
> And my argument is that anything that has this model (which means
> anything that has any sysfs linkage, which pretty much means any
> kobject) absolutely *must* use "kobject_get_unless_zero()" unless it
> had an existing stable pointer and just wants to increase the refcount
> (ie "already got a reference throuigh one of my data structures that
> use the lock")
> 
> But if you have that model, that means that the "last drop" is
> actually almost totally irrelevant.  Because it doesn't matter if it's
> done inside the lock or not - you know that once it has been done,
> that object is entirely gone. It's not discoverable any more -
> regardless of locking. The discoverability is basically controlled
> entirely by the refcount.
> 
> So what happens then?
> 
> The locking isn't important for the last release, but it *is*
> important for new object *creation*.
> 
> Why?
> 
> The refcount means that once an object is gone, it's gone for
> *everyone*. It's a one-way thing, and it's thread-safe. So the code
> that does *creation* can do this:
> 
>  - get subsystem lock
>  - look up object (using the "unless_zero()" model)
>  - if you got the object, re-use it, and you're done: drop lock and return
>  - otherwise, you know that nobody else can get it either
>  - create new object and instantiate it
>  - drop lock
> 
> and this means that you create a new object IFF the old object had its
> refcount drop to zero. So you always have exactly one copy (or no copy
> at all, in between the last drop and the creation of the new one).
> 
> See? The lack of locking at drop time didn't matter.  The refcount
> itself serialized things.
> 
> So the above is what I *think* the "glue_dir" logic should be. No need
> for any other count. Just re-use the old glue dir if you can find it,
> and create a new one if you can't.
> 
> The one important thing is that the object lookup above needs to use
> the lookup needs to find the object all the way until the refcount has
> become zero. And that actually means that the object MUST NOT be
> removed from the object lists until *after* the refcount has been
> decremented to zero. Which is actually why that "automatic cleanup"
> that you hate is actually an integral and important part of the
> process: removing the object *before* the refcount went to zero is
> broken, because that means that the "look up object" phase can now
> miss an object that still has a non-zero refcount.
> 
> > So my patch 1/2 prevents us from finding the old dying object (and thus
> > from crashing) but replaces this with the duplicate name problem.
> 
> So I absolutely agree with your patch 1/2. My argument against it is
> actually that I think the "unless_zero" thing needs to be more
> universal.
> 
> > My patch 2/2 removes that second problem by ensuring we remove the
> > object from sysfs synchronously in device_del when it no longer
> > contains any children, explicitely rather than implicitely by the
> > virtue of doing the "last" kobject_put.
> 
> No. See above. The reason I think your patch 2/2 is wrong is that is
> actually *breaks* the above model, exactly because of that thing that
> you hatre.
> 
> The explicit removal is actively wrong for the "I want to reuse the
> object" model, exactly because it happens before the refcount has gone
> to zero.
> 
> > > No.  That the zero kobject_get() will not result in a warning. It just
> > > does a kref_get(), no warnings anywhere.
> > 
> > It's there but it's in refcount:
> > 
> > void refcount_inc(refcount_t *r)
> > {
> >         WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
> > }
> > EXPORT_SYMBOL(refcount_inc);
> > 
> > In fact that's how I started digging into that problem in the first place :-)
> 
> Hey, you are again hitting this because of extra config options.
> 
> Because the refcount_inc() that I found looks like this:
> 
>   static inline void refcount_inc(refcount_t *r)
>   {
>           atomic_inc(&r->refs);
>   }
> 
> and has no warning.
> 
> I wonder how many people actually run with REFCOUNT_FULL that warns -
> because it's way too expensive. It's not set in the default Fedora
> config, for example, and that's despite how Fedora tends to set all
> the other debug options.
> 
> So no, it really doesn't warn normally.
> 
>                 Linus
