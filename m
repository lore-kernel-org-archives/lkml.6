Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE2BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB6320882
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="K5bArdkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeLZTcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:32:09 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40737 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbeLZTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:32:09 -0500
Received: by mail-ed1-f46.google.com with SMTP id g22so13778406edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 11:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=2KTLNrXt84O4LQWmuO5gR81MvObkH110ktJvlB4rB5I=;
        b=K5bArdkvmWRV5OtXLyBqd11haoXH6iEcMBPt0avAELANCSEeA4pKF7yYvKYNsQXC+x
         fk0RmfIMP/A2RW31RnEPiCyhkCkIv980Mmy2vZc7L0rFu52PK2XfajCeC1ZDJ/sEyFWG
         VKte6x5pCx05gKLyJUiUQSIhF0tXJS6v35kLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2KTLNrXt84O4LQWmuO5gR81MvObkH110ktJvlB4rB5I=;
        b=bFx/0C4Lp5rdLwW4BG6ol3A8du6oJBnU/spV3zeiK/gT56KDXZXvpHawB6f9OYwX3U
         RVehzjl8pKMlZEJzkUSFPBnopkeEiogn58J8N74jXivCKBmcIwnH5rykDegInO5P0ibX
         CY4h8lCZUrbtlz3Jgg6BOkUg2/VoWCZ1UWmElueb3Pt1G7u9CE3W05T1M8PK9vB/slgO
         QPqr9ZBaPUJowHFvBn7M+7qxIYvWxPoNYhTQDqfIT3FfNW1lXL96bPhw3WXKL3dra2Y9
         qyk+Rfh30ii1FPU3KuSIQIdKSyay3zr+AWt2293NbuHIefiaEnJf9Qq0RcwSdNoDMdfE
         Uf0Q==
X-Gm-Message-State: AA+aEWZjfmiFYaIR4dJvuXD6gFklWK5nFTd6/l0YfLStZR1O+fyQlHV7
        lYXR0Z4kQDTEZsArJibuXJ8PyxrjtWD+jpfCGxP/EdxLcag=
X-Google-Smtp-Source: AFSGD/W9I2jyaLuTRsnn+EMq50RHQpAdZlxSeAhXF5Z9bWf1q7M6uFxqEGtww+yB0kZWAxlzpLtCNUaTNdKZgj8dvas=
X-Received: by 2002:a50:8bb5:: with SMTP id m50mr16032859edm.211.1545852725992;
 Wed, 26 Dec 2018 11:32:05 -0800 (PST)
MIME-Version: 1.0
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Wed, 26 Dec 2018 14:31:30 -0500
Message-ID: <CAMp4zn8YdVh62Ti=CPfoerK=QuHTp-HKiWPEdRb8kB325-KDdw@mail.gmail.com>
Subject: CPUs blocking in update_blocked_averages -- 4.19.12
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're seeing an issue introduced in 4.18, and that still persists in
4.19.12 (we upgraded from 4.9), where update_blocked_averages is
blocking. We're running a workload where a majority of our workloads
are  confined by cgroups. This exhibits itself due to a softlockup on
a CPU which is waiting on a lock that's held by
update_blocked_averages. I don't have access to any bare metal
hardware at the moment, and these are all systems running under KVM.
This kernel has CONFIG_FAIR_GROUP_SCHED on.

The Softlocked CPU:
crash> bt
PID: 29314  TASK: ffff99b5f0671f00  CPU: 0   COMMAND: "ag"
 #0 [ffff99b67b203d58] machine_kexec at ffffffff91a602f3
 #1 [ffff99b67b203db0] __crash_kexec at ffffffff91b49011
 #2 [ffff99b67b203e70] panic at ffffffff91a896d1
 #3 [ffff99b67b203ef8] watchdog_timer_fn at ffffffff91b816af
 #4 [ffff99b67b203f28] __hrtimer_run_queues at ffffffff91b26359
 #5 [ffff99b67b203f88] hrtimer_interrupt at ffffffff91b26de2
 #6 [ffff99b67b203fd8] smp_apic_timer_interrupt at ffffffff92402b06
 #7 [ffff99b67b203ff0] apic_timer_interrupt at ffffffff92401a9f
