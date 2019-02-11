Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9522AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5A21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbfBKR77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:59:59 -0500
Received: from foss.arm.com ([217.140.101.70]:55062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbfBKR7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:59:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED88EBD;
        Mon, 11 Feb 2019 09:59:45 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 992703F675;
        Mon, 11 Feb 2019 09:59:43 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 2/4] mm: Expose user stack pointer checking via prctl()
Date:   Mon, 11 Feb 2019 17:59:33 +0000
Message-Id: <20190211175935.4602-3-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211175935.4602-1-will.deacon@arm.com>
References: <20190211175935.4602-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up a prctl() option to control the level of user stack pointer
checking for the current task. By default, no checking is performed, but
checks can be independently controlled for system calls and page faults.

The option is inherited across fork() and preserved across exec().

Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/mm.h         |  5 +++++
 include/uapi/linux/prctl.h |  5 +++++
 kernel/sys.c               |  5 +++++
 mm/memory.c                | 22 ++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9fa02d47a270..7a668447c01f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1483,8 +1483,13 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page);
 int invalidate_inode_page(struct page *page);
 
 #ifdef CONFIG_USER_STACK_POINTER_CHECKS
+long prctl_sp_check(struct task_struct *tsk, unsigned long flags);
 bool usp_check_syscall(void);
 #else
+static inline long prctl_sp_check(struct task_struct *tsk, unsigned long flags)
+{
+	return -EINVAL;
+}
 static inline bool usp_check_syscall(void) { return true; }
 #endif
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b4875a93363a..3c4d93856f2a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -228,4 +228,9 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* User stack pointer sanity checking */
+#define PR_SP_CHECK			55
+# define PR_SP_CHECK_PAGE_FAULT		(1UL << 0)
+# define PR_SP_CHECK_SYSCALL		(1UL << 1)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index f7eb62eceb24..bd507eebed54 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2485,6 +2485,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_SP_CHECK:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = prctl_sp_check(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/mm/memory.c b/mm/memory.c
index e0b449f520da..700d9fd03c88 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/dax.h>
 #include <linux/oom.h>
+#include <linux/prctl.h>
 
 #include <asm/io.h>
 #include <asm/mmu_context.h>
@@ -3949,6 +3950,27 @@ bool usp_check_syscall(void)
 	up_read(&mm->mmap_sem);
 	return ret;
 }
+
+long prctl_sp_check(struct task_struct *tsk, unsigned long flags)
+{
+	if (flags & ~(PR_SP_CHECK_PAGE_FAULT | PR_SP_CHECK_SYSCALL))
+		return -EINVAL;
+
+	if (flags & PR_SP_CHECK_PAGE_FAULT)
+		tsk->usp_checks |= USP_CHECK_FAULT;
+	else
+		tsk->usp_checks &= ~USP_CHECK_FAULT;
+
+	if (flags & PR_SP_CHECK_SYSCALL) {
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_USP_CHECK_SYSCALL))
+			return -EINVAL;
+		tsk->usp_checks |= USP_CHECK_SYSCALL;
+	} else {
+		tsk->usp_checks &= ~USP_CHECK_SYSCALL;
+	}
+
+	return 0;
+}
 #else
 static bool usp_check_fault(unsigned int flags) { return true; }
 #endif
-- 
2.11.0

