Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98659C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6951D20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6951D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeKYL6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 06:58:09 -0500
Received: from air.basealt.ru ([194.107.17.39]:58450 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeKYL6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 06:58:09 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id A6738589AE9; Sun, 25 Nov 2018 01:08:19 +0000 (UTC)
Received: from akathisia (broadband-46-188-15-144.2com.net [46.188.15.144])
        by air.basealt.ru (Postfix) with ESMTPSA id F3A18589AE8;
        Sun, 25 Nov 2018 01:08:17 +0000 (UTC)
Date:   Sun, 25 Nov 2018 02:08:17 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     oleg@redhat.com, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io
Subject: [PATCH v3 1/3] ptrace: pass type of a syscall-stop in
 ptrace_message
Message-ID: <20181125020817.7857cc56@akathisia>
In-Reply-To: <20181125020659.785c7b29@akathisia>
References: <20181125020659.785c7b29@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define two constants, PTRACE_EVENTMSG_SYSCALL_ENTRY and
PTRACE_EVENTMSG_SYSCALL_EXIT, and place them in ptrace_message
for the duration of syscall-stops.
This way ptracers can distinguish syscall-enter-stops
from syscall-exit-stops using PTRACE_GETEVENTMSG request.

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/linux/tracehook.h   |  9 ++++++---
 include/uapi/linux/ptrace.h | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 40b0b4c1bf7b..633a83fe7051 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -57,13 +57,15 @@ struct linux_binprm;
 /*
  * ptrace report for syscall entry and exit looks identical.
  */
-static inline int ptrace_report_syscall(struct pt_regs *regs)
+static inline int ptrace_report_syscall(struct pt_regs *regs,
+					unsigned long message)
 {
 	int ptrace = current->ptrace;
 
 	if (!(ptrace & PT_PTRACED))
 		return 0;
 
+	current->ptrace_message = message;
 	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
@@ -76,6 +78,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
 		current->exit_code = 0;
 	}
 
+	current->ptrace_message = 0;
 	return fatal_signal_pending(current);
 }
 
@@ -101,7 +104,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
 static inline __must_check int tracehook_report_syscall_entry(
 	struct pt_regs *regs)
 {
-	return ptrace_report_syscall(regs);
+	return ptrace_report_syscall(regs, PTRACE_EVENTMSG_SYSCALL_ENTRY);
 }
 
 /**
@@ -126,7 +129,7 @@ static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
 	if (step)
 		user_single_step_report(regs);
 	else
-		ptrace_report_syscall(regs);
+		ptrace_report_syscall(regs, PTRACE_EVENTMSG_SYSCALL_EXIT);
 }
 
 /**
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index d5a1b8a492b9..cb138902d042 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -104,6 +104,16 @@ struct seccomp_metadata {
 #define PTRACE_O_MASK		(\
 	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
 
+/*
+ * These values are stored in task->ptrace_message by tracehook_report_syscall_*
+ * to describe current syscall-stop.
+ *
+ * Values for these constants are chosen so that they do not appear
+ * in task->ptrace_message by other means.
+ */
+#define PTRACE_EVENTMSG_SYSCALL_ENTRY	0x80000000U
+#define PTRACE_EVENTMSG_SYSCALL_EXIT	0x90000000U
+
 #include <asm/ptrace.h>
 
 
-- 
2.19.1

