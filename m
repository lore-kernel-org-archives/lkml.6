Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeEOQ0E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:26:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:50262 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeEOQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:26:02 -0400
X-Google-Smtp-Source: AB8JxZqvxYt6hgkHpo3ylw7NuKuk6ZV7Po6m+qznNsRk2my7ugMXwra6AvbvG+W6H5Oe0tAjy4TTvnt+l+kFi1h5O9liI58GyqPC
MIME-Version: 1.0
Date: Tue, 15 May 2018 09:26:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da269e056c410efd@google.com>
Subject: KMSAN: uninit-value in vcs_read
From: syzbot <syzbot+fed4435f163beccc67eb@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e2ab7e8abba4 kmsan: temporarily disable visitAsmInstructio..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=158135db800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bf8b7964e37a698
dashboard link: https://syzkaller.appspot.com/bug?extid=fed4435f163beccc67eb
compiler:       clang version 7.0.0 (trunk 329391)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17a2f91b800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bd452b800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fed4435f163beccc67eb@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in copy_to_user include/linux/uaccess.h:184  
[inline]
BUG: KMSAN: uninit-value in vcs_read+0x18ba/0x1cc0  
drivers/tty/vt/vc_screen.c:352
CPU: 1 PID: 3501 Comm: syzkaller315412 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  kmsan_internal_check_memory+0x125/0x1d0 mm/kmsan/kmsan.c:1157
  kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
  copy_to_user include/linux/uaccess.h:184 [inline]
  vcs_read+0x18ba/0x1cc0 drivers/tty/vt/vc_screen.c:352
  __vfs_read+0x19f/0x8e0 fs/read_write.c:411
  vfs_read+0x36c/0x6c0 fs/read_write.c:447
  SYSC_pread64+0x275/0x310 fs/read_write.c:611
  SyS_pread64+0x65/0x90 fs/read_write.c:598
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x443d39
RSP: 002b:00007ffcbd3c35f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d39
RDX: 0000000000000083 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004019e0
R13: 0000000000401a70 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
  __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
  vcs_read+0xd01/0x1cc0 drivers/tty/vt/vc_screen.c:274
  __vfs_read+0x19f/0x8e0 fs/read_write.c:411
  vfs_read+0x36c/0x6c0 fs/read_write.c:447
  SYSC_pread64+0x275/0x310 fs/read_write.c:611
  SyS_pread64+0x65/0x90 fs/read_write.c:598
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  __kmalloc+0x23c/0x350 mm/slub.c:3791
  kmalloc include/linux/slab.h:517 [inline]
  vc_allocate+0x438/0x800 drivers/tty/vt/vt.c:787
  con_install+0x8c/0x640 drivers/tty/vt/vt.c:2876
  tty_driver_install_tty drivers/tty/tty_io.c:1224 [inline]
  tty_init_dev+0x1b0/0x1020 drivers/tty/tty_io.c:1324
  tty_open_by_driver drivers/tty/tty_io.c:1959 [inline]
  tty_open+0x15e9/0x2ea0 drivers/tty/tty_io.c:2007
  chrdev_open+0xc20/0xd90 fs/char_dev.c:417
  do_dentry_open+0xcc6/0x1430 fs/open.c:752
  vfs_open+0x1b7/0x2e0 fs/open.c:866
  do_last fs/namei.c:3379 [inline]
  path_openat+0x460a/0x6520 fs/namei.c:3520
  do_filp_open+0x261/0x640 fs/namei.c:3554
  do_sys_open+0x624/0x960 fs/open.c:1059
  SYSC_open+0xab/0xc0 fs/open.c:1077
  SyS_open+0x54/0x80 fs/open.c:1072
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Bytes 0-79 of 131 are uninitialized
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
