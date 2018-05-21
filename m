Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpQFijGfuIC5WKn5d4NpqJRga817L/9b2xuDsSjMcCYI3dqVpiQDWqzv+JKzn0mDJi3etNA
ARC-Seal: i=1; a=rsa-sha256; t=1526937439; cv=none;
        d=google.com; s=arc-20160816;
        b=At92/ND/5u5XJyBBa+Ebb4WI1z1uAt+V3OdxtFtWLDfeo85wvT6PePu6I2u+7Bym9Q
         t7MZ5O+fG6V1BL1L5krlkikldN8YkKQfpHfgDlz6O8f6D1ddZn1sn1NUm6DOIeDb40cO
         Xewwut+pMFe47JEqYBdBGwHojJUiupI48P6PPJw5suGOZ+8j+JNX70pq2Ji2yHxsLV/p
         C3FnAIB3Z0RJrY/MYBoP2RKz9Cs6Pcfo2W7w4sYQ74U+3oh9kxAv5arIrPwnMIppC4A/
         tqXCRPf/A2IEKLk9Bl4mITUsvPXFL+yOs++5LAsX2cBXw4+WYT6nTPi48nUFs5HTrRVi
         ajYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LVQi3RRZspJIXOrGmwkWqyPpH2vNZnlPitghK5hHp8Y=;
        b=Bpb4qwwkAPD9dLjMDzs6doppPGchYvfcibE8S3tTIReDWEG+SPgrM0mxB9RSLO3Iep
         dCXPxz9g0RcJR07Vpm3vbycPUhhuOvy58lkYRvHvgKw4L3JboXdi56hxvFimRlOoDVZ8
         TRTYfn1rnkxhSBo7A7qaAsHIBPoSVCwtLmrvRdwo1QEnoJEyLYVTYq1ZVktepAX8BvJd
         14PV6d9SCFRHcFsyokH39ynWoNuuctCx7kPlzkRjruH2uz3xHQvqnvtK1JVRxHROPCHM
         EgTquLEJFAmmqnNh3Y7X8/cFwuNzTvzqxJWNQmh1772QcT0xgR9JuPfYj0GTcFOgsc4c
         C34Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BAuNH46P;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BAuNH46P;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 55/87] nospec: Allow getting/setting on non-current task
Date: Mon, 21 May 2018 23:11:31 +0200
Message-Id: <20180521210425.207854939@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109953344318245?=
X-GMAIL-MSGID: =?utf-8?q?1601109953344318245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 7bbf1373e228840bb0295a2ca26d548ef37f448e upstream

Adjust arch_prctl_get/set_spec_ctrl() to operate on tasks other than
current.

This is needed both for /proc/$pid/status queries and for seccomp (since
thread-syncing can trigger seccomp in non-current threads).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   27 ++++++++++++++++-----------
 include/linux/nospec.h     |    7 +++++--
 kernel/sys.c               |    9 +++++----
 3 files changed, 26 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -529,31 +529,35 @@ static void ssb_select_mitigation()
 
 #undef pr_fmt
 
-static int ssb_prctl_set(unsigned long ctrl)
+static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
-	bool rds = !!test_tsk_thread_flag(current, TIF_RDS);
+	bool rds = !!test_tsk_thread_flag(task, TIF_RDS);
 
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
 		return -ENXIO;
 
 	if (ctrl == PR_SPEC_ENABLE)
-		clear_tsk_thread_flag(current, TIF_RDS);
+		clear_tsk_thread_flag(task, TIF_RDS);
 	else
-		set_tsk_thread_flag(current, TIF_RDS);
+		set_tsk_thread_flag(task, TIF_RDS);
 
-	if (rds != !!test_tsk_thread_flag(current, TIF_RDS))
+	/*
+	 * If being set on non-current task, delay setting the CPU
+	 * mitigation until it is next scheduled.
+	 */
+	if (task == current && rds != !!test_tsk_thread_flag(task, TIF_RDS))
 		speculative_store_bypass_update();
 
 	return 0;
 }
 
-static int ssb_prctl_get(void)
+static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_PRCTL:
-		if (test_tsk_thread_flag(current, TIF_RDS))
+		if (test_tsk_thread_flag(task, TIF_RDS))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
 	default:
@@ -563,24 +567,25 @@ static int ssb_prctl_get(void)
 	}
 }
 
-int arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl)
+int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
+			     unsigned long ctrl)
 {
 	if (ctrl != PR_SPEC_ENABLE && ctrl != PR_SPEC_DISABLE)
 		return -ERANGE;
 
 	switch (which) {
 	case PR_SPEC_STORE_BYPASS:
-		return ssb_prctl_set(ctrl);
+		return ssb_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
 }
 
-int arch_prctl_spec_ctrl_get(unsigned long which)
+int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 {
 	switch (which) {
 	case PR_SPEC_STORE_BYPASS:
-		return ssb_prctl_get();
+		return ssb_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -7,6 +7,8 @@
 #define _LINUX_NOSPEC_H
 #include <asm/barrier.h>
 
+struct task_struct;
+
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
  * @index: array element index
@@ -57,7 +59,8 @@ static inline unsigned long array_index_
 })
 
 /* Speculation control prctl */
-int arch_prctl_spec_ctrl_get(unsigned long which);
-int arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl);
+int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which);
+int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
+			     unsigned long ctrl);
 
 #endif /* _LINUX_NOSPEC_H */
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2074,12 +2074,13 @@ static int prctl_get_tid_address(struct
 }
 #endif
 
-int __weak arch_prctl_spec_ctrl_get(unsigned long which)
+int __weak arch_prctl_spec_ctrl_get(struct task_struct *t, unsigned long which)
 {
 	return -EINVAL;
 }
 
-int __weak arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl)
+int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
+				    unsigned long ctrl)
 {
 	return -EINVAL;
 }
@@ -2285,12 +2286,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_GET_SPECULATION_CTRL:
 		if (arg3 || arg4 || arg5)
 			return -EINVAL;
-		error = arch_prctl_spec_ctrl_get(arg2);
+		error = arch_prctl_spec_ctrl_get(me, arg2);
 		break;
 	case PR_SET_SPECULATION_CTRL:
 		if (arg4 || arg5)
 			return -EINVAL;
-		error = arch_prctl_spec_ctrl_set(arg2, arg3);
+		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
 		break;
 	default:
 		error = -EINVAL;
