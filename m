Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D89FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0669C208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0669C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kyup.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933317AbeGJNaC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:30:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40928 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGJNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:30:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so16568246edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M07+WvhItn8744B2jUV6qkXL40WnJKe7ggTvkyoBG+E=;
        b=ABZlI5PtQ/DB32adxECMSSUkv2maXZT3/pDvjJJ/zuKCMOb0kNGhgvLLzQYeTW2gpy
         /MJLGut99P290Nr/fdPMboc0zJNZhluhSHYe2FRtrOXUgCoEXXYTLmDokJX71GMgqk5V
         rJ9+Yu0hJ7ZV8GOONudEk1LFzjojkl7rbDAszKYBSuINFnjArVbjk1wzy2lXaTByTi4S
         5F8szM9x1EnR9Jgi9EMNcaeGrAKyEn6iVTQ/PPCigpQRGgHAyIQ+U1CUBA1QwoWTgNnI
         osfaNtH9RkibqUoTTeRVEkcFWwaq0k/iCG2WghTt2T/bMevwo++O5U70jzr5LoUhDi8i
         TEoQ==
X-Gm-Message-State: APt69E0KwATEAK38AQjg2Ni2YZEa4PKae1aIXrtjehbaD4v6JPxQimdj
        UIUsKMTlk8MIjYUDWoKAD6VxMdO3
X-Google-Smtp-Source: AAOMgpffGIye5GDQAuj/fWGwyMvKvVPMT0UyyM0ly30ftEPWDkiFzW5lRy6K2g+qHRZ73BxG9FzPRw==
X-Received: by 2002:a50:9aa4:: with SMTP id p33-v6mr27318187edb.218.1531229397941;
        Tue, 10 Jul 2018 06:29:57 -0700 (PDT)
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com. [74.125.82.51])
        by smtp.gmail.com with ESMTPSA id b9-v6sm7707145edk.28.2018.07.10.06.29.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 06:29:57 -0700 (PDT)
Received: by mail-wm0-f51.google.com with SMTP id s12-v6so24716918wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:29:57 -0700 (PDT)
X-Received: by 2002:a1c:a484:: with SMTP id n126-v6mr16495608wme.140.1531229397067;
 Tue, 10 Jul 2018 06:29:57 -0700 (PDT)
MIME-Version: 1.0
From:   Angel Shtilianov <kernel@kyup.com>
Date:   Tue, 10 Jul 2018 16:29:46 +0300
X-Gmail-Original-Message-ID: <CAJM9R-K3DS6ogCva4QjDYztnQ92xX9_xfsbHYZg4dpf=q9Wp_g@mail.gmail.com>
Message-ID: <CAJM9R-K3DS6ogCva4QjDYztnQ92xX9_xfsbHYZg4dpf=q9Wp_g@mail.gmail.com>
Subject: Crash in scheduler path on Linux-4.15
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
we have experienced several crashes like this with various 4.15
kernels on several different machines. The data used by these
functions doesn't looks corrupted, but the stack maybe is, like we are
trying to return to a functions local variable.
Could you help?

Here is the latest backtrace and some data from the captured crashdump file:
PID: 42021  TASK: ffff8839a34e6740  CPU: 5   COMMAND: "postmaster"
 #0 [ffffc90022f07358] machine_kexec at ffffffff8103c73f
 #1 [ffffc90022f073a0] __crash_kexec at ffffffff810d874e
 #2 [ffffc90022f07458] crash_kexec at ffffffff810d929d
 #3 [ffffc90022f07470] oops_end at ffffffff8101ae70
 #4 [ffffc90022f07490] no_context at ffffffff81044e19
 #5 [ffffc90022f074e8] __do_page_fault at ffffffff8104555d
 #6 [ffffc90022f07550] page_fault at ffffffff818015db
    [exception RIP: unknown or invalid address]
    RIP: 000000000001f440  RSP: ffffc90022f07608  RFLAGS: 00010013
    RAX: 0000000000000000  RBX: ffff881ff83dfae0  RCX: 0000000000000000
    RDX: 3030343220746120  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffff881fff755338   R8: fffffffffffff7da   R9: 0000004000000400
    R10: 0000000000000001  R11: 0000000000000000  R12: ffff881ff83dfac0
    R13: 0000000000000000  R14: ffff881ff83dfae0  R15: ffffc90022f07630
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffc90022f07610] find_busiest_group at ffffffff8108c39b
 #8 [ffffc90022f07780] load_balance at ffffffff8108cd81
 #9 [ffffc90022f07868] pick_next_task_fair at ffffffff8108d9be
