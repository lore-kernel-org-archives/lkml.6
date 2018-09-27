Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58168C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094F02170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094F02170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeI1Cs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:48:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52960 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1Cs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:48:28 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5ctI-0002iA-9P; Thu, 27 Sep 2018 22:28:04 +0200
Date:   Thu, 27 Sep 2018 22:28:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v7 1/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <7f9e1a22-37a8-db88-ffc0-91961174ced4@tycho.nsa.gov>
Message-ID: <alpine.DEB.2.21.1809272218190.8118@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809251431260.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm> <7f9e1a22-37a8-db88-ffc0-91961174ced4@tycho.nsa.gov>
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

On Thu, 27 Sep 2018, Stephen Smalley wrote:
> On 09/25/2018 08:38 AM, Jiri Kosina wrote:
> >   +static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
> > +{
> > +	/*
> > +	 * Check if the current (previous) task has access to the memory
> > +	 * of the @tsk (next) task. If access is denied, make sure to
> > +	 * issue a IBPB to stop user->user Spectre-v2 attacks.
> > +	 *
> > +	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
> > +	 */
> > +	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
> > +		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
> 
> Would there be any safe way to perform the ptrace check earlier at a point
> where the locking constraints are less severe, and just pass down the result
> to this code?  Possibly just defaulting to enabling IBPB for safety if
> something changed in the interim that would invalidate the earlier ptrace
> check?  Probably not possible, but I thought I'd ask as it would avoid the
> need to skip both the ptrace_has_cap check and the LSM hook, and would reduce
> the critical section.

It's not possible unfortunately as this happens under the scheduler run
queue lock and this needs to be taken to figure out which is the next
task. We can't drop it before context switch and revisit the decision
afterwards to verify it, that would be a massive performance issue and open
an even more horrible can of worms.

Any check which needs to be done in that context should be as minimalistic
as possible. So having a special mode which then might invoke special hooks
makes a lot of sense.

> > + * Returns true on success, false on denial.
> > + *
> > + * Similar to ptrace_may_access(). Only to be called from context switch
> > + * code. Does not call into audit and the regular LSM hooks due to locking
> > + * constraints.
> 
> Pardon my ignorance, but can you clarify exactly what are the locking
> constraints for any code that might be called now or in the future from
> ptrace_may_access_sched().  What's permissible?  rcu_read_lock()?

rcu_read_lock() is fine. Locks might be fine, but the probability that you
run into a lock inversion is extremly high. Also please keep in mind that
this wants to be a raw_spinlock as otherwise preempt-RT will have issues
and the lock sections need to be really short. switch_to() is a hot path.

Thanks,

	tglx
