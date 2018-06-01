Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeFANXM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:23:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38678 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeFANXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:03 -0400
X-Google-Smtp-Source: ADUXVKLcFZRUNLE6F5sca83cnvzJWhd5akRUrXuVo5CNeOOQK5DewxG2/AQHClTS11Z53tk3n/RIWw==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 11/17] signal: make recalc_sigpending_tsk() return bool
Date: Fri,  1 Jun 2018 15:22:33 +0200
Message-Id: <20180601132239.4421-12-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recalc_sigpending_tsk() already behaves like a boolean function. Let's
actually declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index faf38b46d124..d5a3b1ef775e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -141,20 +141,21 @@ static inline bool has_pending_signals(sigset_t *signal, sigset_t *blocked)
 
 #define PENDING(p,b) has_pending_signals(&(p)->signal, (b))
 
-static int recalc_sigpending_tsk(struct task_struct *t)
+static bool recalc_sigpending_tsk(struct task_struct *t)
 {
 	if ((t->jobctl & JOBCTL_PENDING_MASK) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked)) {
 		set_tsk_thread_flag(t, TIF_SIGPENDING);
-		return 1;
+		return true;
 	}
+
 	/*
 	 * We must never clear the flag in another thread, or in current
 	 * when it's possible the current syscall is returning -ERESTART*.
 	 * So we don't clear it here, and only callers who know they should do.
 	 */
-	return 0;
+	return false;
 }
 
 /*
-- 
2.17.0
