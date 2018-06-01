Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeFANXG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:23:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36971 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbeFANXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:00 -0400
X-Google-Smtp-Source: ADUXVKKXx3YE2EtgYeatGwAVY0GIeCx7ORYkh9+5BXr31dWCg083ckIC10LvmZ78ntzRFoyOogKOMg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 09/17] signal: make sig_ignored() return bool
Date: Fri,  1 Jun 2018 15:22:31 +0200
Message-Id: <20180601132239.4421-10-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_ignored() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 208e99b57e6f..e48675bd3be8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -85,7 +85,7 @@ static bool sig_task_ignored(struct task_struct *t, int sig, bool force)
 	return sig_handler_ignored(handler, sig);
 }
 
-static int sig_ignored(struct task_struct *t, int sig, bool force)
+static bool sig_ignored(struct task_struct *t, int sig, bool force)
 {
 	/*
 	 * Blocked signals are never ignored, since the
@@ -93,7 +93,7 @@ static int sig_ignored(struct task_struct *t, int sig, bool force)
 	 * unblocked.
 	 */
 	if (sigismember(&t->blocked, sig) || sigismember(&t->real_blocked, sig))
-		return 0;
+		return false;
 
 	/*
 	 * Tracers may want to know about even ignored signal unless it
@@ -101,7 +101,7 @@ static int sig_ignored(struct task_struct *t, int sig, bool force)
 	 * by SIGNAL_UNKILLABLE task.
 	 */
 	if (t->ptrace && sig != SIGKILL)
-		return 0;
+		return false;
 
 	return sig_task_ignored(t, sig, force);
 }
-- 
2.17.0
