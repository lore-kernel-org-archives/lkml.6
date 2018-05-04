Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEDE7Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 00:59:25 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:41264 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeEDE7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 00:59:24 -0400
X-Google-Smtp-Source: AB8JxZo9MC1yYIB5K7G3BgHXc70PHIbC6HlgnQjHFE8xvZxczUs1ew3ze0pYg8whx1hPLBBVM5eeHs3ZZSMW44GOHaw=
MIME-Version: 1.0
In-Reply-To: <87d0ycu62t.fsf@xmission.com>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz> <87efj2q6sq.fsf@xmission.com>
 <20180426192818.GX17484@dhcp22.suse.cz> <20180427070848.GA17484@dhcp22.suse.cz>
 <87r2n01q58.fsf@xmission.com> <87o9hz2sw3.fsf@xmission.com>
 <87h8nr2sa3.fsf_-_@xmission.com> <20180503095952.70bffde1@balbir.ozlabs.ibm.com>
 <87d0ycu62t.fsf@xmission.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 4 May 2018 14:59:22 +1000
Message-ID: <CAKTCnzn2oPXmBed2zcskLzNVO8EpeS5sTG3gRLD0jOsBpDAfRw@mail.gmail.com>
Subject: Re: [RFC][PATCH] memcg: Replace mm->owner with mm->memcg
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Michal Hocko <mhocko@kernel.org>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>, Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 1:11 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> On Tue, 01 May 2018 12:35:16 -0500
>> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>>> Recently it was reported that mm_update_next_owner could get into
>>> cases where it was executing it's fallback for_each_process part of
>>> the loop and thus taking up a lot of time.
>>>
>>> To deal with this replace mm->owner with mm->memcg.  This just reduces
>>> the complexity of everything.  As much as possible I have maintained
>>> the current semantics.  There are two siginificant exceptions.  During
>>> fork the memcg of the process calling fork is charged rather than
>>> init_css_set.  During memory cgroup migration the charges are migrated
>>> not if the process is the owner of the mm, but if the process being
>>> migrated has the same memory cgroup as the mm.
>>>
>>> I believe it was a bug if init_css_set is charged for memory activity
>>> during fork, and the old behavior was simply a consequence of the new
>>> task not having tsk->cgroup not initialized to it's proper cgroup.
>>
>> That does sound like a bug, I guess we've not seen it because we did
>> not track any slab allocations initially.
>
>
>>> Durhing cgroup migration only thread group leaders are allowed to
>>> migrate.  Which means in practice there should only be one.  Linux
>>> tasks created with CLONE_VM are the only exception, but the common
>>> cases are already ruled out.  Processes created with vfork have a
>>> suspended parent and can do nothing but call exec so they should never
>>> show up.  Threads of the same cgroup are not the thread group leader
>>> so also should not show up.  That leaves the old LinuxThreads library
>>> which is probably out of use by now, and someone doing something very
>>> creative with cgroups, and rolling their own threads with CLONE_VM.
>>> So in practice I don't think the difference charge migration will
>>> affect anyone.
>>>
>>> To ensure that mm->memcg is updated appropriately I have implemented
>>> cgroup "attach" and "fork" methods.  This ensures that at those
>>> points the mm pointed to the task has the appropriate memory cgroup.
>>>
>>> For simplicity instead of introducing a new mm lock I simply use
>>> exchange on the pointer where the mm->memcg is updated to get
>>> atomic updates.
>>>
>>> Looking at the history effectively this change is a revert.  The
>>> reason given for adding mm->owner is so that multiple cgroups can be
>>> attached to the same mm.  In the last 8 years a second user of
>>> mm->owner has not appeared.  A feature that has never used, makes the
>>> code more complicated and has horrible worst case performance should
>>> go.
>>
>> The idea was to track the mm to the right cgroup, we did find that
>> the mm could be confused as belonging to two cgroups. tsk->cgroup is
>> not sufficient and if when the tgid left, we needed an owner to track
>> where the current allocations were. But this is from 8 year old history,
>> I don't have my notes anymore :)
>
> I was referring to the change 8ish years ago where mm->memcg was
> replaced with mm->owner.  Semantically the two concepts should both
> be perfectly capable of resolving which cgroup the mm belongs to.
>

Yep, agreed.

>>> +static void mem_cgroup_attach(struct cgroup_taskset *tset)
>>> +{
>>> +    struct cgroup_subsys_state *css;
>>> +    struct task_struct *tsk;
>>> +
>>> +    cgroup_taskset_for_each(tsk, css, tset) {
>>> +            struct mem_cgroup *new = mem_cgroup_from_css(css);
>>> +            css_get(css);
>>> +            task_update_memcg(tsk, new);
>>
>> I'd have to go back and check and I think your comment refers to this,
>> but we don't expect non tgid tasks to show up here? My concern is I can't
>> find the guaratee that task_update_memcg(tsk, new) is not
>>
>> 1. Duplicated for each thread in the process or attached to the mm
>> 2. Do not update mm->memcg to point to different places, so the one
>> that sticks is the one that updated things last.
>
> For cgroupv2 which only operates on processes we have such a guarantee.
>
> There is no such guarantee for cgroupv1.  But it would take someone
> being crazy to try this.
>
> We can add a guarantee to can_attach that we move all of the threads in
> a process, and we probably should.  However having mm->memcg is more
> important structurally than what crazy we let in.  So let's make this
> change first as safely as we can, and then we don't loose important
> data structure simplications if it turns out we have to revert a change
> to make the memcgroup per process in cgroupv1.
>
>
> There are some serious issues with the intereactions between the memory
> control group and the concept of thread group leader, that show up when
> you consider a zombie thread group leader that has called cgroup_exit.
> So I am not anxious to stir in concepts like thread_group_leader into
> new code unless there is a very good reason.
>
> We don't exepect crazy but the code allows it, and I have not changed
> that.
>

OK, lets stick with this

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
