Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFANZH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:25:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36987 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeFANXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:04 -0400
X-Google-Smtp-Source: ADUXVKKQGbPsWSkWTeBISDPe8+tmzTDe4zr8TwWdRiE9/ICova0C1Ict92ECv4cIqiffHKBx5Bj7Pg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 12/17] signal: make unhandled_signal() return bool
Date: Fri,  1 Jun 2018 15:22:34 +0200
Message-Id: <20180601132239.4421-13-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unhandled_signal() already behaves like a boolean function. Let's actually
declare it as such too.
All callers treat it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
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
index d5a3b1ef775e..a41af5a7749f 100644
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
