Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934838AbeE1WBk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 18:01:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40417 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934447AbeE1V6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:08 -0400
X-Google-Smtp-Source: AB8JxZqr0/Iza0K7/ocFPdN/Jr5Mvb6Co9Wdc8dPZC+nRYv9VvbaLhRnIXlaBo9Vul8w0LM0i2ErjQ==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 05/20] signal: flatten do_send_sig_info()
Date: Mon, 28 May 2018 23:53:40 +0200
Message-Id: <20180528215355.16119-6-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's return early when lock_task_sighand() fails and move send_signal()
and unlock_task_sighand() out of the if block.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch unchanged
---
 kernel/signal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index baae137455eb..a628b56415e6 100644
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
