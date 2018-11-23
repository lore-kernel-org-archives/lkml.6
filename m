Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F151720672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F151720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440885AbeKXEQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:16:34 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58514 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436998AbeKXEQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:16:34 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gQFHX-0000px-00; Fri, 23 Nov 2018 17:30:19 +0000
Date:   Fri, 23 Nov 2018 12:30:19 -0500
From:   Rich Felker <dalias@libc.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
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
Message-ID: <20181123173019.GK23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
 <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com>
 <87wop5xeit.fsf@oldenburg.str.redhat.com>
 <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
 <87k1l5xd33.fsf@oldenburg.str.redhat.com>
 <20181122171010.GH23599@brightrain.aerifal.cx>
 <871s7cvt1l.fsf@oldenburg.str.redhat.com>
 <20181123142843.GJ23599@brightrain.aerifal.cx>
 <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:05:20PM -0500, Mathieu Desnoyers wrote:
> ----- On Nov 23, 2018, at 9:28 AM, Rich Felker dalias@libc.org wrote:
> [...]
> > 
> > Absolutely. As long as it's in libc, implicit destruction will happen.
> > Actually I think the glibc code shound unconditionally unregister the
> > rseq address at exit (after blocking signals, so no application code
> > can run) in case a third-party rseq library was linked and failed to
> > do so before thread exit (e.g. due to mismatched ref counts) rather
> > than respecting the reference count, since it knows it's the last
> > user. This would make potentially-buggy code safer.
> 
> OK, let me go ahead with a few ideas/questions along that path.
                                                 ^^^^^^^^^^^^^^^
> 
> Let's say our stated goal is to let the "exit" system call from the
> glibc thread exit path perform rseq unregistration (without explicit
> unregistration beforehand). Let's look at what we need.

This is not "along that path". The above-quoted text is not about
assuming it's safe to make SYS_exit without unregistering the rseq
object, but rather about glibc being able to perform the
rseq-unregister syscall without caring about reference counts, since
it knows no other code that might depend on rseq can run after it.

> First, we need the TLS area to be valid until the exit system call
> is invoked by the thread. If glibc defines __rseq_abi as a weak symbol,
> I'm not entirely sure we can guarantee the IE model if another library
> gets its own global-dynamic weak symbol elected at execution time. Would
> it be better to switch to a "strong" symbol for the glibc __rseq_abi
> rather than weak ?

This doesn't help; still whichever comes first in link order would
override. Either way __rseq_abi would be in static TLS, though,
because any dynamically-loaded library is necessarily loaded after
libc, which is loaded at initial exec time.

> There has been presumptions about signals being blocked when the thread
> exits throughout this email thread. Out of curiosity, what code is
> responsible for disabling signals in this situation ? Related to this,
> is it valid to access a IE model TLS variable from a signal handler at
> _any_ point where the signal handler nests over thread's execution ?
> This includes early start and just before invoking the exit system call.

It should be valid to access *any* TLS object like this, but the
standards don't cover it well. Right now access to dynamic TLS from
signal handlers is unsafe in glibc, but static is safe.

Rich
