Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9487320856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9487320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeICNkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:40:20 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:56266 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeICNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:40:20 -0400
Received: by mail-io0-f197.google.com with SMTP id m15-v6so17089476ioj.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Q/fOZtyv0y/MjGk0PIeEOpv3lpqXwt+9YIDlAyzl14Y=;
        b=A5XHlx1DErqsJ5e7QAQEv7RfYLjqi+6l1ISR0rP/ZY06f3V8NVTZs96x0zZESDVaEr
         Nm2QOfFb/mf78eBh11D4I2Es1mss1bPf9K8/jane4DekXp2K+35l8KpROeYYbvar5md+
         HaywfiDp0fyOa6OQ4rgWDzp4IhWLhRySSq3AwEzKnz2COrgsTwtqrlC+m3JSexznH7t9
         wIz/FuK5IfjyBqzvt8i8rqI1m0oXFwZY73mM1Bo/GiwHxQcJUw3bGmHk1xAvF1p2FVL9
         om/rGgsiXAL0dkRWcIXEo2f7n0DtExJieBsTOb4wCHUDU7wlwMqhUtxz2tLImnWw7WpP
         PP4Q==
X-Gm-Message-State: APzg51D+nYSa4Wua9UsM4oufaz41jsDoTKqWOObtZrKellXEOidcJs82
        KAFq7QJjj408QodgDaG2vAQ04kzn6Tw019fuWMLb/Wn8xEdt
X-Google-Smtp-Source: ANB0VdaLhw3pSzfFeRhqlur23gmD/HZmtvXscTs7zCVn0UrBPFuzLjEh5CcKRA2qXwCJabhfPwcNmN3O1mFROmX2u6yjwm8+ZjLa
MIME-Version: 1.0
X-Received: by 2002:a02:6c2:: with SMTP id 185-v6mr11091935jav.62.1535966463568;
 Mon, 03 Sep 2018 02:21:03 -0700 (PDT)
Date:   Mon, 03 Sep 2018 02:21:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072d3ab0574f40f80@google.com>
Subject: WARNING: suspicious RCU usage in trace_call_bpf
From:   syzbot <syzbot+1c843dc17610ca4c764f@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dc6417949297 Merge branch 'net_sched-reject-unknown-tcfa_a..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc513e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=1c843dc17610ca4c764f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13071951400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119e710a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1c843dc17610ca4c764f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)

=============================
WARNING: suspicious RCU usage
4.19.0-rc1+ #44 Not tainted
-----------------------------
include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!

other info that might help us debug this:


RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
  #0: 000000004b34587c (rcu_read_lock){....}, at: trace_call_bpf+0xf8/0x640  
kernel/trace/bpf_trace.c:46

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #44
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4537
  rcu_read_lock include/linux/rcupdate.h:630 [inline]
  trace_call_bpf+0x533/0x640 kernel/trace/bpf_trace.c:72
  perf_trace_run_bpf_submit+0x15c/0x3b0 kernel/events/core.c:8264
  perf_trace_preemptirq_template+0x3dd/0x650  
include/trace/events/preemptirq.h:14
  trace_irq_enable_rcuidle include/trace/events/preemptirq.h:40 [inline]
  trace_hardirqs_on_caller+0x227/0x2b0 kernel/trace/trace_preemptirq.c:51

=============================
WARNING: suspicious RCU usage
  trace_hardirqs_on_thunk+0x1a/0x1c
4.19.0-rc1+ #44 Not tainted
-----------------------------
  retint_kernel+0x10/0x10
kernel/trace/bpf_trace.c:72 suspicious rcu_dereference_check() usage!
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:56

other info that might help us debug this:

Code: c7 48 89 45 d8 e8 ba 60 e7 fa 48 8b 45 d8 e9 d2 fe ff ff 48 89 df e8  
a9 60 e7 fa eb 8a 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90

RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
RSP: 0018:ffffffff88007bb8 EFLAGS: 00000286
RCU used illegally from extended quiescent state!
  ORIG_RAX: ffffffffffffff13
1 lock held by swapper/1/0:
RAX: dffffc0000000000 RBX: 1ffffffff1000f7b RCX: 0000000000000000
  #0:
RDX: 1ffffffff10237b8 RSI: 0000000000000001 RDI: ffffffff8811bdc0
000000004b34587c
RBP: ffffffff88007bb8 R08: ffffffff88075e00 R09: 0000000000000000
  (
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
rcu_read_lock
R13: ffffffff88007c78 R14: 0000000000000000 R15: 0000000000000000
){....}
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc2/0x410 arch/x86/kernel/process.c:498
, at: trace_call_bpf+0xf8/0x640 kernel/trace/bpf_trace.c:46

stack backtrace:
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3aa/0x580 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  rest_init+0xe1/0xe4 init/main.c:442
  start_kernel+0x913/0x94e init/main.c:739
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc1+ #44
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
=============================
WARNING: suspicious RCU usage
Call Trace:
4.19.0-rc1+ #44 Not tainted
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
-----------------------------
include/linux/rcupdate.h:680 rcu_read_unlock() used illegally while idle!

other info that might help us debug this:


RCU used illegally from idle CPU!
rcu_scheduler_active = 2, debug_locks = 1
  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4537
RCU used illegally from extended quiescent state!
  trace_call_bpf+0x4cb/0x640 kernel/trace/bpf_trace.c:72
1 lock held by swapper/0/0:
  #0:
000000004b34587c
  (
  perf_trace_run_bpf_submit+0x15c/0x3b0 kernel/events/core.c:8264
rcu_read_lock
){....}
, at: trace_call_bpf+0xf8/0x640 kernel/trace/bpf_trace.c:46

stack backtrace:
  perf_trace_preemptirq_template+0x3dd/0x650  
include/trace/events/preemptirq.h:14
  trace_irq_enable_rcuidle include/trace/events/preemptirq.h:40 [inline]
  trace_hardirqs_on+0x22e/0x2c0 kernel/trace/trace_preemptirq.c:25
  default_idle+0x8d/0x410 arch/x86/kernel/process.c:498
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3aa/0x580 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  start_secondary+0x433/0x5d0 arch/x86/kernel/smpboot.c:271
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #44
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4537
  rcu_read_unlock include/linux/rcupdate.h:679 [inline]
  trace_call_bpf+0x579/0x640 kernel/trace/bpf_trace.c:72
  perf_trace_run_bpf_submit+0x15c/0x3b0 kernel/events/core.c:8264
  perf_trace_preemptirq_template+0x3dd/0x650  
include/trace/events/preemptirq.h:14
  trace_irq_enable_rcuidle include/trace/events/preemptirq.h:40 [inline]
  trace_hardirqs_on_caller+0x227/0x2b0 kernel/trace/trace_preemptirq.c:51
  trace_hardirqs_on_thunk+0x1a/0x1c
  retint_kernel+0x10/0x10
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:56
Code: c7 48 89 45 d8 e8 ba 60 e7 fa 48 8b 45 d8 e9 d2 fe ff ff 48 89 df e8  
a9 60 e7 fa eb 8a 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffffffff88007bb8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffffffff1000f7b RCX: 0000000000000000
RDX: 1ffffffff10237b8 RSI: 0000000000000001 RDI: ffffffff8811bdc0
RBP: ffffffff88007bb8 R08: ffffffff88075e00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88007c78 R14: 0000000000000000 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc2/0x410 arch/x86/kernel/process.c:498
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3aa/0x580 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  rest_init+0xe1/0xe4 init/main.c:442
  start_kernel+0x913/0x94e init/main.c:739
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
