Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeC2Mqa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:46:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeC2Mq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:46:28 -0400
Date: Thu, 29 Mar 2018 05:45:55 -0700
From: tip-bot for Tetsuo Handa <tipbot@zytor.com>
Message-ID: <tip-b3c39758c8a6972f02b43f83dba7fe7a352371b9@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        rientjes@google.com, penguin-kernel@I-love.SAKURA.ne.jp, bp@suse.de,
        mingo@kernel.org, hpa@zytor.com, mhocko@suse.com, tglx@linutronix.de
Reply-To: mhocko@suse.com, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        bp@suse.de, penguin-kernel@I-love.SAKURA.ne.jp, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rientjes@google.com
In-Reply-To: <201803271941.GBE57310.tVSOJLQOFFOHFM@I-love.SAKURA.ne.jp>
References: <201803271941.GBE57310.tVSOJLQOFFOHFM@I-love.SAKURA.ne.jp>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] lockdep: Make the lock debug output more useful
Git-Commit-ID: b3c39758c8a6972f02b43f83dba7fe7a352371b9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b3c39758c8a6972f02b43f83dba7fe7a352371b9
Gitweb:     https://git.kernel.org/tip/b3c39758c8a6972f02b43f83dba7fe7a352371b9
Author:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate: Tue, 27 Mar 2018 19:41:41 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 29 Mar 2018 14:41:40 +0200

lockdep: Make the lock debug output more useful

The lock debug output in print_lock() has a few shortcomings:

 - It prints the hlock->acquire_ip field in %px and %pS format. That's
   redundant information.

 - It lacks information about the lock object itself. The lock class is
   not helpful to identify a particular instance of a lock.

Change the output so it prints:

 - hlock->instance to allow identification of a particular lock instance.

 - only the %pS format of hlock->ip_acquire which is sufficient to decode
   the actual code line with faddr2line.

The resulting output is:

3 locks held by a.out/31106:
#0: 00000000b0f753ba (&mm->mmap_sem){++++}, at: copy_process.part.41+0x10d5/0x1fe0
#1: 00000000ef64d539 (&mm->mmap_sem/1){+.+.}, at: copy_process.part.41+0x10fe/0x1fe0
#2: 00000000b41a282e (&mapping->i_mmap_rwsem){++++}, at: copy_process.part.41+0x12f2/0x1fe0

[ tglx: Massaged changelog ]

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org
Cc: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/201803271941.GBE57310.tVSOJLQOFFOHFM@I-love.SAKURA.ne.jp

---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 12a2805dd64a..023386338269 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -556,9 +556,9 @@ static void print_lock(struct held_lock *hlock)
 		return;
 	}
 
+	printk(KERN_CONT "%p", hlock->instance);
 	print_lock_name(lock_classes + class_idx - 1);
-	printk(KERN_CONT ", at: [<%px>] %pS\n",
-		(void *)hlock->acquire_ip, (void *)hlock->acquire_ip);
+	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
 static void lockdep_print_held_locks(struct task_struct *curr)
