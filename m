Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E426F70
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Rgw3nowL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9E426F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeFZVQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:16:40 -0400
Received: from mail.efficios.com ([167.114.142.138]:41000 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeFZVQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:16:37 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 88AFA22DAE0;
        Tue, 26 Jun 2018 17:16:36 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Ot20XGlPZCTu; Tue, 26 Jun 2018 17:16:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BC91322DAD6;
        Tue, 26 Jun 2018 17:16:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BC91322DAD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530047795;
        bh=40zVm4fxxpUlNASy/ALDWkXeA72jWSKyt8DoN6qtPH0=;
        h=From:To:Date:Message-Id;
        b=Rgw3nowLKm/1EfvY/ixQ2k2ZkY37ro7ikEPrNgr9M0VbyxbYOhGI9e6/zcjKMZUZ9
         fRB8z6AMt49fwqoFGgjqbSu3jjW4oKqApZQEsO9pclS50t6s9eIvipvMz0/E4tvK9J
         quuWVTHtKRSUvFxL06rlvWuv8xZQP1UKGXoelYRi9nosnT2OnWlg1qlYfu9px6XlhS
         wLsA8pdmKaw7OsYQWVucm8JFjLuxO3i7nxMRSbTGX/ssQbvhXPQLLute0sTkiqtl5n
         HaDUQlIuETg4fPVwF5RgUKXu9A+MLhneNlTXfjfEnZ/UWKopzOHlhqsCTm+qpyRzXq
         32lhgcba0QiLA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id a1bL8rbmBZ2g; Tue, 26 Jun 2018 17:16:35 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 54B2722DAD0;
        Tue, 26 Jun 2018 17:16:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Hunter <ahh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH for 4.18 1/2] compat: Introduce is_compat_frame
Date:   Tue, 26 Jun 2018 17:16:16 -0400
Message-Id: <20180626211617.8933-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 is moving from is_compat_task() to in_compat_syscall(). However,
in_compat_syscall cannot be used to check whether a signal is being
delivered on a compat task.

Introduce is_compat_frame to allow performing this check from
architecture agnostic code. On all architectures except x86, it
invokes is_compat_task(). On x86, it uses is_ia32_frame() and
is_x32_frame() to check whether the signal frame is 32-bit.

This is needed by restartable sequences to detect whether it needs
to clear the top bits of the start_ip, abort_ip, and post_commit_offset
rseq_cs fields on signal delivery, thus ensuring identical behavior
for a 32-bit binary executed on 32-bit and 64-bit kernels.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Hunter <ahh@google.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/compat.h | 24 ++++++++++++++++++++++++
 arch/x86/kernel/signal.c      | 17 -----------------
 include/linux/compat.h        | 17 +++++++++++++++++
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index fb97cf7c4137..1405a8df5215 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/signal.h>
 #include <asm/processor.h>
 #include <asm/user32.h>
 #include <asm/unistd.h>
@@ -242,4 +243,27 @@ struct compat_siginfo;
 int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 		const siginfo_t *from, bool x32_ABI);
 
+static inline int is_ia32_compat_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
+		ksig->ka.sa.sa_flags & SA_IA32_ABI;
+}
+
+static inline int is_ia32_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_X86_32) || is_ia32_compat_frame(ksig);
+}
+
+static inline int is_x32_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_X86_X32_ABI) &&
+		ksig->ka.sa.sa_flags & SA_X32_ABI;
+}
+
+static inline bool is_compat_frame(struct ksignal *ksig)
+{
+	return is_ia32_frame(ksig) || is_x32_frame(ksig);
+}
+#define is_compat_frame	is_compat_frame		/* override the generic impl */
+
 #endif /* _ASM_X86_COMPAT_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 92a3b312a53c..cb488e3e952d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -664,23 +664,6 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 }
 
-static inline int is_ia32_compat_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
-		ksig->ka.sa.sa_flags & SA_IA32_ABI;
-}
-
-static inline int is_ia32_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_X86_32) || is_ia32_compat_frame(ksig);
-}
-
-static inline int is_x32_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_X86_X32_ABI) &&
-		ksig->ka.sa.sa_flags & SA_X32_ABI;
-}
-
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
diff --git a/include/linux/compat.h b/include/linux/compat.h
index b1a5562b3215..2e1ffba65117 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -1022,6 +1022,19 @@ static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
 	return ctv;
 }
 
+/*
+ * For most but not all architectures, "is this a compat sigframe?" and
+ * "am I a compat task?" are the same question.  For architectures on which
+ * they aren't the same question, arch code can override is_compat_frame.
+ */
+
+#ifndef is_compat_frame
+static inline bool is_compat_frame(struct ksignal *ksig)
+{
+	return is_compat_task();
+}
+#endif
+
 #else /* !CONFIG_COMPAT */
 
 #define is_compat_task() (0)
@@ -1029,6 +1042,10 @@ static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
 static inline bool in_compat_syscall(void) { return false; }
 #endif
 
+#ifndef is_compat_frame
+static inline bool is_compat_frame(struct ksignal *ksig) { return false; }
+#endif
+
 #endif /* CONFIG_COMPAT */
 
 #endif /* _LINUX_COMPAT_H */
-- 
2.11.0

