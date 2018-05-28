Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934726AbeE1WAH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 18:00:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34862 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934473AbeE1V6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:21 -0400
X-Google-Smtp-Source: ADUXVKKyBdUUQhxEaCNLjOmzPLJT3wnuvLeerjTgfIu0e3GtsD1ijsAWlcHoGoJK5cT1+K9kwXJBPQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 15/20] signal: make unhandled_signal() return bool
Date: Mon, 28 May 2018 23:53:50 +0200
Message-Id: <20180528215355.16119-16-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unhandled_signal() already behaves like a boolean function. Let's actually
declare it as such too.
All callers treat it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 include/linux/signal.h |  2 +-
 kernel/signal.c        | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index a9bc7e1b077e..1145d7061ed9 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -284,7 +284,7 @@ static inline void disallow_signal(int sig)
 
 extern struct kmem_cache *sighand_cachep;
 
-int unhandled_signal(struct task_struct *tsk, int sig);
+extern bool unhandled_signal(struct task_struct *tsk, int sig);
 
 /*
  * In POSIX a signal is sent either to a specific thread (Linux task)
diff --git a/kernel/signal.c b/kernel/signal.c
index 623039987546..c382ac346a81 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -508,13 +508,16 @@ flush_signal_handlers(struct task_struct *t, int force_default)
 	}
 }
 
-int unhandled_signal(struct task_struct *tsk, int sig)
+bool unhandled_signal(struct task_struct *tsk, int sig)
 {
-	void __user *handler = tsk->sighand->action[sig-1].sa.sa_handler;
+	void __user *handler = tsk->sighand->action[sig - 1].sa.sa_handler;
+
 	if (is_global_init(tsk))
-		return 1;
+		return true;
+
 	if (handler != SIG_IGN && handler != SIG_DFL)
-		return 0;
+		return false;
+
 	/* if ptraced, let the tracer determine */
 	return !tsk->ptrace;
 }
-- 
2.17.0
