Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB0EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41072150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41072150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934681AbeGDKUn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:20:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934454AbeGDKST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918A81688;
        Wed,  4 Jul 2018 03:18:19 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A7F23F5AD;
        Wed,  4 Jul 2018 03:18:17 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 05/12] sched/fair: Kick nohz balance if rq->misfit_task_load
Date:   Wed,  4 Jul 2018 11:17:43 +0100
Message-Id: <1530699470-29808-6-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

There already are a few conditions in nohz_kick_needed() to ensure
a nohz kick is triggered, but they are not enough for some misfit
task scenarios. Excluding asym packing, those are:

* rq->nr_running >=2: Not relevant here because we are running a
misfit task, it needs to be migrated regardless and potentially through
active balance.
* sds->nr_busy_cpus > 1: If there is only the misfit task being run
on a group of low capacity cpus, this will be evaluated to False.
* rq->cfs.h_nr_running >=1 && check_cpu_capacity(): Not relevant here,
misfit task needs to be migrated regardless of rt/IRQ pressure

As such, this commit adds an rq->misfit_task_load condition to trigger a
nohz kick.

The idea to kick a nohz balance for misfit tasks originally came from
Leo Yan <leo.yan@linaro.org>, and a similar patch was submitted for
the Android Common Kernel - see [1].

[1]: https://lists.linaro.org/pipermail/eas-dev/2016-September/000551.html

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e885d92fad2..acec93e1dc51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9505,7 +9505,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	if (rq->nr_running >= 2) {
+	if (rq->nr_running >= 2 || rq->misfit_task_load) {
 		flags = NOHZ_KICK_MASK;
 		goto out;
 	}
-- 
2.7.4

