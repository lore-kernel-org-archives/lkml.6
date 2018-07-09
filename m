Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D64C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DC42084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DC42084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gliwa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbeGIKGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:06:50 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:57834 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeGIKGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:06:48 -0400
Received: by mail.gliwa.com (Postfix, from userid 992)
        id B8C9E34416F; Mon,  9 Jul 2018 12:06:46 +0200 (CEST)
X-Virus-Checker-Version: ClamAV 0.100.0/24736/Mon Jul 9 06:41:36 2018
X-Virus-Status: OK
Received: from [192.168.1.91] (x590f72cd.dyn.telefonica.de [89.15.114.205])
        by mail.gliwa.com (Postfix) with ESMTPSA id 71E8B344168;
        Mon,  9 Jul 2018 12:06:46 +0200 (CEST)
From:   Claudio <claudio.fontana@gliwa.com>
Subject: Re: ftrace performance (sched events): cyclictest shows 25% more
 latency
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
 <20180706172428.30aeef91@gandalf.local.home>
Message-ID: <f5624adb-6fc3-bf17-d58f-b98ed8c69b7e@gliwa.com>
Date:   Mon, 9 Jul 2018 12:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180706172428.30aeef91@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve,

thank you for your response,

On 07/06/2018 11:24 PM, Steven Rostedt wrote:
> On Fri, 6 Jul 2018 08:22:01 +0200
> Claudio <claudio.fontana@gliwa.com> wrote:
> 
>> Hello all,
>>
>> I have been experimenting with the idea of leaving ftrace enabled, with sched events,
>> on production systems.
>>
>> The main concern that I am having at the moment is about the impact on the system.
>> Enabling the sched events that I currently need for the tracing application
>> seems to slow down context-switches considerably, and make the system less responsive.
>>
>> I have tested with cyclictest on the mainline kernel, and noticed an increase of min, avg latencies of around 25%.
>>
>> Is this expected?
> 
> No it is not. And this is weird. I'm seeing it too.
> 
>>
>> Some initial investigation into ftrace seems to point at the reservation and commit of the events into the ring buffer
>> as the highest sources of overhead, while event parameters copying, including COMM, does not seem to have any noticeable effect
>> relative to those costs.
> 
> Did you use perf to see where the issues were? If so what perf command
> did you use?

I did not use perf, I will now do it and see what I get.
You can discard my comment regarding reservation and commit, it was based on a wrong premise.

Regarding parameter copying, I just brutally modified the code to not fill fields (TP_fast_assign),
and I just noticed that it did not change the result significantly.

> 
> When running just:
>   perf record ./cyclictest --smp -p95 -m -s -N -l 1000000 -q
> 
> I get this:
> 
>    6.08%  cyclictest  [kernel.vmlinux]    [k] syscall_return_via_sysret
>    4.03%  cyclictest  cyclictest          [.] timerthread
>    3.97%  cyclictest  [kernel.vmlinux]    [k] __schedule
>    3.81%  cyclictest  [kernel.vmlinux]    [k] native_write_msr
>    3.13%  cyclictest  [kernel.vmlinux]    [k] trace_save_cmdline
>    2.71%  cyclictest  [kernel.vmlinux]    [k] do_nanosleep
>    2.48%  cyclictest  [kernel.vmlinux]    [k] do_syscall_64
>    2.11%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_fair
>    2.03%  cyclictest  [kernel.vmlinux]    [k] native_sched_clock
>    1.99%  cyclictest  [kernel.vmlinux]    [k] cpuacct_charge
>    1.93%  cyclictest  [vdso]              [.] __vdso_clock_gettime
>    1.86%  cyclictest  [kernel.vmlinux]    [k] hrtimer_nanosleep
>    1.84%  cyclictest  [kernel.vmlinux]    [k] cpupri_set
>    1.66%  cyclictest  [kernel.vmlinux]    [k] update_curr_rt
>    1.65%  cyclictest  [kernel.vmlinux]    [k] __perf_event_task_sched_out
>    1.59%  cyclictest  [kernel.vmlinux]    [k] dequeue_rt_stack
>    1.55%  cyclictest  [kernel.vmlinux]    [k] __rb_reserve_next
> 
> Which shows there's a lot being done before we even get to the ring
> buffer reserve.

I get (CONFIG_PREEMPT_VOLUNTARY):

