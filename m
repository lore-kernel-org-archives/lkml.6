Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06458C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27732177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499352;
	bh=94C2DwuoAJ6qFgEwlITyrqTcbn9UyEEj8hSvPLbdtXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Kjl+faOfC2/+nh9kASkt4GaZySECc4hnX5LQwkU98/Vi/Ku8cjbSSTufgVrLcfM1
	 WvyIU0hPhCxVHMqTqwnNQw06im5OPPE8KjvnPyCw3mg+qnryzaEGwIFmmYMJdzjRbp
	 xpSUCS3I8Fq2LM1i5vMMt8iQenfV7VoPv2BqFV0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391819AbfBROLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390605AbfBROLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3162621905;
        Mon, 18 Feb 2019 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499100;
        bh=94C2DwuoAJ6qFgEwlITyrqTcbn9UyEEj8hSvPLbdtXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oaud4EuCV33yeG4X7CpxzRJiYMelPAgCroK5gEySen3kTzCp5OuC9CoCXN0V07jBq
         Yd722PnA9cKWMcAtffQ8gTFwFT1+Pa6ldnRHWJZttILnxWcFQwFRABQ0sAIMBKxEAo
         rsGlMJIsz525xHiYDk8SKdPl0HMIVFzIsSRw6i0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 053/108] kernel/hung_task.c: break RCU locks based on jiffies
Date:   Mon, 18 Feb 2019 14:43:49 +0100
Message-Id: <20190218133521.970037388@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



