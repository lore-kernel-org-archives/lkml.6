Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A29C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A29C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJYWUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:20:54 -0400
Received: from foss.arm.com ([217.140.101.70]:57140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeJYWUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:20:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B151DA78;
        Thu, 25 Oct 2018 06:48:03 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B08E3F6A8;
        Thu, 25 Oct 2018 06:48:01 -0700 (PDT)
Subject: Re: [PATCH 08/10] sched/fair: Steal work from an overloaded CPU when
 CPU goes idle
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-9-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <223bfcdb-bb0c-b25e-04dc-26226a7c3ab3@arm.com>
Date:   Thu, 25 Oct 2018 14:48:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540220381-424433-9-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 22/10/2018 15:59, Steve Sistare wrote:
[...]
> @@ -9683,6 +9698,141 @@ void trigger_load_balance(struct rq *rq)
>  	nohz_balancer_kick(rq);
>  }
>  
> +/*
> + * Search the runnable tasks in @cfs_rq in order of next to run, and find
> + * the first one that can be migrated to @dst_rq.  @cfs_rq is locked on entry.
> + * On success, dequeue the task from @cfs_rq and return it, else return NULL.
> + */
> +static struct task_struct *
> +detach_next_task(struct cfs_rq *cfs_rq, struct rq *dst_rq)
> +{
> +	int dst_cpu = dst_rq->cpu;
> +	struct task_struct *p;
> +	struct rq *rq = rq_of(cfs_rq);
> +
> +	lockdep_assert_held(&rq_of(cfs_rq)->lock);
> +
> +	list_for_each_entry_reverse(p, &rq->cfs_tasks, se.group_node) {
> +		if (can_migrate_task_llc(p, rq, dst_rq)) {
> +			detach_task(p, rq, dst_cpu);
> +			return p;
> +		}
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * Attempt to migrate a CFS task from @src_cpu to @dst_rq.  @locked indicates
> + * whether @dst_rq is already locked on entry.  This function may lock or
> + * unlock @dst_rq, and updates @locked to indicate the locked state on return.
> + * The locking protocol is based on idle_balance().
> + * Returns 1 on success and 0 on failure.
> + */
> +static int steal_from(struct rq *dst_rq, struct rq_flags *dst_rf, bool *locked,
> +		      int src_cpu)
> +{
> +	struct task_struct *p;
> +	struct rq_flags rf;
> +	int stolen = 0;
> +	int dst_cpu = dst_rq->cpu;
> +	struct rq *src_rq = cpu_rq(src_cpu);
> +
> +	if (dst_cpu == src_cpu || src_rq->cfs.h_nr_running < 2)
> +		return 0;
> +
> +	if (*locked) {
> +		rq_unpin_lock(dst_rq, dst_rf);
> +		raw_spin_unlock(&dst_rq->lock);
> +		*locked = false;
> +	}
> +	rq_lock_irqsave(src_rq, &rf);
> +	update_rq_clock(src_rq);
> +
> +	if (src_rq->cfs.h_nr_running < 2 || !cpu_active(src_cpu))
> +		p = NULL;
> +	else
> +		p = detach_next_task(&src_rq->cfs, dst_rq);
> +
> +	rq_unlock(src_rq, &rf);
> +
> +	if (p) {
> +		raw_spin_lock(&dst_rq->lock);
> +		rq_repin_lock(dst_rq, dst_rf);
> +		*locked = true;
> +		update_rq_clock(dst_rq);
> +		attach_task(dst_rq, p);
> +		stolen = 1;
> +	}
> +	local_irq_restore(rf.flags);
> +
> +	return stolen;
> +}
> +
> +/*
> + * Try to steal a runnable CFS task from a CPU in the same LLC as @dst_rq,
> + * and migrate it to @dst_rq.  rq_lock is held on entry and return, but
> + * may be dropped in between.  Return 1 on success, 0 on failure, and -1
> + * if a task in a different scheduling class has become runnable on @dst_rq.
> + */
> +static int try_steal(struct rq *dst_rq, struct rq_flags *dst_rf)
> +{
> +	int src_cpu;
> +	int dst_cpu = dst_rq->cpu;
> +	bool locked = true;
> +	int stolen = 0;
> +	struct sparsemask *overload_cpus;
> +
> +	if (!sched_feat(STEAL))
> +		return 0;
> +
> +	if (!cpu_active(dst_cpu))
> +		return 0;
> +
> +	/* Get bitmap of overloaded CPUs in the same LLC as @dst_rq */
> +
> +	rcu_read_lock();
> +	overload_cpus = rcu_dereference(dst_rq->cfs_overload_cpus);
> +	if (!overload_cpus) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +#ifdef CONFIG_SCHED_SMT
> +	/*
> +	 * First try overloaded CPUs on the same core to preserve cache warmth.
> +	 */
> +	if (static_branch_likely(&sched_smt_present)) {
> +		for_each_cpu(src_cpu, cpu_smt_mask(dst_cpu)) {
> +			if (sparsemask_test_elem(src_cpu, overload_cpus) &&
> +			    steal_from(dst_rq, dst_rf, &locked, src_cpu)) {
> +				stolen = 1;
> +				goto out;
> +			}
> +		}
> +	}
> +#endif	/* CONFIG_SCHED_SMT */
> +
> +	/* Accept any suitable task in the LLC */
> +
> +	for_each_sparse_wrap(src_cpu, overload_cpus, dst_cpu) {
> +		if (steal_from(dst_rq, dst_rf, &locked, src_cpu)) {
> +			stolen = 1;
> +			break;
			^^^^^^
You might want to have a 'goto out' there for consistency and to make GCC
happy for !CONFIG_SCHED_SMT (I get a "warning: label ‘out’ defined but not
used")

[...]
