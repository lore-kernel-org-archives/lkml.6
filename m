Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeFBKkI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:40:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38706 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeFBKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:25 -0400
X-Google-Smtp-Source: ADUXVKKlnaHYlkYK62zS+8a28v+1stItRaYD/xxHfPdeCNZZKvGJu9s6zP7jU9RhxIUvbi20WkR4vQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 13/17] signal: make flush_sigqueue_mask() void
Date: Sat,  2 Jun 2018 12:36:49 +0200
Message-Id: <20180602103653.18181-14-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of flush_sigqueue_mask() is never checked anywhere.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* unchanged
v1->v2:
* unchanged
v0->v1:
* patch added
---
 kernel/signal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 70680dd8b588..100f2cb29fd8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -687,14 +687,14 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
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
@@ -703,7 +703,6 @@ static int flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
 			__sigqueue_free(q);
 		}
 	}
-	return 1;
 }
 
 static inline int is_si_special(const struct siginfo *info)
-- 
2.17.0
