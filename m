Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8132177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfAKJnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:43:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:33276 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbfAKJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:43:05 -0500
Received: by mail-io1-f72.google.com with SMTP id p21so12661819iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1ILxFW2EUpLoL6VhJST+PMOxdZ4A5EImFZYNrtm9nZM=;
        b=ssMh+/NdKzVDVwcUgCIWc4ULlris4MQ1yqHN/4laBLbFw8pLf3+tF8/YdDs5Ri8wN6
         7sA2fkVvPcPZ8WaY6/zaC6ZohvO9RP2XNXOdiU0gWDE9NAk+oZuny0QzjM3r1yT8OsoH
         8sbnz5z//9PGRtyR+OmdCBYTyClwvx5ukI+63QewROPa9iXJjW0GZ68GL2+t7rhEMYHz
         1lFm8+BQPbhq2NlpODqkUWePn9+yRx/jxEPTb8vGbbeWcRsNa1deV2LCWFGf4Xxbu7hi
         Hcd/2Y/Nq0xNngODIp8QWgj1EDIYJAiwbt5ypsnOtftDeEo4ddE/e5XUL2r4zRbrh9a9
         J3vA==
X-Gm-Message-State: AJcUukczBjhM2ImbUfx74KqyHX5uRCvggO3Xr9SWUvSXF5gN8tjmVahB
        dMOS0AXWFbMjIDFolVZOKthQFRZS4ds8asReyR7Bg/w+gRN/
X-Google-Smtp-Source: ALg8bN4Xy/8JuDzrRWj4qnLQHlY7VxrD7ZeXQVB9UIiSN/gq04d1oDRl9jlU6pdzjcpymWuAvUdkR0HL6a9Gk8rbymuFcB4/cilA
MIME-Version: 1.0
X-Received: by 2002:a24:3603:: with SMTP id l3mr787584itl.11.1547199783789;
 Fri, 11 Jan 2019 01:43:03 -0800 (PST)
Date:   Fri, 11 Jan 2019 01:43:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000827dbb057f2b85bb@google.com>
Subject: possible deadlock in genl_rcv (2)
From:   syzbot <syzbot+cf29f8ae16ca7ceb483d@syzkaller.appspotmail.com>
To:     avagin@virtuozzo.com, davem@davemloft.net, keescook@chromium.org,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1bdbe2274920 Merge tag 'vfio-v5.0-rc2' of git://github.com..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113a7310c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
dashboard link: https://syzkaller.appspot.com/bug?extid=cf29f8ae16ca7ceb483d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cf29f8ae16ca7ceb483d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.0.0-rc1+ #19 Not tainted
------------------------------------------------------
syz-executor4/9818 is trying to acquire lock:
000000005c79b7a6 (cb_lock){++++}, at: genl_rcv+0x1a/0x40  
net/netlink/genetlink.c:636

but task is already holding lock:
00000000074e359b (&pipe->mutex/1){+.+.}, at: pipe_lock_nested fs/pipe.c:62  
[inline]
00000000074e359b (&pipe->mutex/1){+.+.}, at: pipe_lock+0x6e/0x80  
fs/pipe.c:70

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&pipe->mutex/1){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x12f/0x1670 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        pipe_lock_nested fs/pipe.c:62 [inline]
        pipe_lock+0x6e/0x80 fs/pipe.c:70
        iter_file_splice_write+0x284/0xfc0 fs/splice.c:700
        do_splice_from fs/splice.c:851 [inline]
        do_splice+0x64b/0x1410 fs/splice.c:1152
        __do_sys_splice fs/splice.c:1419 [inline]
        __se_sys_splice fs/splice.c:1399 [inline]
        __x64_sys_splice+0x2c6/0x330 fs/splice.c:1399
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #3 (sb_writers#4){.+.+}:
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        __sb_start_write+0x20b/0x360 fs/super.c:1389
        sb_start_write include/linux/fs.h:1602 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:357
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
        ovl_create_object+0x146/0x3b0 fs/overlayfs/dir.c:599
        ovl_create+0x28/0x30 fs/overlayfs/dir.c:630
        lookup_open+0x1332/0x1b80 fs/namei.c:3234
        do_last fs/namei.c:3324 [inline]
        path_openat+0x1983/0x5650 fs/namei.c:3534
PM: Basic memory bitmaps created
        do_filp_open+0x26f/0x370 fs/namei.c:3564
        do_sys_open+0x59a/0x7c0 fs/open.c:1063
        __do_sys_openat fs/open.c:1090 [inline]
        __se_sys_openat fs/open.c:1084 [inline]
        __x64_sys_openat+0x9d/0x100 fs/open.c:1084
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe
PM: Basic memory bitmaps freed

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}:
        down_read+0x8d/0x120 kernel/locking/rwsem.c:24
        inode_lock_shared include/linux/fs.h:767 [inline]
        lookup_slow+0x4a/0x80 fs/namei.c:1687
        walk_component+0x8e5/0x26a0 fs/namei.c:1810
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
        link_path_walk.part.0+0xa57/0x1550 fs/namei.c:2141
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
        link_path_walk fs/namei.c:2072 [inline]
        path_openat+0x222/0x5650 fs/namei.c:3533
        do_filp_open+0x26f/0x370 fs/namei.c:3564
        file_open_name+0x39e/0x590 fs/open.c:1010
        filp_open+0x4c/0x80 fs/open.c:1030
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
        kernel_read_file_from_path+0x84/0x100 fs/exec.c:974
        fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:328  