SCHED EVENTS DISABLED:

     8.57%  cyclictest  [kernel.vmlinux]    [k] syscall_return_via_sysret
     7.04%  cyclictest  [kernel.vmlinux]    [k] native_write_msr
     6.93%  cyclictest  [kernel.vmlinux]    [k] entry_SYSCALL_64_trampoline
     4.42%  cyclictest  cyclictest          [.] timerthread
     4.14%  cyclictest  [kernel.vmlinux]    [k] __schedule
     3.52%  cyclictest  [kernel.vmlinux]    [k] cpupri_set
     2.90%  cyclictest  [kernel.vmlinux]    [k] finish_task_switch
     2.42%  cyclictest  [kernel.vmlinux]    [k] update_curr_rt
     2.34%  cyclictest  [kernel.vmlinux]    [k] _raw_spin_lock
     2.28%  cyclictest  [kernel.vmlinux]    [k] ktime_get
     2.14%  cyclictest  [kernel.vmlinux]    [k] timerqueue_add
     2.06%  cyclictest  [kernel.vmlinux]    [k] read_tsc
     2.06%  cyclictest  [kernel.vmlinux]    [k] native_sched_clock
     2.01%  cyclictest  [vdso]              [.] __vdso_clock_gettime
     1.95%  cyclictest  [kernel.vmlinux]    [k] do_nanosleep
     1.93%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_fair
     1.89%  cyclictest  [vdso]              [.] 0x0000000000000977
     1.75%  cyclictest  [kernel.vmlinux]    [k] dequeue_task_rt
     1.64%  cyclictest  [kernel.vmlinux]    [k] x86_pmu_disable
     1.57%  cyclictest  [kernel.vmlinux]    [k] dequeue_rt_stack
     1.53%  cyclictest  [kernel.vmlinux]    [k] __x64_sys_nanosleep
     1.51%  cyclictest  [kernel.vmlinux]    [k] do_syscall_64
     1.41%  cyclictest  [kernel.vmlinux]    [k] put_prev_task_rt
     1.34%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_dl
     1.28%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_rt
     1.25%  cyclictest  [kernel.vmlinux]    [k] cpuacct_charge
     1.25%  cyclictest  [kernel.vmlinux]    [k] hrtimer_start_range_ns
     1.24%  cyclictest  [kernel.vmlinux]    [k] __x86_indirect_thunk_rax
     1.07%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c1b
     0.94%  cyclictest  [kernel.vmlinux]    [k] pull_rt_task
     0.93%  cyclictest  [kernel.vmlinux]    [k] entry_SYSCALL_64_stage2
     0.89%  cyclictest  [kernel.vmlinux]    [k] hrtimer_nanosleep
     0.89%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c1d
     0.88%  cyclictest  [kernel.vmlinux]    [k] entry_SYSCALL_64
     0.79%  cyclictest  [kernel.vmlinux]    [k] _raw_spin_lock_irqsave
     0.79%  cyclictest  [kernel.vmlinux]    [k] ctx_sched_out
     0.78%  cyclictest  [kernel.vmlinux]    [k] copy_user_generic_unrolled
     0.77%  cyclictest  libpthread-2.23.so  [.] __pthread_enable_asynccancel
     0.71%  cyclictest  [kernel.vmlinux]    [k] __perf_event_task_sched_out
     0.71%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_idle
     0.70%  cyclictest  libpthread-2.23.so  [.] __pthread_disable_asynccancel
     0.70%  cyclictest  [kernel.vmlinux]    [k] __hrtimer_init
     0.68%  cyclictest  [kernel.vmlinux]    [k] clear_page_erms
     0.64%  cyclictest  [kernel.vmlinux]    [k] intel_pmu_disable_all
     0.58%  cyclictest  [kernel.vmlinux]    [k] copy_user_enhanced_fast_string
     0.58%  cyclictest  [kernel.vmlinux]    [k] _copy_from_user
     0.58%  cyclictest  [kernel.vmlinux]    [k] _raw_spin_unlock_irqrestore
     0.54%  cyclictest  [kernel.vmlinux]    [k] get_nohz_timer_target
     0.54%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_stop
     0.48%  cyclictest  [kernel.vmlinux]    [k] schedule
     0.47%  cyclictest  [kernel.vmlinux]    [k] lapic_next_deadline
     0.43%  cyclictest  [kernel.vmlinux]    [k] sched_avg_update
     0.42%  cyclictest  [kernel.vmlinux]    [k] __perf_event_task_sched_in
     0.37%  cyclictest  libc-2.23.so        [.] __clock_gettime
     0.37%  cyclictest  [vdso]              [.] 0x0000000000000974
     0.35%  cyclictest  [kernel.vmlinux]    [k] get_timespec64
     0.32%  cyclictest  [kernel.vmlinux]    [k] dequeue_top_rt_rq
     0.31%  cyclictest  [kernel.vmlinux]    [k] try_to_unmap_one
     0.27%  cyclictest  [kernel.vmlinux]    [k] update_rq_clock
     0.24%  cyclictest  [kernel.vmlinux]    [k] rb_insert_color
     0.23%  cyclictest  [kernel.vmlinux]    [k] deactivate_task
     0.22%  cyclictest  [kernel.vmlinux]    [k] follow_page_pte
     0.21%  cyclictest  [kernel.vmlinux]    [k] page_not_mapped
     0.20%  cyclictest  [kernel.vmlinux]    [k] sched_clock_cpu
     0.18%  cyclictest  cyclictest          [.] main
     0.17%  cyclictest  [kernel.vmlinux]    [k] clockevents_program_event
     0.17%  cyclictest  [kernel.vmlinux]    [k] hrtimer_reprogram
     0.16%  cyclictest  [kernel.vmlinux]    [k] find_busiest_group
     0.15%  cyclictest  [kernel.vmlinux]    [k] enqueue_hrtimer
     0.15%  cyclictest  libc-2.23.so        [.] __nanosleep
     0.14%  cyclictest  cyclictest          [.] clock_gettime@plt
     0.14%  cyclictest  [kernel.vmlinux]    [k] rcu_note_context_switch
     0.14%  cyclictest  [kernel.vmlinux]    [k] __intel_pmu_enable_all
     0.13%  cyclictest  [kernel.vmlinux]    [k] hrtimer_active
     0.13%  cyclictest  libpthread-2.23.so  [.] __nanosleep
     0.13%  cyclictest  [kernel.vmlinux]    [k] __msecs_to_jiffies
     0.13%  cyclictest  [kernel.vmlinux]    [k] rcu_all_qs
     0.13%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c24
     0.13%  cyclictest  [kernel.vmlinux]    [k] hrtimer_try_to_cancel
     0.13%  cyclictest  cyclictest          [.] nanosleep@plt
     0.12%  cyclictest  [kernel.vmlinux]    [k] __intel_pmu_disable_all
     0.12%  cyclictest  [kernel.vmlinux]    [k] _cond_resched
     0.10%  cyclictest  cyclictest          [.] print_stat
     0.10%  cyclictest  [kernel.vmlinux]    [k] perf_ctx_unlock
     0.10%  cyclictest  [kernel.vmlinux]    [k] sched_clock
     0.10%  cyclictest  [kernel.vmlinux]    [k] free_unref_page_list
     0.09%  cyclictest  [vdso]              [.] 0x0000000000000987
     0.09%  cyclictest  [kernel.vmlinux]    [k] update_cfs_group
     0.08%  cyclictest  [kernel.vmlinux]    [k] copy_semundo
     0.08%  cyclictest  [kernel.vmlinux]    [k] update_blocked_averages
     0.07%  cyclictest  [kernel.vmlinux]    [k] tick_program_event
     0.07%  cyclictest  [kernel.vmlinux]    [k] dequeue_task_fair
     0.07%  cyclictest  [kernel.vmlinux]    [k] __handle_mm_fault
     0.06%  cyclictest  [kernel.vmlinux]    [k] plist_del
     0.06%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c0d
     0.06%  cyclictest  [kernel.vmlinux]    [k] put_prev_task_fair
     0.06%  cyclictest  [vdso]              [.] 0x0000000000000979
     0.06%  cyclictest  [kernel.vmlinux]    [k] munlock_vma_pages_range
     0.05%  cyclictest  [vdso]              [.] 0x000000000000097d
     0.05%  cyclictest  [kernel.vmlinux]    [k] __lru_cache_add
     0.05%  cyclictest  [kernel.vmlinux]    [k] update_load_avg
     0.05%  cyclictest  [kernel.vmlinux]    [k] pick_next_entity
     0.04%  cyclictest  [kernel.vmlinux]    [k] update_rt_migration
     0.04%  cyclictest  [kernel.vmlinux]    [k] pagevec_lru_move_fn
     0.04%  cyclictest  [kernel.vmlinux]    [k] reusable_anon_vma
     0.04%  cyclictest  [kernel.vmlinux]    [k] pmd_huge
     0.04%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c21
     0.04%  cyclictest  ld-2.23.so          [.] strcmp
     0.04%  cyclictest  libc-2.23.so        [.] __call_tls_dtors
     0.04%  cyclictest  [kernel.vmlinux]    [k] free_unref_page_commit
     0.04%  cyclictest  [kernel.vmlinux]    [k] unmap_page_range
     0.04%  cyclictest  [kernel.vmlinux]    [k] PageHeadHuge
     0.04%  cyclictest  [kernel.vmlinux]    [k] vma_interval_tree_iter_next
     0.04%  cyclictest  [kernel.vmlinux]    [k] rmap_walk_file
     0.04%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c12
     0.04%  cyclictest  [kernel.vmlinux]    [k] __update_load_avg_se.isra.41
     0.03%  cyclictest  [kernel.vmlinux]    [k] __munlock_pagevec
     0.03%  cyclictest  libc-2.23.so        [.] _itoa_word
     0.03%  cyclictest  [kernel.vmlinux]    [k] __pagevec_lru_add_fn
     0.03%  cyclictest  [kernel.vmlinux]    [k] ext4_file_mmap
     0.03%  cyclictest  [kernel.vmlinux]    [k] free_pcppages_bulk
     0.02%  cyclictest  [kernel.vmlinux]    [k] lock_hrtimer_base.isra.19
     0.02%  cyclictest  [kernel.vmlinux]    [k] __mod_node_page_state
     0.02%  cyclictest  [kernel.vmlinux]    [k] rb_erase
     0.02%  cyclictest  [kernel.vmlinux]    [k] release_pages
     0.02%  cyclictest  [kernel.vmlinux]    [k] clear_buddies
     0.02%  cyclictest  [kernel.vmlinux]    [k] __hrtimer_next_event_base
     0.02%  cyclictest  [kernel.vmlinux]    [k] swapgs_restore_regs_and_return_t
     0.02%  cyclictest  [kernel.vmlinux]    [k] reweight_entity
     0.02%  cyclictest  [kernel.vmlinux]    [k] update_curr
     0.02%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c29
     0.02%  cyclictest  libpthread-2.23.so  [.] start_thread
     0.02%  cyclictest  [kernel.vmlinux]    [k] xhci_queue_intr_tx
     0.02%  cyclictest  [kernel.vmlinux]    [k] __acct_update_integrals
     0.02%  cyclictest  [vdso]              [.] 0x0000000000000971
     0.02%  cyclictest  [kernel.vmlinux]    [k] xhci_check_args
     0.01%  cyclictest  [kernel.vmlinux]    [k] idle_cpu
     0.01%  cyclictest  [kernel.vmlinux]    [k] scheduler_tick
     0.01%  cyclictest  [kernel.vmlinux]    [k] __delayacct_add_tsk
     0.01%  cyclictest  [kernel.vmlinux]    [k] perf_pmu_disable.part.98
     0.01%  cyclictest  [kernel.vmlinux]    [k] end_repeat_nmi
     0.00%  cyclictest  [kernel.vmlinux]    [k] native_irq_return_iret
     0.00%  cyclictest  [kernel.vmlinux]    [k] nmi_restore
     0.00%  cyclictest  [kernel.vmlinux]    [k] do_nmi
     0.00%  cyclictest  [kernel.vmlinux]    [k] nmi_handle
     0.00%  perf        [kernel.vmlinux]    [k] perf_event_addr_filters_exec
     0.00%  cyclictest  [kernel.vmlinux]    [k] perf_event_nmi_handler
     0.00%  perf        [kernel.vmlinux]    [k] native_write_msr
     0.00%  cyclictest  [unknown]           [.] 0000000000000000

