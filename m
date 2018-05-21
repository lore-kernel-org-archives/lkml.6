Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrAWuGfSYeCrbclOG9gOya45wwqNr/C00WPxjDaKaorl416wv36T1h6mpbIR+RU74VEgsco
ARC-Seal: i=1; a=rsa-sha256; t=1526937472; cv=none;
        d=google.com; s=arc-20160816;
        b=b2QHJYJnU+rgf1iShMeDCrnh/Q2XgI9M5y75EyBKjYZsCZQYUAAJ8UQp/e907UePnB
         RxDl7IzL8cIQ7WG+fYCZLixGPRXp/rgodLuFsZ9xoI/nbSEO1feHSYRlD7H8VBDLAGC4
         GCxoUOlbI0dNeWykWVooNEbZKiIRVy4cRFx6rghGqk5ob5jfIDkT3EH+BT59XSitdDn7
         XXgqlFW203M3NEp8N3WmFKFF3KYYN6AgvUAewei2ZHtoSIPNx+U48Qo4ynggdaHoTdHR
         bpZiqSSo9pUW85/20o05CMTiyYEw+b0fNrfa7gME3axWFsLguHyKo8lAFexFwsQQUYmJ
         rHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=yIw/I0jh8KF5PYidftSVZJmva1ZrgTZPRO0dfbO79lc=;
        b=Wc4fqABlO/aN7jVvKJAFUkkgkpf0wbeouOcvi7/A1UiiK4gr/vK3rbvkRc90Drgix0
         3ZqrjqC77DxmzJUWUOVYNKQS+M5klj9w/h16CZJJMgX+h0/9vAfF/DeMMz07lZyvYGHG
         KKP4z7SbQ2w90Y+KhsEycD0OsLpcm2ZCtWSgjwmQ3zJw/FeCdtcwiC2/QmagK0OhJjgm
         xRWtHuyyPPySMb/JUad6yB3/RH93wUYCjRqxtdZspuabFh3A5irwwjI6M15UWWV1xUUB
         XXRv2oeZ8WhEeSYg+zTtUnyPECOcXUuVapeKVvQ4aVYaAvthEMx1Z5+yFiujE+ouMigq
         +spA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wiyP0FYc;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wiyP0FYc;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 61/87] seccomp: Add filter flag to opt-out of SSB mitigation
Date: Mon, 21 May 2018 23:11:37 +0200
Message-Id: <20180521210425.604678841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109987144420611?=
X-GMAIL-MSGID: =?utf-8?q?1601109987144420611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -729,7 +732,7 @@ static long seccomp_set_mode_strict(void
 #ifdef TIF_NOTSC
 	disable_TSC();
 #endif
-	seccomp_assign_mode(current, seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode, 0);
 	ret = 0;
 
 out:
@@ -787,7 +790,7 @@ static long seccomp_set_mode_filter(unsi
 	/* Do not free the successfully attached filter. */
 	prepared = NULL;
 
-	seccomp_assign_mode(current, seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode, flags);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1692,7 +1692,11 @@ TEST_F_SIGNAL(TRACE_syscall, kill_after_
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
@@ -1791,6 +1795,78 @@ TEST(seccomp_syscall_mode_lock)
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
