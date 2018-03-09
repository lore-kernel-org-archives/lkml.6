Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeCIJHQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:07:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeCIJHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:07:15 -0500
Date: Fri, 9 Mar 2018 01:06:54 -0800
From: tip-bot for gaurav jindal <tipbot@zytor.com>
Message-ID: <tip-d17067e4487adc53bedb43681b3cb5a1714ff6ca@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, gauravjindal1104@gmail.com, mingo@kernel.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
        gauravjindal1104@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180221125407.GA14292@gmail.com>
References: <20180221125407.GA14292@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/completions: Use bool in
 try_wait_for_completion()
Git-Commit-ID: d17067e4487adc53bedb43681b3cb5a1714ff6ca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d17067e4487adc53bedb43681b3cb5a1714ff6ca
Gitweb:     https://git.kernel.org/tip/d17067e4487adc53bedb43681b3cb5a1714ff6ca
Author:     gaurav jindal <gauravjindal1104@gmail.com>
AuthorDate: Wed, 21 Feb 2018 18:24:07 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:00:18 +0100

sched/completions: Use bool in try_wait_for_completion()

Since the return type of the function is bool, the internal
'ret' variable should be bool too.

Signed-off-by: Gaurav Jindal<gauravjindal1104@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180221125407.GA14292@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/completion.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 5d2d56b0817a..e426b0cb9ac6 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL(wait_for_completion_killable_timeout);
 bool try_wait_for_completion(struct completion *x)
 {
 	unsigned long flags;
-	int ret = 1;
+	bool ret = true;
 
 	/*
 	 * Since x->done will need to be locked only
@@ -289,11 +289,11 @@ bool try_wait_for_completion(struct completion *x)
 	 * return early in the blocking case.
 	 */
 	if (!READ_ONCE(x->done))
-		return 0;
+		return false;
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
-		ret = 0;
+		ret = false;
 	else if (x->done != UINT_MAX)
 		x->done--;
 	spin_unlock_irqrestore(&x->wait.lock, flags);
