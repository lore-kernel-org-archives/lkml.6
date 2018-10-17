Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D332ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0320658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sNdyVuFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB0320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeJQXF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:05:59 -0400
Received: from mail.efficios.com ([167.114.142.138]:56192 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJQXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:05:58 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9C27D1CA616;
        Wed, 17 Oct 2018 11:09:50 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id nF3AnNyw5lbN; Wed, 17 Oct 2018 11:09:50 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 33A6E1CA60F;
        Wed, 17 Oct 2018 11:09:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 33A6E1CA60F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539788990;
        bh=wWKd6QJ+MQ/yuWkoCIdeyyQB03N3odcK3FEkxpn/8UY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=sNdyVuFcpwObhDOeIFyxJ4F54U9RzFd++rfPR1EgAzMzkoeuDdANVIX3rcO3LC67k
         24nWVMFZy+IUp5w1wmLDQGVyC8AEhvtg8+v2JfumdD4/xReYrAZEFcCMpXjNajntFk
         Z9K7WLXD73mOoQFgE0syYGrFRQTf6Cl/CnlaaNQQ9cukhxc5jKcCx1wZAk0q/oPKs1
         5zT2AIPrVeadFNkMaXv1AHzQdU+MRzpEeWS9DCyJaJGIiZK94NBC9qsj9pAfZy+NIq
         uemyqTthMK3Car6lNKW7JFB6mo5Wz/QQrRuRLZX/yKmPwn8BCfRtKO/mrWpGbokjU/
         i0xUxmWlAtZiQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 1JImKwivWloO; Wed, 17 Oct 2018 11:09:50 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0EDA21CA605;
        Wed, 17 Oct 2018 11:09:50 -0400 (EDT)
Date:   Wed, 17 Oct 2018 11:09:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <704369944.814.1539788989963.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181017065145.GA7111@linux.vnet.ibm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-4-mathieu.desnoyers@efficios.com> <20181017065145.GA7111@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH for 4.21 03/16] sched: Implement push_task_to_cpu
 (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: sched: Implement push_task_to_cpu (v2)
Thread-Index: GiS32WM/xSgzHSI9RscP/cknL+p9+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 17, 2018, at 2:51 AM, Srikar Dronamraju srikar@linux.vnet.ibm.com wrote:

> Hi Mathieu,
> 
>> +int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu)
>> +{
> 
> In your use case, is the task going to be current?
> If yes, we should simply be using migrate_task_to.
> 
>> +	struct rq_flags rf;
>> +	struct rq *rq;
>> +	int ret = 0;
>> +
>> +	rq = task_rq_lock(p, &rf);
>> +	update_rq_clock(rq);
>> +
>> +	if (!cpumask_test_cpu(dest_cpu, &p->cpus_allowed)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
> 
> Ideally we should have checked cpus_allowed/cpu_active_mask before taking
> the lock. This would help reduce the contention on the rqlock when the
> passed parameter is not correct.
> 
>> +
>> +	if (!cpumask_test_cpu(dest_cpu, cpu_active_mask)) {
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	if (task_cpu(p) == dest_cpu)
>> +		goto out;
> 
> Same as above.
> 
>> +
>> +	if (task_running(rq, p) || p->state == TASK_WAKING) {
> 
> Why are we using migration thread to move a task in TASK_WAKING state?
> 
>> +		struct migration_arg arg = { p, dest_cpu };
>> +		/* Need help from migration thread: drop lock and wait. */
>> +		task_rq_unlock(rq, p, &rf);
>> +		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
>> +		tlb_migrate_finish(p->mm);
>> +		return 0;
> 
> Why cant we use migrate_task_to instead?

I could do that be moving migrate_task_to outside of NUMA-specific #ifdef,
but I think we can do much, much simpler than that, see below.

> 
>> +	} else if (task_on_rq_queued(p)) {
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 455fa330de04..27ad25780204 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1340,6 +1340,15 @@ static inline void __set_task_cpu(struct task_struct *p,
>> unsigned int cpu)
>>  #endif
>>  }
>>  
>> +#ifdef CONFIG_SMP
>> +int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu);
>> +#else
>> +static inline int push_task_to_cpu(struct task_struct *p, unsigned int
>> dest_cpu)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
> 
> Your usecase is outside kernel/sched. So I am not sure if this is the right
> place for the declaration.

Actually, now that I think of it, we may not need to migrate the task at all.
Now that cpu_opv implementation takes a temporary vmap() of the user-space pages,
we can touch that virtual address range from interrupt context from another CPU.

So cpu_opv can simply execute the vector of operations in IPI context rather than
do all this silly dance with migration.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