#10 [ffffc90022f078d0] __schedule at ffffffff81687ecf
#11 [ffffc90022f07928] schedule at ffffffff8168864f
#12 [ffffc90022f07930] schedule_hrtimeout_range_clock at ffffffff8168c7db
#13 [ffffc90022f079b0] poll_schedule_timeout at ffffffff811d6a9c
#14 [ffffc90022f079c8] do_select at ffffffff811d74cb
#15 [ffffc90022f07d58] core_sys_select at ffffffff811d8051
#16 [ffffc90022f07ed8] sys_select at ffffffff811d8205
#17 [ffffc90022f07f30] do_syscall_64 at ffffffff81001b8a
#18 [ffffc90022f07f50] entry_SYSCALL_64_after_hwframe at ffffffff81800076
    RIP: 00007fdb99bdf603  RSP: 00007ffe83b8e778  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00000000000f4240  RCX: 00007fdb99bdf603
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: 00021336acf17713   R8: 00007ffe83b8e780   R9: 000000001c6390ae
    R10: 0000000000000000  R11: 0000000000000246  R12: 00007fdb908b4b88
    R13: 00007ffe83b8e870  R14: 000000000000003c  R15: 00000000000f4240
    ORIG_RAX: 0000000000000017  CS: 0033  SS: 002b

