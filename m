Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpS3aaQY0b39LZFjMb3NLOWPJK3ja7gaJTJJ2Zqtb8GOpja6Dsg15grmAwupeDxMXiDV0gn
ARC-Seal: i=1; a=rsa-sha256; t=1526937722; cv=none;
        d=google.com; s=arc-20160816;
        b=dQNT878jqTCgAJSNyH32BCE07V+3t2U+wWqRcceVuoDJkunB51gwd93C54EAsJ5mlm
         +bfcVa4BzUcp8ESGlT2FEMtNtmtzZaezHf4sBwtBzuJHrCa19A5WWrEf/Dmf6U3ydFmF
         1ViOQCPUt0BZNgMVg9v/sANBnZc/OmDnvPGb1k6Vm5POmZtyKa9E0StoBue2avLjBw7/
         FumGMPHQrhsmB9AQJ5KwKFouFf0KcAW15OrNzGt41jOG4bkp/O6o/pGyYpeAPptLgOCY
         exbXxQFaHs9urkwu9dy65nwPZiWk5SDOcJMcu+043W2tvWzaYECPeCJGTqKyP7Acleae
         4Phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Ssj04J1cp1RtBGrt9whaGThgx22Lvv+tW+qj/7Ih1Yc=;
        b=nMvxBRroek5u7WNUqyh+heVfHoGfdqfsSBdZftdjEpz43s6vqQ9vKg02Vzsk6/i2tx
         cecE0YkT33/NntFL4pB5SYuAAgcr4AtjWeZLpa+zaYA0zrkuAYQ1MFxartpVVF6wJAcH
         EwZ7XUt8WQTDiwS2sCuQrsEfINf709xcUKSZS9QWiQPE+z7SQtkmbonAmKKydgCdwZnX
         ZQxWYq87dj0jVryoU+ZUFPDbTxj84N8pWofTqxoowHcdxDJBR5hJuQo2ffnfdd4xGSsf
         Y83mzRUthkYeS2JElV4mwgY+3hRAJp1ExA0ZkuDQm+HkU4i2kF052/0kIkCLLtp05kep
         fDJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SFbFa8jq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SFbFa8jq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 70/95] seccomp: Add filter flag to opt-out of SSB mitigation
Date: Mon, 21 May 2018 23:12:00 +0200
Message-Id: <20180521210500.495328874@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109987144420611?=
X-GMAIL-MSGID: =?utf-8?q?1601110248999324414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
 #ifndef seccomp
@@ -2063,14 +2067,26 @@ TEST(seccomp_syscall_mode_lock)
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
