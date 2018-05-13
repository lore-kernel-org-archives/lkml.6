Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeEMOCR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:02:17 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:38282 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeEMOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:02:15 -0400
X-Google-Smtp-Source: AB8JxZrsM79qHpupRXeUgRI8/VDIHw9whEEqy8spiVlN442/p7nCneVYqGD65m0r27lLSUxZtyo9Hvx4JHTjMVJ0WIU=
MIME-Version: 1.0
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 13 May 2018 17:02:13 +0300
Message-ID: <CAOQ4uxgxP-0OZzT866=RR5rGQZ89EOy-mFF50v_5Y644OrV7tA@mail.gmail.com>
Subject: DEBUG_RWSEMS warning from thaw_super()
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

Since kernel v4.17-rc1 and DEBUG_RWSEMS, I see the
warning below after filesystem freeze/thaw.

This is a case where one process acquires a bunch of rwsem
and another process releases them.

To convey this use case to lockdep, freeze_super() calls
lockdep_sb_freeze_release() on exit and thaw_super()
calls lockdep_sb_freeze_acquire() on entry.

These annotations don't seem to have any effect on the
DEBUG_RWSEMS owner checks.

What do you think is the best way to resolve this issue?

Thanks,
Amir.

----------------------
root@kvm-xfstests:~# fsfreeze -f /vdf
root@kvm-xfstests:~# fsfreeze -u /vdf
[   20.302978] ------------[ cut here ]------------
[   20.305016] DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
[   20.305029] WARNING: CPU: 1 PID: 1401 at
/home/amir/build/src/linux/kernel/locking/rwsem.c:133
up_write+0x59/0x79
[   20.311252] CPU: 1 PID: 1401 Comm: fsfreeze Not tainted
4.17.0-rc3-xfstests-00049-g39e47bf59eb3 #3276
[   20.314808] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   20.318403] RIP: 0010:up_write+0x59/0x79
[   20.320928] RSP: 0018:ffffc90000717e48 EFLAGS: 00010286
[   20.322955] RAX: 0000000000000030 RBX: ffff880078f1c680 RCX: ffff880078e42200
[   20.325665] RDX: ffffffff810cc9c1 RSI: 0000000000000001 RDI: 0000000000000202
[   20.328844] RBP: ffffc90000717e80 R08: 0000000000000001 R09: 0000000000000001
[   20.332340] R10: ffffc90000717c58 R11: ffffffff836807ad R12: ffff880078f1c388
[   20.335095] R13: ffff880078a8b980 R14: 0000000000000000 R15: 00000000fffffff7
[   20.338009] FS:  00007fb61ca42700(0000) GS:ffff88007f400000(0000)
knlGS:0000000000000000
[   20.341423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.343772] CR2: 00007fb61c559b30 CR3: 0000000078da6000 CR4: 00000000000006e0
[   20.346463] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.349201] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   20.351960] Call Trace:
[   20.352911]  percpu_up_write+0x1f/0x28
[   20.354344]  thaw_super_locked+0xdf/0x120
[   20.355944]  do_vfs_ioctl+0x270/0x5f1
[   20.357390]  ? __se_sys_newfstat+0x2e/0x39
[   20.358969]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[   20.360991]  ksys_ioctl+0x52/0x71
[   20.362384]  __x64_sys_ioctl+0x16/0x19
[   20.363702]  do_syscall_64+0x5d/0x167
[   20.365099]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
