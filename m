Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bRwxNnQ6HVsyWQAAmS7hNA
	; Sun, 10 Jun 2018 14:49:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C02616074D; Sun, 10 Jun 2018 14:49:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 784FD604D4;
	Sun, 10 Jun 2018 14:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 784FD604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeFJOtV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:49:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51578 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeFJOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:49:19 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5AEm2iQ046127;
        Sun, 10 Jun 2018 23:48:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sun, 10 Jun 2018 23:48:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5AEluAR046069
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 10 Jun 2018 23:48:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in __sb_start_write
To: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <000000000000283c37056b4a81a5@google.com>
Cc: syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
Date: Sun, 10 Jun 2018 23:47:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000283c37056b4a81a5@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Commits

  401c636a0eeb0d51 "kernel/hung_task.c: show all hung tasks before panic"
  8cc05c71ba5f7936 "locking/lockdep: Move sanity check to inside lockdep_print_held_locks()"

arrived at linux.git and syzbot started giving us more hints.

Quoting from https://syzkaller.appspot.com/text?tag=CrashReport&x=1477e81f800000 :
----------------------------------------
2 locks held by rs:main Q:Reg/4416:
 #0: 00000000dff3f899 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1a9/0x1e0 fs/file.c:766
 #1: 00000000c4a96cb8 (sb_writers#6){++++}, at: file_start_write include/linux/fs.h:2737 [inline]
 #1: 00000000c4a96cb8 (sb_writers#6){++++}, at: vfs_write+0x452/0x560 fs/read_write.c:548

1 lock held by rsyslogd/4418:
 #0: 000000007f0c215c (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1a9/0x1e0 fs/file.c:766

syz-executor4   D22224  4597   4588 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:2856 [inline]
 __schedule+0x801/0x1e30 kernel/sched/core.c:3498
 schedule+0xef/0x430 kernel/sched/core.c:3542
 __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
 rwsem_down_read_failed+0x350/0x5e0 kernel/locking/rwsem-xadd.c:286
 call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
 __down_read arch/x86/include/asm/rwsem.h:83 [inline]
 __percpu_down_read+0x15d/0x200 kernel/locking/percpu-rwsem.c:85
 percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
 __sb_start_write+0x2d7/0x300 fs/super.c:1403
 sb_start_write include/linux/fs.h:1552 [inline]
 mnt_want_write+0x3f/0xc0 fs/namespace.c:386
 do_unlinkat+0x2a3/0xa10 fs/namei.c:4026
 __do_sys_unlink fs/namei.c:4091 [inline]
 __se_sys_unlink fs/namei.c:4089 [inline]
 __x64_sys_unlink+0x42/0x50 fs/namei.c:4089
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
1 lock held by syz-executor4/4597:
 #0: 00000000c4a96cb8 (sb_writers#6){++++}, at: sb_start_write include/linux/fs.h:1552 [inline]
 #0: 00000000c4a96cb8 (sb_writers#6){++++}, at: mnt_want_write+0x3f/0xc0 fs/namespace.c:386

syz-executor6   D21536  4600   4591 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:2856 [inline]
 __schedule+0x801/0x1e30 kernel/sched/core.c:3498
 schedule+0xef/0x430 kernel/sched/core.c:3542
 __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
 rwsem_down_read_failed+0x350/0x5e0 kernel/locking/rwsem-xadd.c:286
 call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
 __down_read arch/x86/include/asm/rwsem.h:83 [inline]
 __percpu_down_read+0x15d/0x200 kernel/locking/percpu-rwsem.c:85
 percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
 __sb_start_write+0x2d7/0x300 fs/super.c:1403
 sb_start_write include/linux/fs.h:1552 [inline]
 mnt_want_write+0x3f/0xc0 fs/namespace.c:386
 do_unlinkat+0x2a3/0xa10 fs/namei.c:4026
 __do_sys_unlink fs/namei.c:4091 [inline]
 __se_sys_unlink fs/namei.c:4089 [inline]
 __x64_sys_unlink+0x42/0x50 fs/namei.c:4089
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
1 lock held by syz-executor6/4600:
 #0: 00000000c4a96cb8 (sb_writers#6){++++}, at: sb_start_write include/linux/fs.h:1552 [inline]
 #0: 00000000c4a96cb8 (sb_writers#6){++++}, at: mnt_want_write+0x3f/0xc0 fs/namespace.c:386

