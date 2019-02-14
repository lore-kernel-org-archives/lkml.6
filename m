Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE573C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B6F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="ZLLFXg1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfBNXCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:02:03 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:48185 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfBNXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=4SlgX0VQfbbRUxcfcuRFjyJ/kVYUAsM2XQqH8/1+HT8=; b=ZLLFXg1jTIUe
        WxMt82Z6cMr4kqqX9F91i3UdKBIki4sDNwGMg7cG6qezNuvrCmt16TlsiIHaoe0GtiRfjMo49NFsY
        +84Du9HoPhnR2TuXE/bhNWDqa3ozYpKYD3rxflUfAna3+UonlwFxOXITQStDlVxCNXGmp0wyJS6I3
        RCWY0DWBU4PErzHYqxkyf1p+NaF10UFcLzewFNBOc/lnZLfGTI18Aq8hjuenTHxGsnaAl9wSX1K96
        Io8bwpSEvgmOrLoEdBnku7T6FEzbcti6yE4c/efD9a6aPCY7Wl4OSiEwGVTFqmkXhEVF+YkYyXhuJ
        x83VA8Gz1/HdoISfozW8BA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0u-0000tw-3g; Fri, 15 Feb 2019 00:01:53 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id F096DC0482;
        Fri, 15 Feb 2019 00:01:49 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 19/23] kernel/workqueue: Use dynamic lockdep keys for workqueues
Date:   Thu, 14 Feb 2019 15:00:54 -0800
Message-Id: <20190214230058.196511-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000542962095069)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jJ7Ih40K1upnWpOd+umqBp602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3bC8dt
 /CV3fELBVC/AS5PvSbXcS42ZV4hGYRCvRHS3A+fHzJ6mVE7ewsipSVIfs4YPrBHsgfEKhDwsBOx3
 ZCT3Q2EZL/JNL8UUAaUS/T4q/hyWVd53YytHpjB/ujB/2NTsysIQh3c1tpyciYbqCvvgzE++dJZh
 hWbGyID6cWhsJRhb5RzkLIvXya0B9hweynIpEbHgsgY3JWab+g/Mh1jtnnOnAcd69x18pg0p8FqR
 rrmbyc5aB71wGr2Wbtmzh89JTRBxdS0lhfyuKilVxvWjCdK5dbUFdaYh4OLOUeZKO4TBa7kme6ff
 96X9WP+3jk0SJ/kTJjKPZ/8yaP/4XwlZZAHYSttyJwNs842uSNa4gyQXDpdUnGtbQi4spq0UVwRE
 wz3BDlSGdw7VMtZPUeP8kDkXGJvniGivX1Fq/UQDddsCO69AoU2oRPPFpAmM+MP3ndP5vfUQ4ul/
 XTPIgii6Kq6qRvDQ2XYchg9MrxV4mWaBWuZZ1rE+MiszWwrZbclSzNQilWcl+AAZWR29Qk/nn/l+
 RqTaqlzUTPtuUYu1AjeGxIg0VP7oXbc+j86yoLU5TqQtU3Fmv+9rOFh5/4AztW1xD7NPHFVkxC5Y
 VnU16VdtBKql0yaiWVS4FZeRyGrddKrYTaNJmUrP3aGF8PhBfZvJhEai+eHegH0Ec43kUsw4Oh2L
 kwsmIC+tUiJAU2HV4JjSb8ZA1ph/XcllGuCYno3HAvYIdfpHfr+BI0lXGBxwEiTVJqDh0qKoKsXx
 5lkrB0NgADpo+u70e0mb9CuXcB1utDIGGzoxX0Pq2Sc4/rXNP8evbj93rcJzfRecDffpfj5sSQhb
 3cc4IkKXIhy+VQFYdTkvI7AHf8uIH0A8UoKhd6FzBtileDUVqU9xfPdO+eyolGM4l8rlxuGfhU+3
 4oc3K5BE7o/7xI7rcp+XGKuAzBSdqYsFmB+z+c7xrxi9hX6LDkmm4X5IcVM5U1xd
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing")
improved deadlock checking in the workqueue implementation. Unfortunately
that patch also introduced a few false positive lockdep complaints. This
patch suppresses these false positives by allocating the workqueue mutex
lockdep key dynamically. An example of a false positive lockdep complaint
suppressed by this report can be found below. The root cause of the
lockdep complaint shown below is that the direct I/O code can call
alloc_workqueue() from inside a work item created by another
alloc_workqueue() call and that both workqueues share the same lockdep
key. This patch avoids that that lockdep complaint is triggered by
allocating the work queue lockdep keys dynamically. In other words, this
patch guarantees that a unique lockdep key is associated with each work
queue mutex.

