Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934793AbeE1WAj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 18:00:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33375 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934497AbeE1V6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:17 -0400
X-Google-Smtp-Source: AB8JxZos0XHWdextagI7wP7nJ3ezcLvOnTm8fh1fy3Bz9cQLP6sR/pbcnKkY8gyXUJj8gwE5euNFqQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 12/20] signal: make sig_ignored() return bool
Date: Mon, 28 May 2018 23:53:47 +0200
Message-Id: <20180528215355.16119-13-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_ignored() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c3981081ec25..60c501db15d9 100644
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