--- <IRQ stack> ---
 #8 [ffffa49fa1acbc08] apic_timer_interrupt at ffffffff92401a9f
    [exception RIP: smp_call_function_many+543]
    RIP: ffffffff91b3e84f  RSP: ffffa49fa1acbcb0  RFLAGS: 00000202
    RAX: 0000000000000010  RBX: ffff99b67b224fc0  RCX: ffff99b67b6286a0
    RDX: 0000000000000001  RSI: 0000000000000200  RDI: ffff99b67b224fc8
    RBP: ffff99b67b224fc8   R8: 0000000000000001   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000025080
    R13: ffffa49fa1acbd00  R14: 0000000000000001  R15: 0000000000000200
    ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
 #9 [ffffa49fa1acbcf8] flush_tlb_mm_range at ffffffff91a7853c
#10 [ffffa49fa1acbd90] free_pgtables at ffffffff91c4ac3b
#11 [ffffa49fa1acbdc8] unmap_region at ffffffff91c54439
#12 [ffffa49fa1acbe90] do_munmap at ffffffff91c56355
#13 [ffffa49fa1acbee0] vm_munmap at ffffffff91c56587
#14 [ffffa49fa1acbf20] __x64_sys_munmap at ffffffff91c565e2
#15 [ffffa49fa1acbf38] do_syscall_64 at ffffffff91a04590
#16 [ffffa49fa1acbf50] entry_SYSCALL_64_after_hwframe at ffffffff9240008d
    RIP: 00007f43e94de747  RSP: 00007f43e91d7e28  RFLAGS: 00000213
    RAX: ffffffffffffffda  RBX: 00000000011a6f30  RCX: 00007f43e94de747
    RDX: 0000000000000001  RSI: 0000000000000ade  RDI: 00007f43ea47d000
    RBP: 0000000000000005   R8: 00007f43e00008c0   R9: 00007f43e91d7d00
    R10: 00000000011a53b0  R11: 0000000000000213  R12: 00007f43ea47d000
    R13: 0000000000000ade  R14: 00007f43e91d89c0  R15: 0000000000000060
    ORIG_RAX: 000000000000000b  CS: 0033  SS: 002b

This is waiting on CPU 16:
crash> bt
PID: 29299  TASK: ffff99b5dffd1f00  CPU: 16  COMMAND: "ag"
 #0 [fffffe00002c8e38] crash_nmi_callback at ffffffff91a54202
 #1 [fffffe00002c8e50] nmi_handle at ffffffff91a32ee2
 #2 [fffffe00002c8ea0] default_do_nmi at ffffffff91a333ea
 #3 [fffffe00002c8ec0] do_nmi at ffffffff91a33553
 #4 [fffffe00002c8ef0] end_repeat_nmi at ffffffff924014e8
    [exception RIP: native_queued_spin_lock_slowpath+33]
    RIP: ffffffff91af2dc1  RSP: ffffa49fa1a93948  RFLAGS: 00000002
    RAX: 0000000000000001  RBX: ffff99b67b763f40  RCX: 000000004f19a57a
    RDX: 0000000000000001  RSI: 0000000000000001  RDI: ffff99b67b763f40
    RBP: 0000000000000082   R8: 0000000000000001   R9: 0000000000000000
    R10: ffffa49fa1a938f8  R11: ffffffff91aca4a7  R12: 0000000000000015
    R13: ffff99b67b764940  R14: ffffa49fa1a93a60  R15: 0000000000000015
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
--- <NMI exception stack> ---
 #5 [ffffa49fa1a93948] native_queued_spin_lock_slowpath at ffffffff91af2dc1
 #6 [ffffa49fa1a93948] do_raw_spin_lock at ffffffff91af48dd
 #7 [ffffa49fa1a93958] _raw_spin_lock_irqsave at ffffffff923c1154
 #8 [ffffa49fa1a93978] update_blocked_averages at ffffffff91aca4a7
 #9 [ffffa49fa1a93a10] update_nohz_stats at ffffffff91acaa3d
#10 [ffffa49fa1a93a20] find_busiest_group at ffffffff91ad2137
#11 [ffffa49fa1a93bb8] load_balance at ffffffff91ad2be0
#12 [ffffa49fa1a93cf0] pick_next_task_fair at ffffffff91ad41e6
#13 [ffffa49fa1a93da0] mark_held_locks at ffffffff91aeebe4
#14 [ffffa49fa1a93de8] schedule at ffffffff923b9ec2
#15 [ffffa49fa1a93df8] rwsem_down_read_failed at ffffffff923be859
#16 [ffffa49fa1a93e80] call_rwsem_down_read_failed at ffffffff923ae944
#17 [ffffa49fa1a93ec8] down_read at ffffffff923bdf0b
#18 [ffffa49fa1a93ee0] __do_page_fault at ffffffff91a71083
#19 [ffffa49fa1a93f50] async_page_fault at ffffffff924010ee
    RIP: 00007f43e945f786  RSP: 00007ffde2b50070  RFLAGS: 00010206
    RAX: 0000000000015f41  RBX: 00007f43e97a1b20  RCX: 0000000000000111
    RDX: 00000000011affb0  RSI: 00000000011b00c0  RDI: 0000000000000000
    RBP: 0000000000000111   R8: 00007f43e97a1bd8   R9: 0000000000000000
    R10: 00007f43e97a1b78  R11: 00007f43e97a1b78  R12: 00007f43e97a1b78
    R13: 00007f43e97a1b78  R14: 0000000000002710  R15: 00007f43e97a1c78
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

