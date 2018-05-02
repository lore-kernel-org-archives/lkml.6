Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEBNTs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:19:48 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48826 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBNTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:19:47 -0400
Date: Wed, 2 May 2018 09:20:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC][PATCH] memcg: Replace mm->owner with mm->memcg
Message-ID: <20180502132026.GB16060@cmpxchg.org>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
 <87efj2q6sq.fsf@xmission.com>
 <20180426192818.GX17484@dhcp22.suse.cz>
 <20180427070848.GA17484@dhcp22.suse.cz>
 <87r2n01q58.fsf@xmission.com>
 <87o9hz2sw3.fsf@xmission.com>
 <87h8nr2sa3.fsf_-_@xmission.com>
 <20180502084708.GC26305@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502084708.GC26305@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, May 02, 2018 at 10:47:08AM +0200, Michal Hocko wrote:
> [CC johannes and Tejun as well. I am sorry but my backlog is so huge I
> will not get to this week.]
> 
> On Tue 01-05-18 12:35:16, Eric W. Biederman wrote:
> > Recently it was reported that mm_update_next_owner could get into
> > cases where it was executing it's fallback for_each_process part of
> > the loop and thus taking up a lot of time.
> > 
> > To deal with this replace mm->owner with mm->memcg.  This just reduces
> > the complexity of everything.  As much as possible I have maintained
> > the current semantics.  There are two siginificant exceptions.  During
> > fork the memcg of the process calling fork is charged rather than
> > init_css_set.  During memory cgroup migration the charges are migrated
> > not if the process is the owner of the mm, but if the process being
> > migrated has the same memory cgroup as the mm.
> > 
> > I believe it was a bug if init_css_set is charged for memory activity
> > during fork, and the old behavior was simply a consequence of the new
> > task not having tsk->cgroup not initialized to it's proper cgroup.
> > 
> > Durhing cgroup migration only thread group leaders are allowed to
> > migrate.  Which means in practice there should only be one.  Linux
> > tasks created with CLONE_VM are the only exception, but the common
> > cases are already ruled out.  Processes created with vfork have a
> > suspended parent and can do nothing but call exec so they should never
> > show up.  Threads of the same cgroup are not the thread group leader
> > so also should not show up.  That leaves the old LinuxThreads library
> > which is probably out of use by now, and someone doing something very
> > creative with cgroups, and rolling their own threads with CLONE_VM.
> > So in practice I don't think the difference charge migration will
> > affect anyone.
> > 
> > To ensure that mm->memcg is updated appropriately I have implemented
> > cgroup "attach" and "fork" methods.  This ensures that at those
> > points the mm pointed to the task has the appropriate memory cgroup.
> > 
> > For simplicity instead of introducing a new mm lock I simply use
> > exchange on the pointer where the mm->memcg is updated to get
> > atomic updates.
> > 
> > Looking at the history effectively this change is a revert.  The
> > reason given for adding mm->owner is so that multiple cgroups can be
> > attached to the same mm.  In the last 8 years a second user of
> > mm->owner has not appeared.  A feature that has never used, makes the
> > code more complicated and has horrible worst case performance should
> > go.
> > 
> > Fixes: cf475ad28ac3 ("cgroups: add an owner to the mm_struct")
> > Reported-by:  Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

I really like this. The multiple css per mm future that was referenced
in cf475ad28ac3's changelog never materialized, so there is no need to
always go through the task just to have the full css_set.

> > @@ -4827,15 +4813,16 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
> >  	if (!move_flags)
> >  		return 0;
> >  
> > -	from = mem_cgroup_from_task(p);
> > +	from = mem_cgroup_from_css(task_css(p, memory_cgrp_id));
> >  
> >  	VM_BUG_ON(from == memcg);
> >  
> >  	mm = get_task_mm(p);
> >  	if (!mm)
> >  		return 0;
> > +
> >  	/* We move charges only when we move a owner of the mm */
> > -	if (mm->owner == p) {
> > +	if (mm->memcg == from) {
> >  		VM_BUG_ON(mc.from);
> >  		VM_BUG_ON(mc.to);
> >  		VM_BUG_ON(mc.precharge);

mm->memcg is updated on every single ->attach(), so this can only
happen to a task when a CLONE_VM sibling is moved out of its
group. Essentially, in the new scheme the "owner" is whichever task
with that mm migrated most recently.

I agree that it's hard to conjure up a practical usecase that would
straddle mms like this over multiple cgroups - especially given how
the memory charges themselves can only belong to one cgroup, too. So
in practice task->mm->memcg will always be task->css_set[memory].

But could you please update the comment to outline the cornercase?
"owner" isn't really a thing anymore after this patch.

Oh, and mm/debug.c::dump_mm() still refers to mm->owner, that needs to
be switched to mm->memcg as well.

Aside from that, this looks great to me. For the fixed version:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
