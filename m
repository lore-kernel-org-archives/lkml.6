Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A84C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C82206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfAHNMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:12:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfAHNMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:12:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02FEC1596;
        Tue,  8 Jan 2019 05:12:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EF773F70D;
        Tue,  8 Jan 2019 05:12:49 -0800 (PST)
Date:   Tue, 8 Jan 2019 13:12:47 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com
Subject: Re: [PATCH v4 10/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Message-ID: <20190108131247.GE56789@e119886-lin.cambridge.arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-11-git-send-email-andrew.murray@arm.com>
 <20190108104841.GD6808@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108104841.GD6808@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:48:41AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 07, 2019 at 04:27:27PM +0000, Andrew Murray wrote:
> > For drivers that do not support context exclusion let's advertise the
> > PERF_PMU_CAP_NOEXCLUDE capability. This ensures that perf will
> > prevent us from handling events where any exclusion flags are set.
> > Let's also remove the now unnecessary check for exclusion flags.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/x86/events/amd/ibs.c          | 13 +------------
> >  arch/x86/events/amd/power.c        | 10 ++--------
> >  arch/x86/events/intel/cstate.c     | 12 +++---------
> >  arch/x86/events/intel/rapl.c       |  9 ++-------
> >  arch/x86/events/intel/uncore_snb.c |  9 ++-------
> >  arch/x86/events/msr.c              | 10 ++--------
> >  6 files changed, 12 insertions(+), 51 deletions(-)
> 
> You (correctly) don't add CAP_NO_EXCLUDE to the main x86 pmu code, but
> then you also don't check if it handles all the various exclude options
> correctly/consistently.
> 
> Now; I must admit that that is a bit of a maze, but I think we can at
> least add exclude_idle and exclude_hv fails in there, nothing uses those
> afaict.

Yes it took me some time to make sense of it.

As per my comments in the other patch, I think you're suggesting that I
add additional checks to x86. I think they are needed but I'd prefer to
make functional changes in a separate series, I'm happy to do this.

> 
> On the various exclude options; they are as follows (IIUC):
> 
>   - exclude_guest: we're a HV/host-kernel and we don't want the counter
>                    to run when we run a guest context.
> 
>   - exclude_host: we're a HV/host-kernel and we don't want the counter
>                   to run when we run in host context.
> 
>   - exclude_hv: we're a guest and don't want the counter to run in HV
>                 context.
> 
> Now, KVM always implies exclude_hv afaict (for guests),

It certaintly does for ARM.

> I'm not sure
> what, if anything Xen does on x86 (IIRC Brendan Gregg once said perf
> works on Xen) -- nor quite sure who to ask, Boris, Jeurgen?

Thanks,

Andrew Murray
> 
