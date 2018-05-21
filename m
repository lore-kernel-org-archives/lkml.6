Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZollT9ZCpMEfmDOouzmN6Qc8EDYw2Mosl14dS/Dr8OnORr7Wj6Okzy0z4Nc19BUiQOQDvAq
ARC-Seal: i=1; a=rsa-sha256; t=1526937634; cv=none;
        d=google.com; s=arc-20160816;
        b=Myw3oV/cL2WnEOPLLi9CSw4poh28qskwkRqwgjP2/0JEcbrkQuIbZI1x1vgqkaAOmx
         t1UZeSGcTtrU4vfbHpFU8utKr+optoWYNhB2KYVB//PZB+N/zK4jJzy/LBO+ah52b2ol
         rxL74F1rfpodyuiiXsTjqC7XzLlAvdKyTba1PNKTn2FYlY9mbrn3YkBZHue2imtC4Hr6
         Klt17UxsRropOzMfZhl7DMsCv4JwGG5aKFoYhZ7+b4dbpM+WTSF/AbRzOFUjOj3Txtx8
         NS028P97XkAJ7pLp6Mob6TkXArCLGuM6qUG/Ddt7jkNOn6vIxwAjfqsE00fLXPPzWGsJ
         B7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=z6/ZCOsMc3t/s6Pd/Z/oVEXuX9X4Dj2QxQmmp7FMPus=;
        b=g63DrPFAJsnYuiNldzKHp4k7Dn+9kTEPvaG0NcKE6jSFmJG2fbuety06MUUrmpYjyn
         Xh1ghQhU8aPL6YaCYm/JDbn9+28b90gUyMD2DHF4hSyYT8Z3mzkx+alLx27r/Uplzm9K
         Hx+CrwmED/jxbup6n9fov3ld5LP4hkcMH8+JIHWTlQy2p2Je19rm+0xAWuWjzfEEF0B1
         JU3ggQcYChBDbCePnJjX31A2OR7VZp1zDeurHnCc3BnBYWX/JjwWbF6x42H+o9JpJDAf
         2rPoLoa25OPgGQgKkXBnh5A5GXvGoj57G99wpalyqb/IUII6xsFDHH0whHERpAmv7aMY
         qPAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bsczwZei;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bsczwZei;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 64/95] nospec: Allow getting/setting on non-current task
Date: Mon, 21 May 2018 23:11:54 +0200
Message-Id: <20180521210459.518058973@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109953344318245?=
X-GMAIL-MSGID: =?utf-8?q?1601110157380290355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2186,12 +2186,13 @@ static int propagate_has_child_subreaper
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
@@ -2401,12 +2402,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
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
