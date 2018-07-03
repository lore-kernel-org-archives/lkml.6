Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E24C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BC524FFD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BC524FFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeGCA6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:58:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:49146 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752770AbeGCA6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:58:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w630vhE5011893;
        Mon, 2 Jul 2018 19:57:45 -0500
Message-ID: <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Tue, 03 Jul 2018 10:57:43 +1000
In-Reply-To: <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
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
         <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
         <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 12:24 -0700, Linus Torvalds wrote:
> On Mon, Jul 2, 2018 at 3:23 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > Let me try one last ditch attempt to convince you using maybe a
> > different perspective: this is how sysfs is intended to work and how
> > the device model already does everywhere else except the gluedirs.
> 
> So don't get me wrong. I don't think that patch is _wrong_. It may
> well be the best thing we can do now.
> 
> I just think some of the arguments for the patch are bogus.
> 
> I still think that the auto-cleanup is actually a good thing in
> general. Not because it simplifies things (which it can do), but
> because it fundamentally *allows* you to use less locking.
> 
> And that ends up being my real reason to not like your patch all that
> much. It depends on
> 
>  (a) an extra reference count

Right, that is not that great, and it might be possible to avoid it if
we have a way to check that the sysfs dir is empty. Maybe kobj->sd-
>subdirs ? This will find subdirs, not files, but for gluedirs that's
sufficient. I can play with that today see if it works.

BTW. Talking of extra reference counts, we already have two everywhere
afaik... kernfs has its own that's separate from the kobject one. I got
lost in that maze a couple of times already.

>  (b) on fairly heavy-handed locking (ie the whole "lock on release
> too, not just on allocation").

This is already there, I'm not adding it ;-) It's just ineffective
without my patch due to the possibility of the "auto-cleanup" to leak
outside the lock.

> and I think both of those are non-optimal.
> 
> So:
> 
> > The actual lifetime of the struct device is handled *separately* by
> > device_get/put which are just wrappers on kobject_get/put.
> 
> I agree that that is the end result of your patch (and perhaps the
> buggy intent of the original code).

This is the existing device_add/del without my patch. I was describing
how the core device stuff works for the normal device directories
today. My patch makes the gludirs do the same thing basically, which I
think was the intend of the code already but was broken.

> I just don't necessarily agree it's a great thing in general. It
> basically uses sysfs visibility as an argument for why lifetimes
> should differ from the refcounted lifetimes.

Yes, it does that so that we can remove and re-add without name
clashes.

> And that may be a practical argument, but I don't think it's a very
> good argument in general. I think it would arguably be much better to
> be less serialized, and depend on refcounting more, and make less of a
> deal about the sysfs visibility.
> 
> For example, if we *really* add back the exact same device immediately
> after removing it, and the device was still in use somehow (ie the
> refcount never went down to zero), maybe we really should not have
> reused the same name? Or if we do re-use the same name, maybe we
> should have re-used the device node itself?

Well, maybe but that's what we've been doing forever, and I think
drivers deal with it already. It applies to devices and to chardevs for
example.

> See what I'm saying? I understand where your patch is coming from, but
> I am suspicious of the fact that it seems to want to re-use a name
> (but not the object) that is by definition still in use.

Yes, I see what you mean.

I don't really have the same qualms as you do, it's how we've done
things forever (it's just that the gluedir code was broken), and it
generally works well.

It's not different in principle to what we do with files. You can
unlink an open file. It's still "in use" but the directory entry is
gone and one can create a new one.

It a slightly more roundabout way, we do that with mm_structs, the last
process can be gone but we keep them around due to being referenced (or
lazily attached to a kthread). Here we have 2 counters too.

> Maybe that's the right thing in this case. Considering that we have a
> real oops and a real problem, and I don't have an alternative patch, I
> guess the "patches talk, bullshit walks" rule applies.

Haha, as you prefer. Patch 1 fixes the oops, patch 2 fixes the name
collision, so in theory you could get away with just patch 1. But then
device would start failing to be re-added or re-bound.

(In my case it was a sub-device created by the driver of a parent
device, so it happens on bind/unbind of that parent driver).

I'll have a look see if I can find a way to check that the sysfs dir is
empty without adding that childcount, that would at least alleviate
some of your objection, and would probably make the patch
smaller/simpler.

Cheers,
Ben.

