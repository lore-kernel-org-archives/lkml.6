Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C21C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB421523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BB421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeIVQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:14:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeIVQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:14:06 -0400
Received: from tmo-109-175.customers.d1-online.com ([80.187.109.175] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g3f1t-0007Qm-K5; Sat, 22 Sep 2018 12:20:49 +0200
Date:   Sat, 22 Sep 2018 12:20:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jiri Kosina <jikos@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
In-Reply-To: <20180922101844.GF24124@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809221219270.1391@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com> <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm> <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de> <20180922101844.GF24124@hirez.programming.kicks-ass.net>
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

On Sat, 22 Sep 2018, Peter Zijlstra wrote:
> On Sat, Sep 22, 2018 at 11:53:14AM +0200, Thomas Gleixner wrote:
> > +bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
> > +{
> > +	struct mm_struct *mm;
> > +	int res;
> > +
> > +	res = __ptrace_may_access_basic(task, mode);
> > +	if (res <= 0)
> > +		return !res;
> > +
> > +	rcu_read_lock();
> > +	res = __ptrace_may_access_cred(__task_cred(task), mode);
> >  	rcu_read_unlock();
> > +	if (res)
> > +		return false;
> > +
> > +	mm = task->mm;
> > +	if (mm && get_dumpable(mm) != SUID_DUMP_USER)
> > +		return false;
> > +	return true;
> > +}
> > +
> > +/* Returns 0 on success, -errno on denial. */
> > +static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
> > +{
> > +	const struct cred *tcred;
> > +	struct mm_struct *mm;
> > +	int res;
> > +
> > +	res = __ptrace_may_access_basic(task, mode);
> > +	if (res <= 0)
> > +		return res;
> > +
> > +	rcu_read_lock();
> > +	tcred = __task_cred(task);
> > +	res = __ptrace_may_access_cred(tcred, mode);
> > +	if (res > 0)
> > +		res = ptrace_has_cap(tcred->user_ns, mode) ? 0 : -EPERM;
> >  	rcu_read_unlock();
> > +	if (res < 0)
> > +		return res;
> > +
> >  	mm = task->mm;
> > +	if (mm && (get_dumpable(mm) != SUID_DUMP_USER &&
> > +		   !ptrace_has_cap(mm->user_ns, mode)))
> > +		return -EPERM;
> >  
> >  	return security_ptrace_access_check(task, mode);
> >  }
> 
> This has some unfortunate duplication.
> 
> Lets go with it for now, but I'll see if I can do something about that
> later.

Yes, I know. I tried to make the duplication smaller, but all attempts
ended up being a convoluted mess. I'll try again after applying more
coffee.

Thanks,

	tglx

