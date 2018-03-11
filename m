Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbeCKLD7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:03:59 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54122 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:47 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: [RFC PATCH 03/35] syscalls: mm_release(): use do_futex() instead of sys_futex()
Date: Sun, 11 Mar 2018 11:55:25 +0100
Message-Id: <20180311105557.20807-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_futex() is a wrapper to do_futex() which does not modify any
values here:

- uaddr, val and val3 are kept the same

- op is masked with FUTEX_CMD_MASK, but is always set to FUTEX_WAKE.
  Therefore, val2 is always 0.

- as utime is set to NULL, *timeout is NULL

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Darren Hart <dvhart@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
