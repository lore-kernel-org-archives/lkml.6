Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDDNX5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:23:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:60352 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDNX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:23:56 -0400
Date: Wed, 4 Apr 2018 09:23:54 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Subject: REGRESSION/TEST FAILURE caused by DEBUG_RWSEMS
Message-ID: <20180404132354.GA13897@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>, Oleg Nesterov <oleg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 5149cbac4235: "locking/rwsem: Add DEBUG_RWSEMS to look for
lock/unlock emismatches" (newly added in this merge window) will cause
xfstests tests failures in generic/068 for all file systems.

This is because the freeze and thaw ioctls, by design, are run in
different processes.  It looks like the concern for why
CONFIG_DEBUG_RWSEMS was added is because read/write semaphores can
spin --- which if the case, we need to make sure that (a) the spinlock
code path is not used for the freeze/thaw ioctls, and (b) we don't
trigger the debug WARN_ON.

Cheers,

						- Ted

generic/068		[08:52:46][   24.807316] run fstests generic/068 at 2018-04-04 08:52:46
[   25.444734] ------------[ cut here ]------------
[   25.446991] DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
[   25.447017] WARNING: CPU: 0 PID: 1302 at /usr/projects/linux/ext4/kernel/locking/rwsem.c:133 up_write+0x113/0x150
[   25.453885] CPU: 0 PID: 1302 Comm: xfs_io Not tainted 4.16.0-rc7-xfstests-00114-g5149cbac4235 #130
[   25.457294] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   25.460534] RIP: 0010:up_write+0x113/0x150
[   25.462096] RSP: 0018:ffff88006504fd30 EFLAGS: 00010282
[   25.464061] RAX: dffffc0000000008 RBX: ffff880068ab2af8 RCX: ffffffff89a28dde
[   25.466724] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000293
[   25.469543] RBP: ffff880068ab2b60 R08: fffffbfff179d951 R09: fffffbfff179d951
[   25.472608] R10: ffff88007ffca010 R11: fffffbfff179d950 R12: ffff880068ab27a0
[   25.475331] R13: ffff880068ab24f0 R14: ffff880068ab2ca0 R15: ffffffff89cf4d47
[   25.478000] FS:  0000000001665880(0000) GS:ffff88006d400000(0000) knlGS:0000000000000000
[   25.481025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.483216] CR2: 000000000166a018 CR3: 00000000696e8000 CR4: 00000000000006f0
[   25.485900] Call Trace:
[   25.487035]  percpu_up_write+0x4c/0x60
[   25.488532]  thaw_super+0x1c4/0x250
[   25.489904]  do_vfs_ioctl+0xe14/0xfb0
[   25.491296]  ? ioctl_preallocate+0x1a0/0x1a0
[   25.492860]  ? _copy_to_user+0x9d/0xc0
[   25.494179]  ? SyS_sysinfo+0x82/0xc0
[   25.495500]  ? SyS_getcpu+0x120/0x120
[   25.496815]  SyS_ioctl+0x43/0x80
[   25.497944]  ? do_vfs_ioctl+0xfb0/0xfb0
[   25.499268]  do_syscall_64+0x1a0/0x640
[   25.500566]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   25.502038] RIP: 0033:0x45d4c7
[   25.502901] RSP: 002b:00007ffe95712ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   25.505362] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000045d4c7
[   25.507286] RDX: 00007ffe9571300c RSI: ffffffffc0045878 RDI: 0000000000000003
[   25.509408] RBP: 0000000001669290 R08: 0000000000000000 R09: 0000000000000000
[   25.511525] R10: 0000000000434cc0 R11: 0000000000000246 R12: 0000000000000001
[   25.513404] R13: 0000000001669270 R14: 000000000166a2d0 R15: 0000000001669270
[   25.515260] Code: 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 48 8b 05 64 84 c2 03 85 c0 75 86 48 c7 c6 20 2a 66 8b 48 c7 c7 e0 29 66 8b e8 ed 07 f2 ff <0f> 0b e9 6c ff ff ff e8 41 74 2d 00 e9 2a ff ff ff 48 89 ef e8 
[   25.520602] ---[ end trace 28e00b42ae928cb1 ]---
