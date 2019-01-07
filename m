Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78841C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F1420859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfAGJtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:49:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:45601 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAGJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:49:07 -0500
Received: by mail-io1-f71.google.com with SMTP id r65so47492139iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dgu7GRXui0SdlIIDBpFFjT9oMH41WdGzZCfmS0Aios4=;
        b=NIG7Hu5O+zIATpT+xmWzrtOeieq2070/kMTdeOrOzyGlHXV3xsL3RNx33ExutT3Gt2
         rHiX33yRJhehekIviuyZ4BYsDMTVr+F8tErOBbKGKKYRGKbuSmtgRL9b1yvmXTQsNEWR
         ue8uN16PWpn7UQYRZiT35GNC4LNpIlQgZw9gQqHPxIbtWhl/3oOTgGG819F/n4Q/G+Xc
         lhMqcuWmHZEczXAlv7aoBk4Pgg4qJ5yAwRoT5t8Tq3a35wx1JKR9tCkHFyzhoFtAiGUE
         O6Gque2ksGaYOC8IAmiG1cXW2Xipt2iHERYDPor3UO9T3HSrFk2ipYsnjO3dI8MVVV37
         A9Uw==
X-Gm-Message-State: AA+aEWaG/y5s4I5VSpoI57lCt8wEIpXDHurDkQME5XFw8CHBgWt1+SqM
        Dm35SpAWj5tpv5dZUcHvLOkqx3RMfasZ3qJrHrMCcA6DSqEZ
X-Google-Smtp-Source: AFSGD/W9ijQLraETO6CtVWcZE3RZwAN6T6T10ss0pALZPIupLnYAJcDsx5BqBZQS/gYE3E9N4X8snm28sLcg68DJ7ZgY3n3p5xON
MIME-Version: 1.0
X-Received: by 2002:a02:77c2:: with SMTP id g185mr47568757jac.9.1546854545842;
 Mon, 07 Jan 2019 01:49:05 -0800 (PST)
Date:   Mon, 07 Jan 2019 01:49:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b97c48057edb2336@google.com>
Subject: possible deadlock in fs_reclaim_acquire
From:   syzbot <syzbot+37c014ba53e043948300@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f1c2f8857c5a Merge tag 'powerpc-4.21-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1043514b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47c29c309c47af16
dashboard link: https://syzkaller.appspot.com/bug?extid=37c014ba53e043948300
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+37c014ba53e043948300@syzkaller.appspotmail.com

