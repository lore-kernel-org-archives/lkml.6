Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5943C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869F820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfAVU3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:29:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37555 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:29:05 -0500
Received: by mail-io1-f69.google.com with SMTP id d63so20488328iog.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SgR17O5l1IkW2rdd8zBeK/estWzgiqZ2u9B+Ruab9NQ=;
        b=UvCre5WZMIhFJwMj0JSc+KWFpiE8WbpFInCLSlRIksN73upXryTt+pOHylnIIPAZmi
         M0845QK1bjmGVEq6m9TYaZCQP2A64sSmvqTETFXwxae4ZCJlRFnoQIKpNa5NRwE+waJi
         /yOc5ybffLMaTgRQA4fQqNI5N338Xyp3LEG1Uz04/xM8Hs2xYP1lHn66XMyM9rZXNiHu
         zAtJuYR61cWOR3H8nmyavQRv3HU6Sx1BZRWoKBuuLK8SCg20qm/JbcH5K1pFJkx+Q8TM
         bBnJXm/fjpAKsLSTjciM/I+3v8PX1wsQOB/TxoxOvoSwMNeWZOLcxMrQw4riPXaqKHiA
         8+ew==
X-Gm-Message-State: AJcUukeav8jmXlWsylC9UZm2diWxfFRUES0YSHUaiozfJOJAGjJO1OLP
        d8n+xl88+brhnAQ4iYzu9Ekn9KIN3QQ8Hjzc0lTixdTObh+d
X-Google-Smtp-Source: ALg8bN49yv9deH6iBY0ep7V7dkP3wjDJ9OPdcqUSKNc6lNlhsJ8uS3cVFgIWljDEKMxINYG1co1Y0fm3wxGtdAeT7PswjKjs4PDP
MIME-Version: 1.0
X-Received: by 2002:a5e:d918:: with SMTP id n24mr1915417iop.3.1548188943787;
 Tue, 22 Jan 2019 12:29:03 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:29:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a300f058011d4da@google.com>
Subject: KASAN: use-after-free Read in do_raw_spin_trylock
From:   syzbot <syzbot+fa0f7116270c30316624@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    28f9d1a3d4fe Merge branch 'mlxsw-spectrum_router-Add-GRE-t..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1302015f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a4dffabfb4e36f9
dashboard link: https://syzkaller.appspot.com/bug?extid=fa0f7116270c30316624
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fa0f7116270c30316624@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in queued_spin_trylock  
include/asm-generic/qspinlock.h:69 [inline]
BUG: KASAN: use-after-free in do_raw_spin_trylock+0x82/0x270  
kernel/locking/spinlock_debug.c:119
Read of size 4 at addr ffff88808f6d6f7c by task syz-executor3/12575

CPU: 0 PID: 12575 Comm: syz-executor3 Not tainted 5.0.0-rc2+ #14
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:100
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  queued_spin_trylock include/asm-generic/qspinlock.h:69 [inline]
  do_raw_spin_trylock+0x82/0x270 kernel/locking/spinlock_debug.c:119
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
  __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
  _raw_spin_trylock+0x1c/0x80 kernel/locking/spinlock.c:128
  spin_trylock include/linux/spinlock.h:339 [inline]
  icmp_xmit_lock net/ipv4/icmp.c:219 [inline]
  icmp_send+0x582/0x1bc0 net/ipv4/icmp.c:665
  ip_options_compile+0xdbe/0x1dd0 net/ipv4/ip_options.c:472
  ip_rcv_options net/ipv4/ip_input.c:282 [inline]
  ip_rcv_finish_core.isra.0+0x7f6/0x1ee0 net/ipv4/ip_input.c:357
  ip_rcv_finish+0xc3/0x2f0 net/ipv4/ip_input.c:412
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xed/0x620 net/ipv4/ip_input.c:523
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  netif_receive_skb_internal+0x11e/0x690 net/core/dev.c:5186
  napi_frags_finish net/core/dev.c:5753 [inline]
  napi_gro_frags+0xd07/0xfe0 net/core/dev.c:5827
  tun_get_user+0x2ec2/0x4150 drivers/net/tun.c:1975
dccp_close: ABORT with 1 bytes unread
  tun_chr_write_iter+0xbd/0x160 drivers/net/tun.c:2020
  call_write_iter include/linux/fs.h:1862 [inline]
  do_iter_readv_writev+0x902/0xbc0 fs/read_write.c:680
nf_conntrack: default automatic helper assignment has been turned off for  
security reasons and CT-based  firewall rule not found. Use the iptables CT  
target to attach helpers instead.
  do_iter_write fs/read_write.c:956 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:937
  vfs_writev+0x1ee/0x370 fs/read_write.c:1001
  do_writev+0x11a/0x300 fs/read_write.c:1036
  __do_sys_writev fs/read_write.c:1109 [inline]
  __se_sys_writev fs/read_write.c:1106 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1106
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f51
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 b8 fb ff c3 48  
83 ec 08 e8 1a 2d 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 63 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fd9f71a3ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000020000036 RCX: 0000000000457f51
RDX: 0000000000000002 RSI: 00007fd9f71a3bf0 RDI: 00000000000000f0
RBP: 0000000020000000 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fd9f71a46d4
R13: 00000000004c6606 R14: 00000000004db860 R15: 00000000ffffffff

Allocated by task 12578:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc mm/kasan/common.c:504 [inline]
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:411
  kmem_cache_alloc+0x12d/0x710 mm/slab.c:3543
  getname_flags fs/namei.c:140 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:129
  user_path_at_empty+0x2f/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  ksys_chdir+0xaf/0x220 fs/open.c:439
  __do_sys_chdir fs/open.c:461 [inline]
  __se_sys_chdir fs/open.c:459 [inline]
  __x64_sys_chdir+0x31/0x40 fs/open.c:459
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 12578:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
  __cache_free mm/slab.c:3487 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3749
  putname+0xef/0x130 fs/namei.c:261
  filename_lookup+0x359/0x530 fs/namei.c:2357
  user_path_at_empty+0x43/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  ksys_chdir+0xaf/0x220 fs/open.c:439
  __do_sys_chdir fs/open.c:461 [inline]
  __se_sys_chdir fs/open.c:459 [inline]
  __x64_sys_chdir+0x31/0x40 fs/open.c:459
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808f6d6a80
  which belongs to the cache names_cache of size 4096
The buggy address is located 1276 bytes inside of
  4096-byte region [ffff88808f6d6a80, ffff88808f6d7a80)
The buggy address belongs to the page:
page:ffffea00023db580 count:1 mapcount:0 mapping:ffff8880aa16adc0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00025da308 ffffea00023db408 ffff8880aa16adc0
raw: 0000000000000000 ffff88808f6d6a80 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808f6d6e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808f6d6e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808f6d6f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff88808f6d6f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808f6d7000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
