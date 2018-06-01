Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeFANYP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:24:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36257 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbeFANXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:23:06 -0400
X-Google-Smtp-Source: ADUXVKK7i1o5fl2pGGeA/nBlsumnPZfqy59V6+SPGCDvLHQJ7qdoD6yRo1VkWoqY9w4IyXyGQ2mk/g==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 13/17] signal: make flush_sigqueue_mask() void
Date: Fri,  1 Jun 2018 15:22:35 +0200
Message-Id: <20180601132239.4421-14-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601132239.4421-1-christian@brauner.io>
References: <20180601132239.4421-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of flush_sigqueue_mask() is never checked anywhere.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a41af5a7749f..dd32a1ce58e2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -691,14 +691,14 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
  *
  * All callers must be holding the siglock.
  */
-static int flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
 
 	sigandsets(&m, mask, &s->signal);
 	if (sigisemptyset(&m))
-		return 0;
+		return;
 
 	sigandnsets(&s->signal, &s->signal, mask);
 	list_for_each_entry_safe(q, n, &s->list, list) {
@@ -707,7 +707,6 @@ static int flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
 			__sigqueue_free(q);
 		}
 	}
-	return 1;
 }
 
 static inline int is_si_special(const struct siginfo *info)
-- 
2.17.0