[inline]
        _request_firmware+0xa73/0x15c0  
drivers/base/firmware_loader/main.c:587
        request_firmware+0x38/0x50 drivers/base/firmware_loader/main.c:636
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
        reg_reload_regdb+0x84/0x2e0 net/wireless/reg.c:1073
        nl80211_reload_regdb+0xe/0x10 net/wireless/nl80211.c:6188
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
        genl_family_rcv_msg+0x80d/0x11a0 net/netlink/genetlink.c:601
        genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:626
        netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
        genl_rcv+0x29/0x40 net/netlink/genetlink.c:637
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
        netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
        netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
        netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
        sock_sendmsg_nosec net/socket.c:621 [inline]
        sock_sendmsg+0xdd/0x130 net/socket.c:631
        ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
        __sys_sendmsg+0x112/0x270 net/socket.c:2154
        __do_sys_sendmsg net/socket.c:2163 [inline]
        __se_sys_sendmsg net/socket.c:2161 [inline]
        __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (genl_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x12f/0x1670 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        genl_lock net/netlink/genetlink.c:33 [inline]
        genl_lock_all net/netlink/genetlink.c:54 [inline]
        genl_register_family net/netlink/genetlink.c:331 [inline]
        genl_register_family+0x273/0x1450 net/netlink/genetlink.c:322
        genl_init+0x17/0x6e net/netlink/genetlink.c:1046
        do_one_initcall+0x129/0x937 init/main.c:888
        do_initcall_level init/main.c:956 [inline]
        do_initcalls init/main.c:964 [inline]
        do_basic_setup init/main.c:982 [inline]
        kernel_init_freeable+0x4db/0x5ca init/main.c:1135
        kernel_init+0x12/0x1c5 init/main.c:1055
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #0 (cb_lock){++++}:
        lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
        down_read+0x8d/0x120 kernel/locking/rwsem.c:24
        genl_rcv+0x1a/0x40 net/netlink/genetlink.c:636
        netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
        netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
        netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
        sock_sendmsg_nosec net/socket.c:621 [inline]
        sock_sendmsg+0xdd/0x130 net/socket.c:631
        kernel_sendmsg+0x44/0x50 net/socket.c:639
        sock_no_sendpage+0x1cd/0x260 net/core/sock.c:2587
        kernel_sendpage+0x95/0xf0 net/socket.c:3360
        sock_sendpage+0x8b/0xc0 net/socket.c:846
        pipe_to_sendpage+0x2b4/0x390 fs/splice.c:452
        splice_from_pipe_feed fs/splice.c:503 [inline]
        __splice_from_pipe+0x39a/0x7e0 fs/splice.c:627
        splice_from_pipe+0x1ea/0x310 fs/splice.c:662
        generic_splice_sendpage+0x3c/0x50 fs/splice.c:832
        do_splice_from fs/splice.c:851 [inline]
        do_splice+0x64b/0x1410 fs/splice.c:1152
        __do_sys_splice fs/splice.c:1419 [inline]
        __se_sys_splice fs/splice.c:1399 [inline]
        __x64_sys_splice+0x2c6/0x330 fs/splice.c:1399
        do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   cb_lock --> sb_writers#4 --> &pipe->mutex/1

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&pipe->mutex/1);
                                lock(sb_writers#4);
                                lock(&pipe->mutex/1);
   lock(cb_lock);

  *** DEADLOCK ***

1 lock held by syz-executor4/9818:
  #0: 00000000074e359b (&pipe->mutex/1){+.+.}, at: pipe_lock_nested  
fs/pipe.c:62 [inline]
  #0: 00000000074e359b (&pipe->mutex/1){+.+.}, at: pipe_lock+0x6e/0x80  
fs/pipe.c:70

stack backtrace:
CPU: 1 PID: 9818 Comm: syz-executor4 Not tainted 5.0.0-rc1+ #19
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
  down_read+0x8d/0x120 kernel/locking/rwsem.c:24
  genl_rcv+0x1a/0x40 net/netlink/genetlink.c:636
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  kernel_sendmsg+0x44/0x50 net/socket.c:639
  sock_no_sendpage+0x1cd/0x260 net/core/sock.c:2587
  kernel_sendpage+0x95/0xf0 net/socket.c:3360
  sock_sendpage+0x8b/0xc0 net/socket.c:846
  pipe_to_sendpage+0x2b4/0x390 fs/splice.c:452
  splice_from_pipe_feed fs/splice.c:503 [inline]
  __splice_from_pipe+0x39a/0x7e0 fs/splice.c:627
  splice_from_pipe+0x1ea/0x310 fs/splice.c:662
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:832
  do_splice_from fs/splice.c:851 [inline]
  do_splice+0x64b/0x1410 fs/splice.c:1152
  __do_sys_splice fs/splice.c:1419 [inline]
  __se_sys_splice fs/splice.c:1399 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1399
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007efe4b3c4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457ec9
RDX: 0000000000000007 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000073bfa0 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007efe4b3c56d4
R13: 00000000004c6b03 R14: 00000000004db2a8 R15: 00000000ffffffff
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
PM: Marking nosave pages: [mem 0xbfffd000-0xffffffff]
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
PM: Basic memory bitmaps created
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
PM: Basic memory bitmaps freed
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
PM: Marking nosave pages: [mem 0xbfffd000-0xffffffff]
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
PM: Basic memory bitmaps created
PM: Basic memory bitmaps freed
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
PM: Marking nosave pages: [mem 0xbfffd000-0xffffffff]
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
PM: Basic memory bitmaps created
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
PM: Basic memory bitmaps freed
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
PM: Marking nosave pages: [mem 0xbfffd000-0xffffffff]
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
net_ratelimit: 14 callbacks suppressed
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
PM: Basic memory bitmaps created
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
PM: Basic memory bitmaps freed
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
PM: Marking nosave pages: [mem 0xbfffd000-0xffffffff]
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
PM: Basic memory bitmaps created
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
PM: Basic memory bitmaps freed
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
PM: Marking nosave pages: [mem 0x0009f000-0x000fffff]
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
PM: Marking nosave pages: [mem 0xbfffd000-0xffffffff]
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'nullb0' (00000000cfa0c564): kobject_uevent_env
kobject: 'nullb0' (00000000cfa0c564): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_0
PM: Basic memory bitmaps created
PM: Basic memory bitmaps freed
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (000000001bbb4ef4): kobject_uevent_env
kobject: 'loop4' (000000001bbb4ef4): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (00000000e2fb39bc): kobject_uevent_env
kobject: 'loop2' (00000000e2fb39bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000a9fd9365): kobject_uevent_env
kobject: 'loop1' (00000000a9fd9365): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop3' (00000000e85e5389): kobject_uevent_env
kobject: 'loop3' (00000000e85e5389): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (000000009b3748cc): kobject_uevent_env
kobject: 'loop5' (000000009b3748cc): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000016ca69e): kobject_uevent_env
kobject: 'loop0' (00000000016ca69e): fill_kobj_path: path  
= '/devices/virtual/block/loop0'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
