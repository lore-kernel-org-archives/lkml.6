Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5302C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D652075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D652075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937668AbeFSLLX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:11:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:46146 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937606AbeFSLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:11:21 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5JBA5ur021079;
        Tue, 19 Jun 2018 20:10:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 19 Jun 2018 20:10:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5JBA4Ux021067
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 19 Jun 2018 20:10:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __sb_start_write
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000283c37056b4a81a5@google.com>
 <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
 <20180611073038.GK12217@hirez.programming.kicks-ass.net>
 <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
 <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
 <CACT4Y+ZaUanRCWtq4nFhFVxfDCX=2e6JCW-qkX7vp++QvijWBw@mail.gmail.com>
 <dd849e4f-a30f-e508-d4e9-0f3c6d11c89a@i-love.sakura.ne.jp>
Message-ID: <f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp>
Date:   Tue, 19 Jun 2018 20:10:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <dd849e4f-a30f-e508-d4e9-0f3c6d11c89a@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/16 4:40, Tetsuo Handa wrote:
> Hmm, there might be other locations calling percpu_rwsem_release() ?

There are other locations calling percpu_rwsem_release(), but quite few.

include/linux/fs.h:1494:#define __sb_writers_release(sb, lev)   \
include/linux/fs.h-1495-        percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)

fs/btrfs/transaction.c:1821:            __sb_writers_release(fs_info->sb, SB_FREEZE_FS);
fs/aio.c:1566:                  __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
fs/xfs/xfs_aops.c:211:  __sb_writers_release(ioend->io_inode->i_sb, SB_FREEZE_FS);



I'd like to check what atomic_long_read(&sem->rw_sem.count) says
when hung task is reported.

Dmitry, if you succeed to reproduce khungtaskd messages, can you try this patch?

---
 include/linux/sched.h         |  1 +
 kernel/hung_task.c            | 25 +++++++++++++++++++++++++
 kernel/locking/percpu-rwsem.c |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87bf02d..af95251 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1179,6 +1179,7 @@ struct task_struct {
 	/* Used by LSM modules for access restriction: */
 	void				*security;
 #endif
+	struct percpu_rw_semaphore	*pcpu_rwsem_read_waiting;
 
 	/*
 	 * New fields for task_struct should be added above here, so that
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 32b4794..409cc82 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -18,6 +18,7 @@
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/percpu-rwsem.h>
 
 #include <trace/events/sched.h>
 
@@ -77,6 +78,29 @@ static int __init hung_task_panic_setup(char *str)
 	.notifier_call = hung_task_panic,
 };
 
+static void dump_percpu_rwsem_state(struct percpu_rw_semaphore *sem)
+{
+	unsigned int sum = 0;
+	int cpu;
+
+	if (!sem)
+		return;
+	pr_info("percpu_rw_semaphore(%p)\n", sem);
+	pr_info("  ->rw_sem.count=0x%lx\n",
+		atomic_long_read(&sem->rw_sem.count));
+	pr_info("  ->rss.gp_state=%d\n", sem->rss.gp_state);
+	pr_info("  ->rss.gp_count=%d\n", sem->rss.gp_count);
+	pr_info("  ->rss.cb_state=%d\n", sem->rss.cb_state);
+	pr_info("  ->rss.gp_type=%d\n", sem->rss.gp_type);
+	pr_info("  ->readers_block=%d\n", sem->readers_block);
+	for_each_possible_cpu(cpu)
+		sum += per_cpu(*sem->read_count, cpu);
+	pr_info("  ->read_count=%d\n", sum);
+	pr_info("  ->list_empty(rw_sem.wait_list)=%d\n",
+	       list_empty(&sem->rw_sem.wait_list));
+	pr_info("  ->writer.task=%p\n", sem->writer.task);
+}
+
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
@@ -122,6 +146,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
 		sched_show_task(t);
+		dump_percpu_rwsem_state(t->pcpu_rwsem_read_waiting);
 		hung_task_show_lock = true;
 	}
 
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 883cf1b..b3654ab 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -82,7 +82,9 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 	/*
 	 * Avoid lockdep for the down/up_read() we already have them.
 	 */
+	current->pcpu_rwsem_read_waiting = sem;
 	__down_read(&sem->rw_sem);
+	current->pcpu_rwsem_read_waiting = NULL;
 	this_cpu_inc(*sem->read_count);
 	__up_read(&sem->rw_sem);
 
-- 
1.8.3.1