Which is waiting on a lock held by CPU owned by CPU 9:
crash> struct raw_spinlock_t ffff99b67b763f40
struct raw_spinlock_t {
  raw_lock = {
    {
      val = {
        counter = 1
      },
      {
        locked = 1 '\001',
        pending = 0 '\000'
      },
      {
        locked_pending = 1,
        tail = 0
      }
    }
  },
  magic = 3735899821,
  owner_cpu = 9,
  owner = 0xffff99b66e7a8000,
  dep_map = {
    key = 0xffffffff9331d120,
    class_cache = {0xffffffff93a13da0, 0x0},
    name = 0xffffffff92a7d9ad "&rq->lock"
  }
}

Which is hanging out in update_blocked_averages:
crash> bt
PID: 0      TASK: ffff99b66e7a8000  CPU: 9   COMMAND: "swapper/9"
 #0 [fffffe0000194e38] crash_nmi_callback at ffffffff91a54202
 #1 [fffffe0000194e50] nmi_handle at ffffffff91a32ee2
 #2 [fffffe0000194ea0] default_do_nmi at ffffffff91a33362
 #3 [fffffe0000194ec0] do_nmi at ffffffff91a33553
 #4 [fffffe0000194ef0] end_repeat_nmi at ffffffff924014e8
    [exception RIP: lock_is_held_type+70]
    RIP: ffffffff91aecec6  RSP: ffff99b67b443e20  RFLAGS: 00000046
    RAX: 0000000000000001  RBX: ffff99b66e7a8000  RCX: 00000000000000a8
    RDX: 0000000000000001  RSI: 00000000ffffffff  RDI: 0000000000000046
    RBP: 0000000000000046   R8: 0000000000000004   R9: 0000000000000000
    R10: ffff99b67b443e38  R11: ffffffff91aca4a7  R12: ffff99b67b763f40
    R13: ffff99b67b764940  R14: 0000000000000000  R15: ffff99b6193d9200
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffff99b67b443e20] lock_is_held_type at ffffffff91aecec6
 #6 [ffff99b67b443e30] update_blocked_averages at ffffffff91aca841
 #7 [ffff99b67b443ec8] update_nohz_stats at ffffffff91acaa3d
 #8 [ffff99b67b443ed8] _nohz_idle_balance at ffffffff91ad39f7
 #9 [ffff99b67b443f70] __softirqentry_text_start at ffffffff926000d1
#10 [ffff99b67b443fd0] irq_exit at ffffffff91a911f5
#11 [ffff99b67b443fd8] smp_apic_timer_interrupt at ffffffff92402b2c
#12 [ffff99b67b443ff0] apic_timer_interrupt at ffffffff92401a9f
--- <IRQ stack> ---
#13 [ffffa49f98993df8] apic_timer_interrupt at ffffffff92401a9f
    [exception RIP: mwait_idle+108]
    RIP: ffffffff923c02fc  RSP: ffffa49f98993ea8  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: 0000000000000009  RCX: 0000000000000000
    RDX: 0000000000000001  RSI: 0000000000000001  RDI: ffff99b66e7a8000
    RBP: 0000000000000009   R8: 0000000000000001   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000000  R12: ffff99b66e7a8000
    R13: 0000000000000000  R14: 0000000000000000  R15: ffff99b66e7a8000
    ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
#14 [ffffa49f98993ec0] do_idle at ffffffff91ac6ba3
#15 [ffffa49f98993f10] cpu_startup_entry at ffffffff91ac6f4f
#16 [ffffa49f98993f30] start_secondary at ffffffff91a55759
#17 [ffffa49f98993f50] secondary_startup_64 at ffffffff91a000d4

---

Lockdep tells me nothing, which makes me think, somehow is the code in
for_each_leaf_cfs_rq_safe looping forever?
