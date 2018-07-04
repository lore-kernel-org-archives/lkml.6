Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6E62400B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6E62400B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeGDKS0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:18:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35054 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934329AbeGDKSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A6461713;
        Wed,  4 Jul 2018 03:18:23 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C68C3F5AD;
        Wed,  4 Jul 2018 03:18:21 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 07/12] sched: Change root_domain->overload type to int
Date:   Wed,  4 Jul 2018 11:17:45 +0100
Message-Id: <1530699470-29808-8-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

sizeof(_Bool) is implementation defined, so let's just go with 'int' as
is done for other structures e.g. sched_domain_shared->has_idle_cores.

The local 'overload' variable used in update_sd_lb_stats can remain
bool, as it won't impact any struct layout and can be assigned to the
root_domain field.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c39a07e8a68..648224b23287 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -696,7 +696,7 @@ struct root_domain {
 	cpumask_var_t		online;
 
 	/* Indicate more than one runnable task for any CPU */
-	bool			overload;
+	int			overload;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
@@ -1673,7 +1673,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
 		if (!rq->rd->overload)
-			rq->rd->overload = true;
+			rq->rd->overload = 1;
 #endif
 	}
 
-- 
2.7.4

