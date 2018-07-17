Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B2BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3679E20779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XfyWS/ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3679E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbeGQQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:14:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44648 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbeGQQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iNAjETrR5c7BDYGuWnQBomWlbWRoOKw/fyTQZw45yV4=; b=XfyWS/wwW77zx27Q51FmI+vEU
        Nsd/PRWzhvrGhM2k3YLj3aAymglQQsROWjP82T/jyCRBZQAoaq7gpUovFd2eB8iFNjt2WCNY10lqx
        a4OCKUVGy6aQtCIWC0zeYjL1/EXizXkd9yBND21terBlI7EyU+ZPMXp7jw3LbEWggavNYYteZEAcM
        XGNoDxl+rnG51vmh5tUwfPZQtKsCe7Pp9nyfk36pAct9/1INHJlBDhGT27AqPDRjRMsq1nx71qQH1
        ji73rZVzqC9cI1DS+VoX7ibQnU7IyrWeyJVZknPGjZeX514c/40/sAxlip1SBXHaCqHDVggST5kU6
        QU8rXIn8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffS61-0001V3-9K; Tue, 17 Jul 2018 15:41:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1B9F20275F38; Tue, 17 Jul 2018 17:40:59 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:40:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 09/10] psi: cgroup support
Message-ID: <20180717154059.GB2476@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-10-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-10-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:41PM -0400, Johannes Weiner wrote:
> +/**
> + * cgroup_move_task - move task to a different cgroup
> + * @task: the task
> + * @to: the target css_set
> + *
> + * Move task to a new cgroup and safely migrate its associated stall
> + * state between the different groups.
> + *
> + * This function acquires the task's rq lock to lock out concurrent
> + * changes to the task's scheduling state and - in case the task is
> + * running - concurrent changes to its stall state.
> + */
> +void cgroup_move_task(struct task_struct *task, struct css_set *to)
> +{
> +	unsigned int task_flags = 0;
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	u64 now;
> +
> +	rq = task_rq_lock(task, &rf);
> +
> +	if (task_on_rq_queued(task)) {
> +		task_flags = TSK_RUNNING;
> +	} else if (task->in_iowait) {
> +		task_flags = TSK_IOWAIT;
> +	}
> +	if (task->flags & PF_MEMSTALL)
> +		task_flags |= TSK_MEMSTALL;
> +
> +	if (task_flags) {
> +		update_rq_clock(rq);
> +		now = rq_clock(rq);
> +		psi_task_change(task, now, task_flags, 0);
> +	}
> +
> +	/*
> +	 * Lame to do this here, but the scheduler cannot be locked
> +	 * from the outside, so we move cgroups from inside sched/.
> +	 */
> +	rcu_assign_pointer(task->cgroups, to);
> +
> +	if (task_flags)
> +		psi_task_change(task, now, 0, task_flags);
> +
> +	task_rq_unlock(rq, task, &rf);
> +}

Why is that not part of cpu_cgroup_attach() / sched_move_task() ?
