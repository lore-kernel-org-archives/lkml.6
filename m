Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62178C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C80214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C80214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeLEScI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:32:08 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:40791 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:32:04 -0500
Received: by mail-it1-f200.google.com with SMTP id 135so17355772itk.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AOHrdVPhoYaQV5UJmVul+hw8e3FgbyloQCsnCHF5JwA=;
        b=QswPn+FtPdTgD1HSyWTbwOyh4TCQCUvAWID8VV2zfOVLAblvA8YR15K8EEQOja9yAw
         c/hvmgotdVMMO+ukPldbXohuasVtsJCydXTUjEE1LFpejuOwPftORil8ehuAe2AEXryC
         sAj5wt1l9ORDQjgMnTjJVSG1OTsQU9ZDudIg9TeZw5pS3IoSrtYZ72iqJiQDX0yUUoPJ
         LRnW6TtSwA6vNaTsRgRTeJRR1ILKcwgDiu69oZhH3zK5JPpGz+Wolz/KYVy2IdIGFFep
         44JnrGiAxdvGa0vl5EtXd4sZ4G6vSqHMNnktdsMO1KkRQHKb/x3XfZfnjhfU0q+4jscH
         90Ng==
X-Gm-Message-State: AA+aEWb1QsPQAcuGKgdUEkZyLXhe1vf52aoASKfaFr85jwlalc4O0Hx0
        hPX6xN33P4ApIU7WZKZ271e0BiM3QOraYYg0wbjRTEx4+G+5
X-Google-Smtp-Source: AFSGD/XGhX5sVQjgZoS3LwNOa+dHTM7PG+Mt/j2VJ2VSKwqyB+anEdp2/6LiCc1XCJ3AGru934FSGvbLAPPVuSC0VaVLbu1nT9nt
MIME-Version: 1.0
X-Received: by 2002:a24:3d88:: with SMTP id n130mr14336649itn.6.1544034722984;
 Wed, 05 Dec 2018 10:32:02 -0800 (PST)
Date:   Wed, 05 Dec 2018 10:32:02 -0800
In-Reply-To: <000000000000b98a67057ad7158a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f45c5057c4a990d@google.com>
Subject: Re: KASAN: use-after-free Read in __lock_sock
From:   syzbot <syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, lucien.xin@gmail.com,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0072a0c14d5b Merge tag 'media/v4.20-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16abfdeb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=9276d76e83e3bcde6c99
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b80cfb400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
audit: type=1400 audit(1544033924.799:39): avc:  denied  { associate } for   
pid=6234 comm="syz-executor3" name="syz3"  
scontext=unconfined_u:object_r:unlabeled_t:s0  
tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem permissive=1
hrtimer: interrupt took 36373 ns
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20  
kernel/locking/lockdep.c:3218
Read of size 8 at addr ffff8881b0f54820 by task syz-executor2/7909

CPU: 0 PID: 7909 Comm: syz-executor2 Not tainted 4.20.0-rc5+ #142
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  __lock_sock+0x203/0x350 net/core/sock.c:2253
  lock_sock_nested+0xfe/0x120 net/core/sock.c:2774
  lock_sock include/net/sock.h:1492 [inline]
  sctp_sock_dump+0x122/0xb20 net/sctp/diag.c:324
  sctp_for_each_transport+0x2b5/0x370 net/sctp/socket.c:5075
  sctp_diag_dump+0x3ac/0x660 net/sctp/diag.c:527
  __inet_diag_dump+0xa8/0x140 net/ipv4/inet_diag.c:1049
  inet_diag_dump+0x9b/0x110 net/ipv4/inet_diag.c:1065
  netlink_dump+0x606/0x1080 net/netlink/af_netlink.c:2244
  __netlink_dump_start+0x59a/0x7c0 net/netlink/af_netlink.c:2352
  netlink_dump_start include/linux/netlink.h:216 [inline]
  inet_diag_handler_cmd+0x2ce/0x3f0 net/ipv4/inet_diag.c:1170
  __sock_diag_cmd net/core/sock_diag.c:232 [inline]
  sock_diag_rcv_msg+0x31d/0x410 net/core/sock_diag.c:263
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:274
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  sock_write_iter+0x35e/0x5c0 net/socket.c:900
  call_write_iter include/linux/fs.h:1857 [inline]
  do_iter_readv_writev+0x8b0/0xa80 fs/read_write.c:680
  do_iter_write+0x185/0x5f0 fs/read_write.c:959
  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
  do_writev+0x11a/0x310 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f75b80d7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000001 RSI: 000000002051c000 RDI: 000000000000000a
RBP: 000000000072c0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f75b80d86d4
R13: 00000000004c3807 R14: 00000000004d9f50 R15: 00000000ffffffff

Allocated by task 7881:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  sk_prot_alloc+0x69/0x2e0 net/core/sock.c:1463
  sk_alloc+0x10d/0x1690 net/core/sock.c:1523
  inet_create+0x509/0x1070 net/ipv4/af_inet.c:321
  __sock_create+0x536/0x930 net/socket.c:1277
  sock_create net/socket.c:1317 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1347
  __do_sys_socket net/socket.c:1356 [inline]
  __se_sys_socket net/socket.c:1354 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1354
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7908:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  sk_prot_free net/core/sock.c:1504 [inline]
  __sk_destruct+0x728/0xa80 net/core/sock.c:1588
  sk_destruct+0x78/0x90 net/core/sock.c:1596
  __sk_free+0xcf/0x300 net/core/sock.c:1607
  sk_free+0x42/0x50 net/core/sock.c:1618
  sock_put include/net/sock.h:1693 [inline]
  sctp_close+0x8d4/0xad0 net/sctp/socket.c:1569
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  get_signal+0x1558/0x1980 kernel/signal.c:2347
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881b0f54780
  which belongs to the cache SCTP(33:syz2) of size 1776
The buggy address is located 160 bytes inside of
  1776-byte region [ffff8881b0f54780, ffff8881b0f54e70)
The buggy address belongs to the page:
page:ffffea0006c3d500 count:1 mapcount:0 mapping:ffff8881d9391e40 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0007310108 ffff8881cc327148 ffff8881d9391e40
raw: 0000000000000000 ffff8881b0f54000 0000000100000002 ffff8881c0f20580
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8881c0f20580

Memory state around the buggy address:
  ffff8881b0f54700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881b0f54780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b0f54800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8881b0f54880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b0f54900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

