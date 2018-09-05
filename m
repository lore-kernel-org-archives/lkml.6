Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C126C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADCA2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cTVtWZpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADCA2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIEM2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:28:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIEM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mnq1WSJbT7LLLuFAcKJoXzVQf/EqWwPlVpOzKYjrQbY=; b=cTVtWZpW1XdSrHOeqymwH2YFa
        rWa/Vtf89pz+mBJKlkwvZhjnKzUauioCU9I+wrZ/94QCh1E3wTt67t6bLaJbQ+HdB5deg2OiZq0Eu
        IfvfgMEQPW+33pBZnlgGHTsLN8aGSe2Eyihw/Yl96ER5R/gXEk2Z8/uyc/ek3eS9yg9W7jgQ26z7L
        VbTY7Ay3G5CMSp/4SxPjdX/ZjBH1YbmTqTFcGKyYG9Wma+hdL/ZsjqXr1n3OSdb2Qgzu+usT9rg+f
        RAbQCNs3TsupiVMh9iPeM3FWYeZ+5oaA/WuKwPW3o5PYRdy9MmgxwQujlDhioOzB8o+SJrHfR7fMx
        e7C6WgtEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxSiY-0003kY-Ia; Wed, 05 Sep 2018 07:59:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6442C20191BFE; Wed,  5 Sep 2018 09:59:13 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:59:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Message-ID: <20180905075913.GO24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm>
 <alpine.DEB.2.21.1809041804080.3395@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809041804080.3395@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 06:18:55PM +0200, Thomas Gleixner wrote:
> On Tue, 4 Sep 2018, Jiri Kosina wrote:
> >  		if (tsk && tsk->mm &&
> >  		    tsk->mm->context.ctx_id != last_ctx_id &&
> > -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> > +		    ___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
> 
> Uurgh. If X86_FEATURE_USE_IBPB is not enabled, then the whole
> __ptrace_may_access() overhead is just done for nothing.
> 
> >  			indirect_branch_prediction_barrier();
> 
> This really wants to be runtime patched:
> 
> 		if (static_cpu_has(X86_FEATURE_USE_IBPB))
> 			stop_speculation(tsk, last_ctx_id);
> 
> and have an inline for that:
> 
> static inline void stop_speculation(struct task_struct *tsk, u64 last_ctx_id)
> {
> 	if (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
> 		___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
> 		indirect_branch_prediction_barrier();
> }
> 
> which also makes the whole mess readable.

How about something like:

	if (static_cpu_has(X86_FEATURE_USE_IBPB) && need_ibpb(tsk, last_ctx_id))
		indirect_branch_predictor_barrier();

where:

static inline bool need_ibpb(struct task_struct *next, u64 last_ctx_id)
{
	return next && next->mm && next->mm->context.ctx_id != last_ctx_id &&
		__ptrace_may_access(next, PTRACE_MODE_IBPB));
}

I don't much like "stop_speculation" for a name here.