SCHED EVENTS ENABLED:

     7.33%  cyclictest  [kernel.vmlinux]    [k] syscall_return_via_sysret
     6.51%  cyclictest  [kernel.vmlinux]    [k] entry_SYSCALL_64_trampoline
     5.84%  cyclictest  [kernel.vmlinux]    [k] native_write_msr
     4.00%  cyclictest  cyclictest          [.] timerthread
     3.62%  cyclictest  [kernel.vmlinux]    [k] __schedule
     2.71%  cyclictest  [kernel.vmlinux]    [k] cpupri_set
     2.57%  cyclictest  [kernel.vmlinux]    [k] finish_task_switch
     2.46%  cyclictest  [kernel.vmlinux]    [k] native_sched_clock
     2.19%  cyclictest  [kernel.vmlinux]    [k] __x86_indirect_thunk_rax
     2.03%  cyclictest  [kernel.vmlinux]    [k] ktime_get
     2.01%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_fair
     1.93%  cyclictest  [kernel.vmlinux]    [k] _raw_spin_lock
     1.90%  cyclictest  [kernel.vmlinux]    [k] timerqueue_add
     1.70%  cyclictest  [kernel.vmlinux]    [k] do_nanosleep
     1.67%  cyclictest  [kernel.vmlinux]    [k] read_tsc
     1.65%  cyclictest  [kernel.vmlinux]    [k] cpuacct_charge
     1.60%  cyclictest  [kernel.vmlinux]    [k] update_curr_rt
     1.49%  cyclictest  [kernel.vmlinux]    [k] probe_sched_switch
     1.40%  cyclictest  [kernel.vmlinux]    [k] __x64_sys_nanosleep
     1.34%  cyclictest  [kernel.vmlinux]    [k] dequeue_rt_stack
     1.28%  cyclictest  [kernel.vmlinux]    [k] do_syscall_64
     1.27%  cyclictest  [kernel.vmlinux]    [k] x86_pmu_disable
     1.24%  cyclictest  [kernel.vmlinux]    [k] __rb_reserve_next
     1.23%  cyclictest  [vdso]              [.] 0x0000000000000977
     1.21%  cyclictest  [vdso]              [.] __vdso_clock_gettime
     1.06%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c1d
     1.06%  cyclictest  [kernel.vmlinux]    [k] entry_SYSCALL_64_stage2
     1.03%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_dl
     1.00%  cyclictest  [kernel.vmlinux]    [k] put_prev_task_rt
     1.00%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_rt
     0.98%  cyclictest  [kernel.vmlinux]    [k] trace_event_raw_event_sched_swit
     0.97%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c1b
     0.95%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_idle
     0.91%  cyclictest  [kernel.vmlinux]    [k] trace_save_cmdline
     0.90%  cyclictest  [kernel.vmlinux]    [k] copy_user_generic_unrolled
     0.90%  cyclictest  [kernel.vmlinux]    [k] ctx_sched_out
     0.90%  cyclictest  [kernel.vmlinux]    [k] lapic_next_deadline
     0.86%  cyclictest  [kernel.vmlinux]    [k] intel_pmu_disable_all
     0.85%  cyclictest  [kernel.vmlinux]    [k] rb_commit
     0.84%  cyclictest  [kernel.vmlinux]    [k] entry_SYSCALL_64
     0.82%  cyclictest  [kernel.vmlinux]    [k] _raw_spin_lock_irqsave
     0.80%  cyclictest  [kernel.vmlinux]    [k] hrtimer_nanosleep
     0.76%  cyclictest  [kernel.vmlinux]    [k] _copy_from_user
     0.75%  cyclictest  [kernel.vmlinux]    [k] __hrtimer_init
     0.72%  cyclictest  [kernel.vmlinux]    [k] ring_buffer_lock_reserve
     0.69%  cyclictest  [kernel.vmlinux]    [k] __perf_event_task_sched_out
     0.66%  cyclictest  [kernel.vmlinux]    [k] hrtimer_start_range_ns
     0.63%  cyclictest  [kernel.vmlinux]    [k] get_nohz_timer_target
     0.62%  cyclictest  [kernel.vmlinux]    [k] clear_page_erms
     0.61%  cyclictest  libpthread-2.23.so  [.] __pthread_disable_asynccancel
     0.59%  cyclictest  [kernel.vmlinux]    [k] dequeue_task_rt
     0.58%  cyclictest  [kernel.vmlinux]    [k] schedule
     0.56%  cyclictest  [kernel.vmlinux]    [k] pull_rt_task
     0.55%  cyclictest  [kernel.vmlinux]    [k] _raw_spin_unlock_irqrestore
     0.54%  cyclictest  [kernel.vmlinux]    [k] rb_insert_color
     0.52%  cyclictest  [kernel.vmlinux]    [k] trace_event_buffer_reserve
     0.51%  cyclictest  [kernel.vmlinux]    [k] trace_clock_local
     0.50%  cyclictest  [kernel.vmlinux]    [k] pick_next_task_stop
     0.48%  cyclictest  [kernel.vmlinux]    [k] __perf_event_task_sched_in
     0.43%  cyclictest  [kernel.vmlinux]    [k] rcu_note_context_switch
     0.41%  cyclictest  [kernel.vmlinux]    [k] trace_event_buffer_commit
     0.41%  cyclictest  [kernel.vmlinux]    [k] deactivate_task
     0.39%  cyclictest  [kernel.vmlinux]    [k] hrtimer_reprogram
     0.36%  cyclictest  libpthread-2.23.so  [.] __pthread_enable_asynccancel
     0.36%  cyclictest  libc-2.23.so        [.] __clock_gettime
     0.34%  cyclictest  [kernel.vmlinux]    [k] tracing_generic_entry_update
     0.34%  cyclictest  [kernel.vmlinux]    [k] enqueue_hrtimer
     0.29%  cyclictest  [kernel.vmlinux]    [k] dequeue_top_rt_rq
     0.29%  cyclictest  [kernel.vmlinux]    [k] perf_ctx_unlock
     0.28%  cyclictest  [kernel.vmlinux]    [k] copy_user_enhanced_fast_string
     0.27%  cyclictest  libpthread-2.23.so  [.] __nanosleep
     0.26%  cyclictest  [kernel.vmlinux]    [k] ring_buffer_unlock_commit
     0.25%  cyclictest  [kernel.vmlinux]    [k] trace_event_buffer_lock_reserve
     0.24%  cyclictest  [kernel.vmlinux]    [k] get_timespec64
     0.23%  cyclictest  [kernel.vmlinux]    [k] find_busiest_group
     0.22%  cyclictest  cyclictest          [.] print_stat
     0.21%  cyclictest  [kernel.vmlinux]    [k] free_unref_page_list
     0.21%  cyclictest  [kernel.vmlinux]    [k] __intel_pmu_enable_all
     0.21%  cyclictest  [kernel.vmlinux]    [k] rb_move_tail
     0.20%  cyclictest  [kernel.vmlinux]    [k] ring_buffer_event_data
     0.20%  cyclictest  [kernel.vmlinux]    [k] vma_interval_tree_subtree_search
     0.20%  cyclictest  [kernel.vmlinux]    [k] sched_avg_update
     0.19%  cyclictest  [kernel.vmlinux]    [k] tick_program_event
     0.19%  cyclictest  [kernel.vmlinux]    [k] follow_page_mask
     0.19%  cyclictest  [kernel.vmlinux]    [k] sched_clock_cpu
     0.19%  cyclictest  [kernel.vmlinux]    [k] tracing_record_taskinfo_sched_sw
     0.16%  cyclictest  [kernel.vmlinux]    [k] get_page_from_freelist
     0.16%  cyclictest  [kernel.vmlinux]    [k] clockevents_program_event
     0.15%  cyclictest  [vdso]              [.] 0x0000000000000974
     0.15%  cyclictest  [kernel.vmlinux]    [k] hrtimer_try_to_cancel
     0.14%  cyclictest  [kernel.vmlinux]    [k] __alloc_pages_nodemask
     0.13%  cyclictest  cyclictest          [.] main
     0.13%  cyclictest  ld-2.23.so          [.] _dl_sysdep_start
     0.13%  cyclictest  [kernel.vmlinux]    [k] rmap_walk_file
     0.12%  cyclictest  [kernel.vmlinux]    [k] update_rq_clock
     0.12%  cyclictest  libc-2.23.so        [.] __libc_disable_asynccancel
     0.12%  cyclictest  [vdso]              [.] 0x0000000000000970
     0.12%  cyclictest  [kernel.vmlinux]    [k] hrtimer_active
     0.11%  cyclictest  [kernel.vmlinux]    [k] page_not_mapped
     0.11%  cyclictest  [kernel.vmlinux]    [k] sched_clock
     0.10%  cyclictest  [kernel.vmlinux]    [k] __mod_zone_page_state
     0.10%  cyclictest  [kernel.vmlinux]    [k] account_entity_dequeue
     0.09%  cyclictest  libc-2.23.so        [.] __nanosleep
     0.09%  cyclictest  [kernel.vmlinux]    [k] rcu_all_qs
     0.09%  cyclictest  [kernel.vmlinux]    [k] _cond_resched
     0.08%  cyclictest  [kernel.vmlinux]    [k] ring_buffer_record_is_on
     0.08%  cyclictest  [kernel.vmlinux]    [k] dequeue_entity
     0.08%  cyclictest  [kernel.vmlinux]    [k] lock_hrtimer_base.isra.19
     0.08%  cyclictest  [kernel.vmlinux]    [k] update_blocked_averages
     0.08%  cyclictest  [kernel.vmlinux]    [k] ftrace_trace_userstack
     0.07%  cyclictest  [kernel.vmlinux]    [k] try_to_unmap_one
     0.07%  cyclictest  [kernel.vmlinux]    [k] tracing_record_taskinfo_skip
     0.07%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c38
     0.07%  cyclictest  [kernel.vmlinux]    [k] __intel_pmu_disable_all
     0.07%  cyclictest  [kernel.vmlinux]    [k] free_pcppages_bulk
     0.07%  cyclictest  [kernel.vmlinux]    [k] task_ctx_sched_out
     0.07%  cyclictest  [kernel.vmlinux]    [k] __msecs_to_jiffies
     0.07%  cyclictest  [vdso]              [.] 0x0000000000000987
     0.07%  cyclictest  [kernel.vmlinux]    [k] update_rt_migration
     0.06%  cyclictest  [kernel.vmlinux]    [k] reweight_entity
     0.06%  cyclictest  [kernel.vmlinux]    [k] dequeue_task_fair
     0.06%  cyclictest  [kernel.vmlinux]    [k] update_load_avg
     0.06%  cyclictest  [kernel.vmlinux]    [k] trace_buffer_unlock_commit_regs
     0.06%  cyclictest  [kernel.vmlinux]    [k] trace_event_raw_event_sched_stat
     0.05%  cyclictest  [kernel.vmlinux]    [k] update_curr
     0.05%  cyclictest  cyclictest          [.] clock_gettime@plt
     0.04%  cyclictest  [vdso]              [.] 0x000000000000097d
     0.04%  cyclictest  [kernel.vmlinux]    [k] rcu_check_callbacks
     0.04%  cyclictest  [kernel.vmlinux]    [k] load_balance
     0.03%  cyclictest  [kernel.vmlinux]    [k] perf_pmu_disable.part.98
     0.03%  cyclictest  [kernel.vmlinux]    [k] __update_load_avg_se.isra.41
     0.03%  cyclictest  [kernel.vmlinux]    [k] __calc_delta
     0.03%  cyclictest  [kernel.vmlinux]    [k] futex_wake
     0.03%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c0d
     0.03%  cyclictest  cyclictest          [.] nanosleep@plt
     0.02%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c09
     0.02%  cyclictest  [kernel.vmlinux]    [k] set_next_entity
     0.02%  cyclictest  [kernel.vmlinux]    [k] switch_mm_irqs_off
     0.02%  cyclictest  [kernel.vmlinux]    [k] balance_runtime
     0.02%  cyclictest  [kernel.vmlinux]    [k] put_prev_task_fair
     0.02%  cyclictest  [kernel.vmlinux]    [k] find_task_by_vpid
     0.02%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c12
     0.02%  cyclictest  [kernel.vmlinux]    [k] kfree
     0.02%  cyclictest  [kernel.vmlinux]    [k] put_prev_entity
     0.01%  cyclictest  [kernel.vmlinux]    [k] rb_next
     0.01%  cyclictest  [kernel.vmlinux]    [k] ring_buffer_time_stamp_abs
     0.01%  cyclictest  [kernel.vmlinux]    [k] update_min_vruntime
     0.01%  cyclictest  [kernel.vmlinux]    [k] enqueue_top_rt_rq
     0.01%  cyclictest  [kernel.vmlinux]    [k] __kmalloc_node
     0.01%  cyclictest  libpthread-2.23.so  [.] 0x0000000000010c30
     0.01%  cyclictest  [kernel.vmlinux]    [k] ktime_get_update_offsets_now
     0.01%  cyclictest  [kernel.vmlinux]    [k] check_cfs_rq_runtime
     0.01%  cyclictest  [kernel.vmlinux]    [k] cpu_load_update
     0.01%  cyclictest  [kernel.vmlinux]    [k] flush_signal_handlers
     0.01%  cyclictest  [kernel.vmlinux]    [k] page_counter_uncharge
     0.00%  cyclictest  [kernel.vmlinux]    [k] end_repeat_nmi
     0.00%  cyclictest  [kernel.vmlinux]    [k] nmi_cpu_backtrace_handler
     0.00%  cyclictest  [kernel.vmlinux]    [k] nmi_restore
     0.00%  cyclictest  [kernel.vmlinux]    [k] nmi_cpu_backtrace
     0.00%  cyclictest  [kernel.vmlinux]    [k] nmi_handle
     0.00%  perf        [kernel.vmlinux]    [k] native_sched_clock
     0.00%  cyclictest  [kernel.vmlinux]    [k] intel_pmu_handle_irq
     0.00%  cyclictest  [kernel.vmlinux]    [k] perf_event_nmi_handler
     0.00%  cyclictest  [kernel.vmlinux]    [k] native_apic_msr_write
     0.00%  perf        [kernel.vmlinux]    [k] native_write_msr

 
