Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEC620685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEC620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbeGWNsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbeGWNsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8879BDB;
        Mon, 23 Jul 2018 12:47:27 +0000 (UTC)
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
Subject: [PATCH 4.4 068/107] nospec: Allow getting/setting on non-current task
Date:   Mon, 23 Jul 2018 14:42:02 +0200
Message-Id: <20180723122416.771611644@linuxfoundation.org>
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

commit 7bbf1373e228840bb0295a2ca26d548ef37f448e upstream

Adjust arch_prctl_get/set_spec_ctrl() to operate on tasks other than
current.

This is needed both for /proc/$pid/status queries and for seccomp (since
thread-syncing can trigger seccomp in non-current threads).

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
@@ -2075,12 +2075,13 @@ static int prctl_get_tid_address(struct
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
@@ -2282,12 +2283,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
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


