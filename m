Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6BFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E9620685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E9620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440996AbeKXEac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:30:32 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58538 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeKXEac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:30:32 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gQFVO-0000se-00; Fri, 23 Nov 2018 17:44:38 +0000
Date:   Fri, 23 Nov 2018 12:44:38 -0500
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
Message-ID: <20181123174438.GL23599@brightrain.aerifal.cx>
References: <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com>
 <87wop5xeit.fsf@oldenburg.str.redhat.com>
 <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
 <87k1l5xd33.fsf@oldenburg.str.redhat.com>
 <20181122171010.GH23599@brightrain.aerifal.cx>
 <871s7cvt1l.fsf@oldenburg.str.redhat.com>
 <20181123142843.GJ23599@brightrain.aerifal.cx>
 <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
 <20181123173019.GK23599@brightrain.aerifal.cx>
 <87zhtzsngn.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhtzsngn.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 06:39:04PM +0100, Florian Weimer wrote:
> * Rich Felker:
> 
> > On Fri, Nov 23, 2018 at 12:05:20PM -0500, Mathieu Desnoyers wrote:
> >> There has been presumptions about signals being blocked when the thread
> >> exits throughout this email thread. Out of curiosity, what code is
> >> responsible for disabling signals in this situation ? Related to this,
> >> is it valid to access a IE model TLS variable from a signal handler at
> >> _any_ point where the signal handler nests over thread's execution ?
> >> This includes early start and just before invoking the exit system call.
> >
> > It should be valid to access *any* TLS object like this, but the
> > standards don't cover it well.
> 
> C++ makes it undefined:
> 
>   <http://eel.is/c++draft/support.signal#def:evaluation,signal-safe>

C also leaves access to pretty much anything from a signal handler
undefined, but that makes signals basically useless. POSIX
inadvertently defines a lot more than it wanted to by ignoring
indirect ways you can access objects using AS-safe functions to pass
around their addresses; there's an open issue for this:

http://austingroupbugs.net/view.php?id=728

I think it's reasonable to say, based on how fond POSIX is of signals
for realtime stuff, that it should allow some reasonable operations,
but just be more careful about what it allows, and disallowing access
to TLS would preclude the only ways to make signals non-awful for
multithreaded processes.

Rich
