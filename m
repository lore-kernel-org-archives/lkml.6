Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeCTLHn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:07:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbeCTLHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:07:38 -0400
Date: Tue, 20 Mar 2018 04:07:00 -0700
From: tip-bot for Matthew Wilcox <tipbot@zytor.com>
Message-ID: <tip-45dbac0e288350f9a4226a5b4b651ed434dd9f85@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        mchehab@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com, mawilcox@microsoft.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Reply-To: corbet@lwn.net, peterz@infradead.org, tglx@linutronix.de,
        mchehab@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mawilcox@microsoft.com
In-Reply-To: <20180315115812.GA9949@bombadil.infradead.org>
References: <20180315115812.GA9949@bombadil.infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/mutex: Improve documentation
Git-Commit-ID: 45dbac0e288350f9a4226a5b4b651ed434dd9f85
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

Commit-ID:  45dbac0e288350f9a4226a5b4b651ed434dd9f85
Gitweb:     https://git.kernel.org/tip/45dbac0e288350f9a4226a5b4b651ed434dd9f85
Author:     Matthew Wilcox <mawilcox@microsoft.com>
AuthorDate: Thu, 15 Mar 2018 04:58:12 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:07:41 +0100

locking/mutex: Improve documentation

On Wed, Mar 14, 2018 at 01:56:31PM -0700, Andrew Morton wrote:

> My memory is weak and our documentation is awful.  What does
> mutex_lock_killable() actually do and how does it differ from
> mutex_lock_interruptible()?

Add kernel-doc for mutex_lock_killable() and mutex_lock_io().  Reword the
kernel-doc for mutex_lock_interruptible().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: cl@linux.com
Cc: tj@kernel.org
Link: http://lkml.kernel.org/r/20180315115812.GA9949@bombadil.infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/mutex.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 858a07590e39..2048359f33d2 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -1082,15 +1082,16 @@ static noinline int __sched
 __mutex_lock_interruptible_slowpath(struct mutex *lock);
 
 /**
- * mutex_lock_interruptible - acquire the mutex, interruptible
- * @lock: the mutex to be acquired
+ * mutex_lock_interruptible() - Acquire the mutex, interruptible by signals.
+ * @lock: The mutex to be acquired.
  *
- * Lock the mutex like mutex_lock(), and return 0 if the mutex has
- * been acquired or sleep until the mutex becomes available. If a
- * signal arrives while waiting for the lock then this function
- * returns -EINTR.
+ * Lock the mutex like mutex_lock().  If a signal is delivered while the
+ * process is sleeping, this function will return without acquiring the
+ * mutex.
  *
- * This function is similar to (but not equivalent to) down_interruptible().
+ * Context: Process context.
+ * Return: 0 if the lock was successfully acquired or %-EINTR if a
+ * signal arrived.
  */
 int __sched mutex_lock_interruptible(struct mutex *lock)
 {
@@ -1104,6 +1105,18 @@ int __sched mutex_lock_interruptible(struct mutex *lock)
 
 EXPORT_SYMBOL(mutex_lock_interruptible);
 
+/**
+ * mutex_lock_killable() - Acquire the mutex, interruptible by fatal signals.
+ * @lock: The mutex to be acquired.
+ *
+ * Lock the mutex like mutex_lock().  If a signal which will be fatal to
+ * the current process is delivered while the process is sleeping, this
+ * function will return without acquiring the mutex.
+ *
+ * Context: Process context.
+ * Return: 0 if the lock was successfully acquired or %-EINTR if a
+ * fatal signal arrived.
+ */
 int __sched mutex_lock_killable(struct mutex *lock)
 {
 	might_sleep();
@@ -1115,6 +1128,16 @@ int __sched mutex_lock_killable(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_lock_killable);
 
+/**
+ * mutex_lock_io() - Acquire the mutex and mark the process as waiting for I/O
+ * @lock: The mutex to be acquired.
+ *
+ * Lock the mutex like mutex_lock().  While the task is waiting for this
+ * mutex, it will be accounted as being in the IO wait state by the
+ * scheduler.
+ *
+ * Context: Process context.
+ */
 void __sched mutex_lock_io(struct mutex *lock)
 {
 	int token;
