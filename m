Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5741C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A1A217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xZ0Cs86c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfBEREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:04:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfBEREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z3w5xLnXc+s9bLff/L5kJlRaW1VcIRG7yTfEMg0T5kw=; b=xZ0Cs86cudusbepSaH//adC4a
        sJF1203oW3L7JnSP2hnPTWjyIqTcBNTLFRE/KnIrNhslMnxLK0/nsEIz37a9aMGAWAkdARW1ifpdT
        LkgqvzDZPsxEKP5DYOL4JSEmmqGPNB/LpKgFIIDzPabHet3SUZF53LpQ6rgPMVAmdGHIVGuQ5SzBf
        RkDKDcrMi8sXy1iGn6nSn7+C6Fy5zGqyGiMjeyudYzRy7etDD+wtQ+zRB+djHcN25XTS1BePBpOQg
        DWbgPHYdU/BrI/OspfCd257/Bfx6wQ5h3ibhXN8MQ86b9s4+2sHNYElFB91aOs8kSqZfvoSH1THuw
        ZMFvmQ0/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr48w-0005AC-9a; Tue, 05 Feb 2019 17:04:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FA2320295AC3; Tue,  5 Feb 2019 18:04:15 +0100 (CET)
Date:   Tue, 5 Feb 2019 18:04:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205170415.GG17550@hirez.programming.kicks-ass.net>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190205084857.GK17528@hirez.programming.kicks-ass.net>
 <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:19:16AM -0800, Dave Hansen wrote:
> On 2/5/19 12:48 AM, Peter Zijlstra wrote:
> > On Mon, Feb 04, 2019 at 12:46:30PM -0800, Dave Hansen wrote:
> >> So, the compromise we reached in this case is that Intel will fully
> >> document the future silicon architecture, and then write the kernel
> >> implementation to _that_.  Then, for the weirdo deployments where this
> >> feature is not enumerated, we have the setcpuid= to fake the enumeration
> >> in software.
> > 
> > What user is _EVER_ going to use this? Nobody, I expect the answer to
> > be.
> 
> This is one of the few times that we're pretty confident that folks will
> use this.  The reason we're going to this trouble is that the split lock
> detection is wanted by actual customers, and they want it before it's
> implemented on a processor with real enumeration.

That's big customers that do magic stuff not users.

> This isn't something we want everybody and their grandma to turn on;
> it's a rather specialized feature.  It's really only for folks that care
> about the latency incurred across the entire system on split lock
> operations.

That really should be everyone. That split lock stuff is horrible. There
is no real down-side to having it always enabled. Code that breaks is
bad code you want fixed anyway.

Like I said elsewhere, I wish it would #AC for any unaligned LOCK
prefix, not just cross-line. I see why we'd not want to traditional RISC
#AC for every load/store, but atomics really had better be aligned.

> > Is this some transient state; where a few (early) models will not have
> > the enumeration sorted but all later models will have it all neat and
> > tidy?
> 
> From my understanding, it's not just an early stepping.  It's a
> generational thing.  The current generation lacks the enumeration and
> the next generation will get it.  Both have the silicon to implement the
> feature itself.

I never said stepping, in fact I explicitly said model.

> > If so, we can easily do the FMS solution for this.
> 
> Yeah, we can.  I honestly forget why we didn't do FMS. :)

Right so FMS is fairly horrible; but when it is a stop-gap for a limited
number of models it's waaay better than dodgy cmdline things.

We could of course try to wrmsr_safe() detect the feature; but that
might be a problem is the MSR exists on any other models and has a
different meaning.

> > But a cmdline features thing is not something I can see anybody but
> > a limited set of developers ever using.
> 
> It's not for developers.  This really is for (somewhat niche) end users
> that want split lock detection in production.  This is all really an
> effort to get them running mainline or real distro kernels.

Yes, because cloud service providers and RT are niche products.. *sigh*.

Nobody wants to do live audio on their laptops.. oh wait..
