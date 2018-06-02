Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeFBKka (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:40:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34607 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFBKhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:24 -0400
X-Google-Smtp-Source: ADUXVKLtM5083HfK+f016kwh3HKyb435ntTJUkQ8/XbdiyLSlMPsV+TLFnEBwb7ulrd+zZfAHQhKpQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 12/17] signal: make unhandled_signal() return bool
Date: Sat,  2 Jun 2018 12:36:48 +0200
Message-Id: <20180602103653.18181-13-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unhandled_signal() already behaves like a boolean function. Let's actually
declare it as such too.
All callers treat it as such too.

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
 kernel/signal.c        | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

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
index 41f9b91db209..70680dd8b588 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -505,13 +505,15 @@ flush_signal_handlers(struct task_struct *t, int force_default)
 	}
 }
 
-int unhandled_signal(struct task_struct *tsk, int sig)
+bool unhandled_signal(struct task_struct *tsk, int sig)
 {
 	void __user *handler = tsk->sighand->action[sig-1].sa.sa_handler;
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
