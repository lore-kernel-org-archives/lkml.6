Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5CC64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BDF2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BDF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJCJbc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbeJCJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:31:32 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A33A208AE;
        Wed,  3 Oct 2018 02:45:09 +0000 (UTC)
Date:   Tue, 2 Oct 2018 22:45:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?546L5pmT5Lic?= <wisedd@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: rcu: Kernel stack is corrupted in: perf_trace_rcu_dyntick
Message-ID: <20181002224507.17606b35@vmware.local.home>
In-Reply-To: <CAHyWSemw6LYChaEZinFTFvA=kfJKqvWMfadVq5a=+j9TcCrewg@mail.gmail.com>
References: <CAHyWSemw6LYChaEZinFTFvA=kfJKqvWMfadVq5a=+j9TcCrewg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2018 17:22:13 +0800
王晓东 <wisedd@gmail.com> wrote:

> Hi there,
> 
> We would like to report a kernel stack corrupted problem we identified
> in the perf_trace_rcu_dyntick function of tracing events subsystem.
> And the problem was founded by syzkaller.  We has tested the PoC on
> the lasted master branch of kernel(4.19.0-rc5+).
> 
> The crash log generated with KASAN enabled:
> 
> root@pc:~# ./perf_trace_rcu_dyntick
> [  582.069938] Kernel panic - not syncing: stack-protector: Kernel
> stack is corrupted in: perf_trace_rcu_dyntick+0x355/0x4f0
> [  582.069938]
> [  582.071341] CPU: 6 PID: 3417 Comm: perf_trace_rcu_ Not tainted 4.19.0-rc5+ #1
> [  582.072134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [  582.073103] Call Trace:
> [  582.073364]  <IRQ>
> [  582.073614]  dump_stack+0x8c/0xce
> [  582.074039]  panic+0x1cb/0x3aa
> [  582.074427]  ? refcount_error_report+0x296/0x296
> [  582.075003]  ? timerqueue_del+0x71/0x130
> [  582.075553]  ? perf_trace_rcu_dyntick+0x355/0x4f0
> [  582.076063]  ? __stack_chk_fail+0x6/0x20
> [  582.076763]  ? perf_trace_rcu_dyntick+0x355/0x4f0
> [  582.077369]  __stack_chk_fail+0x1f/0x20
> [  582.077877]  perf_trace_rcu_dyntick+0x355/0x4f0
> [  582.078442]  ? rcu_gp_is_expedited+0xa0/0xa0
> [  582.078993]  ? rcu_gp_is_expedited+0xa0/0xa0
> [  582.079525]  ? check_preempt_curr+0x1c2/0x2a0
> [  582.080059]  ? sched_clock_cpu+0x18/0x160
> [  582.080551]  rcu_nmi_enter+0x1f0/0x2f0
> [  582.081036]  ? rcu_gp_is_expedited+0xa0/0xa0
> [  582.081507]  irq_enter+0xf/0x80
> [  582.081914]  smp_apic_timer_interrupt+0x1b/0x2d0
> [  582.082480]  apic_timer_interrupt+0xf/0x20
> [  582.082984]  </IRQ>
> [  582.083219] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
> [  582.087816] Code: e8 35 0b 20 00 48 8b 14 24 e9 fe fe ff ff 48 89
> df e8 24 0b 20 00 e9 d9 fe ff ff 4c 89 e7 e8 17 0b 20 00 e9 ab fe ff
> ff 90 90 <65> 48 8b 04 25 40 dd 01 00 65 8b 15 70 03 8f 63 81 e2 00 01
> 1f 00
> [  582.090289] RSP: 0018:ffff8800651bf9e0 EFLAGS: 00000206 ORIG_RAX:
> ffffffffffffff13
> [  582.091238] RAX: 0000000000000000 RBX: ffffffff9eed12a5 RCX: ffffffff9c6ca1b6
> [  582.092873] RDX: 0000000000000005 RSI: ffffffff9ee31d71 RDI: ffffffff9eed12a4
> [  582.093934] RBP: 0000000000000078 R08: ffffed000d38dfb2 R09: ffffed000d38dfb1
> [  582.095102] R10: 000000007350a3ba R11: ffff880069c6fd8f R12: ffff8800651bfa6e
> [  582.096444] R13: 0000000000000001 R14: dffffc0000000000 R15: 000000000000006a
> [  582.097414]  ? kallsyms_expand_symbol.constprop.11+0x176/0x250
> [  582.098518]  kallsyms_expand_symbol.constprop.11+0x12e/0x250
> [  582.099707]  kallsyms_lookup_name+0xbe/0x1d0
> [  582.100369]  ? kallsyms_on_each_symbol+0x210/0x210
> [  582.101436]  ? snprintf+0xbd/0xf0
> [  582.102029]  ? vsprintf+0x30/0x30
> [  582.102805]  ? kasan_kmalloc+0xa9/0xd0
> [  582.103489]  ? alloc_trace_kprobe+0x6c0/0x930
> [  582.104073]  kprobe_on_func_entry+0x57/0xb0

I'm curious to what kretprobe was used.

-- Steve

> [  582.105421]  register_kretprobe+0x89/0xc10
> [  582.105930]  ? set_print_fmt+0x32/0xa0
> [  582.106376]  __register_trace_kprobe.part.10+0x14e/0x2e0
> [  582.106980]  create_local_trace_kprobe+0x29c/0x3f0
> [  582.107487]  perf_kprobe_init+0x15f/0x210
> [  582.107912]  perf_kprobe_event_init+0xc4/0x140
> [  582.108377]  perf_try_init_event+0xcb/0x290
> [  582.108817]  perf_event_alloc+0x1476/0x2020
> [  582.109264]  ? find_get_context.isra.106+0x690/0x690
> [  582.109922]  ? __alloc_fd+0x1a3/0x4e0
> [  582.120002]  __do_sys_perf_event_open+0x222/0x1f40
> [  582.123049]  ? avc_has_perm_noaudit+0x340/0x340
> [  582.131226]  ? perf_event_set_output+0x5f0/0x5f0
> [  582.134395]  ? handle_mm_fault+0x103/0x350
> [  582.138102]  ? ksys_ioctl+0x61/0x90
> [  582.140234]  do_syscall_64+0x9a/0x2c0
> [  582.142674]  ? prepare_exit_to_usermode+0xbc/0x150
> [  582.146856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  582.151127] RIP: 0033:0x446159
> [  582.152816] Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00
> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 08 fc ff c3 66 2e 0f 1f 84 00 00
> 00 00
> [  582.167257] RSP: 002b:00007fffc2b023d8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000012a
> [  582.171375] RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000446159
> [  582.175760] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020000180
> [  582.176487] RBP: 00007fffc2b025b0 R08: 0000000000000000 R09: 0000000000000000
> [  582.177189] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000406e40
> [  582.177898] R13: 0000000000406ed0 R14: 0000000000000000 R15: 0000000000000000
> [  583.353322] Shutting down cpus with NMI
> [  583.354285] Kernel Offset: 0x1b400000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  583.356743] Rebooting in 86400 seconds..
> 
> 
> This bug could be easily reproduced by running the PoC(generated by
> syzkaller, and transformed to C Source code).
> 
> For any further information, please feel free to contact us at
> wisedd@gmail.com. We would be more than happy to provide other
> information of this problem.

