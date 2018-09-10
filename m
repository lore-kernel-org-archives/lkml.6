Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6158DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCF620865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCF620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeIJPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:00:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeIJPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:00:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA7GDU1806967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:07:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA7GiK1806964;
        Mon, 10 Sep 2018 03:07:16 -0700
Date:   Mon, 10 Sep 2018 03:07:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Steve Muckle <tipbot@zytor.com>
Message-ID: <tip-d0cdb3ce8834332d918fc9c8ff74f8a169ec9abe@git.kernel.org>
Cc:     tglx@linutronix.de, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, tkjos@google.com, peterz@infradead.org,
        quentin.perret@arm.com, smuckle@google.com,
        migueldedios@google.com, Patrick.Bellasi@arm.com,
        torvalds@linux-foundation.org, pjt@google.com,
        linux-kernel@vger.kernel.org, joaodias@google.com,
        mingo@kernel.org, hpa@zytor.com, Chris.Redpath@arm.com
Reply-To: tglx@linutronix.de, dietmar.eggemann@arm.com,
          Morten.Rasmussen@arm.com, tkjos@google.com, peterz@infradead.org,
          smuckle@google.com, quentin.perret@arm.com,
          migueldedios@google.com, torvalds@linux-foundation.org,
          Patrick.Bellasi@arm.com, pjt@google.com,
          linux-kernel@vger.kernel.org, joaodias@google.com,
          mingo@kernel.org, hpa@zytor.com, Chris.Redpath@arm.com
In-Reply-To: <20180831224217.169476-1-smuckle@google.com>
References: <20180831224217.169476-1-smuckle@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix vruntime_normalized() for remote
 non-migration wakeup
Git-Commit-ID: d0cdb3ce8834332d918fc9c8ff74f8a169ec9abe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d0cdb3ce8834332d918fc9c8ff74f8a169ec9abe
Gitweb:     https://git.kernel.org/tip/d0cdb3ce8834332d918fc9c8ff74f8a169ec9abe
Author:     Steve Muckle <smuckle@google.com>
AuthorDate: Fri, 31 Aug 2018 15:42:17 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:13:47 +0200

sched/fair: Fix vruntime_normalized() for remote non-migration wakeup

When a task which previously ran on a given CPU is remotely queued to
wake up on that same CPU, there is a period where the task's state is
TASK_WAKING and its vruntime is not normalized. This is not accounted
for in vruntime_normalized() which will cause an error in the task's
vruntime if it is switched from the fair class during this time.

For example if it is boosted to RT priority via rt_mutex_setprio(),
rq->min_vruntime will not be subtracted from the task's vruntime but
it will be added again when the task returns to the fair class. The
task's vruntime will have been erroneously doubled and the effective
priority of the task will be reduced.

Note this will also lead to inflation of all vruntimes since the doubled
vruntime value will become the rq's min_vruntime when other tasks leave
the rq. This leads to repeated doubling of the vruntime and priority
penalty.

Fix this by recognizing a WAKING task's vruntime as normalized only if
sched_remote_wakeup is true. This indicates a migration, in which case
the vruntime would have been normalized in migrate_task_rq_fair().

Based on a similar patch from John Dias <joaodias@google.com>.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Steve Muckle <smuckle@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Chris Redpath <Chris.Redpath@arm.com>
Cc: John Dias <joaodias@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel de Dios <migueldedios@google.com>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: Patrick Bellasi <Patrick.Bellasi@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: kernel-team@android.com
Fixes: b5179ac70de8 ("sched/fair: Prepare to fix fairness problems on migration")
Link: http://lkml.kernel.org/r/20180831224217.169476-1-smuckle@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8cff8d55ee95..c6b7d6daab20 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9644,7 +9644,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+	if (!se->sum_exec_runtime ||
+	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
 	return false;
