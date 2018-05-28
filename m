Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934488AbeE1V7I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:59:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37484 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934495AbeE1V61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:27 -0400
X-Google-Smtp-Source: ADUXVKLX8siwTwbS14Q8wHIloYqwf8CzdfgBY1FpLOsUrLk9/16NokdHbTok6AX+xhVsRil97YQqow==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 20/20] signal: make get_signal() return bool
Date: Mon, 28 May 2018 23:53:55 +0200
Message-Id: <20180528215355.16119-21-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make get_signal() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
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
index a4787c90faab..e3b0719986a2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2311,7 +2311,7 @@ static int ptrace_signal(int signr, siginfo_t *info)
 	return signr;
 }
 
-int get_signal(struct ksignal *ksig)
+bool get_signal(struct ksignal *ksig)
 {
 	struct sighand_struct *sighand = current->sighand;
 	struct signal_struct *signal = current->signal;
@@ -2321,7 +2321,7 @@ int get_signal(struct ksignal *ksig)
 		task_work_run();
 
 	if (unlikely(uprobe_deny_signal()))
-		return 0;
+		return false;
 
 	/*
 	 * Do this once, we can't return to user-mode if freezing() == T.
-- 
2.17.0
