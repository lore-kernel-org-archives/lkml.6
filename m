Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8528DC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368E52083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368E52083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeIAVsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:48:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeIAVsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:48:00 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jjBkqg_FnwbF; Sat,  1 Sep 2018 19:34:57 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDB9B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdb:9b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DFE21EC0200;
        Sat,  1 Sep 2018 19:34:57 +0200 (CEST)
Date:   Sat, 1 Sep 2018 19:35:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: 4.19-rc1: ./include/linux/rcupdate.h:631 rcu_read_lock() used
 illegally while idle!
Message-ID: <20180901173559.GC26871@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a huge splat! It haz some perf* and sched* in it, I guess for
peterz to stare at. And lemme add Paul for good measure too :)

Kernel is -rc1 + 3 microcode loader patches ontop which should not be
related.

Thx.

---
[   62.409125] =============================
[   62.409129] WARNING: suspicious RCU usage
[   62.409133] 4.19.0-rc1+ #1 Not tainted
[   62.409136] -----------------------------
[   62.409140] ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
[   62.409143] 
               other info that might help us debug this:

[   62.409147] 
               RCU used illegally from idle CPU!
               rcu_scheduler_active = 2, debug_locks = 1
[   62.409151] RCU used illegally from extended quiescent state!
[   62.409155] 1 lock held by swapper/0/0:
[   62.409158]  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
[   62.409175] 
               stack backtrace:
[   62.409180] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1
[   62.409183] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.409187] Call Trace:
[   62.409196]  dump_stack+0x85/0xcb
[   62.409203]  perf_event_output_forward+0xf6/0x130
[   62.409215]  __perf_event_overflow+0x52/0xe0
[   62.409223]  perf_swevent_overflow+0x91/0xb0
[   62.409229]  perf_tp_event+0x11a/0x350
[   62.409235]  ? find_held_lock+0x2d/0x90
[   62.409251]  ? __lock_acquire+0x2ce/0x1350
[   62.409263]  ? __lock_acquire+0x2ce/0x1350
[   62.409270]  ? retint_kernel+0x2d/0x2d
[   62.409278]  ? find_held_lock+0x2d/0x90
[   62.409285]  ? tick_nohz_get_sleep_length+0x83/0xb0
[   62.409299]  ? perf_trace_cpu+0xbb/0xd0
[   62.409306]  ? perf_trace_buf_alloc+0x5a/0xa0
[   62.409311]  perf_trace_cpu+0xbb/0xd0
[   62.409323]  cpuidle_enter_state+0x185/0x340
[   62.409332]  do_idle+0x1eb/0x260
[   62.409340]  cpu_startup_entry+0x5f/0x70
[   62.409347]  start_kernel+0x49b/0x4a6

[   62.409357]  secondary_startup_64+0xa4/0xb0

[   62.409374] =============================
[   62.409375] WARNING: suspicious RCU usage
[   62.409377] 4.19.0-rc1+ #1 Not tainted
[   62.409378] -----------------------------
[   62.409380] kernel/events/ring_buffer.c:138 suspicious rcu_dereference_check() usage!
[   62.409381] 
               other info that might help us debug this:

[   62.409382] 
               RCU used illegally from idle CPU!
               rcu_scheduler_active = 2, debug_locks = 1
[   62.409384] RCU used illegally from extended quiescent state!
[   62.409386] 2 locks held by swapper/0/0:
[   62.409387]  #0: 000000004557ee0e (
[   62.409390] =============================
[   62.409391] WARNING: suspicious RCU usage
[   62.409393] rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
[   62.409398] 4.19.0-rc1+ #1 Not tainted
[   62.409399] -----------------------------
[   62.409400]  #1: 000000004557ee0e
[   62.409403] ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
[   62.409403]  (rcu_read_lock){....}
[   62.409406] 
               other info that might help us debug this:

[   62.409408] , at: perf_output_begin_forward+0x5/0x320
[   62.409409] 
               stack backtrace:
[   62.409412] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1
[   62.409413] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.409414] Call Trace:
[   62.409418]  dump_stack+0x85/0xcb
[   62.409422]  perf_output_begin_forward+0x2d2/0x320
[   62.409423] 
               RCU used illegally from idle CPU!
               rcu_scheduler_active = 2, debug_locks = 1