> One thing that I notice too is that we have trace_save_cmdline that
> also gets activated when enabling trace events. Perhaps I should try to
> optimize that more.
>>
>> I have been running 20 times the following test, and thrown away the first results:
>>
>> $ sudo ./cyclictest --smp -p95 -m -s -N -l 100000 -q
>>
>> $ uname -a
>> Linux claudio-HP-ProBook-470-G5 4.18.0-rc3+ #3 SMP Tue Jul 3 15:50:30 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
>>
>> For brevity, this is a comparison of one test's results. All other test results show the same ~25% increase.
>>
>> On the left side, the run without ftrace sched events, on the right side with ftrace sched events enabled.
>>
>> CPU    Count      Min       Act        Avg        Max        Count      Min-ftrace Act-ftrace Avg-ftrace Max-ftrace
>> 0     100000      2339       2936       2841     139478     100000       2900       3182       3566      93056
>> 1      66742      2365       3386       2874      93639      66750       2959       3786       3646     154074
>> 2      50080      2376       3058       2910     196221      50097       2997       4209       3655      18707
>> 3      40076      2394       3461       2931      17914      40091       3006       4417       3750      17159
>> 4      33404      2371       3612       2834      15336      33419       2997       3836       3594      23172
>> 5      28635      2387       3313       2885      25863      28649       2995       3795       3647       9956
>> 6      25058      2384       3428       2968      12162      25071       3051       4366       3719      18151
>> 7      22275      2381       2859       2982      10706      22287       3046       5078       3825      10781
>>
>> I would be thankful for any advice or comments on this,
>> especially with the goal in mind to lower as much as possible the runtime impact on the system.
> 
> But still, we use all sorts of trace events when dealing with real
> time, and trace events hardly shows anything in the PREEMPT_RT kernel.
> Where cyclictest shows 20 microseconds, and sched events hardly touches
> that. But I see this weird side effect on a distro kernel too. Maybe
> there's something weird going on when we have CONFIG_VOLUNTARY_PREEMPT
> set :-/

