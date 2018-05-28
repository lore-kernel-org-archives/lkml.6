Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937613AbeE1Ntv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:49:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52897 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755257AbeE1Ntg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:36 -0400
X-Google-Smtp-Source: ADUXVKK9RInT72WCKXz3HJEL17bIzGrvGiAmd7dOUq8/i6GhN9ffBX7OJmiFEuqzg7iJRWzAu/PD+A==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 3/8] signal: make may_ptrace_stop() return bool
Date: Mon, 28 May 2018 15:49:11 +0200
Message-Id: <20180528134916.7568-4-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528134916.7568-1-christian@brauner.io>
References: <20180528134916.7568-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

may_ptrace_stop() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 81be01d193f4..6c2e7b45cba1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1889,10 +1889,10 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
-static inline int may_ptrace_stop(void)
+static inline bool may_ptrace_stop(void)
 {
 	if (!likely(current->ptrace))
-		return 0;
+		return false;
 	/*
 	 * Are we in the middle of do_coredump?
 	 * If so and our tracer is also part of the coredump stopping
@@ -1908,9 +1908,9 @@ static inline int may_ptrace_stop(void)
 	 */
 	if (unlikely(current->mm->core_state) &&
 	    unlikely(current->mm == current->parent->mm))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
-- 
2.17.0