[   62.409424] RCU used illegally from extended quiescent state!
[   62.409428]  ? find_held_lock+0x2d/0x90
[   62.409433]  ? vprintk_emit+0x2ce/0x340
[   62.409434] 2 locks held by swapper/2/0:
[   62.409435]  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
[   62.409445]  ? find_held_lock+0x2d/0x90
[   62.409449]  ? is_bpf_text_address+0x65/0xe0
[   62.409450]  #1: 000000004557ee0e (rcu_read_lock){....}, at: perf_output_begin_forward+0x5/0x320
[   62.409457] 
               stack backtrace:
[   62.409462]  ? rcu_dynticks_eqs_enter+0x12/0x30
[   62.409466]  ? kernel_text_address+0x8f/0xf0
[   62.409472]  ? __kernel_text_address+0xe/0x30
[   62.409477]  ? show_trace_log_lvl+0x19f/0x3d0
[   62.409484]  ? secondary_startup_64+0xa4/0xb0

[   62.409492] =============================
[   62.409494]  ? sched_clock+0x5/0x10
[   62.409496]  ? sched_clock+0x5/0x10
[   62.409500]  ? sched_clock_cpu+0x10/0xd0
[   62.409504] WARNING: suspicious RCU usage
[   62.409506]  ? perf_event_output_forward+0x70/0x130
[   62.409508]  ? perf_prepare_sample+0x53/0x460
[   62.409513] 4.19.0-rc1+ #1 Not tainted
[   62.409514]  perf_event_output_forward+0x70/0x130
[   62.409518] -----------------------------
[   62.409522] ./include/linux/rcupdate.h:680 rcu_read_unlock() used illegally while idle!
[   62.409523]  __perf_event_overflow+0x52/0xe0
[   62.409528]  perf_swevent_overflow+0x91/0xb0
[   62.409529] 
               other info that might help us debug this:

[   62.409531] 
               RCU used illegally from idle CPU!
               rcu_scheduler_active = 2, debug_locks = 1
[   62.409533] RCU used illegally from extended quiescent state!
[   62.409536] 2 locks held by swapper/3/0:
[   62.409537]  #0: 000000004557ee0e (rcu_read_lock){....}
[   62.409544]  perf_tp_event+0x11a/0x350
[   62.409547]  ? find_held_lock+0x2d/0x90
[   62.409552] , at: perf_event_output_forward+0x0/0x130
[   62.409555]  #1: 000000004557ee0e (
[   62.409560]  ? __lock_acquire+0x2ce/0x1350
[   62.409564] rcu_read_lock){....}, at: perf_output_begin_forward+0x5/0x320
[   62.409569]  ? __lock_acquire+0x2ce/0x1350
[   62.409573]  ? retint_kernel+0x2d/0x2d
[   62.409576] 
               stack backtrace:
[   62.409579]  ? find_held_lock+0x2d/0x90
[   62.409583]  ? tick_nohz_get_sleep_length+0x83/0xb0
[   62.409595]  ? perf_trace_cpu+0xbb/0xd0
[   62.409601]  ? perf_trace_buf_alloc+0x5a/0xa0
[   62.409606]  perf_trace_cpu+0xbb/0xd0
[   62.409615]  cpuidle_enter_state+0x185/0x340
[   62.409624]  do_idle+0x1eb/0x260
[   62.409631]  cpu_startup_entry+0x5f/0x70
[   62.409637]  start_kernel+0x49b/0x4a6
[   62.409644]  secondary_startup_64+0xa4/0xb0
[   62.409661] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.19.0-rc1+ #1

[   62.409662] =============================
[   62.409664] WARNING: suspicious RCU usage
[   62.409666] 4.19.0-rc1+ #1 Not tainted
[   62.409667] -----------------------------
[   62.409669] ./include/linux/rcupdate.h:680 rcu_read_unlock() used illegally while idle!
[   62.409670] 
               other info that might help us debug this:

[   62.409673] 
               RCU used illegally from idle CPU!
               rcu_scheduler_active = 2, debug_locks = 1
[   62.409675] RCU used illegally from extended quiescent state!
[   62.409678] 1 lock held by swapper/0/0:
[   62.409679]  #0: 000000004557ee0e (
[   62.409683] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.409684] Call Trace:
[   62.409689]  dump_stack+0x85/0xcb
[   62.409693]  perf_output_end+0x61/0x70
[   62.409693] rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
[   62.409699]  perf_event_output_forward+0x90/0x130
[   62.409702] 
               stack backtrace:
[   62.409708]  __perf_event_overflow+0x52/0xe0
[   62.409715]  perf_swevent_overflow+0x91/0xb0
[   62.409720]  perf_tp_event+0x11a/0x350
[   62.409740]  ? __lock_acquire+0x2ce/0x1350
[   62.409745]  ? retint_kernel+0x2d/0x2d
[   62.409753]  ? find_held_lock+0x2d/0x90
[   62.409757]  ? tick_nohz_get_sleep_length+0x83/0xb0
[   62.409768]  ? timer_clear_idle+0x12/0x30
[   62.409776]  ? perf_trace_cpu+0xbb/0xd0
[   62.409780]  perf_trace_cpu+0xbb/0xd0
[   62.409789]  cpuidle_enter_state+0x185/0x340
[   62.409797]  do_idle+0x1eb/0x260
[   62.409804]  cpu_startup_entry+0x5f/0x70
[   62.409810]  start_secondary+0x192/0x1b0
[   62.409815]  secondary_startup_64+0xa4/0xb0
[   62.409830] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.0-rc1+ #1
[   62.409833] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.409836] Call Trace:
[   62.409841]  dump_stack+0x85/0xcb
[   62.409846]  perf_output_begin_forward+0x2a1/0x320
[   62.409864]  ? __lock_acquire+0x2ce/0x1350
[   62.409882]  ? sched_clock+0x5/0x10
[   62.409890]  ? sched_clock+0x5/0x10
[   62.409897]  ? sched_clock_cpu+0x10/0xd0
[   62.409904]  ? perf_event_output_forward+0x70/0x130
[   62.409908]  ? perf_prepare_sample+0x53/0x460
[   62.409914]  perf_event_output_forward+0x70/0x130
[   62.409920]  ? unwind_next_frame+0x5b/0x540
[   62.409928]  __perf_event_overflow+0x52/0xe0
[   62.409934]  perf_swevent_overflow+0x91/0xb0
[   62.409940]  perf_tp_event+0x11a/0x350
[   62.409960]  ? lock_acquire+0x9e/0x1b0
[   62.409969]  ? lock_acquire+0x9e/0x1b0
[   62.409973]  ? find_held_lock+0x2d/0x90
[   62.409978]  ? hrtimer_next_event_without+0x67/0x90
[   62.409991]  ? perf_trace_cpu+0xbb/0xd0
[   62.409995]  perf_trace_cpu+0xbb/0xd0
[   62.410003]  cpuidle_enter_state+0x185/0x340
[   62.411086]  do_idle+0x1eb/0x260
[   62.411092]  cpu_startup_entry+0x5f/0x70
[   62.411108]  start_secondary+0x192/0x1b0
[   62.411111]  secondary_startup_64+0xa4/0xb0
[   62.411127] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1

[   62.411217] =============================
[   62.411218] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.411219] WARNING: suspicious RCU usage
[   62.411219] Call Trace:
[   62.411220] 4.19.0-rc1+ #1 Not tainted
[   62.411220] -----------------------------
[   62.411221] ./include/trace/events/sched.h:90 suspicious rcu_dereference_check() usage!
[   62.411224]  dump_stack+0x85/0xcb

[   62.411225] other info that might help us debug this:

[   62.411228]  perf_event_output_forward+0x123/0x130

[   62.411230] RCU used illegally from idle CPU!
[   62.411231] rcu_scheduler_active = 2, debug_locks = 1
[   62.411232] RCU used illegally from extended quiescent state!
[   62.411233] 4 locks held by swapper/2/0:
[   62.411233]  #0: 000000004557ee0e (rcu_read_lock
[   62.411237]  __perf_event_overflow+0x52/0xe0
[   62.411238] ){....}, at: perf_event_output_forward+0x0/0x130
[   62.411240]  #1: 000000004557ee0e (
[   62.411242]  perf_swevent_overflow+0x91/0xb0
[   62.411243] rcu_read_lock){....}, at: perf_output_begin_forward+0x5/0x320
[   62.411246]  #2: 
[   62.411247]  perf_tp_event+0x11a/0x350
[   62.411247] 00000000e39f6018 (
[   62.411250]  ? find_held_lock+0x2d/0x90
[   62.411250] (console_sem).lock){-.-.}, at: up+0x12/0x60
[   62.411253]  #3: 00000000c62ce8a4 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x4f0

