Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934676AbeE1V73 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:59:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39609 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeE1V6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:23 -0400
X-Google-Smtp-Source: AB8JxZomqudCZuQv8recdyJO8MGZgaN+z/ZD0vW/d1B2tiHGVo+eT4WVyOOi3w2iUp2kYBlw2hs4Fg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 17/20] signal: make wants_signal() return bool
Date: Mon, 28 May 2018 23:53:52 +0200
Message-Id: <20180528215355.16119-18-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wants_signal() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 0959965b523d..ac5c2700901d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -889,16 +889,20 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
  * as soon as they're available, so putting the signal on the shared queue
  * will be equivalent to sending it to one such thread.
  */
-static inline int wants_signal(int sig, struct task_struct *p)
+static inline bool wants_signal(int sig, struct task_struct *p)
 {
 	if (sigismember(&p->blocked, sig))
-		return 0;
+		return false;
+
 	if (p->flags & PF_EXITING)
-		return 0;
+		return false;
+
 	if (sig == SIGKILL)
-		return 1;
+		return true;
+
 	if (task_is_stopped_or_traced(p))
-		return 0;
+		return false;
+
 	return task_curr(p) || !signal_pending(p);
 }
 
-- 
2.17.0
