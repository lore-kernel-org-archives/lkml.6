Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C213C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC0C20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC0C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeKYL7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 06:59:25 -0500
Received: from air.basealt.ru ([194.107.17.39]:59392 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeKYL7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 06:59:24 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id 27488589AE9; Sun, 25 Nov 2018 01:09:35 +0000 (UTC)
Received: from akathisia (broadband-46-188-15-144.2com.net [46.188.15.144])
        by air.basealt.ru (Postfix) with ESMTPSA id 49FE0589AE8;
        Sun, 25 Nov 2018 01:09:33 +0000 (UTC)
Date:   Sun, 25 Nov 2018 02:09:32 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     oleg@redhat.com, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org, esyr@redhat.com,
        luto@kernel.org, strace-devel@lists.strace.io
Subject: [RFC PATCH v3 3/3] ptrace: add PTRACE_EVENT_SECCOMP support to
 PTRACE_GET_SYSCALL_INFO
Message-ID: <20181125020932.054e05a6@akathisia>
In-Reply-To: <20181125020659.785c7b29@akathisia>
References: <20181125020659.785c7b29@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend PTRACE_GET_SYSCALL_INFO to support PTRACE_EVENT_SECCOMP stops.
The information returned is the same as for syscall-enter-stops.

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/linux/ptrace.h    | 1 +
 include/linux/sched.h     | 1 +
 include/linux/tracehook.h | 1 +
 kernel/ptrace.c           | 7 +++++--
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 6c2ffed907f5..a993d0fde865 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -166,6 +166,7 @@ static inline void ptrace_event(int event, unsigned long message)
 {
 	if (unlikely(ptrace_event_enabled(current, event))) {
 		current->ptrace_message = message;
+		current->ptrace_event = event;
 		ptrace_notify((event << 8) | SIGTRAP);
 	} else if (event == PTRACE_EVENT_EXEC) {
 		/* legacy EXEC report via SIGTRAP */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c2b1a0..86215fb654d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -964,6 +964,7 @@ struct task_struct {
 
 	/* Ptrace state: */
 	unsigned long			ptrace_message;
+	int				ptrace_event;
 	kernel_siginfo_t		*last_siginfo;
 
 	struct task_io_accounting	ioac;
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 633a83fe7051..5d2e5aa07a5c 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -66,6 +66,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs,
 		return 0;
 
 	current->ptrace_message = message;
+	current->ptrace_event = 0;
 	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 92c47cd5ad84..74a37e74c7f1 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -904,7 +904,9 @@ static int ptrace_get_syscall(struct task_struct *child,
 	unsigned long actual_size;
 	unsigned long write_size;
 
-	if (child->ptrace_message == PTRACE_EVENTMSG_SYSCALL_ENTRY) {
+	if ((child->ptrace_event == 0 &&
+	     child->ptrace_message == PTRACE_EVENTMSG_SYSCALL_ENTRY) ||
+	    child->ptrace_event == PTRACE_EVENT_SECCOMP) {
 		int i;
 
 		info.op = PTRACE_SYSCALL_INFO_ENTRY;
@@ -917,7 +919,8 @@ static int ptrace_get_syscall(struct task_struct *child,
 		for (i = 0; i < ARRAY_SIZE(args); i++)
 			info.entry.args[i] = args[i];
 		actual_size = offsetofend(struct ptrace_syscall_info, entry);
-	} else if (child->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT) {
+	} else if (child->ptrace_event == 0 &&
+		   child->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT) {
 		info.op = PTRACE_SYSCALL_INFO_EXIT;
 		info.arch = syscall_get_arch(child);
 		info.exit.rval = syscall_get_error(child, regs);
-- 
2.19.1