[   62.411259] stack backtrace:
[   62.411260] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.0-rc1+ #1
[   62.411261] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.411263]  ? __lock_acquire+0x2ce/0x1350
[   62.411263] Call Trace:
[   62.411264]  dump_stack+0x85/0xcb
[   62.411265]  try_to_wake_up+0x45b/0x4f0
[   62.411266]  ? console_unlock+0x226/0x5f0
[   62.411267]  up+0x40/0x60
[   62.411268]  __up_console_sem+0x41/0x70
[   62.411268]  console_unlock+0x125/0x5f0
[   62.411270]  vprintk_emit+0x116/0x340
[   62.411270]  ? is_bpf_text_address+0x65/0xe0
[   62.411271]  ? cpuidle_enter_state+0x185/0x340
[   62.411273]  ? __lock_acquire+0x2ce/0x1350
[   62.411273]  printk+0x43/0x4b
[   62.411274]  ? rcu_dynticks_eqs_enter+0x12/0x30
[   62.411275]  ? cpuidle_enter_state+0x185/0x340
[   62.411277]  ? retint_kernel+0x2d/0x2d
[   62.411278]  ? cpuidle_enter_state+0x185/0x340
[   62.411279]  show_trace_log_lvl+0x217/0x3d0
[   62.411280]  ? cpuidle_enter_state+0x185/0x340
[   62.411281]  ? cpuidle_enter_state+0x185/0x340
[   62.411281]  dump_stack+0x85/0xcb
[   62.411283]  perf_output_begin_forward+0x2a1/0x320
[   62.411284]  ? find_held_lock+0x2d/0x90
[   62.411284]  ? __lock_acquire+0x2ce/0x1350
[   62.411285]  ? sched_clock+0x5/0x10
[   62.411286]  ? sched_clock+0x5/0x10
[   62.411288]  ? tick_nohz_get_sleep_length+0x83/0xb0
[   62.411289]  ? sched_clock_cpu+0x10/0xd0
[   62.411290]  ? perf_event_output_forward+0x70/0x130
[   62.411291]  ? perf_prepare_sample+0x53/0x460
[   62.411291]  perf_event_output_forward+0x70/0x130
[   62.411292]  ? unwind_next_frame+0x5b/0x540
[   62.411293]  __perf_event_overflow+0x52/0xe0
[   62.411294]  perf_swevent_overflow+0x91/0xb0
[   62.411295]  perf_tp_event+0x11a/0x350
[   62.411296]  ? lock_acquire+0x9e/0x1b0
[   62.411297]  ? lock_acquire+0x9e/0x1b0
[   62.411298]  ? perf_trace_cpu+0xbb/0xd0
[   62.411299]  ? find_held_lock+0x2d/0x90
[   62.411300]  ? hrtimer_next_event_without+0x67/0x90
[   62.411301]  ? perf_trace_cpu+0xbb/0xd0
[   62.411303]  ? perf_trace_buf_alloc+0x5a/0xa0
[   62.411304]  perf_trace_cpu+0xbb/0xd0
[   62.411305]  cpuidle_enter_state+0x185/0x340
[   62.411306]  perf_trace_cpu+0xbb/0xd0
[   62.411307]  do_idle+0x1eb/0x260
[   62.411308]  cpu_startup_entry+0x5f/0x70
[   62.411309]  start_secondary+0x192/0x1b0
[   62.411310]  secondary_startup_64+0xa4/0xb0

[   62.411311] =============================
[   62.411312] WARNING: suspicious RCU usage
[   62.411314]  cpuidle_enter_state+0x185/0x340
[   62.411315] 4.19.0-rc1+ #1 Not tainted
[   62.411316] -----------------------------
[   62.411317] ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!

[   62.411319] other info that might help us debug this:

[   62.411321]  do_idle+0x1eb/0x260

[   62.411322] RCU used illegally from idle CPU!
[   62.411323] rcu_scheduler_active = 2, debug_locks = 1
[   62.411324] RCU used illegally from extended quiescent state!
[   62.411325] 5 locks held by swapper/2/0:
[   62.411326]  #0: 
[   62.411327]  cpu_startup_entry+0x5f/0x70
[   62.411328] 000000004557ee0e (rcu_read_lock){....}
[   62.411332]  start_kernel+0x49b/0x4a6
[   62.411332] , at: perf_event_output_forward+0x0/0x130
[   62.411333]  #1: 000000004557ee0e (rcu_read_lock){....}, at: perf_output_begin_forward+0x5/0x320
[   62.411338]  secondary_startup_64+0xa4/0xb0
[   62.411339]  #2: 00000000e39f6018 ((console_sem).lock){-.-.}, at: up+0x12/0x60
[   62.411344]  #3: 00000000c62ce8a4 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x4f0
[   62.411348]  #4: 000000004557ee0e (rcu_read_lock){....}, at: select_task_rq_fair+0x142/0xcf0

