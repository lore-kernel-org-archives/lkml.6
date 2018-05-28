Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934489AbeE1V6M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52046 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbeE1V6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:04 -0400
X-Google-Smtp-Source: AB8JxZrhginlXF/xY4T0onlTv/xlM7Isgy96VP+6ZKgi914dCB48AZ4XEjvQFjMYHoY9oItBvZutbA==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 02/20] signal: make kill_as_cred_perm() return bool
Date: Mon, 28 May 2018 23:53:37 +0200
Message-Id: <20180528215355.16119-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kill_as_cred_perm() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* simplify to use a single return
---
 kernel/signal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c756008d589e..6c71d6b8d2b8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1349,14 +1349,15 @@ static int kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 	return error;
 }
 
-static int kill_as_cred_perm(const struct cred *cred,
-			     struct task_struct *target)
+static inline bool kill_as_cred_perm(const struct cred *cred,
+				     struct task_struct *target)
 {
 	const struct cred *pcred = __task_cred(target);
-	if (!uid_eq(cred->euid, pcred->suid) && !uid_eq(cred->euid, pcred->uid) &&
-	    !uid_eq(cred->uid,  pcred->suid) && !uid_eq(cred->uid,  pcred->uid))
-		return 0;
-	return 1;
+
+	return uid_eq(cred->euid, pcred->suid) ||
+	       uid_eq(cred->euid, pcred->uid) ||
+	       uid_eq(cred->uid, pcred->suid) ||
+	       uid_eq(cred->uid, pcred->uid);
 }
 
 /* like kill_pid_info(), but doesn't use uid/euid of "current" */
-- 
2.17.0
