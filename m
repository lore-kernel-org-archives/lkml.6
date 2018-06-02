Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeFBKhf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:37:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54857 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeFBKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:14 -0400
X-Google-Smtp-Source: ADUXVKK1jM+IFlU65VN8pxx4OHFZIEbt5EKEACFZC2G4ZBvcuSSo62F7Rx27xaGu2TgYWBNx0iFR9w==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 06/17] signal: make kill_ok_by_cred() return bool
Date: Sat,  2 Jun 2018 12:36:42 +0200
Message-Id: <20180602103653.18181-7-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kill_ok_by_cred() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v2->v3:
* unchanged
v1->v2:
* unchanged
v0->v1:
* unchanged
---
 kernel/signal.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 21508900805b..dd239a8d7d2c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -717,21 +717,16 @@ static inline bool si_fromuser(const struct siginfo *info)
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
