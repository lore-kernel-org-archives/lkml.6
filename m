Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeFBKh3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:37:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35070 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeFBKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:07 -0400
X-Google-Smtp-Source: ADUXVKJt90ik6yD965Ov/v5cbOGtNVlrdiiwp4nmQ1taCq5Ax3r01ZMgZlOq/EX6jqIQCsIP7VtEeQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 02/17] signal: make kill_as_cred_perm() return bool
Date: Sat,  2 Jun 2018 12:36:38 +0200
Message-Id: <20180602103653.18181-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kill_as_cred_perm() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* unchanged
v1->v2:
* unchanged
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
