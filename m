Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeEBOP3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:15:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49592 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeEBOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:15:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
In-Reply-To: <20180502132026.GB16060@cmpxchg.org> (Johannes Weiner's message
        of "Wed, 2 May 2018 09:20:26 -0400")
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
        <20180426130700.GP17484@dhcp22.suse.cz> <87efj2q6sq.fsf@xmission.com>
        <20180426192818.GX17484@dhcp22.suse.cz>
        <20180427070848.GA17484@dhcp22.suse.cz> <87r2n01q58.fsf@xmission.com>
        <87o9hz2sw3.fsf@xmission.com> <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date: Wed, 02 May 2018 09:05:05 -0500
Message-ID: <871seui25q.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDsQm-0006wx-Rk;;;mid=<871seui25q.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+BIU4I2mXCYvFTUxNfc98+j1n6AdXmyj0=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Johannes Weiner <hannes@cmpxchg.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 415 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (0.6%), b_tie_ro: 1.97 (0.5%), parse: 0.81 (0.2%),
        extract_message_metadata: 17 (4.1%), get_uri_detail_list: 3.1 (0.7%),
        tests_pri_-1000: 8 (2.0%), tests_pri_-950: 1.19 (0.3%), tests_pri_-900: 1.03
        (0.2%), tests_pri_-400: 37 (8.8%), check_bayes: 35 (8.5%), b_tokenize: 11
        (2.7%), b_tok_get_all: 14 (3.3%), b_comp_prob: 3.6 (0.9%), b_tok_touch_all:
        4.3 (1.0%), b_finish: 0.69 (0.2%), tests_pri_0: 339 (81.8%),
        check_dkim_signature: 0.69 (0.2%), check_dkim_adsp: 2.5 (0.6%),
        tests_pri_500: 5 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> Hi Eric,
>
> On Wed, May 02, 2018 at 10:47:08AM +0200, Michal Hocko wrote:
>> [CC johannes and Tejun as well. I am sorry but my backlog is so huge I
>> will not get to this week.]
>> 
>> On Tue 01-05-18 12:35:16, Eric W. Biederman wrote:
>> > Recently it was reported that mm_update_next_owner could get into
>> > cases where it was executing it's fallback for_each_process part of
>> > the loop and thus taking up a lot of time.
>> > 
>> > To deal with this replace mm->owner with mm->memcg.  This just reduces
>> > the complexity of everything.  As much as possible I have maintained
>> > the current semantics.  There are two siginificant exceptions.  During
>> > fork the memcg of the process calling fork is charged rather than
>> > init_css_set.  During memory cgroup migration the charges are migrated
>> > not if the process is the owner of the mm, but if the process being
>> > migrated has the same memory cgroup as the mm.
>> > 
>> > I believe it was a bug if init_css_set is charged for memory activity
>> > during fork, and the old behavior was simply a consequence of the new
>> > task not having tsk->cgroup not initialized to it's proper cgroup.
>> > 
>> > Durhing cgroup migration only thread group leaders are allowed to
>> > migrate.  Which means in practice there should only be one.  Linux
>> > tasks created with CLONE_VM are the only exception, but the common
>> > cases are already ruled out.  Processes created with vfork have a
>> > suspended parent and can do nothing but call exec so they should never
>> > show up.  Threads of the same cgroup are not the thread group leader
>> > so also should not show up.  That leaves the old LinuxThreads library
>> > which is probably out of use by now, and someone doing something very
>> > creative with cgroups, and rolling their own threads with CLONE_VM.
>> > So in practice I don't think the difference charge migration will
>> > affect anyone.
>> > 
>> > To ensure that mm->memcg is updated appropriately I have implemented
>> > cgroup "attach" and "fork" methods.  This ensures that at those
>> > points the mm pointed to the task has the appropriate memory cgroup.
>> > 
>> > For simplicity instead of introducing a new mm lock I simply use
>> > exchange on the pointer where the mm->memcg is updated to get
>> > atomic updates.
>> > 
>> > Looking at the history effectively this change is a revert.  The
>> > reason given for adding mm->owner is so that multiple cgroups can be
>> > attached to the same mm.  In the last 8 years a second user of
>> > mm->owner has not appeared.  A feature that has never used, makes the
>> > code more complicated and has horrible worst case performance should
>> > go.
>> > 
>> > Fixes: cf475ad28ac3 ("cgroups: add an owner to the mm_struct")
>> > Reported-by:  Kirill Tkhai <ktkhai@virtuozzo.com>
>> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> I really like this. The multiple css per mm future that was referenced
> in cf475ad28ac3's changelog never materialized, so there is no need to
> always go through the task just to have the full css_set.
>
>> > @@ -4827,15 +4813,16 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
>> >  	if (!move_flags)
>> >  		return 0;
>> >  
>> > -	from = mem_cgroup_from_task(p);
>> > +	from = mem_cgroup_from_css(task_css(p, memory_cgrp_id));
>> >  
>> >  	VM_BUG_ON(from == memcg);
>> >  
>> >  	mm = get_task_mm(p);
>> >  	if (!mm)
>> >  		return 0;
>> > +
>> >  	/* We move charges only when we move a owner of the mm */
>> > -	if (mm->owner == p) {
>> > +	if (mm->memcg == from) {
>> >  		VM_BUG_ON(mc.from);
>> >  		VM_BUG_ON(mc.to);
>> >  		VM_BUG_ON(mc.precharge);
>
> mm->memcg is updated on every single ->attach(), so this can only
> happen to a task when a CLONE_VM sibling is moved out of its
> group. Essentially, in the new scheme the "owner" is whichever task
> with that mm migrated most recently.

Yes.  The charges will only fail to be migrated in some CLONE_VM
situations.

> I agree that it's hard to conjure up a practical usecase that would
> straddle mms like this over multiple cgroups - especially given how
> the memory charges themselves can only belong to one cgroup, too. So
> in practice task->mm->memcg will always be task->css_set[memory].
>
> But could you please update the comment to outline the cornercase?
> "owner" isn't really a thing anymore after this patch.

I can.  How about:
	/* We move charges except for creative uses of CLONE_VM */

> Oh, and mm/debug.c::dump_mm() still refers to mm->owner, that needs to
> be switched to mm->memcg as well.

The kbuild test robot pointed that out as well.

> Aside from that, this looks great to me. For the fixed version:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Will do and will repost in a bit.

Eric
