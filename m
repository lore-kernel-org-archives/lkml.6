Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937490AbeE1Ntr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:49:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39163 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755250AbeE1Ntf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:35 -0400
X-Google-Smtp-Source: AB8JxZq73aBca0YizS3/f4XttVAsDijwZDmaS+1HNy2D3e2ex2YHipfz9CMotpFDAzKeNp4v7qeiPA==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/8] signal: make kill_as_cred_perm() return bool
Date: Mon, 28 May 2018 15:49:10 +0200
Message-Id: <20180528134916.7568-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528134916.7568-1-christian@brauner.io>
References: <20180528134916.7568-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kill_as_cred_perm() already behaves like a boolean function. Let's actually
declare it as such too.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c756008d589e..81be01d193f4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1349,14 +1349,15 @@ static int kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 	return error;
 }
 
-static int kill_as_cred_perm(const struct cred *cred,
+static bool kill_as_cred_perm(const struct cred *cred,
 			     struct task_struct *target)
 {
 	const struct cred *pcred = __task_cred(target);
 	if (!uid_eq(cred->euid, pcred->suid) && !uid_eq(cred->euid, pcred->uid) &&
 	    !uid_eq(cred->uid,  pcred->suid) && !uid_eq(cred->uid,  pcred->uid))
-		return 0;
-	return 1;
+		return false;
+
+	return true;
 }
 
 /* like kill_pid_info(), but doesn't use uid/euid of "current" */
-- 
2.17.0
