Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJtTG3pPawOdZD+9Qh7QDDhmTUtOIdVbEpC59gqulQhWdRk9cklJJlcyWdxDgYfQfFqSCO
ARC-Seal: i=1; a=rsa-sha256; t=1526937948; cv=none;
        d=google.com; s=arc-20160816;
        b=Y6u6olcTgvbEQzkRj7gtazkTlLC20dtQ2BhsbSpZgmGJGm7Q0IFcpig1qZ9EoIc99r
         FTbOVpO3wrc1pcwqL6hSIMYj3zAUB1zl4AThr46msy6PNg/WYH0rS+CxTQ1++Y3lXMAP
         90wVgoSaoSj69dvXdRYlqSQLMb2uT1WErfHjpCWCg06XM4H/dBVfCbrPAjyZIdoMR5jh
         Yx9t0qT7ERb5/7Thn7xdyXjFU0NSOrg+IpR0E27msTwqnD9tmrAIOcGBnTQC60XIYTqt
         Ez4TPPnNx2HwZaKcmXfRboJvBXPMoNe3wNJJ4OHrru/Ptf7JV4oSO/pV0k785BQRHptK
         R31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TARaxA0wN5OtZR22+GdrdfnfC+w4zfN13yZTobA0fBU=;
        b=zExAoQF2S7qrxOfAA3VCKuyq5FRXIw2WCP4nRHw6ZgKKLJMY0yGimlK6SkEWCOXwZY
         t8+Qv1r1ln9qUqJ53nn1rySkbm6iJPkdLZm1Vjr4oq0yz0lRERONxojJ9LutODUKW9aS
         6dHt/St31Fb+kc3/BC93+3MqW4+tx9gAp43gHUqTQdZnmf4Ba1/2WwyxorrNmTb/QkCK
         ih4+ZXnKdrJnMdMDU+ukLo3Y6LuWHQtijram3ncIS/NfHQWC1FJgbOoHT47s7QThR5LT
         A3L9UPjfbiDNq/Nt1pqGCgXl1Mmvg2b6+JIEpPqKg4Bfk4hdFMe6ubgUMfXW7bTLifm9
         gpAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xj4oe6Rs;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xj4oe6Rs;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 084/110] seccomp: Add filter flag to opt-out of SSB mitigation
Date: Mon, 21 May 2018 23:12:21 +0200
Message-Id: <20180521210513.633321016@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109987144420611?=
X-GMAIL-MSGID: =?utf-8?q?1601110486136692141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 00a02d0c502a06d15e07b857f8ff921e3e402675 upstream

If a seccomp user is not interested in Speculative Store Bypass mitigation
by default, it can set the new SECCOMP_FILTER_FLAG_SPEC_ALLOW flag when
adding filters.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/seccomp.h                       |    5 +++--
 include/uapi/linux/seccomp.h                  |    5 +++--
 kernel/seccomp.c                              |   19 +++++++++++--------
 tools/testing/selftests/seccomp/seccomp_bpf.c |   22 +++++++++++++++++++---
 4 files changed, 36 insertions(+), 15 deletions(-)

--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -4,8 +4,9 @@
 
 #include <uapi/linux/seccomp.h>
 
-#define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC | \
-					 SECCOMP_FILTER_FLAG_LOG)
+#define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC	| \
+					 SECCOMP_FILTER_FLAG_LOG	| \
+					 SECCOMP_FILTER_FLAG_SPEC_ALLOW)
 
 #ifdef CONFIG_SECCOMP
 
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -17,8 +17,9 @@
 #define SECCOMP_GET_ACTION_AVAIL	2
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
-#define SECCOMP_FILTER_FLAG_TSYNC	1
-#define SECCOMP_FILTER_FLAG_LOG		2
+#define SECCOMP_FILTER_FLAG_TSYNC	(1UL << 0)
+#define SECCOMP_FILTER_FLAG_LOG		(1UL << 1)
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW	(1UL << 2)
 
 /*
  * All BPF programs must return a 32-bit value.
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -243,7 +243,8 @@ static inline void spec_mitigate(struct
 }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
-				       unsigned long seccomp_mode)
+				       unsigned long seccomp_mode,
+				       unsigned long flags)
 {
 	assert_spin_locked(&task->sighand->siglock);
 
@@ -253,8 +254,9 @@ static inline void seccomp_assign_mode(s
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
 
@@ -322,7 +324,7 @@ static inline pid_t seccomp_can_sync_thr
  * without dropping the locks.
  *
  */