syz-executor3   D21536  7320   7261 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:2856 [inline]
 __schedule+0x801/0x1e30 kernel/sched/core.c:3498
 schedule+0xef/0x430 kernel/sched/core.c:3542
 __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
 rwsem_down_read_failed+0x350/0x5e0 kernel/locking/rwsem-xadd.c:286
 call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
 __down_read arch/x86/include/asm/rwsem.h:83 [inline]
 __percpu_down_read+0x15d/0x200 kernel/locking/percpu-rwsem.c:85
 percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
 __sb_start_write+0x2d7/0x300 fs/super.c:1403
 sb_start_write include/linux/fs.h:1552 [inline]
 mnt_want_write+0x3f/0xc0 fs/namespace.c:386
 do_unlinkat+0x2a3/0xa10 fs/namei.c:4026
 __do_sys_unlink fs/namei.c:4091 [inline]
 __se_sys_unlink fs/namei.c:4089 [inline]
 __x64_sys_unlink+0x42/0x50 fs/namei.c:4089
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
1 lock held by syz-executor3/7320:
 #0: 00000000c4a96cb8 (sb_writers#6){++++}, at: sb_start_write include/linux/fs.h:1552 [inline]
 #0: 00000000c4a96cb8 (sb_writers#6){++++}, at: mnt_want_write+0x3f/0xc0 fs/namespace.c:386

syz-executor2   D24032 13221   4593 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:2856 [inline]
 __schedule+0x801/0x1e30 kernel/sched/core.c:3498
 schedule+0xef/0x430 kernel/sched/core.c:3542
 __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
 rwsem_down_read_failed+0x350/0x5e0 kernel/locking/rwsem-xadd.c:286
 call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
 __down_read arch/x86/include/asm/rwsem.h:83 [inline]
 __percpu_down_read+0x15d/0x200 kernel/locking/percpu-rwsem.c:85
 percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
 __sb_start_write+0x2d7/0x300 fs/super.c:1403
 sb_start_pagefault include/linux/fs.h:1581 [inline]
 ext4_page_mkwrite+0x1c8/0x1420 fs/ext4/inode.c:6125
 do_page_mkwrite+0x146/0x500 mm/memory.c:2380
 do_shared_fault mm/memory.c:3706 [inline]
 do_fault mm/memory.c:3745 [inline]
 handle_pte_fault mm/memory.c:3972 [inline]
 __handle_mm_fault+0x2acb/0x4390 mm/memory.c:4096
 handle_mm_fault+0x53a/0xc70 mm/memory.c:4133
 __do_page_fault+0x60b/0xe40 arch/x86/mm/fault.c:1403
 do_page_fault+0xee/0x8a7 arch/x86/mm/fault.c:1478
 page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1160
2 locks held by syz-executor2/13221:
 #0: 000000002618cb0b (&mm->mmap_sem){++++}, at: __do_page_fault+0x381/0xe40 arch/x86/mm/fault.c:1332
 #1: 00000000a50d0f8c (sb_pagefaults){++++}, at: sb_start_pagefault include/linux/fs.h:1581 [inline]
 #1: 00000000a50d0f8c (sb_pagefaults){++++}, at: ext4_page_mkwrite+0x1c8/0x1420 fs/ext4/inode.c:6125

