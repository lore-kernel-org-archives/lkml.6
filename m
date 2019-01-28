Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FEDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C432147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692915;
	bh=uASGG9hm5uKKwOR6CEQJx6+ENtIcjH6f9eRjOn1W8xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8xOgV+tPjb2gcGekt1uUYcW3FwqcbZD/9dcRrgBNRqnLtjW/Y7+pZWMP7jW1lPg2
	 rkOugQDZx/f9WiIz81vEvA4Ek6TfifGOZpP1xMgKo1sf7+NE37Qvz+Sm3hx57CSjtA
	 On3zYGM/+jIPjkRCTnYQ32+qvRwEjOZ0wGsqkJlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbfA1Q2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390595AbfA1Q2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:28:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A161E21925;
        Mon, 28 Jan 2019 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692890;
        bh=uASGG9hm5uKKwOR6CEQJx6+ENtIcjH6f9eRjOn1W8xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzR9xVasjjDSaqeSNpZxHQ6TjFjM+4DfT3snGP0YpLUis+OzdZwDXd84s32/BIk9Z
         StMBlBqsnEAOSjH4aleqFW/MxNl0VK5AO4fcoUxJwzYBG0o31exwFHcTrHoE8napAo
         dCu7EaAu7NG5XUffgfeADE4E8JD2G+SdYlFsS+iE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 59/61] kernel/hung_task.c: break RCU locks based on jiffies
Date:   Mon, 28 Jan 2019 11:26:21 -0500
Message-Id: <20190128162623.59854-59-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 304ae42739b108305f8d7b3eb3c1aec7c2b643a9 ]

check_hung_uninterruptible_tasks() is currently calling rcu_lock_break()
for every 1024 threads.  But check_hung_task() is very slow if printk()
was called, and is very fast otherwise.

If many threads within some 1024 threads called printk(), the RCU grace
period might be extended enough to trigger RCU stall warnings.
Therefore, calling rcu_lock_break() for every some fixed jiffies will be
safer.

Link: http://lkml.kernel.org/r/1544800658-11423-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/hung_task.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 06db12434d72..eda60beeac7d 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -30,7 +30,7 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  * is disabled during the critical section. It also controls the size of
  * the RCU grace period. So it needs to be upper-bound.
  */
-#define HUNG_TASK_BATCHING 1024
+#define HUNG_TASK_LOCK_BREAK (HZ / 10)
 
 /*
  * Zero means infinite timeout - no checking done:
@@ -158,7 +158,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
 static void check_hung_uninterruptible_tasks(unsigned long timeout)
 {
 	int max_count = sysctl_hung_task_check_count;
-	int batch_count = HUNG_TASK_BATCHING;
+	unsigned long last_break = jiffies;
 	struct task_struct *g, *t;
 
 	/*
@@ -172,10 +172,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	do_each_thread(g, t) {
 		if (!max_count--)
 			goto unlock;
-		if (!--batch_count) {
-			batch_count = HUNG_TASK_BATCHING;
+		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
 			if (!rcu_lock_break(g, t))
 				goto unlock;
+			last_break = jiffies;
 		}
 		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
 		if (t->state == TASK_UNINTERRUPTIBLE)
-- 
2.19.1

