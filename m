Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeFANYL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:24:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33849 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeFANXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:08 -0400
X-Google-Smtp-Source: ADUXVKJOwdt68MkqhewUsGuvNwA7fM9SafxxM+KlFhQCercUFpIGyWBNoKAobkrR5CW6/RprVluARw==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 14/17] signal: make wants_signal() return bool
Date: Fri,  1 Jun 2018 15:22:36 +0200
Message-Id: <20180601132239.4421-15-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wants_signal() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index dd32a1ce58e2..8ee3e4a57117 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -883,16 +883,20 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
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
