Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755386AbeE1Nu7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:50:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44174 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755288AbeE1Ntj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:39 -0400
X-Google-Smtp-Source: AB8JxZqS1wehmH74B6pPuXcCED+eIsijaURNmYFUNS43KNlAbm8IuLemz4g0wM+XNy9d6a0sFwUGbw==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 6/8] signal: drop else branch in do_signal_stop()
Date: Mon, 28 May 2018 15:49:14 +0200
Message-Id: <20180528134916.7568-7-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528134916.7568-1-christian@brauner.io>
References: <20180528134916.7568-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_signal_stop() already returns in the if branch so there's no need to
keep the else branch around.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/signal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 498b464fe862..3b7712ec0746 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2214,14 +2214,14 @@ static bool do_signal_stop(int signr)
 		/* Now we don't run again until woken by SIGCONT or SIGKILL */
 		freezable_schedule();
 		return true;
-	} else {
-		/*
-		 * While ptraced, group stop is handled by STOP trap.
-		 * Schedule it and let the caller deal with it.
-		 */
-		task_set_jobctl_pending(current, JOBCTL_TRAP_STOP);
-		return false;
 	}
+
+	/*
+	 * While ptraced, group stop is handled by STOP trap.
+	 * Schedule it and let the caller deal with it.
+	 */
+	task_set_jobctl_pending(current, JOBCTL_TRAP_STOP);
+	return false;
 }
 
 /**
-- 
2.17.0