If it helps, I tested also CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT=y,
with the same relative result (~25% increase).

> 
> I'll investigate further.

If stress-ng --switch-ops is of any help, I have some results for that as well.

This is with CONFIG_PREEMPT_NONE:

SCHED EVENTS DISABLED

$ stress-ng --times -s 8 --switch-ops 20000000

Test  Runtime(s) User(%) Sys(%) Total(%) bogo ops/s
   1       22.56    6.33  92.96    99.29     886525
   2       23.09    6.34  92.34    98.68     866176
   3       23.54    6.35  89.02    95.37     849618
   4       22.19    6.56  92.73    99.29     901306
   5       22.69    6.41  92.77    99.18     881445

SCHED EVENTS ENABLED

$ stress-ng --times -s 8 --switch-ops 20000000

Test  Runtime(s) User(%) Sys(%) Total(%) bogo ops/s
   1       36.28    4.12  95.31    99.43     551268
   2       37.61    4.07  95.18    99.25     531773
   3       37.96    4.09  94.94    99.03     526870
   4       38.17    4.01  94.97    98.99     523972
   5       37.47    4.11  94.92    99.03     533760

This is with CONFIG_PREEMPT:

SCHED EVENTS DISABLED

$ stress-ng --times -s 8 --switch-ops 20000000

