Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7A6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB924FDD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0zK15DqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CB924FDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeF1QaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeF1Q37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:29:59 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-193-82.w83-194.abo.wanadoo.fr [83.194.41.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 189A824AC4;
        Thu, 28 Jun 2018 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530203399;
        bh=cFJrJNw8naLGegXR2E4XmSkC6vtU6RROMggj43iriko=;
        h=From:To:Cc:Subject:Date:From;
        b=0zK15DqUcEZgUbNN245SWMgEWcJ+qlqX2Fmcqge3eD30JcTIzQvXzzdmfWYGHEEii
         rK3yVfbmqYeXfioj8a9maMiHH+L63L4uzK8jeIuaw9MY69wd6Mil9JGtQlCR7OTTaK
         ciKLAkksfQn4A+AhiLG2B1LjRB6X/PFmY7HuEes4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Jacek Tomaka <jacekt@dug.com>
Subject: [PATCH] sched/nohz: Skip remote tick on idle task entirely
Date:   Thu, 28 Jun 2018 18:29:41 +0200
Message-Id: <1530203381-31234-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some people have reported that the warning in sched_tick_remote()
occasionally triggers, especially in favour of some RCU-Torture
pressure:

	WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
	Modules linked in:
	CPU: 11 PID: 906 Comm: kworker/u32:3 Not tainted 4.18.0-rc2+ #1
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
	Workqueue: events_unbound sched_tick_remote
	RIP: 0010:sched_tick_remote+0xb6/0xc0
	Code: e8 0f 06 b8 00 c6 03 00 fb eb 9d 8b 43 04 85 c0 75 8d 48 8b 83 e0 0a 00 00 48 85 c0 75 81 eb 88 48 89 df e8 bc fe ff ff eb aa <0f> 0b eb
	+c5 66 0f 1f 44 00 00 bf 17 00 00 00 e8 b6 2e fe ff 0f b6
	Call Trace:
	 process_one_work+0x1df/0x3b0
	 worker_thread+0x44/0x3d0
	 kthread+0xf3/0x130
	 ? set_worker_desc+0xb0/0xb0
	 ? kthread_create_worker_on_cpu+0x70/0x70
	 ret_from_fork+0x35/0x40

This happens when the remote tick applies on an idle task. Usually the
idle_cpu() check avoids that, but it is performed before we lock the
runqueue and it is therefore racy. It was intended to be that way in
order to prevent from useless runqueue locks since idle task tick
callback is a no-op.

Now if the racy check slips out of our hands and we end up remotely
ticking an idle task, the empty task_tick_idle() is harmless. Still
it won't pass the WARN_ON_ONCE() test that ensures rq_clock_task() is
not too far from curr->se.exec_start because update_curr_idle() doesn't
update the exec_start value like other scheduler policies. Hence the
reported false positive.

So let's have another check, while the rq is locked, to make sure we
don't remote tick on an idle task. The lockless idle_cpu() still applies
to avoid unecessary rq lock contention.

Reported-by: Jacek Tomaka <jacekt@dug.com>
Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8fac..da8f121 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3127,16 +3127,18 @@ static void sched_tick_remote(struct work_struct *work)
 		u64 delta;
 
 		rq_lock_irq(rq, &rf);
-		update_rq_clock(rq);
 		curr = rq->curr;
-		delta = rq_clock_task(rq) - curr->se.exec_start;
+		if (!is_idle_task(curr)) {
+			update_rq_clock(rq);
+			delta = rq_clock_task(rq) - curr->se.exec_start;
 
-		/*
-		 * Make sure the next tick runs within a reasonable
-		 * amount of time.
-		 */
-		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
-		curr->sched_class->task_tick(rq, curr, 0);
+			/*
+			 * Make sure the next tick runs within a reasonable
+			 * amount of time.
+			 */
+			WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+			curr->sched_class->task_tick(rq, curr, 0);
+		}
 		rq_unlock_irq(rq, &rf);
 	}
 
-- 
2.7.4

