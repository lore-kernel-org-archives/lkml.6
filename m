Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E692C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6EE20895
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6EE20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeI3Ebq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:31:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51535 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbeI3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000H9-Pq; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006qD-K5; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.488254518@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 017/131] nospec: Allow getting/setting on non-current
 task
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 7bbf1373e228840bb0295a2ca26d548ef37f448e upstream.

Adjust arch_prctl_get/set_spec_ctrl() to operate on tasks other than
current.

This is needed both for /proc/$pid/status queries and for seccomp (since
thread-syncing can trigger seccomp in non-current threads).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 27 ++++++++++++++++-----------
 include/linux/nospec.h     |  7 +++++--
 kernel/sys.c               |  9 +++++----
 3 files changed, 26 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -568,31 +568,35 @@ static void ssb_select_mitigation()
 
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
@@ -602,24 +606,25 @@ static int ssb_prctl_get(void)
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
@@ -1834,12 +1834,13 @@ static int prctl_get_tid_address(struct
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
@@ -2025,12 +2026,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
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

