Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56335C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158752081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158752081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKCBQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:16:29 -0400
Received: from foss.arm.com ([217.140.101.70]:43524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeKCBQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 082151596;
        Fri,  2 Nov 2018 09:08:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BBA03F718;
        Fri,  2 Nov 2018 09:08:49 -0700 (PDT)
Date:   Fri, 2 Nov 2018 16:08:45 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: Supporting core-specific instruction sets (e.g. big.LITTLE) with
 restartable sequences
Message-ID: <20181102160844.ihge4najccn63cxi@lakrids.cambridge.arm.com>
References: <313542172.8.1541171544337.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313542172.8.1541171544337.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Richard,

On Fri, Nov 02, 2018 at 11:12:24AM -0400, Mathieu Desnoyers wrote:
> Hi Richard,
> 
> I stumbled on these articles:
> 
> - https://medium.com/@jadr2ddude/a-big-little-problem-a-tale-of-big-little-gone-wrong-e7778ce744bb
> - https://www.mono-project.com/news/2016/09/12/arm64-icache/
> 
> and discussed them with Will Deacon. He told me you were looking into
> gcc atomics and it might be worthwhile to discuss the possible use of
> the new rseq system call that has been added in Linux 4.18 for those
> use-cases.
> 
> Basically, the use-cases targeted are those where some cores on the
> system support a larger instruction set than others. So for instance,
> some cores could use a faster atomic add instruction than others,
> which should rely on a slower fallback. This is also the same story
> for reading the performance monitoring unit counters from user-space:
> it depends on the feature-set supported by the CPU on which the
> instruction is issued. Same applies to cores having different
> cache-line sizes.

Please note that upstream arm64 Linux does not expose mismatched ISA
feature to userspace. We go to great pains to expose a uniform set of
supported features.

The two issues referenced above are both handled by the kernel, and no
userspace changes are required to handle them.

We do not intend or expect to expose mismatched features to userspace.
Correctly-written userspace should not use optional instructions unless
the kernel has advertised their presence via a hwcap (or via ID register
emulation).

> The main problem is that the kernel can migrate a thread at any point
> between user-space reading the current cpu number and issuing the
> instruction. This is where rseq can help.
> 
> The core idea to solve the instruction set issue is to set a mask of
> cpus supporting the new instruction in a library constructor, and then
> load cpu_id, use it with the mask, and branch to either the new or old
> instruction, all with a rseq critical section. If the kernel needs to
> abort due to preemption or signal delivery, the abort behavior would
> be to issue the fallback (slow) atomic operation, which guarantees
> progress even if single-stepping.
> 
> As long as the load, test and branch is faster than the performance
> delta between the old and new atomic instruction, it would be worth
> it.

Specifically w.r.t. the atomics, the kernel will only expose the
presence of the ARMv8.1 atomic instructions when supported by all CPUs
in the system.

> In the case of PMU read from user-space, using rseq to figure out how
> to issue the PMU read enables a use-case which is not otherwise
> possible to do on big.LITTLE. On rseq abort, it would fallback to a
> system call to read the PMU counter. This abort behavior guarantees
> forward progress.

We do not currently expose any PMU registers to userspace. If we were to
expose them for big.LITTLE, rseq may be of use, but no-one has done the
groundwork to investigate this.

> The second article is about cache line size discrepancy between CPUs.
> Here again, doing the cacheline flushing in a rseq critical section
> could allow tuning it to characteristics of the actual core it is
> running on. The fast-path would use a stride fitting the current core
> characteristics, and if rseq needs to abort, the slow-path would
> fall-back to a conservative value which would fit all cores (smaller
> cache line size on the overall system).

This is already handled by the kernel, and the proposed rseq approach is
not correct -- cache maintenance must *always* use the system-wide
minimum cacheline size, or stale entries will be left on some CPUs,
which will result in later failures.

Thanks,
Mark.
