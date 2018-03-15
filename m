Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbeCOTLv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:11:51 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36226 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbeCOTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:22 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH v2 03/36] mm: use do_futex() instead of sys_futex() in mm_release()
Date: Thu, 15 Mar 2018 20:04:56 +0100
Message-Id: <20180315190529.20943-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_futex() is a wrapper to do_futex() which does not modify any
values here:

- uaddr, val and val3 are kept the same

- op is masked with FUTEX_CMD_MASK, but is always set to FUTEX_WAKE.
  Therefore, val2 is always 0.

- as utime is set to NULL, *timeout is NULL

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/futex.h | 13 ++++++++++---
 kernel/fork.c         |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index c0fb9a24bbd2..821ae502d3d8 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -9,9 +9,6 @@ struct inode;
 struct mm_struct;
 struct task_struct;
 
-long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
-	      u32 __user *uaddr2, u32 val2, u32 val3);
-
 extern int
 handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi);
 
@@ -55,6 +52,9 @@ union futex_key {
 
 #ifdef CONFIG_FUTEX
 extern void exit_robust_list(struct task_struct *curr);
+
+long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
+	      u32 __user *uaddr2, u32 val2, u32 val3);
 #ifdef CONFIG_HAVE_FUTEX_CMPXCHG
 #define futex_cmpxchg_enabled 1
 #else
@@ -64,6 +64,13 @@ extern int futex_cmpxchg_enabled;
 static inline void exit_robust_list(struct task_struct *curr)
 {
 }
+
+static inline long do_futex(u32 __user *uaddr, int op, u32 val,
+			    ktime_t *timeout, u32 __user *uaddr2,
+			    u32 val2, u32 val3)
+{
+	return -EINVAL;
+}
 #endif
 
 #ifdef CONFIG_FUTEX_PI
diff --git a/kernel/fork.c b/kernel/fork.c
index e5d9d405ae4e..b1e031aac9db 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1198,8 +1198,8 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 			 * not set up a proper pointer then tough luck.
 			 */
 			put_user(0, tsk->clear_child_tid);
-			sys_futex(tsk->clear_child_tid, FUTEX_WAKE,
-					1, NULL, NULL, 0);
+			do_futex(tsk->clear_child_tid, FUTEX_WAKE,
+					1, NULL, NULL, 0, 0);
 		}
 		tsk->clear_child_tid = NULL;
 	}
-- 
2.16.2
