Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE9CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E904720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E904720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeFTKnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:43:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFTKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:43:03 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVaZU-0003Wm-Sl; Wed, 20 Jun 2018 12:42:41 +0200
Date:   Wed, 20 Jun 2018 12:42:40 +0200 (CEST)
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
In-Reply-To: <20180620091532.GK2476@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806201231030.10546@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-8-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806192335390.10546@nanos.tec.linutronix.de> <20180620091532.GK2476@hirez.programming.kicks-ass.net>
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

On Wed, 20 Jun 2018, Peter Zijlstra wrote:

> On Wed, Jun 20, 2018 at 01:52:10AM +0200, Thomas Gleixner wrote:
> >  u64 native_sched_clock(void)
> >  {
> > +	if (static_branch_likely(&__use_tsc))
> > +		return cycles_2_ns(rdtsc());
> >  
> > +	if (static_branch_unlikely(&tsc_early_enabled)) {
> > +		if (tsc_early_sched_clock)
> > +			return cycles_2_ns(rdtsc());
> >  	}
> 
> I'm still puzzled by the entire need for tsc_early_enabled and all that.
> Esp. since both branches do the exact same thing:
> 
> 	return cycles_2_ns(rdtsc());

Right. But up to the point where the real sched_clock initialization can be
done and the static keys can be flipped, there must be a way to
conditinally use TSC depending on availablility and early initialization.

We cannot make the __use_tsc key TRUE at conmpile timeunless we add an
extra conditional into that codepath which makes the whole static key moot.

So the second static key for the early stuff is TRUE and has the extra
conditional:

	if (tsc_early_sched_clock)
		return cycles_2_ns(rdtsc());

And that code path gets nuked with flipping the key to FALSE in the later
init code, so that in case of jiffies we do not have the extra conditional
in every sched_clock() invocation.

You might argue, that we shouldn't care becasue the jiffies case is just
the worst case fallback anyway. I wouldn't even disagree as those old
machines which have TSC varying with the CPU frequency really should not
matter anymore. Pavel might disagree of course.

Thanks,

	tglx

