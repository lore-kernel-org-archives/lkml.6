Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeEDOVD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:21:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751262AbeEDOVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:21:02 -0400
Date: Fri, 4 May 2018 16:20:57 +0200
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
Message-ID: <20180504142056.GA26151@redhat.com>
References: <20180426192818.GX17484@dhcp22.suse.cz>
 <20180427070848.GA17484@dhcp22.suse.cz>
 <87r2n01q58.fsf@xmission.com>
 <87o9hz2sw3.fsf@xmission.com>
 <87h8nr2sa3.fsf_-_@xmission.com>
 <20180502084708.GC26305@dhcp22.suse.cz>
 <20180502132026.GB16060@cmpxchg.org>
 <87lgd1zww0.fsf_-_@xmission.com>
 <20180503133338.GA23401@redhat.com>
 <87y3h0x0qg.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3h0x0qg.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 05/02, Eric W. Biederman wrote:
> >>
> >> +static void mem_cgroup_fork(struct task_struct *tsk)
> >> +{
> >> +	struct cgroup_subsys_state *css;
> >> +
> >> +	rcu_read_lock();
> >> +	css = task_css(tsk, memory_cgrp_id);
> >> +	if (css && css_tryget(css))
> >> +		task_update_memcg(tsk, mem_cgroup_from_css(css));
> >> +	rcu_read_unlock();
> >> +}
> >
> > Why do we need it?
> >
> > The child's mm->memcg was already initialized by mm_init_memcg() and we can't
> > race with migrate until cgroup_threadgroup_change_end() ?
>
> I admit I missed the cgroup_threadgroup_change_begin
> cgroup_threadgroup_change_end pair in fs fork.  In this case it doesn't
> matter because mm_init_memcg is called from:
>
>    copy_mm
>       dup_mm
>         mm_init
>
> And copy_mm is called before we call cgroup_threadgroup_change_begin.
> So the race remains.

Ah yes, you are right.

> We could move move cgroup_threadgroup_change_begin earlier, to remove
> the need for mem_cgroup_fork.  But I have not analyzed that.

No, cgroup_threadgroup_change_begin() was called early and this was wrong, see
568ac888215c7fb2fabe8ea739b00ec3c1f5d440. Actually there were more problems, say
copy_net() could deadlock because cleanup_net() does do_wait() with net_mutex held.


OK, what about exec() ? mm_init_memcg() initializes bprm->mm->memcg early in
bprm_mm_init(). What if the execing task migrates before exec_mmap() ?

Oleg.
