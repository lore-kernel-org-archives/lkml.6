Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587DD2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587DD2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbeGaXEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:04:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeGaXEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:04:45 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkc5s-00048l-QX; Tue, 31 Jul 2018 23:22:13 +0200
Date:   Tue, 31 Jul 2018 23:22:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 6/7] x86/vdso: Add vDSO functions for user wait
 instructions
In-Reply-To: <2267fbe6-37e8-7063-d48f-1879f31d3258@kernel.org>
Message-ID: <alpine.DEB.2.21.1807312220490.1713@nanos.tec.linutronix.de>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com> <1532350557-98388-7-git-send-email-fenghua.yu@intel.com> <2267fbe6-37e8-7063-d48f-1879f31d3258@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Andy Lutomirski wrote:
> On 07/23/2018 05:55 AM, Fenghua Yu wrote:
> >     static void __init init_vdso_funcs_data(void)
> >   {
> > +	struct system_counterval_t sys_counterval;
> > +
> >   	if (static_cpu_has(X86_FEATURE_MOVDIRI))
> >   		vdso_funcs_data.movdiri_supported = true;
> >   	if (static_cpu_has(X86_FEATURE_MOVDIR64B))
> >   		vdso_funcs_data.movdir64b_supported = true;
> > +	if (static_cpu_has(X86_FEATURE_WAITPKG))
> > +		vdso_funcs_data.waitpkg_supported = true;
> > +	if (static_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> > +		vdso_funcs_data.tsc_known_freq = true;
> > +		sys_counterval = convert_art_ns_to_tsc(1);
> > +		vdso_funcs_data.tsc_per_nsec = sys_counterval.cycles;
> > +	}
> 
> You're losing a ton of precision here.  You might even be losing *all* of the
> precision and malfunctioning rather badly.

Indeed.

> The correct way to do this is:
> 
> tsc_counts = ns * mul >> shift;

> and the vclock code illustrates it.

Albeit you cannot use the TSC mult/shift pair as that is for the TSC to
nsec conversion.

To get the proper mult/shift pair use clocks_calc_mult_shift(). Note that
the scaled math has an upper limit when using 64 bit variables. You might
need 128bit scaled math to make it work correctly.

> convert_art_ns_to_tsc() is a bad example because it uses an expensive
> division operation for no good reason except that no one bothered to
> optimize it.

Right. It's not a hot path function and it does the job and we would need
128bit scaled math to avoid mult overflows.

Aside of that I have no idea why anyone would use convert_art_ns_to_tsc()
for anything else than converting art to nsecs.

> > +notrace int __vdso_umwait(int state, unsigned long nsec)
> 
> __vdso_umwait_relative(), please.  Because some day (possibly soon) someone
> will want __vdso_umwait_absolute() and its friend __vdso_read_art_ns() so they
> can do:
> 
> u64 start = __vdso_read_art_ns();

Errm. No. You can't read ART. ART is only used by decives to which it is
distributed. You can only read TSC here and convert that to nsecs.

> __vdso_umonitor(...);
> ... do something potentially slow or that might fault ...
> __vdso_umwait_absolute(start + timeout);

That definitely requires 128bit scaled math to work correctly, unless you
make the timeout relative before conversion.

But I really think we should avoid creating yet another interface to
retrieve TSC time in nsecs. We have enough of these things already.

Ideally we'd use CLOCK_MONOTONIC here, but that needs more thought as:

  1) TSC might be disabled as the timekeeping clocksource

  2) The mult/shift pair for converting to nanoseconds is affected by
     NTP/PTP so it can be different from the initial mult/shift pair for
     converting nanoseconds to TSC.

A possible solution would be to use CLOCK_MOTONIC_RAW which is not affected
by NTP/PTP adjustments. But that still has the issue of TSC not being the
timekeeping clocksource. Bah, the whole TSC deadline mode sucks. I have no
idea what's wrong with simple down counters. They Just Work.

> Also, this patch appears to have a subtle but show-stopping race.  Consider:

It's not the patch which has this issue. It's the hardware ....

> 1. Task A does UMONITOR on CPU 1
> 2. Task A is preempted.
> 3. Task B does UMONITOR on CPU 1 at a different address
> 4. Task A resumes
> 5. Task A does UMWAIT
> 
> Now task A hangs, at least until the next external wakeup happens.
> 
> It's not entirely clear to me how you're supposed to fix this without some
> abomination that's so bad that it torpedoes the entire feature. Except that
> there is no chicken bit to turn this thing off.  Sigh.

That sounds similar to the ARM monitor which is used for implementing
cmpxchg. They had to sprinkle monitor aborts all over the place....

So yes, unless there is undocumented magic which aborts the monitor under
certain circumstances, this thing is broken beyond repair.

Thanks,

	tglx