I might happen after scheduling from syscall, of form softirq, but the
crash is always at find_busiest_group(). I have gone futher and
captured a crashdump. After examining it it turns out that the crash
is actually at update_sg_lb_stats() (which is inline function) exactly
at the following line:
for_each_cpu_and(i, sched_group_span(group), env->cpus) {

dissasembly around the code show:
/root/ssd/linux-4.15.y/kernel/sched/fair.c: 7795
0xffffffff8108c381 <find_busiest_group+225>:    mov    $0x1f440,%rbx
/root/ssd/linux-4.15.y/kernel/sched/fair.c: 7794 -> static inline void
update_sg_lb_stats(): for_each_cpu_and(i, sched_group_span(group),
env->cpus) {
0xffffffff8108c388 <find_busiest_group+232>:    mov    $0xffffffff,%ecx
0xffffffff8108c38d <find_busiest_group+237>:    mov    0x38(%rbp),%rdx
0xffffffff8108c391 <find_busiest_group+241>:    mov    %ecx,%edi
0xffffffff8108c393 <find_busiest_group+243>:    mov    %r14,%rsi
0xffffffff8108c396 <find_busiest_group+246>:    callq
0xffffffff8166e370 <cpumask_next_and>
--------------------------------------------------------------------------------------------
crash> dis -l 0xffffffff8166e370
/root/ssd/linux-4.15.y/lib/cpumask.c: 35
0xffffffff8166e370 <cpumask_next_and>:  push   %rbp
0xffffffff8166e371 <cpumask_next_and+1>:        mov    %rdx,%rbp
0xffffffff8166e374 <cpumask_next_and+4>:        push   %rbx
0xffffffff8166e375 <cpumask_next_and+5>:        mov    %rsi,%rbx
/root/ssd/linux-4.15.y/lib/cpumask.c: 36
0xffffffff8166e378 <cpumask_next_and+8>:        jmp
0xffffffff8166e383 <cpumask_next_and+19>
/root/ssd/linux-4.15.y/./include/linux/cpumask.h: 330
0xffffffff8166e37a <cpumask_next_and+10>:       mov    %eax,%eax
/root/ssd/linux-4.15.y/./arch/x86/include/asm/bitops.h: 332
0xffffffff8166e37c <cpumask_next_and+12>:       bt     %rax,0x0(%rbp)
/root/ssd/linux-4.15.y/lib/cpumask.c: 37
0xffffffff8166e381 <cpumask_next_and+17>:       jb
0xffffffff8166e3a0 <cpumask_next_and+48>
/root/ssd/linux-4.15.y/lib/cpumask.c: 21
0xffffffff8166e383 <cpumask_next_and+19>:       add    $0x1,%edi
0xffffffff8166e386 <cpumask_next_and+22>:       mov    $0x40,%esi
0xffffffff8166e38b <cpumask_next_and+27>:       movslq %edi,%rdx
0xffffffff8166e38e <cpumask_next_and+30>:       mov    %rbx,%rdi
0xffffffff8166e391 <cpumask_next_and+33>:       callq
0xffffffff8132d0f0 <find_next_bit>
--------------------------------------------------------------------------------------------
/root/ssd/linux-4.15.y/lib/find_bit.c: 64
0xffffffff8132d0f0 <find_next_bit>:     xor    %ecx,%ecx
0xffffffff8132d0f2 <find_next_bit+2>:   jmp    0xffffffff8132d080
<_find_next_bit>
----------------------------------------------------------------------------
crash> dis -l 0xffffffff8132d080
/root/ssd/linux-4.15.y/lib/find_bit.c: 33 -> int cpumask_next_and(): {
0xffffffff8132d080 <_find_next_bit>:    mov    %rsi,%rax
0xffffffff8132d083 <_find_next_bit+3>:  mov    %rcx,%rsi
/root/ssd/linux-4.15.y/lib/find_bit.c: 36 int cpumask_next_and():
0xffffffff8132d086 <_find_next_bit+6>:  cmp    %rax,%rdx
0xffffffff8132d089 <_find_next_bit+9>:  jae    0xffffffff8132d0e7
<_find_next_bit+103>
/root/ssd/linux-4.15.y/lib/find_bit.c: 39
0xffffffff8132d08b <_find_next_bit+11>: mov    %rdx,%rcx
/root/ssd/linux-4.15.y/lib/find_bit.c: 42
0xffffffff8132d08e <_find_next_bit+14>: mov    $0xffffffffffffffff,%r8
/root/ssd/linux-4.15.y/lib/find_bit.c: 39
0xffffffff8132d095 <_find_next_bit+21>: shr    $0x6,%rcx
0xffffffff8132d099 <_find_next_bit+25>: mov    (%rdi,%rcx,8),%r9
/root/ssd/linux-4.15.y/lib/find_bit.c: 42
0xffffffff8132d09d <_find_next_bit+29>: mov    %edx,%ecx
/root/ssd/linux-4.15.y/lib/find_bit.c: 43
0xffffffff8132d09f <_find_next_bit+31>: and    $0xffffffffffffffc0,%rdx
/root/ssd/linux-4.15.y/lib/find_bit.c: 42
0xffffffff8132d0a3 <_find_next_bit+35>: shl    %cl,%r8
0xffffffff8132d0a6 <_find_next_bit+38>: mov    %r8,%rcx
/root/ssd/linux-4.15.y/lib/find_bit.c: 39
0xffffffff8132d0a9 <_find_next_bit+41>: xor    %rsi,%r9
/root/ssd/linux-4.15.y/lib/find_bit.c: 45
0xffffffff8132d0ac <_find_next_bit+44>: and    %r9,%rcx
0xffffffff8132d0af <_find_next_bit+47>: jne    0xffffffff8132d0d8
<_find_next_bit+88>
/root/ssd/linux-4.15.y/lib/find_bit.c: 46
0xffffffff8132d0b1 <_find_next_bit+49>: add    $0x40,%rdx
/root/ssd/linux-4.15.y/lib/find_bit.c: 47
0xffffffff8132d0b5 <_find_next_bit+53>: cmp    %rax,%rdx
0xffffffff8132d0b8 <_find_next_bit+56>: jb     0xffffffff8132d0c5
<_find_next_bit+69>
0xffffffff8132d0ba <_find_next_bit+58>: jmp    0xffffffff8132d0e8
<_find_next_bit+104>
/root/ssd/linux-4.15.y/lib/find_bit.c: 46
0xffffffff8132d0bc <_find_next_bit+60>: add    $0x40,%rdx
/root/ssd/linux-4.15.y/lib/find_bit.c: 47
0xffffffff8132d0c0 <_find_next_bit+64>: cmp    %rdx,%rax
0xffffffff8132d0c3 <_find_next_bit+67>: jbe    0xffffffff8132d0e7
<_find_next_bit+103>
/root/ssd/linux-4.15.y/lib/find_bit.c: 50
0xffffffff8132d0c5 <_find_next_bit+69>: mov    %rdx,%rcx
0xffffffff8132d0c8 <_find_next_bit+72>: shr    $0x6,%rcx
0xffffffff8132d0cc <_find_next_bit+76>: mov    (%rdi,%rcx,8),%rcx
/root/ssd/linux-4.15.y/lib/find_bit.c: 45
0xffffffff8132d0d0 <_find_next_bit+80>: cmp    %rsi,%rcx
0xffffffff8132d0d3 <_find_next_bit+83>: je     0xffffffff8132d0bc
<_find_next_bit+60>
/root/ssd/linux-4.15.y/lib/find_bit.c: 50
0xffffffff8132d0d5 <_find_next_bit+85>: xor    %rsi,%rcx
/root/ssd/linux-4.15.y/./arch/x86/include/asm/bitops.h: 362
0xffffffff8132d0d8 <_find_next_bit+88>: tzcnt  %rcx,%rcx
/root/ssd/linux-4.15.y/lib/find_bit.c: 53
0xffffffff8132d0dd <_find_next_bit+93>: add    %rcx,%rdx
0xffffffff8132d0e0 <_find_next_bit+96>: cmp    %rdx,%rax
0xffffffff8132d0e3 <_find_next_bit+99>: cmova  %rdx,%rax
/root/ssd/linux-4.15.y/lib/find_bit.c: 54
0xffffffff8132d0e7 <_find_next_bit+103>:        retq
0xffffffff8132d0e8 <_find_next_bit+104>:        retq
--------------------------------------------------------------------------------------------
/root/ssd/linux-4.15.y/lib/cpumask.c: 36 -> int cpumask_next_and():
while ((n = cpumask_next(n, src1p)) < nr_cpu_ids)
0xffffffff8166e396 <cpumask_next_and+38>:       cmp
%eax,0xa73238(%rip)        # 0xffffffff820e15d4 <nr_cpu_ids>
0xffffffff8166e39c <cpumask_next_and+44>:       mov    %eax,%edi
0xffffffff8166e39e <cpumask_next_and+46>:       ja
0xffffffff8166e37a <cpumask_next_and+10>
/root/ssd/linux-4.15.y/lib/cpumask.c: 40 -> nt cpumask_next_and(): }
0xffffffff8166e3a0 <cpumask_next_and+48>:       mov    %edi,%eax
0xffffffff8166e3a2 <cpumask_next_and+50>:       pop    %rbx
0xffffffff8166e3a3 <cpumask_next_and+51>:       pop    %rbp
0xffffffff8166e3a4 <cpumask_next_and+52>:       retq
--------------------------------------------------------------------------------------------
0xffffffff8108c39b <find_busiest_group+251>:    cmp
0x1055233(%rip),%eax        # 0xffffffff820e15d4 <nr_cpu_ids>
0xffffffff8108c3a1 <find_busiest_group+257>:    mov    %eax,%ecx
0xffffffff8108c3a3 <find_busiest_group+259>:    jae
0xffffffff8108c4a8 <find_busiest_group+520>
/root/ssd/linux-4.15.y/kernel/sched/fair.c: 7795 -> static inline void
update_sg_lb_stats(): struct rq *rq = cpu_rq(i);
0xffffffff8108c3a9 <find_busiest_group+265>:    movslq %ecx,%rdx
0xffffffff8108c3ac <find_busiest_group+268>:    mov    %rbx,%rax
0xffffffff8108c3af <find_busiest_group+271>:    mov    -0x7e175c20(,%rdx,8),%rdi
0xffffffff8108c3b7 <find_busiest_group+279>:    add    %rdi,%rax
/root/ssd/linux-4.15.y/kernel/sched/fair.c: 7798
0xffffffff8108c3ba <find_busiest_group+282>:    test   %r13b,%r13b
0xffffffff8108c3bd <find_busiest_group+285>:    mov    0x110(%rax),%rdx
0xffffffff8108c3c4 <find_busiest_group+292>:    je
0xffffffff8108c45d <find_busiest_group+445>

I have examined the data in env, sched domain structs and the cpumask:

crash> struct lb_env ffffc90022f077d0
struct lb_env {
  sd = 0xffff881ff7c3e000,
  src_rq = 0x0,
  src_cpu = 0,
  dst_cpu = 5,
  dst_rq = 0xffff881fff75f440,
  dst_grpmask = 0xffff881ff83dfd60,
  new_dst_cpu = 0,
  idle = CPU_NEWLY_IDLE,
  imbalance = 0,
  cpus = 0xffff881fff755338,
  flags = 0,
  loop = 0,
  loop_break = 32,
  loop_max = 0,
  fbq_type = all,
  tasks = {
    next = 0xffffc90022f07828,
    prev = 0xffffc90022f07828
  }
}
crash> struct sched_domain 0xffff881ff7c3e000
struct sched_domain {
  parent = 0xffff881ff7c53400,
  child = 0xffff881ff7c3c400,
  groups = 0xffff881ff83dfd40,
  min_interval = 28,
  max_interval = 56,
  busy_factor = 32,
  imbalance_pct = 117,
  cache_nice_tries = 1,
  busy_idx = 2,
  idle_idx = 0,
  newidle_idx = 0,
  wake_idx = 0,
  forkexec_idx = 0,
  smt_gain = 0,
  nohz_idle = 0,
  flags = 4655,
  level = 1,
  last_balance = 6680736603,
  balance_interval = 56,
  nr_balance_failed = 0,
  max_newidle_lb_cost = 9422,
  next_decay_max_lb_cost = 6680736698,
  avg_scan_cost = 410,
  lb_count = {0, 0, 0},
  lb_failed = {0, 0, 0},
  lb_balanced = {0, 0, 0},
  lb_imbalance = {0, 0, 0},
  lb_gained = {0, 0, 0},
  lb_hot_gained = {0, 0, 0},
  lb_nobusyg = {0, 0, 0},
  lb_nobusyq = {0, 0, 0},
  alb_count = 0,
  alb_failed = 0,
  alb_pushed = 0,
  sbe_count = 0,
  sbe_balanced = 0,
  sbe_pushed = 0,
  sbf_count = 0,
  sbf_balanced = 0,
  sbf_pushed = 0,
  ttwu_wake_remote = 0,
  ttwu_move_affine = 0,
  ttwu_move_balance = 0,
  name = 0xffffffff81de73c9 "MC",
  {
    private = 0xffff883ff7fe6858,
    rcu = {
      next = 0xffff883ff7fe6858,
      func = 0x0
    }
  },
  shared = 0xffff881fff001970,
  span_weight = 28,
  span = 0xffff881ff7c3e138
}

crash> struct -x cpumask 0xffff881fff755338
struct cpumask {
  bits = {0x3fff0003fff}
}
The memory doesn't seems to be corrupted, the mask looks fine for this machine.

Best Regards,
Angel Shtilianov
