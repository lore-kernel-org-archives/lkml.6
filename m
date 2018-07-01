Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1FD25385
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 03:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1FD25385
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeGADwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 23:52:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:48302 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbeGADwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 23:52:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w613qCiV020823;
        Sat, 30 Jun 2018 22:52:13 -0500
Message-ID: <743d1ab2e9cf2e89ef5a024e4b29b5f37ad45c00.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 01 Jul 2018 13:52:12 +1000
In-Reply-To: <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This is a resend with lkml added for background & archival purposes)

On Sat, 2018-06-30 at 12:29 -0700, Linus Torvalds wrote:
> On Thu, Jun 28, 2018 at 7:19 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > For devices with a class, we create a "glue" directory between
> > the parent device and the new device with the class name.
> > 
> > This directory is never "explicitely" removed when empty however,
> > this is left to the implicit sysfs removal done by kobjects when
> > they are released on the last kobject_put().
> > 
> > This is problematic because as long as it's not been removed from
> > sysfs, it is still present in the class kset and in sysfs directory
> > structure.
> 
> Ok, so I don't hate the patch per se, but looking around, I think this
> is still wrong in the end.
> 
> Why?
> 
> Because normally, the last kobject_put() really does do a synchronous
> kobject_del(). So normally, this is all completely pointless, and the
> normal kobject lifetime rules should be sufficient.

Not entirely sadly....

There's a small race between the kref going down to 0 and the last
kobject_put(). Something might still "catch" the 0-reference object
during that window. 

In this specific case our bacon is mostly saved by the gdp_mutex which
is taken by cleanup_glue_dir() around what *should* be the lats
kobject_put.... but what if it isn't ?

If anything else happens to hold a reference to the directory object
(open files in sysfs maybe ?), then the last put will come from
elsewhere and will happen without that mutex being held, thus re-
opening the tiny race.

Is this possible ?
 
> So I *think* your problem happens because you have
> CONFIG_DEBUG_KOBJECT_RELEASE enabled, and that intentionally delays
> the cleanup.

I think it just opens an existing race more widely. The race always
exist becaues another CPU can observe the object between the reference
going to 0 and the last kobject_del done by kobject_release. That's one
main reason why I dislike this "auto-clean" mechanism.

One other way to solve it, which I just thought about, could be to,
inside kobject_put() itself, check that the reference is *1* and do
kobject_del() before the last kref_put. That does mean that somebody
can snatch it in that window after it's been removed from sysfs though,
is that ok ? It won't crash I suppose...

> This is actually not really what DEBUG_KOBJECT_RELEASE is really
> documented to do.  It is documented as a "let's debug problems where
> drivers think deletion is immediate", but the sysfs interaction with
> the same-name issue really smells different.
> 
> So what the patch does is basically to just fight
> DEBUG_KOBJECT_RELEASE delaying rules, and that kind of stinks.

Not entirely, it fight an existing race that DEBUG_KOBJECT_RELEASE just
opens more widely.

> To me, it really feels like either we should see the
> DEBUG_KOBJECT_RELEASE rules are "real" (in which case fighting them is
> wrong), or we should admit that DEBUG_KOBJECT_RELEASE causes problems
> (in which case we should probably try to fix the debug aid).
> 
> Ben, can you confirm that your problem just goes away if you don't
> select DEBUG_KOBJECT_RELEASE?

The easily reproducable crash goes away, because the device I've been
observing these is a tiny slow single core ARM embedded thing. But I'm
not sure the therical race is solved.

> Greg - comments? The pattern of "remove last device, add a new device
> of the same class" really seems to be a valid pattern, and
> CONFIG_DEBUG_KOBJECT_RELEASE seems to actively break it.
> 
> Could we perhaps add a synthetic test for exactly this pattern (add a
> silly device with a bogus class, remove it, and add another device
> with the same class)?
> 
>                  Linus
