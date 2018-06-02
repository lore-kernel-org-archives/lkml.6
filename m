Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeFBKhd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:37:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37075 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbeFBKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:09 -0400
X-Google-Smtp-Source: ADUXVKLQymOblIE+E4snuXqEzbRjExnlqaxJ/RRNJDha/7yjgZTH/8zrzQDG1J6IGuUpiyGPMbE6dw==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 03/17] signal: make may_ptrace_stop() return bool
Date: Sat,  2 Jun 2018 12:36:39 +0200
Message-Id: <20180602103653.18181-4-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

may_ptrace_stop() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* [Oleg Nestorov] s/likely/unlikely logic
v1->v2:
* unchanged
v0->v1:
* unchanged
---
 kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 6c71d6b8d2b8..1848959a3b72 100644
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
