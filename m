Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC66BC65BB0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C1120878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C1120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeLCN4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:56:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37850 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCN4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:56:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95820168F;
        Mon,  3 Dec 2018 05:55:27 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E42523F614;
        Mon,  3 Dec 2018 05:55:25 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [RFC PATCH v2 1/2] uaccess: Check no rescheduling function is called in unsafe region
Date:   Mon,  3 Dec 2018 13:55:17 +0000
Message-Id: <1543845318-24543-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running a user_access regions, it is not supported to reschedule.
Add an overridable primitive to indicate whether a user_access region is
active and check that this is not the case when calling rescheduling
functions.

Also, add a comment clarifying the behaviour of user_access regions.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 include/linux/kernel.h  |  6 ++++--
 include/linux/uaccess.h | 11 +++++++++++
 kernel/sched/core.c     | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

I'm not sure these are the best locations to check this but I was hoping
this patch could start the discussion.

Should I move the check? Should I add a config option to conditionally
build those checks?

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75..fe0e984 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -237,11 +237,13 @@
 struct pt_regs;
 struct user;

+extern void __might_resched(const char *file, int line);
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int _cond_resched(void);
-# define might_resched() _cond_resched()
+# define might_resched() \
+	do { __might_resched(__FILE__, __LINE__); _cond_resched(); } while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() __might_resched(__FILE__, __LINE__)
 #endif

 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1..50adb84 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -266,6 +266,13 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))

+/*
+ * user_access_begin() and user_access_end() define a region where
+ * unsafe user accessors can be used.
+ * During execution of this region, no sleeping functions should be called.
+ * Exceptions and interrupt shall exit the user_access region and re-enter it
+ * when returning to the interrupted context.
+ */
 #ifndef user_access_begin
 #define user_access_begin() do { } while (0)
 #define user_access_end() do { } while (0)
@@ -273,6 +280,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
 #endif

+#ifndef unsafe_user_region_active
+#define unsafe_user_region_active()	false
+#endif
+
 #ifdef CONFIG_HARDENED_USERCOPY
 void usercopy_warn(const char *name, const char *detail, bool to_user,
 		   unsigned long offset, unsigned long len);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fedf3a..03f53c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3289,6 +3289,13 @@ static inline void schedule_debug(struct task_struct *prev)
 		__schedule_bug(prev);
 		preempt_count_set(PREEMPT_DISABLED);
 	}
+
+	if (unlikely(unsafe_user_region_active())) {
+		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
+		       prev->comm, prev->pid, preempt_count());
+		dump_stack();
+	}
+
 	rcu_sleep_check();

 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
@@ -6151,6 +6158,18 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 EXPORT_SYMBOL(___might_sleep);
 #endif

+void __might_resched(const char *file, int line)
+{
+	if (!unsafe_user_region_active())
+		return;
+
+	printk(KERN_ERR
+		"BUG: rescheduling function called from user access context at %s:%d\n",
+			file, line);
+	dump_stack();
+}
+EXPORT_SYMBOL(__might_resched);
+
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
--
1.9.1
