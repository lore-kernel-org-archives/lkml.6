Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD134C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB5320872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB5320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeFTNaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:30:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60341 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754318AbeFTNaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:30:05 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVdB5-0005t9-Lj; Wed, 20 Jun 2018 15:29:39 +0200
Date:   Wed, 20 Jun 2018 15:29:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 7/7] x86/tsc: use tsc early
In-Reply-To: <20180620123208.GN2476@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806201521530.1693@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-8-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de> <20180620091532.GK2476@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806201231030.10546@nanos.tec.linutronix.de> <20180620123208.GN2476@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Peter Zijlstra wrote:
> On Wed, Jun 20, 2018 at 12:42:40PM +0200, Thomas Gleixner wrote:
> > On Wed, 20 Jun 2018, Peter Zijlstra wrote:
> 
> > > I'm still puzzled by the entire need for tsc_early_enabled and all that.
> > > Esp. since both branches do the exact same thing:
> > > 
> > > 	return cycles_2_ns(rdtsc());
> > 
> > Right. But up to the point where the real sched_clock initialization can be
> > done and the static keys can be flipped, there must be a way to
> > conditinally use TSC depending on availablility and early initialization.
> 
> Ah, so we want to flip keys early, can be done, see below.
> 
> > You might argue, that we shouldn't care becasue the jiffies case is just
> > the worst case fallback anyway. I wouldn't even disagree as those old
> > machines which have TSC varying with the CPU frequency really should not
> > matter anymore. Pavel might disagree of course.
> 
> You forgot (rightfully) that we even use TSC on those !constant
> machines, we adjust the cycles_2_ns thing from the cpufreq notifiers.
> 
> The only case we should _ever_ use that jiffies callback is when TSC
> really isn't there. Basically, if we kill notsc, we could make
> native_sched_clock() := cycles_2_ns(rdtsc()) (for CONFIG_X86_TSC), the
> end.
> 
> No static keys, nothing.

So much for the theory. There are CPUs out there where you can't figure out
the TSC frequency which in turn needs to discard TSC as well. Yes, it's all
utter crap....

> That said; flipping static keys early isn't hard. We should call
> jump_label_init() early, because we want the entries sorted and the
> key->entries link set. It will also replace the GENERIC_NOP5_ATOMIC
> thing, which means we need to also do arch_init_ideal_nop() early, but
> since that is pure CPUID based that should be doable.

Yes, that should work and then we'd just have a single static key.

Thanks,

	tglx
