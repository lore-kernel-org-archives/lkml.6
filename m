Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E30C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D91F252BE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D91F252BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeGAHQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 03:16:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:50502 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbeGAHQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 03:16:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w617GOs8025316;
        Sun, 1 Jul 2018 02:16:25 -0500
Message-ID: <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Sun, 01 Jul 2018 17:16:24 +1000
In-Reply-To: <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
         <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
         <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
         <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
         <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-30 at 20:57 -0700, Linus Torvalds wrote:
> On Sat, Jun 30, 2018 at 8:42 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > But what if something *else* still holds a reference to the kobject ?
> > It could be anything really... t
> 
> But that's fine. Then the object will continue to exist, and the sysfs
> file will continue to exist, and you won't get a new glue directory.

I suspect you didn't read it my entire argument or I wasn't clear
enough :-) This is actually the crux of the problem:

Yes the object continues to exist. However, the *last* kobject_put to
it will no longer be done under whatever higher level locking the
subsystem provides (whatever prevents for example concurrent add and
removes).

Thus in that scenario the "last minute" kobject_release() done by the
last kobject_put() will be effectively unprotected from for example the
gdp_mutex (in the case of the gluedirs) or whatever other locking the
subsystem owning the kobject is using to avoid making that "refount 0"
object "discoverable".

So not only the conitnued existence of the object will potentially
trigger the duplicate sysfs name problem, but it *will* also re-open
the window for the object to be temporarily be visible with a 0
refcount.

The kobject debugging doesn't create a new race here. It just
significantly increase the size of an existing race window.

You argued yourself that the reason that window is a non-issue without
kobject debugging is that the expectation is that the release happens
synchronously with the last kobject_put done by device_del, which has
appropriate higher-level locking.

My point is that this specific assumption doesn't hold in the case
where another reference exists. In that case the object will be freed
with the race open for others to observe it while its refcount is 0.

> In fact, what you describe is a problem with *your* patch, exactly
> because you introduce another counter that is *not* the reference
> count, and now you have the problem with "old directory kobject is
> still live, but I removed the sysfs part, and now I'm creating a new
> object with the same name".
> 
> Hmm?

So my patch 1/2 prevents us from finding the old dying object (and thus
from crashing) but replaces this with the duplicate name problem.

My patch 2/2 removes that second problem by ensuring we remove the
object from sysfs synchronously in device_del when it no longer
contains any children, explicitely rather than implicitely by the
virtue of doing the "last" kobject_put.

You'll notice the existing code wraps that kobject_put() with the
gdp_mutex, specifically I suppose to synronize with the creation path
of the gluedir, ie with the expectation that this kobject_put() will
synchronously remove the object from the kset.

I argue this assumption is flawed, that another reference could delay
the removal from the kset to a point where the mutex isn't held, and
thus the race re-opens.

My patch doesn't implement a separate "refcount" per-se, it implements
a "childcount". This is akin to mm_users vs mm_count.

We want the glue dir to be removed when it has no more children, we
currently "conflate" this with the kobject having no reference. This is
what I argue is incorrect. The kobject can have "unrelated" references,
that define the lifetime of the object in memory, but it's presence in
sysfs is dictated by the number of children it contains.

> > It is and there's a WARN_ON about it inside kobject_get(). I don't
> > think anybody argues against that, you are absolutely right.
> 
> No.  That the zero kobject_get() will not result in a warning. It just
> does a kref_get(), no warnings anywhere.

It's there but it's in refcount:

void refcount_inc(refcount_t *r)
{
	WARN_ONCE(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
}
EXPORT_SYMBOL(refcount_inc);

In fact that's how I started digging into that problem in the first place :-)

> Yes, there is a kobject_get() warning, but that's about an
> _uninitialized_ kobject, not a already released one! You will get no
> warning that I can see from the "oh, you just got a stale one".

Cheers,
Ben.

>            Linus