-static inline void seccomp_sync_threads(void)
+static inline void seccomp_sync_threads(unsigned long flags)
 {
 	struct task_struct *thread, *caller;
 
@@ -363,7 +365,8 @@ static inline void seccomp_sync_threads(
 		 * allow one thread to transition the other.
 		 */
 		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED)
-			seccomp_assign_mode(thread, SECCOMP_MODE_FILTER);
+			seccomp_assign_mode(thread, SECCOMP_MODE_FILTER,
+					    flags);
 	}
 }
 
@@ -486,7 +489,7 @@ static long seccomp_attach_filter(unsign
 
 	/* Now that the new filter is in place, synchronize to all threads. */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
-		seccomp_sync_threads();
+		seccomp_sync_threads(flags);
 
 	return 0;
 }
@@ -835,7 +838,7 @@ static long seccomp_set_mode_strict(void
 #ifdef TIF_NOTSC
 	disable_TSC();
 #endif
-	seccomp_assign_mode(current, seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode, 0);
 	ret = 0;
 
 out:
@@ -893,7 +896,7 @@ static long seccomp_set_mode_filter(unsi
 	/* Do not free the successfully attached filter. */
 	prepared = NULL;
 
-	seccomp_assign_mode(current, seccomp_mode);
+	seccomp_assign_mode(current, seccomp_mode, flags);
 out:
 	spin_unlock_irq(&current->sighand->siglock);
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -134,11 +134,15 @@ struct seccomp_data {
 #endif
 
 #ifndef SECCOMP_FILTER_FLAG_TSYNC
-#define SECCOMP_FILTER_FLAG_TSYNC 1
+#define SECCOMP_FILTER_FLAG_TSYNC (1UL << 0)
 #endif
 
 #ifndef SECCOMP_FILTER_FLAG_LOG
-#define SECCOMP_FILTER_FLAG_LOG 2
+#define SECCOMP_FILTER_FLAG_LOG (1UL << 1)
+#endif
+
+#ifndef SECCOMP_FILTER_FLAG_SPEC_ALLOW
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW (1UL << 2)
 #endif
 
 #ifndef PTRACE_SECCOMP_GET_METADATA
@@ -2072,14 +2076,26 @@ TEST(seccomp_syscall_mode_lock)
 TEST(detect_seccomp_filter_flags)
 {
 	unsigned int flags[] = { SECCOMP_FILTER_FLAG_TSYNC,
-				 SECCOMP_FILTER_FLAG_LOG };
+				 SECCOMP_FILTER_FLAG_LOG,
+				 SECCOMP_FILTER_FLAG_SPEC_ALLOW };
 	unsigned int flag, all_flags;
 	int i;
 	long ret;
 
 	/* Test detection of known-good filter flags */
 	for (i = 0, all_flags = 0; i < ARRAY_SIZE(flags); i++) {
+		int bits = 0;
+
 		flag = flags[i];
+		/* Make sure the flag is a single bit! */
+		while (flag) {
+			if (flag & 0x1)
+				bits ++;
+			flag >>= 1;
+		}
+		ASSERT_EQ(1, bits);
+		flag = flags[i];
+
 		ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
 		ASSERT_NE(ENOSYS, errno) {
 			TH_LOG("Kernel does not support seccomp syscall!");
