Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756706AbeDZPVu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:21:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51350 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756434AbeDZPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:21:44 -0400
Date: Thu, 26 Apr 2018 17:20:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        akpm@linux-foundation.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, mhocko@suse.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        ebiederm@xmission.com, dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 4/4] exit: Lockless iteration over task list in
 mm_update_next_owner()
Message-ID: <20180426152053.GC4082@hirez.programming.kicks-ass.net>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
 <20180426123542.GA819@andrea>
 <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 04:52:39PM +0300, Kirill Tkhai wrote:
> >>
> >> 1)for_each_process(g)            copy_process()
> >>                                    p->mm = mm
> >>     smp_rmb();                     smp_wmb() implied by alloc_pid()
> >>     if (g->flags & PF_KTHREAD)     list_add_tail_rcu(&p->tasks, &init_task.tasks)
> >>
> >> 2)for_each_thread(g, c)          copy_process()
> >>                                    p->mm = mm
> >>     smp_rmb();                     smp_wmb() implied by alloc_pid()
> >>     tmp = READ_ONCE(c->mm)         list_add_tail_rcu(&p->thread_node, ...)

For these two; what's the purpose of the smp_rmb()? which loads are
ordered?
