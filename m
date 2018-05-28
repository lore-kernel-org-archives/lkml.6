Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755399AbeE1NvR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:51:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35325 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeE1Nti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:38 -0400
X-Google-Smtp-Source: ADUXVKK6rYA0Mmjs3bPHTK4IeRiHtxTeUCgGDrOw025YyU2add8k0odo4yfewYBXt8LWH4ssxwCaqg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 5/8] signal: flatten do_send_sig_info()
Date: Mon, 28 May 2018 15:49:13 +0200
Message-Id: <20180528134916.7568-6-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528134916.7568-1-christian@brauner.io>
References: <20180528134916.7568-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's return early when lock_task_sighand() fails and move send_signal()
and unlock_task_sighand() out of the if block.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/signal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 821b54e3328b..498b464fe862 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1167,16 +1167,16 @@ specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
 }
 
 int do_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
-			bool group)
+		     bool group)
 {
 	unsigned long flags;
 	int ret = -ESRCH;
 
-	if (lock_task_sighand(p, &flags)) {
-		ret = send_signal(sig, info, p, group);
-		unlock_task_sighand(p, &flags);
-	}
+	if (!lock_task_sighand(p, &flags))
+		return ret;
 
+	ret = send_signal(sig, info, p, group);
+	unlock_task_sighand(p, &flags);
 	return ret;
 }
 
-- 
2.17.0
