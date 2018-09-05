Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153BFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0162064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0162064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIEMbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:31:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbeIEMbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:31:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E459CAE55;
        Wed,  5 Sep 2018 08:02:41 +0000 (UTC)
Date:   Wed, 5 Sep 2018 10:02:41 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <20180905075913.GO24124@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1809051001360.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm> <alpine.DEB.2.21.1809041804080.3395@nanos.tec.linutronix.de>
 <20180905075913.GO24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Peter Zijlstra wrote:

> On Tue, Sep 04, 2018 at 06:18:55PM +0200, Thomas Gleixner wrote:
> > On Tue, 4 Sep 2018, Jiri Kosina wrote:
> > >  		if (tsk && tsk->mm &&
> > >  		    tsk->mm->context.ctx_id != last_ctx_id &&
> > > -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> > > +		    ___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
> > 
> > Uurgh. If X86_FEATURE_USE_IBPB is not enabled, then the whole
> > __ptrace_may_access() overhead is just done for nothing.
> > 
> > >  			indirect_branch_prediction_barrier();
> > 
> > This really wants to be runtime patched:
> > 
> > 		if (static_cpu_has(X86_FEATURE_USE_IBPB))
> > 			stop_speculation(tsk, last_ctx_id);
> > 
> > and have an inline for that:
> > 
> > static inline void stop_speculation(struct task_struct *tsk, u64 last_ctx_id)
> > {
> > 	if (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
> > 		___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
> > 		indirect_branch_prediction_barrier();
> > }
> > 
> > which also makes the whole mess readable.
> 
> How about something like:
> 
> 	if (static_cpu_has(X86_FEATURE_USE_IBPB) && need_ibpb(tsk, last_ctx_id))
> 		indirect_branch_predictor_barrier();
> 
> where:
> 
> static inline bool need_ibpb(struct task_struct *next, u64 last_ctx_id)
> {
> 	return next && next->mm && next->mm->context.ctx_id != last_ctx_id &&
> 		__ptrace_may_access(next, PTRACE_MODE_IBPB));
> }
> 
> I don't much like "stop_speculation" for a name here.

Yeah, I did more or less that earlier today; my series currently has

+static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
+{
+       return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
+                       __ptrace_may_access(tsk, PTRACE_MODE_IBPB));
+}
+
[ ... ]
-               if (tsk && tsk->mm &&
-                   tsk->mm->context.ctx_id != last_ctx_id &&
-                   get_dumpable(tsk->mm) != SUID_DUMP_USER)
+               if (static_cpu_has(X86_FEATURE_USE_IBPB) &&
+                               ibpb_needed(tsk, last_ctx_id))
                        indirect_branch_prediction_barrier();

Thanks,

-- 
Jiri Kosina
SUSE Labs

