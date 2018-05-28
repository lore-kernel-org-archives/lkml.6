Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934611AbeE1V6d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37582 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbeE1V6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:13 -0400
X-Google-Smtp-Source: AB8JxZpPsdNlNnkwBavotsjDRaNny7CUqlaV8h06u7hSGvYLd4/Aqo7Bfw/yHEXWcYmXYpPX7pLsFw==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 09/20] signal: make kill_ok_by_cred() return bool
Date: Mon, 28 May 2018 23:53:44 +0200
Message-Id: <20180528215355.16119-10-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kill_ok_by_cred() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch introduced
---
 kernel/signal.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7095fa11af15..faef85bb243e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -723,21 +723,16 @@ static inline bool si_fromuser(const struct siginfo *info)
 /*
  * called with RCU read lock from check_kill_permission()
  */
-static int kill_ok_by_cred(struct task_struct *t)
+static bool kill_ok_by_cred(struct task_struct *t)
 {
 	const struct cred *cred = current_cred();
 	const struct cred *tcred = __task_cred(t);
 
-	if (uid_eq(cred->euid, tcred->suid) ||
-	    uid_eq(cred->euid, tcred->uid)  ||
-	    uid_eq(cred->uid,  tcred->suid) ||
-	    uid_eq(cred->uid,  tcred->uid))
-		return 1;
-
-	if (ns_capable(tcred->user_ns, CAP_KILL))
-		return 1;
-
-	return 0;
+	return uid_eq(cred->euid, tcred->suid) ||
+	       uid_eq(cred->euid, tcred->uid) ||
+	       uid_eq(cred->uid, tcred->suid) ||
+	       uid_eq(cred->uid, tcred->uid) ||
+	       ns_capable(tcred->user_ns, CAP_KILL);
 }
 
 /*
-- 
2.17.0
