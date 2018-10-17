Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F850ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10842150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10842150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJQSIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:08:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:44011 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeJQSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:08:22 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9HACjao056450;
        Wed, 17 Oct 2018 19:12:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Wed, 17 Oct 2018 19:12:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9HACjEc056447
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 17 Oct 2018 19:12:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/{lockdep,hung_task}: Show locks and backtrace of
 running tasks.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <1535975097-19080-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <cf1c8ccb-9a66-3c44-01d3-b11f15a83802@i-love.sakura.ne.jp>
Message-ID: <3a686cf6-44ac-2f16-1db3-c79f4df41a56@i-love.sakura.ne.jp>
Date:   Wed, 17 Oct 2018 19:12:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cf1c8ccb-9a66-3c44-01d3-b11f15a83802@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I think that this patch helps examining reports like

  https://syzkaller.appspot.com/text?tag=CrashLog&x=150eab91400000

where there is a TASK_RUNNING thread with a lock held

  1 lock held by syz-executor0/18295:

and presumably it is the lock which the hung tasks are waiting for.

On 2018/09/10 15:07, Tetsuo Handa wrote:
> On 2018/09/03 20:44, Tetsuo Handa wrote:
>> We are getting reports from syzbot where running task seems to be
>> relevant to a hung task problem but NMI backtrace does not print useful
>> information [1].
> 
> According to my local cache, 69% of hung task reports from syzbot say that
> one CPU was running check_hung_uninterruptible_tasks() and the other CPU
> was idle. I think that this patch would in many cases give more useful
> information than trigger_all_cpu_backtrace() reports. Can we try this patch?
> 
> $ ls -l */CrashLog.*[0-9a-f] | wc -l
> 1666
> $ for i in */CrashLog.*; do awk ' BEGIN { flag = 0; } { if (index($0, "NMI backtrace") > 0) { flag = 1; } else if (index($0, "panic") > 0) { exit; } if (flag == 1) { print $0; } }' $i > $i.tmp; done
> $ ls -l */*.tmp | wc -l
> 1666
> $ grep -i watchdog+ */*.tmp | wc -l
> 1662
> $ grep -i "idling at" */*.tmp | wc -l
> 1151
> $ grep -F '<IRQ>' */*.tmp | wc -l
> 220
> 
>>
>> Although commit 8cc05c71ba5f7936 ("locking/lockdep: Move sanity check to
>> inside lockdep_print_held_locks()") says that calling
>> lockdep_print_held_locks() on a running thread is considered unsafe,
>> it is useful for syzbot to show locks and backtrace of running tasks.
>> Thus, let's allow it if CONFIG_DEBUG_AID_FOR_SYZBOT is defined.
>>
>> [1] https://syzkaller.appspot.com/bug?id=8bab7a6a5597bb10f90e8227a7d8a483748d93be
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> ---
>>  kernel/hung_task.c       | 20 ++++++++++++++++++++
>>  kernel/locking/lockdep.c |  9 +++++++++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index b9132d1..1ac49a5 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -201,6 +201,26 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>>  	if (hung_task_show_lock)
>>  		debug_show_all_locks();
>>  	if (hung_task_call_panic) {
>> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
>> +		/*
>> +		 * debug_show_all_locks() above forcibly dumped locks held by
>> +		 * running tasks with locks held. Now, let's dump backtrace of
>> +		 * running tasks as well, for NMI backtrace below tends to show
>> +		 * current thread (i.e. khungtaskd thread itself) and idle CPU
>> +		 * which are useless for debugging hung task problems.
>> +		 */
>> +		rcu_read_lock();
>> +		for_each_process_thread(g, t) {
>> +			if (t->state != TASK_RUNNING || t == current)
>> +				continue;
>> +			pr_err("INFO: task %s:%d was running.\n", t->comm,
>> +			       t->pid);
>> +			sched_show_task(t);
>> +			touch_nmi_watchdog();
>> +			touch_all_softlockup_watchdogs();
>> +		}
>> +		rcu_read_unlock();
>> +#endif
>>  		trigger_all_cpu_backtrace();
>>  		panic("hung_task: blocked tasks");
>>  	}
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index e406c5f..efeebf6 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -565,12 +565,21 @@ static void lockdep_print_held_locks(struct task_struct *p)
>>  	else
>>  		printk("%d lock%s held by %s/%d:\n", depth,
>>  		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
>> +#ifndef CONFIG_DEBUG_AID_FOR_SYZBOT
>>  	/*
>>  	 * It's not reliable to print a task's held locks if it's not sleeping
>>  	 * and it's not the current task.
>>  	 */
>>  	if (p->state == TASK_RUNNING && p != current)
>>  		return;
>> +#else
>> +	/*
>> +	 * But showing locks and backtrace of running tasks seems to be helpful
>> +	 * for debugging hung task problems. Since syzbot will call panic()
>> +	 * shortly, risking problems caused by accessing stale information is
>> +	 * acceptable here.
>> +	 */
>> +#endif
>>  	for (i = 0; i < depth; i++) {
>>  		printk(" #%d: ", i);
>>  		print_lock(p->held_locks + i);
>>
> 

