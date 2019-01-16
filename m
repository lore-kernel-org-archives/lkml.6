Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368D820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392900AbfAPMyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:54:32 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42418 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733128AbfAPMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:54:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D268A18525;
        Wed, 16 Jan 2019 13:54:29 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id noIeBu7GFu-U; Wed, 16 Jan 2019 13:54:29 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 1FA9A1853A;
        Wed, 16 Jan 2019 13:54:29 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BF361E08E;
        Wed, 16 Jan 2019 13:54:29 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 000751E086;
        Wed, 16 Jan 2019 13:54:28 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 13:54:28 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id E837D11D1;
        Wed, 16 Jan 2019 13:54:28 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id E4DA7801F0; Wed, 16 Jan 2019 13:54:28 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     akpm@linux-foundation.org
Cc:     mcgrof@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] sysctl: Add panic-fatal-signals
Date:   Wed, 16 Jan 2019 13:54:22 +0100
Message-Id: <20190116125422.19643-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sysctl which asks the kernel to panic when any userspace process
receives a fatal signal which would trigger a core dump.  This has
proven to be quite useful when debugging problems seen during testing of
embedded systems:  When combined with kernel core dumps (saved due to
the panic), it allows easier debugging of crashes which have their
origin in system-wide problems such as buggy drivers or other kernel or
hardware-related issues.

The crashing process's core dump can be extracted from the kernel core
dump using tools such as the crash utility's gcore extension.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 include/linux/signal.h | 1 +
 kernel/signal.c        | 5 ++++-
 kernel/sysctl.c        | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index cc7e2c1cd444..109efd1432e9 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -10,6 +10,7 @@ struct task_struct;
 
 /* for sysctl */
 extern int print_fatal_signals;
+extern int panic_fatal_signals;
 
 static inline void copy_siginfo(kernel_siginfo_t *to,
 				const kernel_siginfo_t *from)
diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..83c6877b0182 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -59,6 +59,7 @@
 static struct kmem_cache *sigqueue_cachep;
 
 int print_fatal_signals __read_mostly;
+int panic_fatal_signals __read_mostly;
 
 static void __user *sig_handler(struct task_struct *t, int sig)
 {
@@ -2497,8 +2498,10 @@ bool get_signal(struct ksignal *ksig)
 		current->flags |= PF_SIGNALED;
 
 		if (sig_kernel_coredump(signr)) {
-			if (print_fatal_signals)
+			if (print_fatal_signals || panic_fatal_signals)
 				print_fatal_signal(ksig->info.si_signo);
+			if (panic_fatal_signals)
+				panic("Fatal signal and panic_fatal_signals=1");
 			proc_coredump_connector(current);
 			/*
 			 * If it was able to dump core, this kills all
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..ad1ac6ec2004 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -557,6 +557,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "panic-fatal-signals",
+		.data		= &panic_fatal_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #ifdef CONFIG_SPARC
 	{
 		.procname	= "reboot-cmd",
-- 
2.20.0

