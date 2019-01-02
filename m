Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A6B218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfABKbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:31:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49346 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfABKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:31:06 -0500
Received: by mail-io1-f69.google.com with SMTP id c4so10042624ioh.16
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=moDNfs8b7De+NLBTL0iYtgL6IL6VT8q0BSPOsCfyBOQ=;
        b=CbzxVxIDjUoPaXhgJnmt98yAJNHLy/NkF+P9OAGZdOL3eoHp4IBfLZxj4DCkH2UfWb
         D8TxggS36OxS0En0hWIEx0sKgb+nFelLP74E9SbDPvWvh0OVY/d9xtZgLwoRZRZXJnWI
         9p1Djy/MP43e5hFGCSWgZhAcfGk4igUwO//MZIU74HE62D6hMqveRhjuhhUakkDrO5Pc
         fAt0AFd621z3lW4I/6eVFB6mHsvINELwKRcCgOuu8ueSLoK78iT1KiiLYbuLmFCZc9Vt
         MbAh3kAET5+hXqmpocG1Rps5nVxiXOBqK1gloCQqwXzrQJ81L9OTcpBF+8CsijaPwDfw
         aeog==
X-Gm-Message-State: AJcUukcRBCDwLmAnlv25vy4fHbVymDxIdf6reDdXP3D/Tmm/jSGpbCr2
        ToE2X8aoQPqkd8tS1hdx2h1Lo32mBd+xImpqI5D74GFnJ71p
X-Google-Smtp-Source: ALg8bN4lS/o/oTI24UMkrzj5M/aW1syNFhptW0zUroTusgDtec/JidGmhjAf0wVDziCqJwsbVRtH3F8stS3kAtI1qhIS1Ax5p4rX
MIME-Version: 1.0
X-Received: by 2002:a5e:d918:: with SMTP id n24mr16078841iop.3.1546425064719;
 Wed, 02 Jan 2019 02:31:04 -0800 (PST)
Date:   Wed, 02 Jan 2019 02:31:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7904f057e772492@google.com>
Subject: possible deadlock in nr_destroy_socket
From:   syzbot <syzbot+acfc1713819b146ae4b2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e1ef035d272e Merge tag 'armsoc-defconfig' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159934e3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c6a26e22579190b
dashboard link: https://syzkaller.appspot.com/bug?extid=acfc1713819b146ae4b2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+acfc1713819b146ae4b2@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #3 Not tainted
------------------------------------------------------
swapper/0/0 is trying to acquire lock:
000000002a66169c (nr_list_lock){+.-.}, at: spin_lock_bh  
include/linux/spinlock.h:334 [inline]
000000002a66169c (nr_list_lock){+.-.}, at: nr_remove_socket  
net/netrom/af_netrom.c:96 [inline]
000000002a66169c (nr_list_lock){+.-.}, at: nr_destroy_socket+0x96/0x6e0  
net/netrom/af_netrom.c:264

