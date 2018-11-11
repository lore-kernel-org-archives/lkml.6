Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59858C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBF420818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBF420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeKKUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:51:07 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41860 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeKKUvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:51:07 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wABB2aqv004374;
        Sun, 11 Nov 2018 12:02:36 +0100
Date:   Sun, 11 Nov 2018 12:02:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181111110236.GA4189@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <20181111081725.GA30248@1wt.eu>
 <87y39zx5xa.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y39zx5xa.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:30:25AM +0100, Florian Weimer wrote:
> * Willy Tarreau:
> 
> > On Sun, Nov 11, 2018 at 07:55:30AM +0100, Michael Kerrisk (man-pages) wrote:
> >> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399 is a
> >>     longstanding example.
> >
> > This one was a sad read and shows that applications will continue to
> > suffer from glibc's prehistorical view on operating systems and will
> > continue to have to define their own syscall wrappers to exploit the
> > full potential of the modern operating systems they execute on.
> 
> What's modern about a 15-bit thread identifier?

It's 15-bit on 32-bit systems, and 22 on 64-bit, hence you can have
4 million threads and/or processes on a single system image provided
you have the resources for that of course.

> I understand that using this interface is required in some cases (which
> includes some system calls for which glibc does provide wrappers), but I
> assumed that it was at least understood that these reusable IDs for
> tasks were an extremely poor interface.  Aren't the resulting bugs
> common knowledge?

Sure, just as are the bugs created by people trying to implement their
own syscall wrappers. It's not by denying access to some native system
interfaces that you will prevent users from accessing them, you'll just
force them to work around the restriction and make things even worse.

> > This reminds me when one had to write their own spinlocks and atomics
> > many years ago. Seeing comments suggesting an application should open
> > /proc/$PID makes me really wonder if people actually want to use slow
> > and insecure applications designed this way.
> 
> I don't understand.  If you want a non-reusable identifier, you have to
> go through the /proc interface anyway.  I think the recommendation is to
> use the PID/start time combination to get a unique process identifier or
> something like that.

It depends what you want to achieve. If you just need the tid, the one
you'll pass to sched_setaffinity(), gettid() is fine. There are two issues
with abusing /proc to emulate syscalls :
  - it's sometimes much slower than the equivalent syscall and can
    encourage users to cache the resulting values when they should not
  - either it's done upon process startup and it may not get valid value
    or may not work if /proc is not mounted yet (think init, mount etc),
    or it's done upon first use and can break daemons which chroot()
    themselves.

Syscalls don't have such limitations and are much safer to use. For other
things it's quite possible that you cannot rely on this syscall at all,
it's not a solution to everything, but it's a nice solution to all cases
where you need to access the system-wide identifier to pin a thread to a
given CPU set or renice it.

> I wanted to add gettid to glibc this cycle, but your comments suggest to
> me that if we did this, we'd likely never get a proper non-reusable
> thread identifier from the kernel.  So I'm not sure what do anymore.

"Look people, I was about to do what we all refused to do for 10 years
now and Willy's comment made me change my mind, I'm sorry". The *real*
argument that most users could understand is "guys, we're sorry, but we
are running out of time and we won't work on this low priority stuff,
so someone else will have to take care of it".

In my opinion what matters is not whether or not people will use it
appropriately, but that its validity, side effects and wrong assumptions
are properly documented so that users don't shoot themselves in the foot.
But I guess that most of those defining it by themselves already figured
this out and are happy to use this available syscall when their application
wants to make use of certain feature that are offered by their operating
system.

Thanks,
Willy
