Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51567C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED2206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ED2206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeIVNb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:31:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbeIVNb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:31:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54EBEADDD;
        Sat, 22 Sep 2018 07:38:51 +0000 (UTC)
Date:   Sat, 22 Sep 2018 09:38:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
In-Reply-To: <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com> <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018, Peter Zijlstra wrote:

> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 5c5e7cb597cd..202a4d9c2af7 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -330,9 +330,7 @@ int __ptrace_may_access(struct task_struct *task, unsigned int mode)
> >                !ptrace_has_cap(mm->user_ns, mode))))
> >             return -EPERM;
> > 
> > -       if (!(mode & PTRACE_MODE_NOACCESS_CHK))
> > -               return security_ptrace_access_check(task, mode);
> > -       return 0;
> > +       return security_ptrace_access_check(task, mode);
> >  }
> > 
> >  bool ptrace_may_access(struct task_struct *task, unsigned int mode)
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 161a4f29f860..30d21142e9fe 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2215,7 +2215,12 @@ static int selinux_ptrace_access_check(struct task_struct *child,
> >  {
> >         u32 sid = current_sid();
> >         u32 csid = task_sid(child);
> > +       struct av_decision avd;
> > 
> > +       if (mode == PTRACE_MODE_IBPB)
> > +               return avc_has_perm_noaudit(&selinux_state, sid, csid,
> > +                                           SECCLASS_PROCESS, PROCESS__PTRACE,
> > +                                           0, &avd);
> >         if (mode & PTRACE_MODE_READ)
> >                 return avc_has_perm(&selinux_state,
> >                                     sid, csid, SECCLASS_FILE, FILE__READ, NULL);
> > 
> 
> As far as I can tell, this still has:
> 
> 	avc_has_perm_noaudit()
> 	  security_compute_av()
> 	    read_lock(&state->ss->policy_rwlock);
> 	  avc_insert()
> 	    spin_lock_irqsave();
> 	  avc_denied()
> 	    avc_update_node()
> 	      spin_lock_irqsave();
> 
> under the scheduler's raw_spinlock_t, which are invalid lock nestings.

Agreed. Therefore, if the current form (v6) of the patches is merged, the 
check before security_ptrace_access_check() should stay.

Once all the LSM callbacks are potentially audited, it could then go in 
second phase.

Is there anything else blocking v6 being merged? (and then Tim's set on 
top I guess, once the details are sorted out there).

Thanks,

-- 
Jiri Kosina
SUSE Labs