but task is already holding lock:
0000000049240dca (slock-AF_NETROM){+.-.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
0000000049240dca (slock-AF_NETROM){+.-.}, at: nr_destroy_timer+0x32/0x90  
net/netrom/af_netrom.c:247

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (slock-AF_NETROM){+.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
        spin_lock include/linux/spinlock.h:329 [inline]
        nr_find_listener net/netrom/af_netrom.c:156 [inline]
        nr_rx_frame+0x60c/0x1d50 net/netrom/af_netrom.c:955
        nr_loopback_timer+0x7b/0x170 net/netrom/nr_loopback.c:62
        call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
        expire_timers kernel/time/timer.c:1362 [inline]
        __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
        run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
        __do_softirq+0x30b/0xb11 kernel/softirq.c:292
        invoke_softirq kernel/softirq.c:373 [inline]
        irq_exit+0x180/0x1d0 kernel/softirq.c:413
        exiting_irq arch/x86/include/asm/apic.h:536 [inline]
        smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
        apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
        _raw_spin_lock+0x0/0x40
        __do_sys_close fs/open.c:1159 [inline]
        __se_sys_close fs/open.c:1157 [inline]
        __x64_sys_close+0x69/0xf0 fs/open.c:1157
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (nr_list_lock){+.-.}:
        lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
        __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
        _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:168
        spin_lock_bh include/linux/spinlock.h:334 [inline]
        nr_remove_socket net/netrom/af_netrom.c:96 [inline]
        nr_destroy_socket+0x96/0x6e0 net/netrom/af_netrom.c:264
        nr_destroy_timer+0x42/0x90 net/netrom/af_netrom.c:249
        call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
        expire_timers kernel/time/timer.c:1362 [inline]
        __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
        run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
        __do_softirq+0x30b/0xb11 kernel/softirq.c:292
        invoke_softirq kernel/softirq.c:373 [inline]
        irq_exit+0x180/0x1d0 kernel/softirq.c:413
        exiting_irq arch/x86/include/asm/apic.h:536 [inline]
        smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
        apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
        native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:57
        arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
        default_idle_call+0x36/0x90 kernel/sched/idle.c:93
        cpuidle_idle_call kernel/sched/idle.c:153 [inline]
        do_idle+0x386/0x5d0 kernel/sched/idle.c:262
        cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
        rest_init+0x245/0x37b init/main.c:443
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x882/0x8bd init/main.c:741
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(slock-AF_NETROM);
                                lock(nr_list_lock);
                                lock(slock-AF_NETROM);
   lock(nr_list_lock);

  *** DEADLOCK ***

2 locks held by swapper/0/0:
  #0: 00000000652b24b3 ((&sk->sk_timer)#2){+.-.}, at: lockdep_copy_map  
include/linux/lockdep.h:171 [inline]
  #0: 00000000652b24b3 ((&sk->sk_timer)#2){+.-.}, at:  
call_timer_fn+0x1b4/0x900 kernel/time/timer.c:1315
  #1: 0000000049240dca (slock-AF_NETROM){+.-.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
  #1: 0000000049240dca (slock-AF_NETROM){+.-.}, at:  
nr_destroy_timer+0x32/0x90 net/netrom/af_netrom.c:247

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1224
  check_prev_add kernel/locking/lockdep.c:1866 [inline]
  check_prevs_add kernel/locking/lockdep.c:1979 [inline]
  validate_chain kernel/locking/lockdep.c:2350 [inline]
  __lock_acquire+0x3014/0x4a30 kernel/locking/lockdep.c:3338
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  nr_remove_socket net/netrom/af_netrom.c:96 [inline]
  nr_destroy_socket+0x96/0x6e0 net/netrom/af_netrom.c:264
  nr_destroy_timer+0x42/0x90 net/netrom/af_netrom.c:249
  call_timer_fn+0x254/0x900 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers+0x6fc/0xd50 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
Code: ff ff ff 48 89 c7 48 89 45 d8 e8 59 49 d3 f9 48 8b 45 d8 e9 ce fe ff  
ff 48 89 df e8 48 49 d3 f9 eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66  
2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
RSP: 0018:ffffffff89807c60 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff13249e9 RBX: 1ffffffff1300f8f RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8987b73c
RBP: ffffffff89807d20 R08: ffffffff8987aec0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff89807cf8 R14: 0000000000000000 R15: ffffffff89924f38
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
  default_idle_call+0x36/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x386/0x5d0 kernel/sched/idle.c:262
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
  rest_init+0x245/0x37b init/main.c:443
  arch_call_rest_init+0xe/0x1b
  start_kernel+0x882/0x8bd init/main.c:741
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
net_ratelimit: 16 callbacks suppressed
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop5' (00000000f6c15714): kobject_uevent_env
kobject: 'loop5' (00000000f6c15714): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000006ef955fb): kobject_uevent_env
kobject: 'loop0' (000000006ef955fb): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (0000000039030495): kobject_uevent_env
kobject: 'loop1' (0000000039030495): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000a229739b): kobject_uevent_env
kobject: 'loop2' (00000000a229739b): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000001f21180a): kobject_uevent_env
kobject: 'loop4' (000000001f21180a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000006ef955fb): kobject_uevent_env
kobject: 'loop0' (000000006ef955fb): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f6c15714): kobject_uevent_env
kobject: 'loop5' (00000000f6c15714): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000001f21180a): kobject_uevent_env
kobject: 'loop4' (000000001f21180a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000006ef955fb): kobject_uevent_env
kobject: 'loop0' (000000006ef955fb): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000a229739b): kobject_uevent_env
kobject: 'loop2' (00000000a229739b): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000039030495): kobject_uevent_env
kobject: 'loop1' (0000000039030495): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000f6c15714): kobject_uevent_env
kobject: 'loop5' (00000000f6c15714): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
net_ratelimit: 20 callbacks suppressed
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000001f21180a): kobject_uevent_env
kobject: 'loop4' (000000001f21180a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000006ef955fb): kobject_uevent_env
kobject: 'loop0' (000000006ef955fb): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop0' (000000006ef955fb): kobject_uevent_env
kobject: 'loop0' (000000006ef955fb): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000039030495): kobject_uevent_env
kobject: 'loop1' (0000000039030495): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000a229739b): kobject_uevent_env
kobject: 'loop2' (00000000a229739b): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000f6c15714): kobject_uevent_env
kobject: 'loop5' (00000000f6c15714): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (0000000039030495): kobject_uevent_env
kobject: 'loop1' (0000000039030495): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop1' (0000000039030495): kobject_uevent_env
kobject: 'loop1' (0000000039030495): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000a229739b): kobject_uevent_env
kobject: 'loop2' (00000000a229739b): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000006ef955fb): kobject_uevent_env
kobject: 'loop0' (000000006ef955fb): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (00000000f6c15714): kobject_uevent_env
kobject: 'loop5' (00000000f6c15714): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (000000001f21180a): kobject_uevent_env
kobject: 'loop4' (000000001f21180a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (000000009eab774b): kobject_uevent_env
kobject: 'loop3' (000000009eab774b): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (0000000039030495): kobject_uevent_env
kobject: 'loop1' (0000000039030495): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000006ef955fb): kobject_uevent_env
kobject: 'loop0' (000000006ef955fb): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000a229739b): kobject_uevent_env
kobject: 'loop2' (00000000a229739b): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (000000001f21180a): kobject_uevent_env
kobject: 'loop4' (000000001f21180a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