[   62.411353] stack backtrace:
[   62.411354] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.0-rc1+ #1
[   62.411355] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.411356] Call Trace:
[   62.411357]  dump_stack+0x85/0xcb
[   62.411358]  select_task_rq_fair+0x32a/0xcf0
[   62.411358]  try_to_wake_up+0x11c/0x4f0
[   62.411359]  ? console_unlock+0x226/0x5f0
[   62.411359]  up+0x40/0x60
[   62.411361]  __up_console_sem+0x41/0x70
[   62.411361]  console_unlock+0x125/0x5f0
[   62.411362]  vprintk_emit+0x116/0x340
[   62.411363]  ? is_bpf_text_address+0x65/0xe0
[   62.411364]  ? cpuidle_enter_state+0x185/0x340
[   62.411365]  printk+0x43/0x4b
[   62.411366]  ? rcu_dynticks_eqs_enter+0x12/0x30
[   62.411367]  ? cpuidle_enter_state+0x185/0x340
[   62.411368]  ? cpuidle_enter_state+0x185/0x340
[   62.411368]  show_trace_log_lvl+0x217/0x3d0
[   62.411370]  ? cpuidle_enter_state+0x185/0x340
[   62.411370]  ? cpuidle_enter_state+0x185/0x340
[   62.411371]  dump_stack+0x85/0xcb
[   62.411372]  perf_output_begin_forward+0x2a1/0x320
[   62.411373]  ? __lock_acquire+0x2ce/0x1350
[   62.411374]  ? sched_clock+0x5/0x10
[   62.411375]  ? sched_clock+0x5/0x10
[   62.411376]  ? sched_clock_cpu+0x10/0xd0
[   62.411377]  ? perf_event_output_forward+0x70/0x130
[   62.411377]  ? perf_prepare_sample+0x53/0x460
[   62.411379]  perf_event_output_forward+0x70/0x130
[   62.411379]  ? unwind_next_frame+0x5b/0x540
[   62.411380]  __perf_event_overflow+0x52/0xe0
[   62.411381]  perf_swevent_overflow+0x91/0xb0
[   62.411382]  perf_tp_event+0x11a/0x350
[   62.411383]  ? lock_acquire+0x9e/0x1b0
[   62.411384]  ? lock_acquire+0x9e/0x1b0
[   62.411385]  ? find_held_lock+0x2d/0x90
[   62.411386]  ? hrtimer_next_event_without+0x67/0x90
[   62.411386]  ? perf_trace_cpu+0xbb/0xd0
[   62.411387]  perf_trace_cpu+0xbb/0xd0
[   62.411388]  cpuidle_enter_state+0x185/0x340
[   62.411389]  do_idle+0x1eb/0x260
[   62.411390]  cpu_startup_entry+0x5f/0x70
[   62.411391]  start_secondary+0x192/0x1b0
[   62.411392]  secondary_startup_64+0xa4/0xb0

[   62.411393] =============================
[   62.411395] WARNING: suspicious RCU usage
[   62.411395] 4.19.0-rc1+ #1 Not tainted
[   62.411396] -----------------------------
[   62.411397] kernel/sched/fair.c:6231 suspicious rcu_dereference_check() usage!

[   62.411399] other info that might help us debug this:


[   62.411402] RCU used illegally from idle CPU!
[   62.411402] rcu_scheduler_active = 2, debug_locks = 1
[   62.411403] RCU used illegally from extended quiescent state!
[   62.411404] 5 locks held by swapper/2/0:
[   62.411405]  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
[   62.411410]  #1: 000000004557ee0e (rcu_read_lock){....}, at: perf_output_begin_forward+0x5/0x320
[   62.411414]  #2: 00000000e39f6018 ((console_sem).lock){-.-.}, at: up+0x12/0x60
[   62.411420]  #3: 00000000c62ce8a4 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x4f0
[   62.411424]  #4: 000000004557ee0e (rcu_read_lock){....}, at: select_task_rq_fair+0x142/0xcf0

