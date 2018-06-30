Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E3C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729D0280C2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729D0280C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbeF3BEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:04:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:39493 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbeF3BEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:04:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5U14aeo001625;
        Fri, 29 Jun 2018 20:04:38 -0500
Message-ID: <61424071cc0feb487e4b8ce2c9c396df2fc56bd9.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 30 Jun 2018 11:04:36 +1000
In-Reply-To: <CA+55aFwZG+wWwRX-FOgQHwt3eA76qgKb0W0sRGSd8Ug=szr20A@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <ac64e45950c8e3df26fd50e7b251d5895c1d2201.camel@kernel.crashing.org>
         <CA+55aFwZG+wWwRX-FOgQHwt3eA76qgKb0W0sRGSd8Ug=szr20A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 06:56 -0700, Linus Torvalds wrote:
> On Thu, Jun 28, 2018 at 7:22 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > This fixes it by instead doing an explicit kobject_del() when
> > the glue dir is empty, by keeping track of the number of
> > child devices of the gluedir.
> 
> Ugh. I was hoping that you'd just do the "only check duplicate names
> if actually in use" instead.

I had a look (see my other email). It's non-trivial. We can still look
into it, but from what I gathered of how sysfs works, it's based on
kernfs which doesn't have the kobjects nor access to the reference
count, and is the holder of the names rbtree.

So we'd need to find a way to convey that "in-use" information down to
kernfs (I thought maybe adding an optional pointer to a kref ? but
then, it's still somewhat racy ...)

Additionally, we would need a few more pairs of eyes to make sure that
sticking duplicates in that rbtree isn't going to break some corner
case in there.

It's a code base I'm not at all familiar with. So while I agree with
the overall idea that a kobject whose reference has gone down to 0
should probably be ignored by sysfs, actually doing it doesn't seem
simple.

> This patch seems to make patch 1/2 pointless. No?

Somewhat. It's stil the "right thing" to do in case a hole shows up
elsewhere, and it's an easier stable backport. But yes. I wrote it
before I figured out what to do with 2/2 (I was still trying to do what
you wanted and just skip ref=0 in sysfs name lookups).

But yes, with 2/2, there shouldn't be a kobject with a 0 ref in the
list anymore... hopefully.

I would very much appreciate the opinion of someone more familiar with
sysfs and the device core on all this though.

Cheers,
Ben.

