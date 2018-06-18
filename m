Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FCDC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187E420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187E420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968141AbeFRIon (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:44:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030399AbeFRIhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:37:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74238CB9;
        Mon, 18 Jun 2018 08:37:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Theodore Y. Tso" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 177/189] locking/percpu-rwsem: Annotate rwsem ownership transfer by setting RWSEM_OWNER_UNKNOWN
Date:   Mon, 18 Jun 2018 10:14:33 +0200
Message-Id: <20180618081216.335211177@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit 5a817641f68a6399a5fac8b7d2da67a73698ffed ]

The filesystem freezing code needs to transfer ownership of a rwsem
embedded in a percpu-rwsem from the task that does the freezing to
another one that does the thawing by calling percpu_rwsem_release()
after freezing and percpu_rwsem_acquire() before thawing.

However, the new rwsem debug code runs afoul with this scheme by warning
that the task that releases the rwsem isn't the one that acquires it,
as reported by Amir Goldstein:

  DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
  WARNING: CPU: 1 PID: 1401 at /home/amir/build/src/linux/kernel/locking/rwsem.c:133 up_write+0x59/0x79

  Call Trace:
   percpu_up_write+0x1f/0x28
   thaw_super_locked+0xdf/0x120
   do_vfs_ioctl+0x270/0x5f1
   ksys_ioctl+0x52/0x71
   __x64_sys_ioctl+0x16/0x19
   do_syscall_64+0x5d/0x167
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

To work properly with the rwsem debug code, we need to annotate that the
rwsem ownership is unknown during the tranfer period until a brave soul
comes forward to acquire the ownership. During that period, optimistic
spinning will be disabled.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Link: http://lkml.kernel.org/r/1526420991-21213-3-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/percpu-rwsem.h |    6 +++++-
 include/linux/rwsem.h        |    6 ++++++
 kernel/locking/rwsem-xadd.c  |    2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -133,7 +133,7 @@ static inline void percpu_rwsem_release(
 	lock_release(&sem->rw_sem.dep_map, 1, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
-		sem->rw_sem.owner = NULL;
+		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
 #endif
 }
 
@@ -141,6 +141,10 @@ static inline void percpu_rwsem_acquire(
 					bool read, unsigned long ip)
 {
 	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+	if (!read)
+		sem->rw_sem.owner = current;
+#endif
 }
 
 #endif
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -44,6 +44,12 @@ struct rw_semaphore {
 #endif
 };
 
+/*
+ * Setting bit 0 of the owner field with other non-zero bits will indicate
+ * that the rwsem is writer-owned with an unknown owner.
+ */
+#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1L)
+
 extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -352,6 +352,8 @@ static inline bool rwsem_can_spin_on_own
 	struct task_struct *owner;
 	bool ret = true;
 
+	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
+
 	if (need_resched())
 		return false;
 