[   62.411429] stack backtrace:
[   62.411431] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.0-rc1+ #1
[   62.411432] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.411433] Call Trace:
[   62.411433]  dump_stack+0x85/0xcb
[   62.411434]  select_task_rq_fair+0x3a5/0xcf0
[   62.411435]  try_to_wake_up+0x11c/0x4f0
[   62.411436]  ? console_unlock+0x226/0x5f0
[   62.411437]  up+0x40/0x60
[   62.411438]  __up_console_sem+0x41/0x70
[   62.411439]  console_unlock+0x125/0x5f0
[   62.411440]  vprintk_emit+0x116/0x340
[   62.411441]  ? is_bpf_text_address+0x65/0xe0
[   62.411442]  ? cpuidle_enter_state+0x185/0x340
[   62.411442]  printk+0x43/0x4b
[   62.411444]  ? rcu_dynticks_eqs_enter+0x12/0x30
[   62.411444]  ? cpuidle_enter_state+0x185/0x340
[   62.411445]  ? cpuidle_enter_state+0x185/0x340
[   62.411446]  show_trace_log_lvl+0x217/0x3d0
[   62.411447]  ? cpuidle_enter_state+0x185/0x340
[   62.411448]  ? cpuidle_enter_state+0x185/0x340
[   62.411449]  dump_stack+0x85/0xcb
[   62.411450]  perf_output_begin_forward+0x2a1/0x320
[   62.411451]  ? __lock_acquire+0x2ce/0x1350
[   62.411451]  ? sched_clock+0x5/0x10
[   62.411452]  ? sched_clock+0x5/0x10
[   62.411453]  ? sched_clock_cpu+0x10/0xd0
[   62.411454]  ? perf_event_output_forward+0x70/0x130
[   62.411455]  ? perf_prepare_sample+0x53/0x460
[   62.411456]  perf_event_output_forward+0x70/0x130
[   62.411457]  ? unwind_next_frame+0x5b/0x540
[   62.411458]  __perf_event_overflow+0x52/0xe0
[   62.411459]  perf_swevent_overflow+0x91/0xb0
[   62.411460]  perf_tp_event+0x11a/0x350
[   62.411460]  ? lock_acquire+0x9e/0x1b0
[   62.411461]  ? lock_acquire+0x9e/0x1b0
[   62.411462]  ? find_held_lock+0x2d/0x90
[   62.411463]  ? hrtimer_next_event_without+0x67/0x90
[   62.411464]  ? perf_trace_cpu+0xbb/0xd0
[   62.411465]  perf_trace_cpu+0xbb/0xd0
[   62.411466]  cpuidle_enter_state+0x185/0x340
[   62.411467]  do_idle+0x1eb/0x260
[   62.411467]  cpu_startup_entry+0x5f/0x70
[   62.411469]  start_secondary+0x192/0x1b0
[   62.411469]  secondary_startup_64+0xa4/0xb0

[   62.411471] =============================
[   62.411472] WARNING: suspicious RCU usage
[   62.411473] 4.19.0-rc1+ #1 Not tainted
[   62.411474] -----------------------------
[   62.411475] ./include/linux/rcupdate.h:680 rcu_read_unlock() used illegally while idle!

[   62.411477] other info that might help us debug this:


[   62.411479] RCU used illegally from idle CPU!
[   62.411480] rcu_scheduler_active = 2, debug_locks = 1
[   62.411481] RCU used illegally from extended quiescent state!
[   62.411482] 5 locks held by swapper/2/0:
[   62.411483]  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
[   62.411487]  #1: 000000004557ee0e (rcu_read_lock){....}, at: perf_output_begin_forward+0x5/0x320
[   62.411492]  #2: 00000000e39f6018 ((console_sem).lock){-.-.}, at: up+0x12/0x60
[   62.411496]  #3: 00000000c62ce8a4 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x4f0
[   62.411500]  #4: 000000004557ee0e (rcu_read_lock){....}, at: select_task_rq_fair+0x142/0xcf0

[   62.411506] stack backtrace:
[   62.411507] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.0-rc1+ #1
[   62.411508] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
[   62.411508] Call Trace:
[   62.411509]  dump_stack+0x85/0xcb
[   62.411510]  select_task_rq_fair+0x35b/0xcf0
[   62.411511]  try_to_wake_up+0x11c/0x4f0
[   62.411512]  ? console_unlock+0x226/0x5f0
[   62.411513]  up+0x40/0x60
[   62.411514]  __up_console_sem+0x41/0x70
[   62.411515]  console_unlock+0x125/0x5f0
[   62.411515]  vprintk_emit+0x116/0x340
[   62.411517]  ? is_bpf_text_address+0x65/0xe0
[   62.411517]  ? cpuidle_enter_state+0x185/
[   62.411519] Lost 290 message(s)!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