Test  Runtime(s) User(%) Sys(%) Total(%) bogo ops/s
   1      25.73    5.65   93.28  98.93   777303
   2      25.74    5.68   93.14  98.82   777001
   3      24.84    5.88   92.95  98.83   805153
   4      25.12    5.69   93.06  98.75   796178
   5      26.04    5.58   92.79  98.37   768049

SCHED EVENTS ENABLED

Test  Runtime(s) User(%) Sys(%) Total(%) bogo ops/s
   1  	  41.70	   3.72	  95.90	 99.62	 479616
   2      42.91	   3.59	  95.52	 99.11 	 466092
   3  	  43.24	   3.48	  95.57	 99.05	 462535
   4      43.04	   3.46	  95.83	 99.30	 464684
   5  	  42.62	   3.60	  95.75	 99.34 	 469263

This is with CONFIG_VOLUNTARY_PREEMPT:

SCHED EVENTS DISABLED

$ stress-ng --times -s 8 --switch-ops 20000000

Test  Runtime(s) User(%) Sys(%) Total(%) bogo ops/s
   1      23.27    6.24  91.41   97.64   859476
   2      23.51    6.16  92.70   98.86   850702
   3      23.47    6.42  92.62   99.04   852152
   4      23.92    6.34  92.47   98.81   836120
   5      23.63    6.28  92.77   99.05   846382

SCHED EVENTS ENABLED

Test  Runtime(s) User(%) Sys(%) Total(%) bogo ops/s
   1   	  38.65	   3.82	 95.12	 98.94	 517464
   2  	  38.77	   4.27	 94.77	 99.03	 515863
   3  	  38.70	   3.96	 95.29	 99.25	 516796
   4  	  38.52	   4.06	 95.32	 99.38	 519211
   5  	  38.58	   4.24	 94.71	 98.95	 518403

> Thanks for the report.
> 
> -- Steve
> 

Thank you,

I will try to get more familiar with the internals
and then investigate as well.

Claudio