======================================================
WARNING: possible circular locking dependency detected
4.19.0-dbg+ #1 Not tainted
------------------------------------------------------
fio/4129 is trying to acquire lock:
00000000a01cfe1a ((wq_completion)"dio/%s"sb->s_id){+.+.}, at: flush_workqueue+0xd0/0x970

but task is already holding lock:
00000000a0acecf9 (&sb->s_type->i_mutex_key#14){+.+.}, at: ext4_file_write_iter+0x154/0x710

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#14){+.+.}:
       down_write+0x3d/0x80
       __generic_file_fsync+0x77/0xf0
       ext4_sync_file+0x3c9/0x780
       vfs_fsync_range+0x66/0x100
       dio_complete+0x2f5/0x360
       dio_aio_complete_work+0x1c/0x20
       process_one_work+0x481/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #1 ((work_completion)(&dio->complete_work)){+.+.}:
       process_one_work+0x447/0x9f0
       worker_thread+0x63/0x5a0
       kthread+0x1cf/0x1f0
       ret_from_fork+0x24/0x30

-> #0 ((wq_completion)"dio/%s"sb->s_id){+.+.}:
       lock_acquire+0xc5/0x200
       flush_workqueue+0xf3/0x970
       drain_workqueue+0xec/0x220
       destroy_workqueue+0x23/0x350
       sb_init_dio_done_wq+0x6a/0x80
       do_blockdev_direct_IO+0x1f33/0x4be0
       __blockdev_direct_IO+0x79/0x86
       ext4_direct_IO+0x5df/0xbb0
       generic_file_direct_write+0x119/0x220
       __generic_file_write_iter+0x131/0x2d0
       ext4_file_write_iter+0x3fa/0x710
       aio_write+0x235/0x330
       io_submit_one+0x510/0xeb0
       __x64_sys_io_submit+0x122/0x340
       do_syscall_64+0x71/0x220
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  (wq_completion)"dio/%s"sb->s_id --> (work_completion)(&dio->complete_work) --> &sb->s_type->i_mutex_key#14

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#14);
                               lock((work_completion)(&dio->complete_work));
                               lock(&sb->s_type->i_mutex_key#14);
  lock((wq_completion)"dio/%s"sb->s_id);

 *** DEADLOCK ***

1 lock held by fio/4129:
 #0: 00000000a0acecf9 (&sb->s_type->i_mutex_key#14){+.+.}, at: ext4_file_write_iter+0x154/0x710

stack backtrace:
CPU: 3 PID: 4129 Comm: fio Not tainted 4.19.0-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x86/0xc5
 print_circular_bug.isra.32+0x20a/0x218
 __lock_acquire+0x1c68/0x1cf0
 lock_acquire+0xc5/0x200
 flush_workqueue+0xf3/0x970
 drain_workqueue+0xec/0x220
 destroy_workqueue+0x23/0x350
 sb_init_dio_done_wq+0x6a/0x80
 do_blockdev_direct_IO+0x1f33/0x4be0
 __blockdev_direct_IO+0x79/0x86
 ext4_direct_IO+0x5df/0xbb0
 generic_file_direct_write+0x119/0x220
 __generic_file_write_iter+0x131/0x2d0
 ext4_file_write_iter+0x3fa/0x710
 aio_write+0x235/0x330
 io_submit_one+0x510/0xeb0
 __x64_sys_io_submit+0x122/0x340
 do_syscall_64+0x71/0x220
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/workqueue.h | 28 +++----------------
 kernel/workqueue.c        | 59 +++++++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 60d673e15632..d9a1a480e920 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -390,43 +390,23 @@ extern struct workqueue_struct *system_freezable_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;
 
-extern struct workqueue_struct *
-__alloc_workqueue_key(const char *fmt, unsigned int flags, int max_active,
-	struct lock_class_key *key, const char *lock_name, ...) __printf(1, 6);
-
 /**
  * alloc_workqueue - allocate a workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags
  * @max_active: max in-flight work items, 0 for default
- * @args...: args for @fmt
+ * remaining args: args for @fmt
  *
  * Allocate a workqueue with the specified parameters.  For detailed
  * information on WQ_* flags, please refer to
  * Documentation/core-api/workqueue.rst.
  *
- * The __lock_name macro dance is to guarantee that single lock_class_key
- * doesn't end up with different namesm, which isn't allowed by lockdep.
- *
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
-#ifdef CONFIG_LOCKDEP
-#define alloc_workqueue(fmt, flags, max_active, args...)		\
-({									\
-	static struct lock_class_key __key;				\
-	const char *__lock_name;					\
-									\
-	__lock_name = "(wq_completion)"#fmt#args;			\
-									\
-	__alloc_workqueue_key((fmt), (flags), (max_active),		\
-			      &__key, __lock_name, ##args);		\
-})
-#else
-#define alloc_workqueue(fmt, flags, max_active, args...)		\
-	__alloc_workqueue_key((fmt), (flags), (max_active),		\
-			      NULL, NULL, ##args)
-#endif
+struct workqueue_struct *alloc_workqueue(const char *fmt,
+					 unsigned int flags,
+					 int max_active, ...);
 
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fc5d23d752a5..e163e7a7f5e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -259,6 +259,8 @@ struct workqueue_struct {
 	struct wq_device	*wq_dev;	/* I: for sysfs interface */
 #endif
 #ifdef CONFIG_LOCKDEP
+	char			*lock_name;
+	struct lock_class_key	key;
 	struct lockdep_map	lockdep_map;
 #endif
 	char			name[WQ_NAME_LEN]; /* I: workqueue name */
@@ -3337,11 +3339,49 @@ static int init_worker_pool(struct worker_pool *pool)
 	return 0;
 }
 
+#ifdef CONFIG_LOCKDEP
+static void wq_init_lockdep(struct workqueue_struct *wq)
+{
+	char *lock_name;
+
+	lockdep_register_key(&wq->key);
+	lock_name = kasprintf(GFP_KERNEL, "%s%s", "(wq_completion)", wq->name);
+	if (!lock_name)
+		lock_name = wq->name;
+	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
+}
+
+static void wq_unregister_lockdep(struct workqueue_struct *wq)
+{
+	lockdep_unregister_key(&wq->key);
+}
+
+static void wq_free_lockdep(struct workqueue_struct *wq)
+{
+	if (wq->lock_name != wq->name)
+		kfree(wq->lock_name);
+}
+#else
+static void wq_init_lockdep(struct workqueue_struct *wq)
+{
+}
+
+static void wq_unregister_lockdep(struct workqueue_struct *wq)
+{
+}
+
+static void wq_free_lockdep(struct workqueue_struct *wq)
+{
+}
+#endif
+
 static void rcu_free_wq(struct rcu_head *rcu)
 {
 	struct workqueue_struct *wq =
 		container_of(rcu, struct workqueue_struct, rcu);
 
+	wq_free_lockdep(wq);
+
 	if (!(wq->flags & WQ_UNBOUND))
 		free_percpu(wq->cpu_pwqs);
 	else
@@ -3532,8 +3572,10 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
 	 * If we're the last pwq going away, @wq is already dead and no one
 	 * is gonna access it anymore.  Schedule RCU free.
 	 */
-	if (is_last)
+	if (is_last) {
+		wq_unregister_lockdep(wq);
 		call_rcu(&wq->rcu, rcu_free_wq);
+	}
 }
 
 /**
@@ -4067,11 +4109,9 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
-struct workqueue_struct *__alloc_workqueue_key(const char *fmt,
-					       unsigned int flags,
-					       int max_active,
-					       struct lock_class_key *key,
-					       const char *lock_name, ...)
+struct workqueue_struct *alloc_workqueue(const char *fmt,
+					 unsigned int flags,
+					 int max_active, ...)
 {
 	size_t tbl_size = 0;
 	va_list args;
@@ -4106,7 +4146,7 @@ struct workqueue_struct *__alloc_workqueue_key(const char *fmt,
 			goto err_free_wq;
 	}
 
-	va_start(args, lock_name);
+	va_start(args, max_active);
 	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
@@ -4123,7 +4163,7 @@ struct workqueue_struct *__alloc_workqueue_key(const char *fmt,
 	INIT_LIST_HEAD(&wq->flusher_overflow);
 	INIT_LIST_HEAD(&wq->maydays);
 
-	lockdep_init_map(&wq->lockdep_map, lock_name, key, 0);
+	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
 	if (alloc_and_link_pwqs(wq) < 0)
@@ -4161,7 +4201,7 @@ struct workqueue_struct *__alloc_workqueue_key(const char *fmt,
 	destroy_workqueue(wq);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(__alloc_workqueue_key);
+EXPORT_SYMBOL_GPL(alloc_workqueue);
 
 /**
  * destroy_workqueue - safely terminate a workqueue
@@ -4214,6 +4254,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 		kthread_stop(wq->rescuer->task);
 
 	if (!(wq->flags & WQ_UNBOUND)) {
+		wq_unregister_lockdep(wq);
 		/*
 		 * The base ref is never dropped on per-cpu pwqs.  Directly
 		 * schedule RCU free.
-- 
2.21.0.rc0.258.g878e2cd30e-goog

