Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF19C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B2D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B2D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbeKXBOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:14:20 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58490 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeKXBOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:14:19 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gQCRn-0000MF-00; Fri, 23 Nov 2018 14:28:43 +0000
Date:   Fri, 23 Nov 2018 09:28:43 -0500
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
Message-ID: <20181123142843.GJ23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
 <20181122143603.GD23599@brightrain.aerifal.cx>
 <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com>
 <20181122151444.GE23599@brightrain.aerifal.cx>
 <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com>
 <87wop5xeit.fsf@oldenburg.str.redhat.com>
 <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
 <87k1l5xd33.fsf@oldenburg.str.redhat.com>
 <20181122171010.GH23599@brightrain.aerifal.cx>
 <871s7cvt1l.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s7cvt1l.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 02:10:14PM +0100, Florian Weimer wrote:
> * Rich Felker:
> 
> >> I'm not entirely sure because the glibc terminology is confusing, but I
> >> think it places intial-exec TLS into the static TLS area (so that it has
> >> a fixed offset from the TCB).  The static TLS area is placed on the
> >> user-supplied stack.
> >
> > This is an implementation detail that should not leak to applications,
> > and I believe it's still considered a bug, in that, with large static
> > TLS, it could overflow or leave unusably little space left on an
> > otherwise-plenty-large application-provided stack.
> 
> Sure, but that does not matter in this context because right now, there
> is no fix for this bug, and when we fix it, we can take backwards
> compatibility into account.
> 
> Any library that ends up using rseq will need to coordinate with the
> toolchain.  I think that's unavoidable given the kernel interface.

Right. I don't agree with this. What I'm saying is that this behavior
(putting static TLS in the caller-provided stack) should not be
documented as a behavior applications can rely on or accounted as a
solution to the rseq problem, since doing so would preclude fixing the
"application doesn't have as much stack as it requested" bug.

> >> > One issue here is that early adopter libraries cannot always use
> >> > the IE model. I tried using it for other TLS variables in lttng-ust, and
> >> > it ended up hanging our CI tests when tracing a sample application with
> >> > lttng-ust under a Java virtual machine: being dlopen'd in a process that
> >> > possibly already exhausts the number of available backup TLS IE entries
> >> > seems to have odd effects. This is why I'm worried about using the IE model
> >> > within lttng-ust.
> >> 
> >> You can work around this by preloading the library.  I'm not sure if
> >> this is a compelling reason not to use initial-exec TLS memory.
> >
> > Use of IE model from a .so file (except possibly libc.so or something
> > else that inherently needs to be present at program startup for other
> > reasons) should be a considered a bug and unsupported usage.
> > Encouraging libraries to perpetuate this behavior is going backwards
> > on progress that's being made to end it.
> 
> Why?  Just because glibc's TCB allocation strategy is problematic?
> We can fix that, even with dlopen.
> 
> If you are only concerned about the interactions with dlopen, then why
> do you think initial-exec TLS is the problem, and not dlopen?

The initial-exec model, *by design*, only works for TLS objects that
exist at initial execution time. That's why it's called initial-exec.
This is not an implementation flaw/limitation in glibc but
fundamental to the fact that you don't have an unlimited-size (or
practically unlimited) virtual address space range for each thread.
The global-dynamic model is the one that admits dynamic creation of
new TLS objects at runtime (thus the name).

> >> > The per-thread reference counter is a way to avoid issues that arise from
> >> > lack of destructor ordering. Is it an acceptable approach for you, or
> >> > you have something else in mind ?
> >> 
> >> Only for the involved libraries.  It will not help if other TLS
> >> destructors run and use these libraries.
> >
> > Presumably they should have registered their need for rseq too,
> > thereby incrementing the reference count. I'm not sure this is a good
> > idea, but I think I understand it now.
> 
> They may have to increase the reference count from 0 to 1, though, so
> they have to re-register the rseq area.  This tends to get rather messy.
> 
> I still I think implicit destruction of the rseq area is preferable over
> this complexity.

Absolutely. As long as it's in libc, implicit destruction will happen.
Actually I think the glibc code shound unconditionally unregister the
rseq address at exit (after blocking signals, so no application code
can run) in case a third-party rseq library was linked and failed to
do so before thread exit (e.g. due to mismatched ref counts) rather
than respecting the reference count, since it knows it's the last
user. This would make potentially-buggy code safer.

Rich
