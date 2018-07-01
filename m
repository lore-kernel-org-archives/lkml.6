Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C2C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C408E25384
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408E25384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeGADtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 23:49:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:48288 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752164AbeGADtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 23:49:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w613nEjH020784;
        Sat, 30 Jun 2018 22:49:15 -0500
Message-ID: <9f2faf2b65f8025c70cbb233e0bae39df650860f.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Sun, 01 Jul 2018 13:49:14 +1000
In-Reply-To: <CA+55aFwwzF-PeS02x-9FFSQdPpJgmaEtC8KNfG_U_DTbSXz+-g@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
         <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
         <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
         <CA+55aFwwzF-PeS02x-9FFSQdPpJgmaEtC8KNfG_U_DTbSXz+-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-30 at 19:18 -0700, Linus Torvalds wrote:
> On Sat, Jun 30, 2018 at 7:07 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > Those locks won't protect kobj races in _general_ (ie there is no
> > locking between two totally unrelated buses), but they *should*
> > serialize the case of a device being added within one class. No?
> 
> Side note: there had *better* be some locking whenever there is a way
> to find an object, because otherwise you have a fundamental lifetime
> problem: one thread finding the object at the same time another thread
> frees it for the last time. Even the "unless_zero()" won't fix it,
> because the final free will release the underlying object itself, so
> the "zero" state is ephemeral.

Right. We agree. The problem here relates to that built-in cleanup in
kobject_release() which violates that rule: it removes the object from
sysfs (and from any kset) after the reference has been dropped.

Users such as the gluedir code try to workaround this by using outer
mutexes or locks, but it's fundamentally racy if there's any chance
that another 3rd party holds the last reference, since in that case,
the cleanup happens outside of any added locking.

That's why I tend to think that anything that relies on that "late
removal from sysfs" is broken by design :) Anything that uses kobject
should ensure they are taken out of sysfs and their respective ksets
before the last reference drops.

Now it's probably all fine for most cases, I assume sysfs itself checks
the reference to be non-0 in lookup path (I haven't checked), at least
to prevent use-after-free. This is still open to the duplicate name
issue. The bigger issue of use-after-free only happens in the rare
cases where there's a separate list being maintained and cleaned up
late.

The gluedir is such an example because it "manually" thrawls the kset
list.

So you are right, kobject_get should probably always be _unless_zero,
but my point is we even with that, we probably still need to ensure the
gluedir is taken out of the kset before we drop the last reference, so
this can be done with the appropriate upper layer subsystem locking,
and thus without racing with a new device being bound.
 
> That locking might be just RCU during lookup, and rcu-delaying the
> release, of course.  I think that's all the sysfs code needs, for
> example, since that's what lookup uses.
> 
> And for any other embedded kobj cases, where you can reach the object
> using some random subsystem pointers, there had better be other
> locking in place for that pointer lookup vs the last removal.
> 
> kobject itself doesn't provide that locking, it only provides the
> reference counting. But that's partly why it really has to disallow
> any kobject_get() of a zero object, because it means that the
> tear-down has been started, but the tear-down itself may not have had
> time to get the lock yet (ie kobject_release() may be just about to
> call the t->release() function).
> 
> But maybe I'm missing something subtle.
> 
>                Linus
