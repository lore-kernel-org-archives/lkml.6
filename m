Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAABCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719C821532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719C821532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeGDKUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:20:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934471AbeGDKSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E7B016A3;
        Wed,  4 Jul 2018 03:18:21 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D12773F5AD;
        Wed,  4 Jul 2018 03:18:19 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 06/12] sched/fair: Change prefer_sibling type to bool
Date:   Wed,  4 Jul 2018 11:17:44 +0100
Message-Id: <1530699470-29808-7-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

This variable is entirely local to update_sd_lb_stats, so we can
safely change its type and slightly clean up its initialisation.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index acec93e1dc51..ee26eeb188ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8352,11 +8352,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx, prefer_sibling = 0;
+	int load_idx;
 	bool overload = false;
-
-	if (child && child->flags & SD_PREFER_SIBLING)
-		prefer_sibling = 1;
+	bool prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
-- 
2.7.4

