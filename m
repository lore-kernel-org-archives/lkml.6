Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqSA5OldMJ4hqcE7hN2HJB0ELaQurDANK5ktD94bS+i4xo8Nc3SBelWrI8cazbI21eqTnv8
ARC-Seal: i=1; a=rsa-sha256; t=1526937381; cv=none;
        d=google.com; s=arc-20160816;
        b=vGDox9rcxa7KnoizeSpcXtObPld0q3KtbCKyLQGGQaCjht03b0phT7AZ7WC5X+o3zB
         ak3U4rGm7i9yvf7zDQeIjFGZhZiBHqKSO/q0lcPAZBAiuU1UpFhGnA3+jIF+Ta3GSy0Q
         8dtaho29S3H8z9tRMduPakrEzMWw1256oT49k8/vLUYCY4AqPb2Zh+kOxTfvASg10o8T
         8oaOjdWGfiKsAB7sGs/jNIlESM7d4S9ril3LPhzM81AuT4SFVSz5cDuXYHnGqIwSt0n5
         5HdKh6eteSM57s6wE754uZm2tnofKZwpa/eDoYuykQ4Zb2QkSe3WQw/D6Bxz2zWg2FLt
         h9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Jnx/5BS4yuM1GMDKUwyxiEGlGdSZIVs+iUpqvo2+2QA=;
        b=LnpAZI1v+Rjht/0g1zwiWvXwU7ckBWI21rx+RKngIPOVrmacHiF0old9LiL6J0E0Ht
         inFPydNFNl2eDoQfLJ6P2XmM3+UfXCpLTMlZHSq/ihIIq/mMaQZnKW9FpYQI44W5Rl2x
         7pUb2gKxekazhJ0h3k9NmXIM7XEIgBHDD/ExcWVYYjz4BSIRiAUNXsrE+CcwL/scO6tT
         mvt7fNa8z+N/BT7lei7sp3xecY7eWV0e6QM9vDOcQbWpFx4GLaA+JYFlCNj0XVW7Cw78
         ml4JQa+9m+Z43jsWPJBvy01/4gRWaXHrOxmMo96O4tNm5QovlDLTOwYOOJibDDBB1i6G
         xlMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2FHxxIKf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2FHxxIKf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 62/87] seccomp: Move speculation migitation control to arch code
Date: Mon, 21 May 2018 23:11:38 +0200
Message-Id: <20180521210425.692595297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109891840824631?=
X-GMAIL-MSGID: =?utf-8?q?1601109891840824631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 8bf37d8c067bb7eb8e7c381bdadf9bd89182b6bc upstream

The migitation control is simpler to implement in architecture code as it
avoids the extra function call to check the mode. Aside of that having an
explicit seccomp enabled mode in the architecture mitigations would require
even more workarounds.

Move it into architecture code and provide a weak function in the seccomp
code. Remove the 'which' argument as this allows the architecture to decide
which mitigations are relevant for seccomp.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   29 ++++++++++++++++++-----------
 include/linux/nospec.h     |    2 ++
 kernel/seccomp.c           |   15 ++-------------
 3 files changed, 22 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -568,6 +568,24 @@ static int ssb_prctl_set(struct task_str
 	return 0;
 }
 
+int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
+			     unsigned long ctrl)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_set(task, ctrl);
+	default:
+		return -ENODEV;
+	}
+}
+
+#ifdef CONFIG_SECCOMP
+void arch_seccomp_spec_mitigate(struct task_struct *task)
+{
+	ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+}
+#endif
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -586,17 +604,6 @@ static int ssb_prctl_get(struct task_str
 	}
 }
 
-int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
-			     unsigned long ctrl)
-{
-	switch (which) {
-	case PR_SPEC_STORE_BYPASS:
-		return ssb_prctl_set(task, ctrl);
-	default:
-		return -ENODEV;
-	}
-}
-
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 {
 	switch (which) {
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -62,5 +62,7 @@ static inline unsigned long array_index_
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which);
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl);
+/* Speculation control for seccomp enforced mitigation */
+void arch_seccomp_spec_mitigate(struct task_struct *task);
 
 #endif /* _LINUX_NOSPEC_H */
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -216,18 +216,7 @@ static inline bool seccomp_may_assign_mo
 	return true;
 }
 
-/*
- * If a given speculation mitigation is opt-in (prctl()-controlled),
- * select it, by disabling speculation (enabling mitigation).
- */
-static inline void spec_mitigate(struct task_struct *task,
-				 unsigned long which)
-{
-	int state = arch_prctl_spec_ctrl_get(task, which);
-
-	if (state > 0 && (state & PR_SPEC_PRCTL))
-		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_FORCE_DISABLE);
-}
+void __weak arch_seccomp_spec_mitigate(struct task_struct *task) { }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
 				       unsigned long seccomp_mode,
@@ -243,7 +232,7 @@ static inline void seccomp_assign_mode(s
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
-		spec_mitigate(task, PR_SPEC_STORE_BYPASS);
+		arch_seccomp_spec_mitigate(task);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
