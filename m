Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeB0A0W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:26:22 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45781 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751631AbeB0A0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:26:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SyYb1iR_1519691153;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org, mingo@kernel.org, adobriyan@gmail.com
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4 v2] fs: proc: use down_read_killable in proc_pid_cmdline_read()
Date: Tue, 27 Feb 2018 08:25:49 +0800
Message-Id: <1519691151-101999-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

down_read_trylock() sounds too aggressive, and we already have killable
version APIs for semaphore, here use down_read_killable() to improve the
responsiveness.

And, convert access_remote_vm() to killable version.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9298324..9bdb84b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -242,7 +242,9 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 		goto out_mmput;
 	}
 
-	down_read(&mm->mmap_sem);
+	rv = down_read_killable(&mm->mmap_sem);
+	if (rv)
+		goto out_free_page;
 	arg_start = mm->arg_start;
 	arg_end = mm->arg_end;
 	env_start = mm->env_start;
@@ -264,7 +266,7 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
+	rv = access_remote_vm_killable(mm, arg_end - 1, &c, 1, 0);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -282,7 +284,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm_killable(mm, p, page,
+							_count, 0);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -328,7 +331,8 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 				bool final;
 
 				_count = min3(count, len, PAGE_SIZE);
-				nr_read = access_remote_vm(mm, p, page, _count, 0);
+				nr_read = access_remote_vm_killable(mm, p,
+							page, _count, 0);
 				if (nr_read < 0)
 					rv = nr_read;
 				if (nr_read <= 0)
-- 
1.8.3.1
