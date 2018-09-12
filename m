Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDAD20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDAD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeILU5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:57:11 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:41227 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:57:11 -0400
Received: by mail-it0-f71.google.com with SMTP id w132-v6so4091305ita.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=43yZeKv0F12eAN7b1jtdA0raXOfU6hrMGXpLJSr3APM=;
        b=VAF0JYOkmsyESN6WwW7NVl+l1iP2X54poNuZ96vNM5Q29ffKj1ztdzAy+dQP7SN6rV
         7I4kcHwl8ueaqtDhfI0WxsFw/8tIXqoR51WN6ZCMf1q884/XvAsN37aXWsprz4ORNep4
         Qd9qeD4qFaqeXhFX90/aqKnjIgeSVOpvlk59I5Cxi+0WSxF+WPO9vvwZSTCUu6SxUfIT
         KeOq0Wb4ARPANbULPPQ5OUnhTL5xbPARmmzpu+zMIsad+2WCygJ8TK58N8F6K4rZghLS
         GABeJfltw6qPT4YMBLdhSNAzCTOsSFfBu3oo/5puG6VBn4nFfZFx/i+WJNvZT2NnRx3p
         nPvQ==
X-Gm-Message-State: APzg51DJzY2YUkcUtu1qBqd9W4f8W88oqnj/Ats2NPh3Qk2mGb1DrGOQ
        fN3Fv4BCWeYo63U8TBkZr7Ne1wF2LFzQ3HLuQvavMiCxMo/J
X-Google-Smtp-Source: ANB0VdZqMxCYGOUx9zt9fRkz5v1ycof7n6zOdlhNslI/FFYUFr/GtE2rqeooQgD/kQMYe3qj43bAqOLBvDGWZsdlWxuBKi/lNiju
MIME-Version: 1.0
X-Received: by 2002:a6b:c94f:: with SMTP id z76-v6mr2083748iof.13.1536767523528;
 Wed, 12 Sep 2018 08:52:03 -0700 (PDT)
Date:   Wed, 12 Sep 2018 08:52:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057bac40575ae92b0@google.com>
Subject: BUG: spinlock bad magic in lockref_get
From:   syzbot <syzbot+235c05f074825627f96c@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dhowells@redhat.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14560521400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=235c05f074825627f96c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1378658e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1432a521400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+235c05f074825627f96c@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
BUG: spinlock bad magic on CPU#0, syz-executor607/5569
IPVS: ftp: loaded support on port[0] = 21
  lock: root_task_group+0xe8/0x320, .magic: 00000000, .owner:  
<none>/-1, .owner_cpu: 0
CPU: 0 PID: 5569 Comm: syz-executor607 Not tainted  
4.19.0-rc3-next-20180912+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  spin_dump+0x160/0x169 kernel/locking/spinlock_debug.c:67
  spin_bug kernel/locking/spinlock_debug.c:75 [inline]
  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
  do_raw_spin_lock.cold.3+0x37/0x3c kernel/locking/spinlock_debug.c:112
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x35/0x40 kernel/locking/spinlock.c:144
  lockref_get+0x15/0x50 include/linux/spinlock.h:329
  dget include/linux/dcache.h:322 [inline]
  mqueue_get_tree+0x101/0x2e0 ipc/mqueue.c:362
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1787
  mq_create_mount+0xe3/0x190 ipc/mqueue.c:415
IPVS: ftp: loaded support on port[0] = 21
  mq_init_ns+0x15a/0x210 ipc/mqueue.c:1621
kobject: 'lo' (00000000aab97c31): kobject_add_internal: parent: 'net',  
set: 'devices'
  create_ipc_ns ipc/namespace.c:58 [inline]
  copy_ipcs+0x3d2/0x580 ipc/namespace.c:84
