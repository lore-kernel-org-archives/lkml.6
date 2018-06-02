Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeFBKjQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:39:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33640 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeFBKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:31 -0400
X-Google-Smtp-Source: ADUXVKJNnFy0/bI5l1R4Or+mdqccx9SZOlRSm0Hp5snJ2xrzvNvvJ2hIezlyo83ZN0idnEe+CFl8UQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 17/17] signal: make get_signal() return bool
Date: Sat,  2 Jun 2018 12:36:53 +0200
Message-Id: <20180602103653.18181-18-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make get_signal() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* unchanged
v1->v2:
* unchanged
v0->v1:
* patch added
---
 include/linux/signal.h | 2 +-
 kernel/signal.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 1145d7061ed9..97d5ff809716 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -262,7 +262,7 @@ extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
 extern int show_unhandled_signals;
 
-extern int get_signal(struct ksignal *ksig);
+extern bool get_signal(struct ksignal *ksig);
 extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping);
 extern void exit_signals(struct task_struct *tsk);
 extern void kernel_sigaction(int, __sighandler_t);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8d57a64abe52..47d0e3a9b166 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2301,7 +2301,7 @@ static int ptrace_signal(int signr, siginfo_t *info)
 	return signr;
 }
 
-int get_signal(struct ksignal *ksig)
+bool get_signal(struct ksignal *ksig)
 {
 	struct sighand_struct *sighand = current->sighand;
 	struct signal_struct *signal = current->signal;
@@ -2311,7 +2311,7 @@ int get_signal(struct ksignal *ksig)
 		task_work_run();
 
 	if (unlikely(uprobe_deny_signal()))
-		return 0;
+		return false;
 
 	/*
 	 * Do this once, we can't return to user-mode if freezing() == T.
-- 
2.17.0
