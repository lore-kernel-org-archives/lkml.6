Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934697AbeE1V7c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:59:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34866 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934524AbeE1V6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:22 -0400
X-Google-Smtp-Source: ADUXVKKy5Ut8V1PseA5xkD/TluJrWOEWBQQNXxZtnLHsCZOn9/zxOjRyGb8R9e6lRplCKLCqTgkHiQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 16/20] signal: make flush_sigqueue_mask() void
Date: Mon, 28 May 2018 23:53:51 +0200
Message-Id: <20180528215355.16119-17-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of flush_sigqueue_mask() is never checked anywhere.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c382ac346a81..0959965b523d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -697,14 +697,14 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
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
@@ -713,7 +713,6 @@ static int flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
 			__sigqueue_free(q);
 		}
 	}
-	return 1;
 }
 
 static inline int is_si_special(const struct siginfo *info)
-- 
2.17.0
