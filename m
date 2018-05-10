Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757334AbeEJMit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:38:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757217AbeEJMis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:38:48 -0400
Date: Thu, 10 May 2018 14:38:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
Message-ID: <20180510123843.GB29222@redhat.com>
References: <20180504142056.GA26151@redhat.com>
 <87r2mrh4is.fsf@xmission.com>
 <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
 <20180507143358.GA3071@redhat.com>
 <87vabyvnw0.fsf@xmission.com>
 <20180509144016.GA25742@redhat.com>
 <87vabwp5p6.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vabwp5p6.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> >> The patch does solve the issue.  There should be nothing a userspace
> >> process can observe that should tell it where in the middle of exec
> >> such a migration happend so placing the migration at what from the
> >> kernel's perspective might be technically later should not be a problem.
> >>
> >> If it is a problem the issue is that there is a way to observe the
> >> difference.
> >
> > So. The task migrates from some MEMCG right after bprm_mm_init().
> >
> > copy_strings() triggers OOM in MEMCG. This is quite possible, it can use a lot
> > of memory and that is why we have acct_arg_size() to make these allocations
> > visible to oom killer.
> >
> > task_in_mem_cgroup(MEMCG) returns false and oom killer has to kill another
> > innocent process in MEMCG.
> >
> > Does this look like a way to observe the difference?
>
> Sort of.
>
> I don't know how the memcg gets away without migrating charges
> when it migrates a process.  With charges not being migrated
> I don't think this is observable.

Not sure I understand how this connects to accounting...

But yes sure, with or without your change, mem_cgroup_move_task() obviously
can't see the the nascent bprm->mm. I have no idea if this is important or
not, and iiuc cgroup v2 doesn't even support ->move_charge_at_immigrate.

As for accounting, I still think that it would be better to nullify ->memcg in
mm_init_memcg(), simply because we can not initialize it properly, we can race
with migration until exec_mmap/cgroup_post_fork which need to update ->memcg
anyway.

Yes, this means a special case in get_mem_cgroup_from_mm().

Oleg.


> That does look like a real issue however.
>
> >> > Perhaps we can change get_mem_cgroup_from_mm() to use
> >> > mem_cgroup_from_css(current, memory_cgrp_id) if mm->memcg == NULL?
> >>
> >> Please God no.  Having any unnecessary special case is just going to
> >> confuse people and cause bugs.
> >
> > To me the unnecessary special case is the new_mm->memcg which is used for
> > accounting but doesn't follow migration till exec_mmap(). But I won't
> > argue.
> 
> Eric