syz-executor5   D24696 13225   4598 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:2856 [inline]
 __schedule+0x801/0x1e30 kernel/sched/core.c:3498
 schedule+0xef/0x430 kernel/sched/core.c:3542
 __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
 rwsem_down_read_failed+0x350/0x5e0 kernel/locking/rwsem-xadd.c:286
 call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
 __down_read arch/x86/include/asm/rwsem.h:83 [inline]
 __percpu_down_read+0x15d/0x200 kernel/locking/percpu-rwsem.c:85
 percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
 __sb_start_write+0x2d7/0x300 fs/super.c:1403
 sb_start_pagefault include/linux/fs.h:1581 [inline]
 ext4_page_mkwrite+0x1c8/0x1420 fs/ext4/inode.c:6125
 do_page_mkwrite+0x146/0x500 mm/memory.c:2380
 wp_page_shared mm/memory.c:2676 [inline]
 do_wp_page+0xf5d/0x1990 mm/memory.c:2776
 handle_pte_fault mm/memory.c:3988 [inline]
 __handle_mm_fault+0x29f5/0x4390 mm/memory.c:4096
 handle_mm_fault+0x53a/0xc70 mm/memory.c:4133
 __do_page_fault+0x60b/0xe40 arch/x86/mm/fault.c:1403
 do_page_fault+0xee/0x8a7 arch/x86/mm/fault.c:1478
 page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1160
2 locks held by syz-executor5/13225:
 #0: 000000000aa505ed (&mm->mmap_sem){++++}, at: __do_page_fault+0x381/0xe40 arch/x86/mm/fault.c:1332
 #1: 00000000a50d0f8c (sb_pagefaults){++++}, at: sb_start_pagefault include/linux/fs.h:1581 [inline]
 #1: 00000000a50d0f8c (sb_pagefaults){++++}, at: ext4_page_mkwrite+0x1c8/0x1420 fs/ext4/inode.c:6125

syz-executor1   D23432 13236   4594 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:2856 [inline]
 __schedule+0x801/0x1e30 kernel/sched/core.c:3498
 schedule+0xef/0x430 kernel/sched/core.c:3542
 __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
 rwsem_down_read_failed+0x350/0x5e0 kernel/locking/rwsem-xadd.c:286
 call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
 __down_read arch/x86/include/asm/rwsem.h:83 [inline]
 __percpu_down_read+0x15d/0x200 kernel/locking/percpu-rwsem.c:85
 percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
 __sb_start_write+0x2d7/0x300 fs/super.c:1403
 sb_start_pagefault include/linux/fs.h:1581 [inline]
 ext4_page_mkwrite+0x1c8/0x1420 fs/ext4/inode.c:6125
 do_page_mkwrite+0x146/0x500 mm/memory.c:2380
 wp_page_shared mm/memory.c:2676 [inline]
 do_wp_page+0xf5d/0x1990 mm/memory.c:2776
 handle_pte_fault mm/memory.c:3988 [inline]
 __handle_mm_fault+0x29f5/0x4390 mm/memory.c:4096
 handle_mm_fault+0x53a/0xc70 mm/memory.c:4133
 __do_page_fault+0x60b/0xe40 arch/x86/mm/fault.c:1403
 do_page_fault+0xee/0x8a7 arch/x86/mm/fault.c:1478
 page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1160
2 locks held by syz-executor1/13236:
 #0: 0000000079279c9c (&mm->mmap_sem){++++}, at: __do_page_fault+0x381/0xe40 arch/x86/mm/fault.c:1332
 #1: 00000000a50d0f8c (sb_pagefaults){++++}, at: sb_start_pagefault include/linux/fs.h:1581 [inline]
 #1: 00000000a50d0f8c (sb_pagefaults){++++}, at: ext4_page_mkwrite+0x1c8/0x1420 fs/ext4/inode.c:6125
----------------------------------------

This looks quite strange that nobody is holding percpu_rw_semaphore for
write but everybody is stuck trying to hold it for read. (Since there
is no "X locks held by ..." line without followup "#0:" line, there is
no possibility that somebody is in TASK_RUNNING state while holding
percpu_rw_semaphore for write.)

I feel that either API has a bug or API usage is wrong.
Any idea for debugging this?
