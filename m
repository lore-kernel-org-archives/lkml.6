Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EEAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8499825C1A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8499825C1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965542AbeGBKYA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:24:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:42993 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965103AbeGBKX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:23:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w62ANnTV019724;
        Mon, 2 Jul 2018 05:23:50 -0500
Message-ID: <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Mon, 02 Jul 2018 20:23:48 +1000
In-Reply-To: <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
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
         <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 09:36 +1000, Benjamin Herrenschmidt wrote:
> > No. See above. The reason I think your patch 2/2 is wrong is that is
> > actually *breaks* the above model, exactly because of that thing that
> > you hatre.
> > 
> > The explicit removal is actively wrong for the "I want to reuse the
> > object" model, exactly because it happens before the refcount has gone
> > to zero.
> 
> That's indeed where we disagree.

Sooo...

I had some quality time with my good friend Oban 14 last night,
thinking through this and during the resulting hangover today. I've
tried very hard to "get" your perspective, but after another dive
through the code, I'm afraid I still think patch 2/2 is the right thing
to do.

(Let's ignore patch 1/1 for now and assume we get that part right)

Let me try one last ditch attempt to convince you using maybe a
different perspective: this is how sysfs is intended to work and how
the device model already does everywhere else except the gluedirs.

Sooo... let's start pulling the string bit by bit...

I think you agree since (I'm not going to try to quote you here) you
did mention adding/removing need to generally be protected by higher
level locks in whatever subsystem owns the kobjects. I don't think
there's an argument here.

This is hinted by some comments (among others) in sysfs/dir.c about the
kobject owner being responsible to ensure that removal doesn't race
with any operation, which is hard to do when such removal doesn't
happen under subsystem internal locks.

Now let's look at how things are handled for a normal struct device
kobject.

The device core provides device_add and device_del functions. Those are
completely orthogonal to the object lifetime controlled by
device_initialize (creation) and device_put. And for good reasons (yes,
there are helpers, device_register/unregister that combine them, but
those are just that... helpers).

Why ? For the exact same reason mentioned above: Along with all the
driver binding/unbinding business etc... those functions ensure that
the kobject of the device is added/removed from sysfs under all the
necessary locks in the device model, so that they cannot race with each
other.

This guarantees among others that it is possible to do a new device_add
for the same device immediately after device_del, without clashing with
a duplicate sysfs name, *even* if something still holds a reference to
the kobject for any reason (and there are plenty of these, see the cdev
example below).

The actual lifetime of the struct device is handled *separately* by
device_get/put which are just wrappers on kobject_get/put.

This is the same with a cdev. cdev_add and cdev_del or their friends
cdev_device_add/del do the same thing. The chardev case is interesting
specifically because it is much more common for these to persist
(lifetime) beyond cdev_del. You just need userspace to have an open
file descriptor to the chardev. Drivers have to deal with it of course,
they need to handle things like read/write/ioctl being called on
already open files after remove/del/unbind, and hopefully do so.

*But* it's also possible to create a new identical cdev with the same
sysfs name immediately after cdev_device_del even if the old one still
has open instanced precisely because we separate the sysfs presence,
handled through the device model internal locking, from the object
lifetime.

Now, going back to our gluedirs, in essence those are just more objects
owned by the device core. More specifically, they need to be created
synchronously with the first child device of a class added under a
given parent, and removed synchronously with the last child device of
that class under that same parent.

Delaying that removal from sysfs simply means that we now are unable to
re-add the same device after removing it for some arbitrary amount of
time, because something might still hold a kobject reference to the
gluedir for any reason, it doesn't matter.

It also means that the deletion from sysfs is no longer synchronized
with addition since it no longer happens from within the context of
decice_del which is the "owner" of the glue dir, under whatever locks
it uses to ensure there is no races between multiple devices addition
removal etc...

In fact, if you look at the code and the way the gdp_mutex is used, I
think this is *exactly* the intention of the code. That the
kobject_put() done inside device_del() is the last one, done under that
mutex, thus removing the gluedir synchronously and we have no race.

However, that code just fails to take into account the delayed removal
by kobject debugging and the possibility of another reference existing.

Now it's possible there there can be no other references of a gluedir
today, to be frank I haven't audited the entire code base to figure out
if anything can possibly hold one that isn't a child of that gluedir,
so if indeed there can't be any and the only references to the kref
possible *ever* on a gluedir are its children, then it's possibe that
the assumption holds, except with kobject debugging.

However, even if that is the case, I call it fragile. I think we should
ensure, which is what patch 2/2 does, that regardless of "when" the
object is actually freed, and regardless of what other references might
exist, the gluedir behaves just like other struct device or cdev, and
gets removed from sysfs synchronously, along with the last child, with
all the necessary device core mutexes held, as to never race with an
addition and as to never trigger the duplicate name problem.

Now, I know why you dislike patch 2/2, because it adds another counter,
and there's something "itchy" about having a refcount and that
childcount.

We don't absolutely need that childcount. It could be that we have ways
to ask sysfs whether there are any children left in that directory,
which would work as well, I just haven't really figured out how, and a
child count felt like a trivial way to solve the problem. It's
protected by the gdp_mutex so it's safe.

There are precedents to such dual counters, such as mm_users vs
mm_count. There are precedents to separating file system visibility
from lifetime, every fs does it with unlink() when there are still open
files, so I think overall, what I'm trying to achieve is just pretty
much standard practice: unlink the gluedir exactly when it needs to be
unlinked so a new one can be created when needed, and deal with
lifetime of the actual structure the usual way which can be delayed.

Now if this doesn't convince you, I'm afraid nothing will ;-)

I'm curious to hear from Greg though.

Cheers,
Ben.


