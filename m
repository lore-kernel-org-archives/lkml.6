Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeB0A0L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:26:11 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54534 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751094AbeB0A0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:26:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SyYb1iR_1519691153;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org, mingo@kernel.org, adobriyan@gmail.com
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4 v2] Define killable version for access_remote_vm() and use it in fs/proc
Date: Tue, 27 Feb 2018 08:25:47 +0800
Message-Id: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Background:
When running vm-scalability with large memory (> 300GB), the below hung
task issue happens occasionally.

INFO: task ps:14018 blocked for more than 120 seconds.
       Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 ps              D    0 14018      1 0x00000004
  ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
  ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
  00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
 Call Trace:
  [<ffffffff817154d0>] ? __schedule+0x250/0x730
  [<ffffffff817159e6>] schedule+0x36/0x80
  [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
  [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
  [<ffffffff81717db0>] down_read+0x20/0x40
  [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
  [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
  [<ffffffff81241d87>] __vfs_read+0x37/0x150
  [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
  [<ffffffff81242266>] vfs_read+0x96/0x130
  [<ffffffff812437b5>] SyS_read+0x55/0xc0
  [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5

When manipulating a large mapping, the process may hold the mmap_sem for
long time, so reading /proc/<pid>/cmdline may be blocked in
uninterruptible state for long time.
We already have killable version APIs for semaphore, here use down_read_killable()
to improve the responsiveness.


When reviewing the v1 patch (https://patchwork.kernel.org/patch/10230809/),
Alexey pointed out access_remote_vm() need to be killable too. And, /proc/*/environ
reading may suffer from the same issue, so it should be converted to killable
version for both down_read and access_remote_vm too.

With reading the code, both access_remote_vm() and access_process_vm() calls
__access_remote_vm() which acquires mmap_sem by down_read(). access_remote_vm()
is only used by fs/proc/base.c, but access_process_vm() is used by other
subsystems too, i.e. ptrace, audit, etc. So, it sounds not that safe to convert
both access_remote_vm() and access_process_vm() to killable.
Instead of doing so, extract command part of __access_remote_vm() (gup part) to
a new static function, called raw_access_remote_vm(), then define
__access_remote_vm() and __access_remote_vm_killable(), which acquire mmap_sem
by down_read() and _killable() respectively.

Then define access_remote_vm() and access_remote_vm_killable() to call them
respectively. Keep access_process_vm() calls __access_remote_vm().

So far fs/proc/base.c is the only user of access_remote_vm_killable(), but
there might be other users in the future.

There are 4 patches in this revision:
#1 define access_remote_vm_killable() APIs
#2 convert /proc/*/cmdline reading to down_read_killable() and access_remote_vm_killable()
#3 convert /proc/*/environ reading to down_read_killable() and access_remote_vm_killable()
#4 replace access_process_vm() to access_remote_vm() in get_cmdline to save one
   mm reference count inc (please see the commit log for the details). This
   change makes get_cmdline() is the only user of access_remote_vm()


Yang Shi (4):
      mm: add access_remote_vm_killable APIs
      fs: proc: use down_read_killable in proc_pid_cmdline_read()
      fs: proc: use down_read_killable() in environ_read()
      mm: use access_remote_vm() in get_cmdline()

 fs/proc/base.c     | 21 +++++++++++++++------
 include/linux/mm.h |  5 +++++
 mm/memory.c        | 44 +++++++++++++++++++++++++++++++++++++-------
 mm/nommu.c         | 36 ++++++++++++++++++++++++++++++++----
 mm/util.c          |  4 ++--
 5 files changed, 91 insertions(+), 19 deletions(-)
