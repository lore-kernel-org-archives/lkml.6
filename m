Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeFBKkE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:40:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38676 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeFBKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:26 -0400
X-Google-Smtp-Source: ADUXVKK/ymf7pz/I0nPrr2mgQBuAO4uLUK57mClllj1jviYhx9wY46wuNNuHtJZbPt6buxViPjpgog==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 14/17] signal: make wants_signal() return bool
Date: Sat,  2 Jun 2018 12:36:50 +0200
Message-Id: <20180602103653.18181-15-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wants_signal() already behaves like a boolean function. Let's actually
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
 kernel/signal.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 100f2cb29fd8..3a12d3b25584 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -879,16 +879,20 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
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
