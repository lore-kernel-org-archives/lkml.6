Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B103C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9963920870
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeGADmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 23:42:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:59418 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbeGADmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 23:42:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w613gddx020624;
        Sat, 30 Jun 2018 22:42:40 -0500
Message-ID: <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Sun, 01 Jul 2018 13:42:39 +1000
In-Reply-To: <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
         <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
         <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-30 at 19:07 -0700, Linus Torvalds wrote:
> [ Ben - feel free to post the missing emails to lkml too ]
> 
> On Sat, Jun 30, 2018 at 6:56 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > On Sat, 2018-06-30 at 12:29 -0700, Linus Torvalds wrote:
> > > 
> > > Because normally, the last kobject_put() really does do a synchronous
> > > kobject_del(). So normally, this is all completely pointless, and the
> > > normal kobject lifetime rules should be sufficient.
> > 
> > Not entirely sadly....
> > 
> > There's a small race between the kref going down to 0 and the last
> > kobject_put(). Something might still "catch" the 0-reference object
> > during that window.
> 
> That's only true if the underlying subsystem doesn't have any
> serialization itself.
> 
> Which I don't think is normal.
> 
> IOW, if you have (say) a PCI hotplug model, the PCI layer will have
> the pci_hp_mutex, for example, which protects the PCI hotplug slot
> lists and the kobj things.
> 
> Those locks won't protect kobj races in _general_ (ie there is no
> locking between two totally unrelated buses), but they *should*
> serialize the case of a device being added within one class. No?
> 
> If not, maybe we need to add some class-based serialization.

Well, yes and no ... yes I agree there should be upper level
serialization such that you can't hit the "add" path until the "del"
path has completed.

And this will work as long as the kobject_put done at the end of "del"
is indeed the very last one.

But what if something *else* still holds a reference to the kobject ?
It could be anything really... the driver itself, that is now unbound,
might have a client that's holding a stale reference because some
chardev is still open, for example. I don't know if sysfs can also hold
one because a users still has an open directory there, but in the
general case I don't thing one can assume that the kobject_put() done
by the end of the "owner" subsystem delete path (in our example
device_del) is the very last kobject_put.

And since some other random thing might be doing that last put, it may
also do it without any of the upper level locking/serialization.

Which is the reason I so dislike the whole "cleanup sysfs in the last
kobject_put" we do in kobject_release(). This is also why we clearly
differenciate in the device model device_del from the final device_put
etc...

We generally separeate "visibility to the outside world" from the
actual object lifetime, the latter being what the kref controls.

 .. except when we dont, such as this gluedir case. And I think that's
wrong in principle.

This is the reason why I prefer the approach of explicitely doing the
kobject_del() instead of kobject_put() in the tail of device_del (what
this 2/2 patch does), because it restores that separation between the
object being "active/visible" or not from the actual lifetime of the
structure.

> > I think it just opens an existing race more widely. The race always
> > exist becaues another CPU can observe the object between the reference
> > going to 0 and the last kobject_del done by kobject_release.
> 
> No it really damn well can't, exactly because we should not allow it -
> and allowing it would be fundamentally racy.
> 
> We should never allow a kobject_get() with a zero reference count.
> It's always a *fundamental* bug - see my other email on your 1/2
> patch.

It is and there's a WARN_ON about it inside kobject_get(). I don't
think anybody argues against that, you are absolutely right.

That said, the fact that it happens is I think the result of a deeper
problem of conflating the visibility of the object and its refcount,
and the fact that we do the sysfs "cleanup" (visibility) after we've
dropped the last reference.

Yes, the race is generally not going to happen if the put() done by the
owning subystem is indeed the last one, because as you said, the
subsystem should have higher level locking to precent racing between
removal and addition.

However, it *can* happen because by definition kobjects can have
references held elsewhere for any reason, and those can be dropped
outside of any subsystem locking.

> So there is no race, because the reference count itself protects the
> object. Either another CPU gets it in time (before it went down to
> zero), or it went down to zero and it is dead (because at that point,
> deletion will have been scheduled.
> 
> Note that this is entirely independent of the auto-clean actions,
> since even with absolutely zero cleanup, you still have the
> fundamental issue of "reference count goes to zero causes the object
> to be free'd".

Yes.

Cheers,
Ben.

