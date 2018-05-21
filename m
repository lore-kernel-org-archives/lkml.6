Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr2+YFWwvPW6rYuQNPNGy+xj3y0TruFiENoYvZjCXPt9UkuC3xxCN2xaw3uOPyfVRDof6Eg
ARC-Seal: i=1; a=rsa-sha256; t=1526937929; cv=none;
        d=google.com; s=arc-20160816;
        b=wsGgzvGAJhtIOvHGmZo6UGmS6jM8P8UDMbTGdKB6HTlmPTSCR7ITFT0yzGbRsepXjm
         xXYK8omGJ1YhZii4dWqtSFIHL/4ygp1fRN95Z+rREBtS/jJ8Uo98N6WL2kZIJQZWJ8D1
         9ZCKQqdCDrqMLtPpOi1WpcDd+8ulK8yloZS+4IUQTJ2qSMstSLZCx/iuHt3BC/6hq7LK
         aHe/46FRn2ckidR+ji8GKwgg5nY3PIdoAovmlEcR3XGrb3kFTNjFuoOr9+/l5lG+CKv0
         c1PG1RFG4YS1MqZXgu52pyboEYMI7W6TsoJNRMJiWTxy4VO0zIPRrxJiyxDx5fZM8OAY
         jGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hJs9aYnYwGuDTxPyxAjM/Ntkwj7c5/i6QhWleA8tQx4=;
        b=TLfBca1fCWPJ07vq6IZI6/1XphAGqH2h+ZPrLd4WwGS5Zz3ir3aFdRROuhXHX/e5d7
         g6sp6Ly1s7D1VlyuXu9mLjo7TPE9AZhhO4dP0bsZENiSYpvBbXpfEgMM0Wlx3OVt237T
         OMlriw+gi9x7WVC/JxhNmffnsPRrQM9bQTtLqu7G+/IXPF4XK8D/0+/zQ+MeG2WAZHUK
         6/AA/sOvKzbvu/FCc1yTqhLT7cts4Wzl1sfsQIJ1cqmB/sFfF6FR8nCQG7B7lKXQuBGD
         kkHkXF4gPc5XzcqX2RqRnzN7S+L5kV/ExQ5ET7rYd5dRCbHU0SjjdIcBQg+ALSGqjozS
         A5mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rm+vBqV2;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rm+vBqV2;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 078/110] nospec: Allow getting/setting on non-current task
Date: Mon, 21 May 2018 23:12:15 +0200
Message-Id: <20180521210512.997790253@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109953344318245?=
X-GMAIL-MSGID: =?utf-8?q?1601110466472310211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 7bbf1373e228840bb0295a2ca26d548ef37f448e upstream

Adjust arch_prctl_get/set_spec_ctrl() to operate on tasks other than
current.

This is needed both for /proc/$pid/status queries and for seccomp (since
thread-syncing can trigger seccomp in non-current threads).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   27 ++++++++++++++++-----------
 include/linux/nospec.h     |    7 +++++--
 kernel/sys.c               |    9 +++++----
 3 files changed, 26 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -530,31 +530,35 @@ static void ssb_select_mitigation()
 
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
@@ -564,24 +568,25 @@ static int ssb_prctl_get(void)
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
@@ -2192,12 +2192,13 @@ static int propagate_has_child_subreaper
 	return 1;
 }
 
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
@@ -2413,12 +2414,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
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