audit: type=1800 audit(1546723962.588:71): pid=17034 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="syz-executor0" name="bus" dev="sda1" ino=17041 res=0
audit: type=1804 audit(1546723962.588:72): pid=17034 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor0"  
name="/root/syzkaller-testdir655153572/syzkaller.fWFGPV/140/bus" dev="sda1"  
ino=17041 res=1
======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #11 Not tainted
------------------------------------------------------
syz-executor0/17034 is trying to acquire lock:
00000000ddf28c4e (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.0+0x0/0x30  
mm/internal.h:79

but task is already holding lock:
00000000db203ae3 (delayed_uprobe_lock){+.+.}, at:  
update_ref_ctr+0x288/0x5a0 kernel/events/uprobes.c:445

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (delayed_uprobe_lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x12f/0x1670 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        uprobe_clear_state+0xad/0x380 kernel/events/uprobes.c:1511
        __mmput kernel/fork.c:1042 [inline]
        mmput+0x1af/0x640 kernel/fork.c:1067
        binder_alloc_free_page+0x597/0x1620  
drivers/android/binder_alloc.c:984
        __list_lru_walk_one+0x267/0x880 mm/list_lru.c:234
        list_lru_walk_one+0xa3/0xe0 mm/list_lru.c:278
        list_lru_walk_node+0x43/0x280 mm/list_lru.c:307
        list_lru_walk include/linux/list_lru.h:214 [inline]
        binder_shrink_scan+0x16d/0x210 drivers/android/binder_alloc.c:1020
        do_shrink_slab+0x4e5/0xd30 mm/vmscan.c:561
        shrink_slab mm/vmscan.c:710 [inline]
        shrink_slab+0x6bb/0x8c0 mm/vmscan.c:690
        shrink_node+0x61a/0x17e0 mm/vmscan.c:2757
        shrink_zones mm/vmscan.c:2987 [inline]
        do_try_to_free_pages+0x3e2/0x1290 mm/vmscan.c:3049
        try_to_free_pages+0x4b9/0xb70 mm/vmscan.c:3265
        __perform_reclaim mm/page_alloc.c:3920 [inline]
        __alloc_pages_direct_reclaim mm/page_alloc.c:3942 [inline]
        __alloc_pages_slowpath+0x9e0/0x2cc0 mm/page_alloc.c:4335
        __alloc_pages_nodemask+0xa37/0xdc0 mm/page_alloc.c:4549
        __alloc_pages include/linux/gfp.h:473 [inline]
        __alloc_pages_node include/linux/gfp.h:486 [inline]
        khugepaged_alloc_page+0x95/0x190 mm/khugepaged.c:773
        collapse_huge_page+0x141/0x2240 mm/khugepaged.c:962
        khugepaged_scan_pmd+0x165f/0x1f00 mm/khugepaged.c:1214
        khugepaged_scan_mm_slot mm/khugepaged.c:1723 [inline]
        khugepaged_do_scan mm/khugepaged.c:1804 [inline]
        khugepaged+0xcfe/0x18a0 mm/khugepaged.c:1849
        kthread+0x357/0x430 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #0 (fs_reclaim){+.+.}:
        lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
        __fs_reclaim_acquire mm/page_alloc.c:3877 [inline]
        fs_reclaim_acquire.part.0+0x24/0x30 mm/page_alloc.c:3888
        fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3889
        slab_pre_alloc_hook mm/slab.h:418 [inline]
        slab_alloc mm/slab.c:3365 [inline]
        kmem_cache_alloc_trace+0x2d/0x760 mm/slab.c:3605
        kmalloc include/linux/slab.h:545 [inline]
        kzalloc include/linux/slab.h:740 [inline]
        delayed_uprobe_add kernel/events/uprobes.c:313 [inline]
        update_ref_ctr+0x373/0x5a0 kernel/events/uprobes.c:447
        uprobe_write_opcode+0xa23/0xcb0 kernel/events/uprobes.c:496
        set_swbp+0x2b/0x40
        install_breakpoint kernel/events/uprobes.c:885 [inline]
        install_breakpoint.isra.0+0x162/0x860 kernel/events/uprobes.c:867
        register_for_each_vma+0xaa2/0xef0 kernel/events/uprobes.c:1041
        uprobe_apply+0xeb/0x140 kernel/events/uprobes.c:1192
        uprobe_perf_open kernel/trace/trace_uprobe.c:1067 [inline]
        trace_uprobe_register+0x9c9/0xcf0 kernel/trace/trace_uprobe.c:1207
        perf_trace_event_open kernel/trace/trace_event_perf.c:181 [inline]
        perf_trace_event_init kernel/trace/trace_event_perf.c:203 [inline]
        perf_trace_event_init+0x1a5/0x990 kernel/trace/trace_event_perf.c:190
        perf_uprobe_init+0x1db/0x290 kernel/trace/trace_event_perf.c:329
        perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8503
        perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9770
        perf_init_event kernel/events/core.c:9801 [inline]
        perf_event_alloc.part.0+0x20bf/0x3520 kernel/events/core.c:10074
        perf_event_alloc kernel/events/core.c:10430 [inline]
        __do_sys_perf_event_open+0xbb5/0x2f00 kernel/events/core.c:10531
        __se_sys_perf_event_open kernel/events/core.c:10420 [inline]
        __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10420
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(delayed_uprobe_lock);
                                lock(fs_reclaim);
                                lock(delayed_uprobe_lock);
   lock(fs_reclaim);

  *** DEADLOCK ***

7 locks held by syz-executor0/17034:
  #0: 00000000264208d4 (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0x9c3/0x2f00 kernel/events/core.c:10511
  #1: 00000000330dd4b9 (&pmus_srcu){....}, at:  
perf_event_alloc.part.0+0x10c1/0x3520 kernel/events/core.c:10070
  #2: 0000000020b523b5 (event_mutex){+.+.}, at: perf_uprobe_init+0x1d0/0x290  
kernel/trace/trace_event_perf.c:328
  #3: 00000000a1be6cce (&uprobe->register_rwsem){+.+.}, at:  
uprobe_apply+0x4a/0x140 kernel/events/uprobes.c:1188
  #4: 0000000021d0fe9b (&dup_mmap_sem){++++}, at:  
percpu_down_write+0x9a/0x540 kernel/locking/percpu-rwsem.c:145
  #5: 00000000bc992431 (&mm->mmap_sem){++++}, at:  
register_for_each_vma+0x7d6/0xef0 kernel/events/uprobes.c:1027
  #6: 00000000db203ae3 (delayed_uprobe_lock){+.+.}, at:  
update_ref_ctr+0x288/0x5a0 kernel/events/uprobes.c:445

stack backtrace:
CPU: 0 PID: 17034 Comm: syz-executor0 Not tainted 4.20.0+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_circular_bug.isra.0.cold+0x1cc/0x28f kernel/locking/lockdep.c:1224
  check_prev_add kernel/locking/lockdep.c:1866 [inline]
  check_prevs_add kernel/locking/lockdep.c:1979 [inline]
  validate_chain kernel/locking/lockdep.c:2350 [inline]
  __lock_acquire+0x3014/0x4a30 kernel/locking/lockdep.c:3338
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
  __fs_reclaim_acquire mm/page_alloc.c:3877 [inline]
  fs_reclaim_acquire.part.0+0x24/0x30 mm/page_alloc.c:3888
  fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3889
  slab_pre_alloc_hook mm/slab.h:418 [inline]
  slab_alloc mm/slab.c:3365 [inline]
  kmem_cache_alloc_trace+0x2d/0x760 mm/slab.c:3605
  kmalloc include/linux/slab.h:545 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  delayed_uprobe_add kernel/events/uprobes.c:313 [inline]
  update_ref_ctr+0x373/0x5a0 kernel/events/uprobes.c:447
  uprobe_write_opcode+0xa23/0xcb0 kernel/events/uprobes.c:496
  set_swbp+0x2b/0x40
  install_breakpoint kernel/events/uprobes.c:885 [inline]
  install_breakpoint.isra.0+0x162/0x860 kernel/events/uprobes.c:867
  register_for_each_vma+0xaa2/0xef0 kernel/events/uprobes.c:1041
  uprobe_apply+0xeb/0x140 kernel/events/uprobes.c:1192
  uprobe_perf_open kernel/trace/trace_uprobe.c:1067 [inline]
  trace_uprobe_register+0x9c9/0xcf0 kernel/trace/trace_uprobe.c:1207
  perf_trace_event_open kernel/trace/trace_event_perf.c:181 [inline]
  perf_trace_event_init kernel/trace/trace_event_perf.c:203 [inline]
  perf_trace_event_init+0x1a5/0x990 kernel/trace/trace_event_perf.c:190
  perf_uprobe_init+0x1db/0x290 kernel/trace/trace_event_perf.c:329
  perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8503
  perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9770
  perf_init_event kernel/events/core.c:9801 [inline]
  perf_event_alloc.part.0+0x20bf/0x3520 kernel/events/core.c:10074
  perf_event_alloc kernel/events/core.c:10430 [inline]
  __do_sys_perf_event_open+0xbb5/0x2f00 kernel/events/core.c:10531
  __se_sys_perf_event_open kernel/events/core.c:10420 [inline]
  __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10420
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa71dbc3c78 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 00007fa71dbc46d4
R13: 00000000004c43bf R14: 00000000004d7708 R15: 00000000ffffffff
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
audit: type=1804 audit(1546723963.668:73): pid=17040 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor0"  
name="/root/syzkaller-testdir655153572/syzkaller.fWFGPV/140/bus" dev="sda1"  
ino=17041 res=1
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
audit: type=1804 audit(1546723963.668:74): pid=17040 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor0"  
name="/root/syzkaller-testdir655153572/syzkaller.fWFGPV/140/bus" dev="sda1"  
ino=17041 res=1
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
block nbd0: Receive control failed (result -22)
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'nbd0' (000000005e8ae9fb): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'nbd0' (000000005e8ae9fb): fill_kobj_path: path  
= '/devices/virtual/block/nbd0'
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
audit: type=1804 audit(1546723964.148:76): pid=17091 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor0"  
name="/root/syzkaller-testdir655153572/syzkaller.fWFGPV/141/bus" dev="sda1"  
ino=17249 res=1
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
audit: type=1800 audit(1546723964.138:75): pid=17089 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="syz-executor0" name="bus" dev="sda1" ino=17249 res=0
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
block nbd0: shutting down sockets
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
audit: type=1800 audit(1546723964.678:77): pid=17112 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="syz-executor0" name="bus" dev="sda1" ino=17169 res=0
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
audit: type=1804 audit(1546723964.748:78): pid=17112 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor0"  
name="/root/syzkaller-testdir655153572/syzkaller.fWFGPV/142/bus" dev="sda1"  
ino=17169 res=1
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
audit: type=1800 audit(1546723964.998:79): pid=17132 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="syz-executor1" name="bus" dev="sda1" ino=17036 res=0
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
audit: type=1804 audit(1546723965.068:80): pid=17132 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=ToMToU  
comm="syz-executor1"  
name="/root/syzkaller-testdir677149384/syzkaller.lTtzhN/313/bus" dev="sda1"  
ino=17036 res=1
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
netlink: 'syz-executor0': attribute type 5 has an invalid length.
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
netlink: 'syz-executor0': attribute type 5 has an invalid length.
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
netlink: 'syz-executor0': attribute type 5 has an invalid length.
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
netlink: 'syz-executor0': attribute type 5 has an invalid length.
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
netlink: 'syz-executor4': attribute type 5 has an invalid length.
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
netlink: 'syz-executor4': attribute type 5 has an invalid length.
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
netlink: 'syz-executor4': attribute type 5 has an invalid length.
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
FAT-fs (loop5): error, invalid access to FAT (entry 0x00000900)
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
FAT-fs (loop5): Filesystem has been set read-only
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
FAT-fs (loop5): error, invalid access to FAT (entry 0x00000020)
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kauditd_printk_skb: 22 callbacks suppressed
audit: type=1804 audit(1546723967.708:103): pid=17255 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor4"  
name="/root/syzkaller-testdir416587791/syzkaller.rSQsRC/410/memory.events"  
dev="sda1" ino=16981 res=1
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
audit: type=1804 audit(1546723968.208:104): pid=17283 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor0"  
name="/root/syzkaller-testdir655153572/syzkaller.fWFGPV/150/memory.events"  
dev="sda1" ino=17031 res=1
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
audit: type=1804 audit(1546723968.828:105): pid=17302 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor4"  
name="/root/syzkaller-testdir416587791/syzkaller.rSQsRC/411/memory.events"  
dev="sda1" ino=16753 res=1
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
audit: type=1804 audit(1546723968.958:106): pid=17307 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor0"  
name="/root/syzkaller-testdir655153572/syzkaller.fWFGPV/151/memory.events"  
dev="sda1" ino=16676 res=1
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
audit: type=1804 audit(1546723969.588:107): pid=17319 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=invalid_pcr cause=open_writers  
comm="syz-executor4"  
name="/root/syzkaller-testdir416587791/syzkaller.rSQsRC/412/memory.events"  
dev="sda1" ino=16753 res=1
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000e6213de2): kobject_uevent_env
kobject: 'loop4' (00000000e6213de2): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (0000000032e8128e): kobject_uevent_env
kobject: 'loop1' (0000000032e8128e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (0000000073fb5ab2): kobject_uevent_env
kobject: 'loop3' (0000000073fb5ab2): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop2' (000000009ca7b820): kobject_uevent_env
kobject: 'loop2' (000000009ca7b820): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (000000007dc0e32f): kobject_uevent_env
kobject: 'loop5' (000000007dc0e32f): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (0000000064e6e564): kobject_uevent_env
kobject: 'loop0' (0000000064e6e564): fill_kobj_path: path  
= '/devices/virtual/block/loop0'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
