Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934589AbeE1V63 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45860 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934492AbeE1V6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:15 -0400
X-Google-Smtp-Source: AB8JxZq4iZyZKbIWSd11F2yiW2aAropY6oxYsksovBViS6uRo6xIslfZXd+jNOkfV3pZ/zq723MaCg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 10/20] signal: make sig_handler_ignored() return bool
Date: Mon, 28 May 2018 23:53:45 +0200
Message-Id: <20180528215355.16119-11-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sig_handler_ignored() already behaves like a boolean function. Let's
actually declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index faef85bb243e..78a9b32785df 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -65,11 +65,11 @@ static void __user *sig_handler(struct task_struct *t, int sig)
 	return t->sighand->action[sig - 1].sa.sa_handler;
 }
 
-static int sig_handler_ignored(void __user *handler, int sig)
+static inline bool sig_handler_ignored(void __user *handler, int sig)
 {
 	/* Is it explicitly or implicitly ignored? */
 	return handler == SIG_IGN ||
-		(handler == SIG_DFL && sig_kernel_ignore(sig));
+	       (handler == SIG_DFL && sig_kernel_ignore(sig));
 }
 
 static int sig_task_ignored(struct task_struct *t, int sig, bool force)
-- 
2.17.0
