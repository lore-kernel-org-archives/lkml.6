Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA01C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29FD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfAON66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:58:58 -0500
Received: from foss.arm.com ([217.140.101.70]:51680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfAON6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:58:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975B715BF;
        Tue, 15 Jan 2019 05:58:43 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2BC53F70D;
        Tue, 15 Jan 2019 05:58:41 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 3/4] uaccess: Check no rescheduling function is called in unsafe region
Date:   Tue, 15 Jan 2019 13:58:28 +0000
Message-Id: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running a user_access regions, it is not supported to reschedule.
Add an overridable primitive to indicate whether a user_access region is
active and check that this is not the case when calling rescheduling
functions.

These checks are only performed when DEBUG_UACCESS_SLEEP is selected.

Also, add a comment clarifying the behaviour of user_access regions.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
 include/linux/kernel.h  | 11 +++++++++--
 include/linux/uaccess.h | 13 +++++++++++++
 kernel/sched/core.c     | 22 ++++++++++++++++++++++
 lib/Kconfig.debug       |  8 ++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e..73f1f82 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -237,11 +237,18 @@
 struct pt_regs;
 struct user;

+#ifdef CONFIG_DEBUG_UACCESS_SLEEP
+extern void __might_resched(const char *file, int line);
+#else
+#define __might_resched(file, line) do { } while (0)
+#endif
+
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
index 37b226e..2c0c39e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -263,6 +263,15 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))

+/*
+ * user_access_begin() and user_access_end() define a region where
+ * unsafe user accessors can be used. Exceptions and interrupt shall exit the
+ * user_access region and re-enter it when returning to the interrupted context.
+ *
+ * No sleeping function should get called during a user_access region - we rely
+ * on exception handling to take care of the user_access status for us, but that
+ * doesn't happen when directly calling schedule().
+ */
 #ifndef user_access_begin
 #define user_access_begin(ptr,len) access_ok(ptr, len)
 #define user_access_end() do { } while (0)
@@ -270,6 +279,10 @@ static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
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
index a674c7db..b1bb7e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
 		__schedule_bug(prev);
 		preempt_count_set(PREEMPT_DISABLED);
 	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
+	    unlikely(unsafe_user_region_active())) {
+		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
+		       prev->comm, prev->pid, preempt_count());
+		dump_stack();
+	}
+
 	rcu_sleep_check();

 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
@@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 EXPORT_SYMBOL(___might_sleep);
 #endif

+#ifdef CONFIG_DEBUG_UACCESS_SLEEP
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
+#endif
+
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b2..d030e31 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2069,6 +2069,14 @@ config IO_STRICT_DEVMEM

 	  If in doubt, say Y.

+config DEBUG_UACCESS_SLEEP
+	bool "Check sleep inside a user access region"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, various routines which may sleep will become very
+	  noisy if they are called inside a user access region (i.e. between
+	  a user_access_begin() and a user_access_end())
+
 source "arch/$(SRCARCH)/Kconfig.debug"

 endmenu # Kernel hacking
--
1.9.1
