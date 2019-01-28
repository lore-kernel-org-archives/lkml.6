Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1606CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB05021738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692375;
	bh=fr/RykGUuDF68rrG38QP+a297L2kMy7Z85B3gxaJNJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aS1OqiXTgpOf383GX8fvZykMmdDJcexkbqt5cpWj1Yj7s+TNk6aaqv7QRiHC5On25
	 9+CTVyobp74DavTZcJnzzux7qHrohRYC+HaR9TExxsVA4AMHPPx2Wg3yDteZPGgbKV
	 tcnd2HtzNT2TlolXcfO2zE6a2gdJvhB1GdKzqHWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbfA1QTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731777AbfA1QTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5B821924;
        Mon, 28 Jan 2019 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692369;
        bh=fr/RykGUuDF68rrG38QP+a297L2kMy7Z85B3gxaJNJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GC6GyApL8971rCydPUBKwqEYbZlR8jp4ARfMiDx9FlEmBxPhr+TBqPPGxlboHQDp9
         j4ARuGmc+On5TIBNZfW94Zt25Oq8b/I85wsfUa0ERduhJQ5EmHNwVHgfmfV0NZCnNr
         lsjA5uZ4lI81Hvmt+ghPNv1wiqrSe5aF0PL8hOSc=
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
Subject: [PATCH AUTOSEL 4.14 165/170] kernel/hung_task.c: break RCU locks based on jiffies
Date:   Mon, 28 Jan 2019 11:11:55 -0500
Message-Id: <20190128161200.55107-165-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index 32b479468e4d..0cec1241e26f 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -33,7 +33,7 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  * is disabled during the critical section. It also controls the size of
  * the RCU grace period. So it needs to be upper-bound.
  */
-#define HUNG_TASK_BATCHING 1024
+#define HUNG_TASK_LOCK_BREAK (HZ / 10)
 
 /*
  * Zero means infinite timeout - no checking done:
@@ -164,7 +164,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
 static void check_hung_uninterruptible_tasks(unsigned long timeout)
 {
 	int max_count = sysctl_hung_task_check_count;
-	int batch_count = HUNG_TASK_BATCHING;
+	unsigned long last_break = jiffies;
 	struct task_struct *g, *t;
 
 	/*
@@ -179,10 +179,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	for_each_process_thread(g, t) {
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

