Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeEHDPl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:15:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53349 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeEHDPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:15:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
References: <20180502132026.GB16060@cmpxchg.org>
        <87lgd1zww0.fsf_-_@xmission.com> <20180503133338.GA23401@redhat.com>
        <87y3h0x0qg.fsf@xmission.com> <20180504142056.GA26151@redhat.com>
        <87r2mrh4is.fsf@xmission.com> <20180504145435.GA26573@redhat.com>
        <87y3gzfmjt.fsf@xmission.com> <20180504162209.GB26573@redhat.com>
        <871serfk77.fsf@xmission.com> <20180507143358.GA3071@redhat.com>
Date: Mon, 07 May 2018 22:15:27 -0500
In-Reply-To: <20180507143358.GA3071@redhat.com> (Oleg Nesterov's message of
        "Mon, 7 May 2018 16:33:58 +0200")
Message-ID: <87vabyvnw0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fFt6E-0004OQ-MA;;;mid=<87vabyvnw0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+1FnaO3I9Q7JIRHEWVpetGk4/NIQoP/g=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 304 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.8%), b_tie_ro: 1.77 (0.6%), parse: 0.79 (0.3%),
        extract_message_metadata: 3.5 (1.1%), get_uri_detail_list: 1.95 (0.6%),
        tests_pri_-1000: 4.0 (1.3%), tests_pri_-950: 1.19 (0.4%), tests_pri_-900:
        1.00 (0.3%), tests_pri_-400: 25 (8.3%), check_bayes: 24 (8.0%), b_tokenize: 9
        (2.9%), b_tok_get_all: 8 (2.8%), b_comp_prob: 2.3 (0.8%), b_tok_touch_all:
        2.9 (1.0%), b_finish: 0.54 (0.2%), tests_pri_0: 255 (83.8%),
        check_dkim_signature: 0.64 (0.2%), check_dkim_adsp: 2.7 (0.9%),
        tests_pri_500: 3.8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/04, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > On 05/04, Eric W. Biederman wrote:
>> >>
>> >> Oleg Nesterov <oleg@redhat.com> writes:
>> >>
>> >> > I'd vote for the change in exec_mmap(). This way mm_init_memcg() can just
>> >> > nullify mm->memcg.
>> >>
>> >> There is at least one common path where we need the memory control group
>> >> properly initialized so memory allocations don't escape the memory
>> >> control group.
>> >>
>> >> do_execveat_common
>> >>    copy_strings
>> >>       get_arg_page
>> >>          get_user_pages_remote
>> >>             __get_user_pages_locked
>> >>                __get_user_pages
>> >>                   faultin_page
>> >>                      handle_mm_fault
>> >>                         count_memcg_event_mm
>> >>                         __handle_mm_fault
>> >>                           handle_pte_fault
>> >>                              do_anonymous_page
>> >>                                 mem_cgroup_try_charge
>
> Ah yes, indeed.
>
>> mm_init_memcg is at the same point as mm_init_owner.  So my change did
>> not introduce any logic changes on when the memory control group became
>> valid.
>
> Not sure, but perhaps I am all confused....

So.  In exec actions that are initiated while a process is calling exec
can either logcially happen either before or after the exec.  That is
the way these races are always resolved.  I don't see any reason
for the memory control group to be any different.

Which means it is perfectly valid for a migration that technically
happens in the middle of copy_strings to not show up until some time
later in exec.

This works because there are no user visible effects until exec
completes.  If there are user visible effects they are bugs.

That is all it takes to understand why my patch fixes things.

It might make more sense to simply fail migration if task->in_execve.
While perhaps the best solution that might introduce a user visible
effect that we don't care about right now.

> before your patch get_mem_cgroup_from_mm() looks at mm->owner == current
> (in this case) and mem_cgroup_from_task() should return the correct memcg
> even if execing task migrates after bprm_mm_init(). At least in the common
> case when the old mm is not shared.
>
> After your patch the memory allocations in copy_strings() won't be accounted
> correctly, bprm->mm->memcg is wrong if this task migrates. And iiuc your recent
> "[PATCH 2/2] memcg: Close the race between migration and installing bprm->mm as mm"
> doesn't fix the problem.
>
> No?

The patch does solve the issue.  There should be nothing a userspace
process can observe that should tell it where in the middle of exec
such a migration happend so placing the migration at what from the
kernel's perspective might be technically later should not be a problem.

If it is a problem the issue is that there is a way to observe the
difference.

> Perhaps we can change get_mem_cgroup_from_mm() to use
> mem_cgroup_from_css(current, memory_cgrp_id) if mm->memcg == NULL?

Please God no.  Having any unnecessary special case is just going to
confuse people and cause bugs.

Plus as I have pointed out above that is not an issue.

Eric
