Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FAA860767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeFFLNi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:13:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbeFFLNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:13:37 -0400
Date: Wed, 6 Jun 2018 13:13:33 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in
 the same memory cgroup
Message-ID: <20180606111333.GF32433@dhcp22.suse.cz>
References: <20180510121418.GD5325@dhcp22.suse.cz>
 <20180522125757.GL20020@dhcp22.suse.cz>
 <87wovu889o.fsf@xmission.com>
 <20180524111002.GB20441@dhcp22.suse.cz>
 <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
 <20180530121721.GD27180@dhcp22.suse.cz>
 <87wovjacrh.fsf@xmission.com>
 <87wovj8e1d.fsf_-_@xmission.com>
 <87y3fywodn.fsf_-_@xmission.com>
 <87sh66wobu.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh66wobu.fsf_-_@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-06-18 09:53:09, Eric W. Biederman wrote:
[...]
> +static int mem_cgroup_mm_can_attach(struct cgroup_taskset *tset)
> +{
> +	struct cgroup_subsys_state *css, *tcss;
> +	struct task_struct *p, *t;
> +	struct mm_struct *mm = NULL;
> +	int ret = -EINVAL;
> +
> +	/*
> +	 * Ensure all references for every mm can be accounted for by
> +	 * tasks that are being migrated.
> +	 */
> +	rcu_read_lock();
> +	cgroup_taskset_for_each(p, css, tset) {
> +		int mm_users, mm_count;
> +
> +		/* Does this task have an mm that has not been visited? */
> +		if (!p->mm || (p->flags & PF_KTHREAD) || (p->mm == mm))
> +			continue;
> +
> +		mm = p->mm;
> +		mm_users = atomic_read(&mm->mm_users);
> +		if (mm_users == 1)
> +			continue;
> +
> +		mm_count = 0;
> +		cgroup_taskset_for_each(t, tcss, tset) {
> +			if (t->mm != mm)
> +				continue;
> +			mm_count++;
> +		}
> +		/*
> +		 * If there are no non-task references mm_users will
> +		 * be stable as holding cgroup_thread_rwsem for write
> +		 * blocks fork and exit.
> +		 */
> +		if (mm_count != mm_users)
> +			goto out;

Wouldn't it be much more simple to do something like this instead? Sure
it will break migration of non-thread tasks sharing mms but I would like
to see that this actually matters to anybody rather than make the code
more complicated and maintain it forever without a good reason. So yes
this is a bit harsh but considering that the migration suceeded silently
and that was simply broken as well, I am not sure this is any worse.

Btw. MMF_ALIEN_MM could be used in the OOM proper as well.

diff --git a/kernel/fork.c b/kernel/fork.c
index dfe8e14c0fba..285cd0397307 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1303,6 +1303,8 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm = oldmm;
+		if (unlikely(!(clone_flags & CLONE_THREAD)))
+			set_bit(MMF_ALIEN_MM, &mm->flags);
 		goto good_mm;
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2f5dac193431..fa0248fcdb36 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5103,6 +5103,18 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 	if (!mm)
 		return 0;
 
+	/*
+	 * Migrating a task which shares mm with other thread group
+	 * has never been really well defined. Shout to the log when
+	 * this happens and see whether anybody really complains.
+	 * If so make sure to support migration if all processes sharing
+	 * this mm are migrating together.
+	 */
+	if (WARN_ON_ONCE(test_bit(MMF_ALIEN_MM, &mm->flags))) {
+		mmput(mm);
+		return -EBUSY;
+	}
+
 	/* We move charges except for creative uses of CLONE_VM */
 	if (mm->memcg == from) {
 		VM_BUG_ON(mc.from);

-- 
Michal Hocko
SUSE Labs
