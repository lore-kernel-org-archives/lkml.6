Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeENTd7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:33:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751962AbeENTdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:33:45 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as non-spinnable in percpu_rwsem_release()
Date: Mon, 14 May 2018 15:31:07 -0400
Message-Id: <1526326267-22501-3-git-send-email-longman@redhat.com>
In-Reply-To: <1526326267-22501-1-git-send-email-longman@redhat.com>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu_rwsem_release() is called when the ownership of the embedded
rwsem is to be transferred to another task. The new owner, however, may
take a while to get the ownership of the lock via percpu_rwsem_acquire().
During that period, the rwsem is now marked as writer-owned with no
optimistic spinning.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/percpu-rwsem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index b1f37a8..dd37102 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -131,16 +131,16 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
 	lock_release(&sem->rw_sem.dep_map, 1, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
-		sem->rw_sem.owner = NULL;
-#endif
+		rwsem_set_writer_owned_nospin(&sem->rw_sem);
 }
 
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
 	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+	if (!read)
+		rwsem_set_writer_owned(&sem->rw_sem, current);
 }
 
 #endif
-- 
1.8.3.1
