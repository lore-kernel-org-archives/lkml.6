Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3FFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ACC20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68ACC20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbeGWNw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:52:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388391AbeGWNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:52 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6C14CB7;
        Mon, 23 Jul 2018 12:45:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 073/107] seccomp: Add filter flag to opt-out of SSB mitigation
Date:   Mon, 23 Jul 2018 14:42:07 +0200
Message-Id: <20180723122417.054322782@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 00a02d0c502a06d15e07b857f8ff921e3e402675 upstream

If a seccomp user is not interested in Speculative Store Bypass mitigation
by default, it can set the new SECCOMP_FILTER_FLAG_SPEC_ALLOW flag when
adding filters.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 include/linux/seccomp.h                       |    3 -
 include/uapi/linux/seccomp.h                  |    4 +
 kernel/seccomp.c                              |   19 +++---
 tools/testing/selftests/seccomp/seccomp_bpf.c |   78 +++++++++++++++++++++++++-
 4 files changed, 93 insertions(+), 11 deletions(-)

--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -3,7 +3,8 @@
 
 #include <uapi/linux/seccomp.h>
 
-#define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC)
+#define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC	| \
+					 SECCOMP_FILTER_FLAG_SPEC_ALLOW)
 
 #ifdef CONFIG_SECCOMP
 
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -15,7 +15,9 @@
 #define SECCOMP_SET_MODE_FILTER	1
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
-#define SECCOMP_FILTER_FLAG_TSYNC	1
+#define SECCOMP_FILTER_FLAG_TSYNC	(1UL << 0)
+/* In v4.14+ SECCOMP_FILTER_FLAG_LOG is (1UL << 1) */
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW	(1UL << 2)
 
 /*
  * All BPF programs must return a 32-bit value.
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -230,7 +230,8 @@ static inline void spec_mitigate(struct
 }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
-				       unsigned long seccomp_mode)
+				       unsigned long seccomp_mode,
+				       unsigned long flags)
 {
 	assert_spin_locked(&task->sighand->siglock);
 
@@ -240,8 +241,9 @@ static inline void seccomp_assign_mode(s
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
-	/* Assume seccomp processes want speculation flaw mitigation. */
-	spec_mitigate(task, PR_SPEC_STORE_BYPASS);
+	/* Assume default seccomp processes want spec flaw mitigation. */
+	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
+		spec_mitigate(task, PR_SPEC_STORE_BYPASS);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
@@ -309,7 +311,7 @@ static inline pid_t seccomp_can_sync_thr
  * without dropping the locks.
  *
  */
-static inline void seccomp_sync_threads(void)
+static inline void seccomp_sync_threads(unsigned long flags)
 {
 	struct task_struct *thread, *caller;
 
@@ -350,7 +352,8 @@ static inline void seccomp_sync_threads(
 		 * allow one thread to transition the other.
 		 */
 		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED)
-			seccomp_assign_mode(thread, SECCOMP_MODE_FILTER);
+			seccomp_assign_mode(thread, SECCOMP_MODE_FILTER,
+					    flags);
 	}
 }
 
@@ -469,7 +472,7 @@ static long seccomp_attach_filter(unsign
 
 	/* Now that the new filter is in place, synchronize to all threads. */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
-		seccomp_sync_threads();
+		seccomp_sync_threads(flags);
 
 	return 0;
 }
@@ -764,7 +767,7 @@ static long seccomp_set_mode_strict(void
 #ifdef TIF_NOTSC
 	disable_TSC();
 #endif
-	seccomp_assign_mode(current, seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode, 0);
 	ret = 0;
 
 out:
@@ -822,7 +825,7 @@ static long seccomp_set_mode_filter(unsi
 	/* Do not free the successfully attached filter. */
 	prepared = NULL;
 
-	seccomp_assign_mode(current, seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode, flags);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1477,7 +1477,11 @@ TEST_F(TRACE_syscall, syscall_dropped)
 #endif
 
 #ifndef SECCOMP_FILTER_FLAG_TSYNC
-#define SECCOMP_FILTER_FLAG_TSYNC 1
+#define SECCOMP_FILTER_FLAG_TSYNC (1UL << 0)
+#endif
+
+#ifndef SECCOMP_FILTER_FLAG_SPEC_ALLOW
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW (1UL << 2)
 #endif
 
 #ifndef seccomp
@@ -1576,6 +1580,78 @@ TEST(seccomp_syscall_mode_lock)
 	}
 }
 
+/*
+ * Test detection of known and unknown filter flags. Userspace needs to be able
+ * to check if a filter flag is supported by the current kernel and a good way
+ * of doing that is by attempting to enter filter mode, with the flag bit in
+ * question set, and a NULL pointer for the _args_ parameter. EFAULT indicates
+ * that the flag is valid and EINVAL indicates that the flag is invalid.
+ */
+TEST(detect_seccomp_filter_flags)
+{
+	unsigned int flags[] = { SECCOMP_FILTER_FLAG_TSYNC,
+				 SECCOMP_FILTER_FLAG_SPEC_ALLOW };
+	unsigned int flag, all_flags;
+	int i;
+	long ret;
+
+	/* Test detection of known-good filter flags */
+	for (i = 0, all_flags = 0; i < ARRAY_SIZE(flags); i++) {
+		int bits = 0;
+
+		flag = flags[i];
+		/* Make sure the flag is a single bit! */
+		while (flag) {
+			if (flag & 0x1)
+				bits ++;
+			flag >>= 1;
+		}
+		ASSERT_EQ(1, bits);
+		flag = flags[i];
+
+		ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
+		ASSERT_NE(ENOSYS, errno) {
+			TH_LOG("Kernel does not support seccomp syscall!");
+		}
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EFAULT, errno) {
+			TH_LOG("Failed to detect that a known-good filter flag (0x%X) is supported!",
+			       flag);
+		}
+
+		all_flags |= flag;
+	}
+
+	/* Test detection of all known-good filter flags */
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, all_flags, NULL);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EFAULT, errno) {
+		TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
+		       all_flags);
+	}
+
+	/* Test detection of an unknown filter flag */
+	flag = -1;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno) {
+		TH_LOG("Failed to detect that an unknown filter flag (0x%X) is unsupported!",
+		       flag);
+	}
+
+	/*
+	 * Test detection of an unknown filter flag that may simply need to be
+	 * added to this test
+	 */
+	flag = flags[ARRAY_SIZE(flags) - 1] << 1;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno) {
+		TH_LOG("Failed to detect that an unknown filter flag (0x%X) is unsupported! Does a new flag need to be added to this test?",
+		       flag);
+	}
+}
+
 TEST(TSYNC_first)
 {
 	struct sock_filter filter[] = {


