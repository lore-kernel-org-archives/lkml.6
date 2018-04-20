Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755838AbeDTPjX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:39:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:42839 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755683AbeDTPjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:39:22 -0400
Date: Fri, 20 Apr 2018 08:25:07 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org
Cc: longman@redhat.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/2] rtmutex: Use waiter debug init,free magic numbers
Message-ID: <20180420152507.sn2ozymqvefvxuci@linux-n805>
References: <20180410162750.8290-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180410162750.8290-1-dave@stgolabs.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... we already use these for regular mutexes, rtmutex can
also use it, and while at it rename the whole thing since
this is specific to waiters.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/poison.h         | 4 ++--
 kernel/locking/mutex-debug.c   | 4 ++--
 kernel/locking/rtmutex-debug.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 15927ebc22f2..99119d34857e 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -79,8 +79,8 @@
 #define ATM_POISON		0xdeadbeef
 
 /********** kernel/mutexes **********/
-#define MUTEX_DEBUG_INIT	0x11
-#define MUTEX_DEBUG_FREE	0x22
+#define MUTEX_WAITER_DEBUG_INIT	0x11
+#define MUTEX_WAITER_DEBUG_FREE	0x22
 #define MUTEX_POISON_WW_CTX	((void *) 0x500 + POISON_POINTER_DELTA)
 
 /********** lib/flex_array.c **********/
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 9aa713629387..79b71421d763 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -29,7 +29,7 @@
  */
 void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
-	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
+	memset(waiter, MUTEX_WAITER_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic = waiter;
 	INIT_LIST_HEAD(&waiter->list);
 }
@@ -45,7 +45,7 @@ void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 void debug_mutex_free_waiter(struct mutex_waiter *waiter)
 {
 	DEBUG_LOCKS_WARN_ON(!list_empty(&waiter->list));
-	memset(waiter, MUTEX_DEBUG_FREE, sizeof(*waiter));
+	memset(waiter, MUTEX_WAITER_DEBUG_FREE, sizeof(*waiter));
 }
 
 void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index fd4fe1f5b458..95e9d8efce60 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -157,14 +157,14 @@ void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 
 void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
-	memset(waiter, 0x11, sizeof(*waiter));
+	memset(waiter, MUTEX_WAITER_DEBUG_INIT, sizeof(*waiter));
 	waiter->deadlock_task_pid = NULL;
 }
 
 void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 {
 	put_pid(waiter->deadlock_task_pid);
-	memset(waiter, 0x22, sizeof(*waiter));
+	memset(waiter, MUTEX_WAITER_DEBUG_FREE, sizeof(*waiter));
 }
 
 void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key)
-- 
2.13.6
