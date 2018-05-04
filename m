Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeEDOyl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:54:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750707AbeEDOyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:54:40 -0400
Date: Fri, 4 May 2018 16:54:35 +0200
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
Message-ID: <20180504145435.GA26573@redhat.com>
References: <87r2n01q58.fsf@xmission.com>
 <87o9hz2sw3.fsf@xmission.com>
 <87h8nr2sa3.fsf_-_@xmission.com>
 <20180502084708.GC26305@dhcp22.suse.cz>
 <20180502132026.GB16060@cmpxchg.org>
 <87lgd1zww0.fsf_-_@xmission.com>
 <20180503133338.GA23401@redhat.com>
 <87y3h0x0qg.fsf@xmission.com>
 <20180504142056.GA26151@redhat.com>
 <87r2mrh4is.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2mrh4is.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > OK, what about exec() ? mm_init_memcg() initializes bprm->mm->memcg early in
> > bprm_mm_init(). What if the execing task migrates before exec_mmap() ?
>
> We need the the cgroup when the mm is initialized.  That way we have the
> cgroup information when initializing the mm.

Yes, we need to initialize new_mm->memcg but iiuc mostly for the error path,

> I don't know if a lock preventing changing the cgroup in exec or just
> a little bit of code in exec_mmap to ensure mm->memcg is properly set
> is the better approach.

I'd vote for the change in exec_mmap(). This way mm_init_memcg() can just
nullify mm->memcg.

> This does look like a very good place for an incremental patch to close
> that race.

Hmm. I think v2 makes more sense, but I won't argue.

Oleg.
