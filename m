Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HXTCB00aGVtVYgAAmS7hNA
	; Thu, 07 Jun 2018 11:43:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 063C66089E; Thu,  7 Jun 2018 11:43:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0414C608BF;
	Thu,  7 Jun 2018 11:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0414C608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeFGLnE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:43:04 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52315 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbeFGLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:43:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fQtJl-0007pU-2O; Thu, 07 Jun 2018 05:43:01 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fQtJk-0003EP-At; Thu, 07 Jun 2018 05:43:00 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michal Hocko <mhocko@kernel.org>
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
References: <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz> <87wovu889o.fsf@xmission.com>
        <20180524111002.GB20441@dhcp22.suse.cz>
        <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
        <20180530121721.GD27180@dhcp22.suse.cz> <87wovjacrh.fsf@xmission.com>
        <87wovj8e1d.fsf_-_@xmission.com> <87y3fywodn.fsf_-_@xmission.com>
        <87sh66wobu.fsf_-_@xmission.com>
        <20180606111333.GF32433@dhcp22.suse.cz>
Date: Thu, 07 Jun 2018 06:42:49 -0500
In-Reply-To: <20180606111333.GF32433@dhcp22.suse.cz> (Michal Hocko's message
        of "Wed, 6 Jun 2018 13:13:33 +0200")
Message-ID: <87wova6cw6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fQtJk-0003EP-At;;;mid=<87wova6cw6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/XR/o+d+NQl0o7Vfft569wc+DNxaGoPGI=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in the same memory cgroup
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 01-06-18 09:53:09, Eric W. Biederman wrote:
> [...]
>> +static int mem_cgroup_mm_can_attach(struct cgroup_taskset *tset)
>> +{
>> +	struct cgroup_subsys_state *css, *tcss;
>> +	struct task_struct *p, *t;
>> +	struct mm_struct *mm = NULL;
>> +	int ret = -EINVAL;
>> +
>> +	/*
>> +	 * Ensure all references for every mm can be accounted for by
>> +	 * tasks that are being migrated.
>> +	 */
>> +	rcu_read_lock();
>> +	cgroup_taskset_for_each(p, css, tset) {
>> +		int mm_users, mm_count;
>> +
>> +		/* Does this task have an mm that has not been visited? */
>> +		if (!p->mm || (p->flags & PF_KTHREAD) || (p->mm == mm))
>> +			continue;
>> +
>> +		mm = p->mm;
>> +		mm_users = atomic_read(&mm->mm_users);
>> +		if (mm_users == 1)
>> +			continue;
>> +
>> +		mm_count = 0;
>> +		cgroup_taskset_for_each(t, tcss, tset) {
>> +			if (t->mm != mm)
>> +				continue;
>> +			mm_count++;
>> +		}
>> +		/*
>> +		 * If there are no non-task references mm_users will
>> +		 * be stable as holding cgroup_thread_rwsem for write
>> +		 * blocks fork and exit.
>> +		 */
>> +		if (mm_count != mm_users)
>> +			goto out;
>
> Wouldn't it be much more simple to do something like this instead? Sure
> it will break migration of non-thread tasks sharing mms but I would like
> to see that this actually matters to anybody rather than make the code
> more complicated and maintain it forever without a good reason. So yes
> this is a bit harsh but considering that the migration suceeded silently
> and that was simply broken as well, I am not sure this is any worse.

I definitely agree that there are some other possibilities worth
exploring.

> Btw. MMF_ALIEN_MM could be used in the OOM proper as well.

There are two big issues I see with your suggested alternative.
1) cgroupv1 the task interface.  We still need to deny migrating
   part of a thread group.

2) vfork.  That uses CLONE_MM and it gets used.  At a quick look
   I am seeing gcc, g++, cpp, emacs24, strace, calendar, nm, telnet, gdb,
   and several other programs I don't recognize.

I believe your proposal will prevent onlining the memcgroup if there
is a compile running, because of failure to support vfork.

Further I expect we would need a count rather than a bit that gets set
and never gets cleared.  Or else even when the mm is no longer shared by
vfork we will still think it is.

Michal do you have an opinion on my previous patch?

I just want to make certain that this fun work does not get all of the
attention, and the bug fix actually gets reviewed.

Eric

> diff --git a/kernel/fork.c b/kernel/fork.c
> index dfe8e14c0fba..285cd0397307 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1303,6 +1303,8 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>  	if (clone_flags & CLONE_VM) {
>  		mmget(oldmm);
>  		mm = oldmm;
> +		if (unlikely(!(clone_flags & CLONE_THREAD)))
> +			set_bit(MMF_ALIEN_MM, &mm->flags);
>  		goto good_mm;
>  	}
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2f5dac193431..fa0248fcdb36 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5103,6 +5103,18 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
>  	if (!mm)
>  		return 0;
>  
> +	/*
> +	 * Migrating a task which shares mm with other thread group
> +	 * has never been really well defined. Shout to the log when
> +	 * this happens and see whether anybody really complains.
> +	 * If so make sure to support migration if all processes sharing
> +	 * this mm are migrating together.
> +	 */
> +	if (WARN_ON_ONCE(test_bit(MMF_ALIEN_MM, &mm->flags))) {
> +		mmput(mm);
> +		return -EBUSY;
> +	}
> +
>  	/* We move charges except for creative uses of CLONE_VM */
>  	if (mm->memcg == from) {
>  		VM_BUG_ON(mc.from);
