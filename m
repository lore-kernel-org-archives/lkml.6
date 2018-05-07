Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeEGOeJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:34:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751991AbeEGOeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:34:06 -0400
Date: Mon, 7 May 2018 16:33:58 +0200
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
Message-ID: <20180507143358.GA3071@redhat.com>
References: <20180502132026.GB16060@cmpxchg.org>
 <87lgd1zww0.fsf_-_@xmission.com>
 <20180503133338.GA23401@redhat.com>
 <87y3h0x0qg.fsf@xmission.com>
 <20180504142056.GA26151@redhat.com>
 <87r2mrh4is.fsf@xmission.com>
 <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871serfk77.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 05/04, Eric W. Biederman wrote:
> >>
> >> Oleg Nesterov <oleg@redhat.com> writes:
> >>
> >> > I'd vote for the change in exec_mmap(). This way mm_init_memcg() can just
> >> > nullify mm->memcg.
> >>
> >> There is at least one common path where we need the memory control group
> >> properly initialized so memory allocations don't escape the memory
> >> control group.
> >>
> >> do_execveat_common
> >>    copy_strings
> >>       get_arg_page
> >>          get_user_pages_remote
> >>             __get_user_pages_locked
> >>                __get_user_pages
> >>                   faultin_page
> >>                      handle_mm_fault
> >>                         count_memcg_event_mm
> >>                         __handle_mm_fault
> >>                           handle_pte_fault
> >>                              do_anonymous_page
> >>                                 mem_cgroup_try_charge

Ah yes, indeed.

> mm_init_memcg is at the same point as mm_init_owner.  So my change did
> not introduce any logic changes on when the memory control group became
> valid.

Not sure, but perhaps I am all confused....

before your patch get_mem_cgroup_from_mm() looks at mm->owner == current
(in this case) and mem_cgroup_from_task() should return the correct memcg
even if execing task migrates after bprm_mm_init(). At least in the common
case when the old mm is not shared.

After your patch the memory allocations in copy_strings() won't be accounted
correctly, bprm->mm->memcg is wrong if this task migrates. And iiuc your recent
"[PATCH 2/2] memcg: Close the race between migration and installing bprm->mm as mm"
doesn't fix the problem.

No?

Perhaps we can change get_mem_cgroup_from_mm() to use
mem_cgroup_from_css(current, memory_cgrp_id) if mm->memcg == NULL?

Oleg.
