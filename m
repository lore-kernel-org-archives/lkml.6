Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbeE1V6J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40338 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933951AbeE1V6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:03 -0400
X-Google-Smtp-Source: ADUXVKKHi/rpHz7oA8ZP/tmRAyMk6+GCwIsp5jOntjED28EyEnRaQaX81LqLEkDZISFoR1vEX9I5pQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 01/20] signal: make force_sigsegv() void
Date: Mon, 28 May 2018 23:53:36 +0200
Message-Id: <20180528215355.16119-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

force_sigsegv() returned 0 unconditionally so it doesn't make sense to have
it return at all. In addition, there are no callers that check
force_sigsegv()'s return value.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch unchanged
---
 include/linux/sched/signal.h | 2 +-
 kernel/signal.c              | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 113d1ad1ced7..e138ac16c650 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -314,7 +314,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey);
 int force_sig_ptrace_errno_trap(int errno, void __user *addr);
 
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
-extern int force_sigsegv(int, struct task_struct *);
+extern void force_sigsegv(int sig, struct task_struct *p);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
 extern int __kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp);
 extern int kill_pid_info(int sig, struct siginfo *info, struct pid *pid);
diff --git a/kernel/signal.c b/kernel/signal.c
index 9c33163a6165..c756008d589e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1468,8 +1468,7 @@ send_sig(int sig, struct task_struct *p, int priv)
 	return send_sig_info(sig, __si_special(priv), p);
 }
 
-void
-force_sig(int sig, struct task_struct *p)
+void force_sig(int sig, struct task_struct *p)
 {
 	force_sig_info(sig, SEND_SIG_PRIV, p);
 }
@@ -1480,8 +1479,7 @@ force_sig(int sig, struct task_struct *p)
  * the problem was already a SIGSEGV, we'll want to
  * make sure we don't even try to deliver the signal..
  */
-int
-force_sigsegv(int sig, struct task_struct *p)
+void force_sigsegv(int sig, struct task_struct *p)
 {
 	if (sig == SIGSEGV) {
 		unsigned long flags;
@@ -1490,7 +1488,6 @@ force_sigsegv(int sig, struct task_struct *p)
 		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	}
 	force_sig(SIGSEGV, p);
-	return 0;
 }
 
 int force_sig_fault(int sig, int code, void __user *addr
-- 
2.17.0