kobject: 'lo' (00000000aab97c31): kobject_uevent_env
kobject: 'lo' (00000000aab97c31): fill_kobj_path: path  
= '/devices/virtual/net/lo'
kobject: 'queues' (000000002365bd8c): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
  create_new_namespaces+0x376/0x900 kernel/nsproxy.c:87
kobject: 'queues' (000000002365bd8c): kobject_uevent_env
kobject: 'queues' (000000002365bd8c): kobject_uevent_env: filter function  
caused the event to drop!
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x79c/0x10b0 kernel/fork.c:2535
kobject: 'rx-0' (0000000045cbaa93): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000045cbaa93): kobject_uevent_env
kobject: 'rx-0' (0000000045cbaa93): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
IPVS: ftp: loaded support on port[0] = 21
kobject: 'tx-0' (00000000198833ed): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000198833ed): kobject_uevent_env
  __do_sys_unshare kernel/fork.c:2603 [inline]
  __se_sys_unshare kernel/fork.c:2601 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2601
kobject: 'tx-0' (00000000198833ed): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/tx-0'
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a837
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 9d d6 fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7d d6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc5d7d6b08 EFLAGS: 00000217 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ffc5d7d6c70 RCX: 000000000044a837
RDX: 0000000000000000 RSI: 00007ffc5d7d6b10 RDI: 0000000008000000
RBP: 585858582e72656c R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000000 R11: 0000000000000217 R12: 6c616b7a79732f2e
R13: 00000000004083d0 R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: slab-out-of-bounds in atomic_inc  
include/asm-generic/atomic-instrumented.h:109 [inline]
BUG: KASAN: slab-out-of-bounds in mqueue_get_tree+0x169/0x2e0  
ipc/mqueue.c:363
Write of size 4 at addr ffff8801da80c5f4 by task syz-executor607/5569

CPU: 0 PID: 5569 Comm: syz-executor607 Not tainted  
4.19.0-rc3-next-20180912+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_inc include/asm-generic/atomic-instrumented.h:109 [inline]
  mqueue_get_tree+0x169/0x2e0 ipc/mqueue.c:363
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1787
  mq_create_mount+0xe3/0x190 ipc/mqueue.c:415
  mq_init_ns+0x15a/0x210 ipc/mqueue.c:1621
  create_ipc_ns ipc/namespace.c:58 [inline]
  copy_ipcs+0x3d2/0x580 ipc/namespace.c:84
  create_new_namespaces+0x376/0x900 kernel/nsproxy.c:87
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x79c/0x10b0 kernel/fork.c:2535
  __do_sys_unshare kernel/fork.c:2603 [inline]
  __se_sys_unshare kernel/fork.c:2601 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2601
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a837
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 9d d6 fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7d d6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc5d7d6b08 EFLAGS: 00000217 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ffc5d7d6c70 RCX: 000000000044a837
RDX: 0000000000000000 RSI: 00007ffc5d7d6b10 RDI: 0000000008000000
RBP: 585858582e72656c R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000000 R11: 0000000000000217 R12: 6c616b7a79732f2e
R13: 00000000004083d0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 0:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  alloc_workqueue_attrs+0x63/0x100 kernel/workqueue.c:3230
  init_worker_pool+0x4a3/0x620 kernel/workqueue.c:3311
  workqueue_init_early+0x25c/0x772 kernel/workqueue.c:5706
  start_kernel+0x4b5/0x915 init/main.c:624
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801da80c5c0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 20 bytes to the right of
  32-byte region [ffff8801da80c5c0, ffff8801da80c5e0)
The buggy address belongs to the page:
page:ffffea00076a0300 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff8801da80cfc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801da801248 ffffea00076a5a48 ffff8801da8001c0
raw: ffff8801da80cfc1 ffff8801da80c000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801da80c480: 00 00 04 fc fc fc fc fc 00 00 04 fc fc fc fc fc
  ffff8801da80c500: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
> ffff8801da80c580: 00 fc fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
                                                              ^
  ffff8801da80c600: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
  ffff8801da80c680: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
