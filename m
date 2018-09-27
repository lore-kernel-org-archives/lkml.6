Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07311C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC56821533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC56821533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeI0Pt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:49:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeI0Pt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:49:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5EC6E1120;
        Thu, 27 Sep 2018 09:32:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steve Muckle <smuckle@google.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        John Dias <joaodias@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel de Dios <migueldedios@google.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>, kernel-team@android.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 39/44] sched/fair: Fix vruntime_normalized() for remote non-migration wakeup
Date:   Thu, 27 Sep 2018 11:04:28 +0200
Message-Id: <20180927090124.114697672@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
References: <20180927090117.997362691@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Muckle <smuckle@google.com>

commit d0cdb3ce8834332d918fc9c8ff74f8a169ec9abe upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/fair.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8639,7 +8639,8 @@ static inline bool vruntime_normalized(s
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+	if (!se->sum_exec_runtime ||
+	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
 	return false;


