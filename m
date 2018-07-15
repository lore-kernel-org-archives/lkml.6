Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891A7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 05:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D32086E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 05:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208D32086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeGOGTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 02:19:32 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:10733 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeGOGTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 02:19:32 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w6F5vNs1019370;
        Sun, 15 Jul 2018 07:57:23 +0200
Date:   Sun, 15 Jul 2018 07:57:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180715055723.GA18578@1wt.eu>
References: <20180501205448.GE10479@thunk.org>
 <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu>
 <20180502194139.GA18390@sasha-vm>
 <20180502200229.GA12729@1wt.eu>
 <20180714173812.xhfwtcijlxebmn2k@devuan>
 <e1198cd9-9113-d231-d15a-31ac5224b3b1@roeck-us.net>
 <20180714194716.GA27381@amd>
 <4fbbb00c-dcc1-8a2a-a1c6-8d61d545b7b6@roeck-us.net>
 <20180714210913.GA31065@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714210913.GA31065@amd>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 11:09:13PM +0200, Pavel Machek wrote:
> > For anyone interested in making sure that obscure (whatever that means)
> > drivers are tested for stable releases, but does not want to spend time on it,
> > all I can recommend is to implement qemu support for it and let me know,
> > and I'll be happy to add a respective test to my test farm.
> 
> Umm. Yes, qemu support for every driver would be nice, but will not happen.

Well, I would argue that driver code changes much less than core code
between kernel versions, and that most of the changes in drivers are
mostly infrastructure changes. Drivers don't evolve much in general,
they are written, tested, merged, they receive fixes and then they
only receive infrastructure changes that touch all drivers in the same
category.

When you backport fixes to drivers, it is very common that the code
looks almost the same between even a very old kernel and mainline, and
when not, the adaptations generally look quite straightforward, and if
not it means the driver changed significantly and in this case we don't
backport the fix as we don't even know if it is relevant.

I've always had much more difficulties backporting fixes under the arch/
subdir where stuff changes all the time. Sometimes a patch applies but
doesn't even compile. I learned not to play black magic in this area
because some patches are subtle and if the code changed you often need
the author and/or maintainers to double-check. Some subsystems like KVM
improve a lot over time and are difficult to backport to as well, and
even if you manage to properly backport a fix you're uncertain how to
verify you backported it well. Similarly you don't want to improvise
yourself the backporter of the year in this area.

Drivers are often OK and are the ones harder to test, so in the end
you don't miss much by your limited ability to test a backport there.

What I can certainly say as a stable kernel user is that the regression
rate is so low compared to the fix rate that I never have any problem
upgrading to a more recent version in the same branch, because the
number of problems that will be fixed is much higher than the risk of
a single regression.

As Guenter says, we can always improve, but the most important is to
deliver fixes in a timely manner. When you see that any LTS branch
accumulates around 5000 fixes over time, you understand that any
single new kernel being released contains around 5000 bugs left to be
found. Fixing them quickly is much more important to me (as a user)
than ensuring that I will not reach 5001 by inheriting from a poorly
tested backport.

My hope is that thanks to all the automated testing in place we can
further accelerate the backport rate so that a stable kernel reaches
in 2 months the level of quality that we previously used to reach only
after one year. And I think we're already about there, as both 4.4.x
and 4.9.x in their early versions (x < 10) were already very good for
various use cases. 4.17.5 I'm using on this PC looks pretty slick as
well. Overall it means that we can provide a clean upgrade path for
users so that they don't stick to bogus or insecure kernels by fear
of upgrading. We can always argue that a bug may appear once in a
while but for me while technically this is true, stastistically this
is just FUD and is not relevant to end users' real usage.

Willy
