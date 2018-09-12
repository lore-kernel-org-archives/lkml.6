Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C1FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8021477
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD8021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeIMAbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:31:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbeIMAbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:31:33 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDD96E6B;
        Wed, 12 Sep 2018 19:25:34 +0000 (UTC)
Date:   Wed, 12 Sep 2018 12:25:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] introduce for_each_process_thread_break() and
 for_each_process_thread_continue()
Message-Id: <20180912122533.459e73df8f512e74b7eb7354@linux-foundation.org>
In-Reply-To: <20180912163335.GA18748@redhat.com>
References: <20180912163312.GA18739@redhat.com>
        <20180912163335.GA18748@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 18:33:35 +0200 Oleg Nesterov <oleg@redhat.com> wrote:

> Usage:
> 
> 	rcu_read_lock();
> 	for_each_process_thread(p, t) {
> 		do_something_slow(p, t);
> 
> 		if (SPENT_TOO_MUCH_TIME) {
> 			for_each_process_thread_break(p, t);
> 			rcu_read_unlock();
> 			schedule();
> 			rcu_read_lock();
> 			for_each_process_thread_continue(&p, &t);
> 		}
> 	}
> 	rcu_read_unlock();
> 
> This looks similar to rcu_lock_break(), but much better and the next patch
> changes check_hung_uninterruptible_tasks() to use these new helpers. But my
> real target is show_state_filter() which can trivially lead to lockup.
> 
> Compared to rcu_lock_break(), for_each_process_thread_continue() never gives
> up, it relies on fact that both process and thread lists are sorted by the
> task->start_time key. So, for example, even if both leader/thread are already
> dead we can find the next alive process and continue.
> 
> Strictly speaking, the for_each_process/for_each_thread loops in _continue()
> could be "SPEND_TOO_MUCH_TIME" by themselves, so perhaps we will add another
> "max_scan" argument later or do something else. But at least they can not
> livelock under heavy fork/exit loads, they are bounded by PID_MAX_DEFAULT in
> the worst case.
> 
> NOTE: it seems that, contrary to the comment, task_struct->start_time is not
> really monotonic, and this should be probably fixed. Until then  _continue()
> might skip more threads with the same ->start_time than necessary.
> 
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -565,6 +565,16 @@ extern bool current_is_single_threaded(void);
>  #define for_each_process_thread(p, t)	\
>  	for_each_process(p) for_each_thread(p, t)
>  
> +static inline void
> +for_each_process_thread_break(struct task_struct *p, struct task_struct *t)
> +{
> +	get_task_struct(p);
> +	get_task_struct(t);
> +}
> +
> +extern void
> +for_each_process_thread_continue(struct task_struct **, struct task_struct **);

These things will need some documentation, please.  What they do, why
they do it, how people should use them, when and why they should use
them.  Etcetera!  This is tricky stuff.


> +void for_each_process_thread_continue(struct task_struct **p_leader,
> +				      struct task_struct **p_thread)
> +{
> +	struct task_struct *leader = *p_leader, *thread = *p_thread;
> +	struct task_struct *prev, *next;
> +	u64 start_time;
> +
> +	if (pid_alive(thread)) {
> +		/* mt exec could change the leader */
> +		*p_leader = thread->group_leader;
> +	} else if (pid_alive(leader)) {
> +		start_time = thread->start_time;
> +		prev = leader;
> +
> +		for_each_thread(leader, next) {
> +			if (next->start_time > start_time)
> +				break;
> +			prev = next;
> +		}
> +
> +		*p_thread = prev;
> +	} else {
> +		start_time = leader->start_time;
> +		prev = &init_task;
> +
> +		for_each_process(next) {
> +			if (next->start_time > start_time)
> +				break;
> +			prev = next;
> +		}
> +
> +		*p_leader = prev;
> +		/* a new thread can come after that, but this is fine */
> +		*p_thread = list_last_entry(&prev->signal->thread_head,
> +						struct task_struct,
> +						thread_node);
> +	}
> +
> +	put_task_struct(leader);
> +	put_task_struct(thread);
> +}

Should these be available to modules, like the rest of these things
appear to be?  Or we could do that later if a need is shown.
