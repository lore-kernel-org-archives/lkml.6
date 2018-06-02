Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeFBKhs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:37:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53619 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeFBKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:19 -0400
X-Google-Smtp-Source: ADUXVKIsIkj5F7G3aHwWjmLg7PhbXepZR4iiG4mrtrkcnRmVl9I43iprec9YD7mD+1df4C7E/W13DA==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 09/17] signal: make sig_ignored() return bool
Date: Sat,  2 Jun 2018 12:36:45 +0200
Message-Id: <20180602103653.18181-10-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_ignored() already behaves like a boolean function. Let's actually
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
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ff2ea82e376b..fed938c2e273 100644
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
