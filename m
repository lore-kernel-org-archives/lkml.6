Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E077C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458C420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458C420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeIJPJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:09:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:09:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAFR5d1808144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:15:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAFRHb1808141;
        Mon, 10 Sep 2018 03:15:27 -0700
Date:   Mon, 10 Sep 2018 03:15:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-5fbdfae5221a5208ed8e7653fc1c4b31de420f74@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, morten.rasmussen@arm.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, morten.rasmussen@arm.com, tglx@linutronix.de,
          hpa@zytor.com, peterz@infradead.org,
          torvalds@linux-foundation.org, valentin.schneider@arm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1530699470-29808-6-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-6-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Kick nohz balance if
 rq->misfit_task_load
Git-Commit-ID: 5fbdfae5221a5208ed8e7653fc1c4b31de420f74
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

Commit-ID:  5fbdfae5221a5208ed8e7653fc1c4b31de420f74
Gitweb:     https://git.kernel.org/tip/5fbdfae5221a5208ed8e7653fc1c4b31de420f74
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:43 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:51 +0200

sched/fair: Kick nohz balance if rq->misfit_task_load

There already are a few conditions in nohz_kick_needed() to ensure
a nohz kick is triggered, but they are not enough for some misfit
task scenarios. Excluding asym packing, those are:

 - rq->nr_running >=2: Not relevant here because we are running a
   misfit task, it needs to be migrated regardless and potentially through
   active balance.

 - sds->nr_busy_cpus > 1: If there is only the misfit task being run
   on a group of low capacity CPUs, this will be evaluated to False.

 - rq->cfs.h_nr_running >=1 && check_cpu_capacity(): Not relevant here,
   misfit task needs to be migrated regardless of rt/IRQ pressure

As such, this commit adds an rq->misfit_task_load condition to trigger a
nohz kick.

The idea to kick a nohz balance for misfit tasks originally came from
Leo Yan <leo.yan@linaro.org>, and a similar patch was submitted for
the Android Common Kernel - see:

  https://lists.linaro.org/pipermail/eas-dev/2016-September/000551.html

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-6-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24fe39e57bc3..e08287d3806f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9135,7 +9135,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	if (rq->nr_running >= 2) {
+	if (rq->nr_running >= 2 || rq->misfit_task_load) {
 		flags = NOHZ_KICK_MASK;
 		goto out;
 	}
