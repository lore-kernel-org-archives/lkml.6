Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2016020BEC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2016020BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934684AbeGDKSx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:18:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35122 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934620AbeGDKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D7D1684;
        Wed,  4 Jul 2018 03:18:32 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9739D3F5AD;
        Wed,  4 Jul 2018 03:18:30 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 12/12] sched/core: Disable SD_PREFER_SIBLING on asymmetric cpu capacity domains
Date:   Wed,  4 Jul 2018 11:17:50 +0100
Message-Id: <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'prefer sibling' sched_domain flag is intended to encourage
spreading tasks to sibling sched_domain to take advantage of more caches
and core for SMT systems. It has recently been changed to be on all
non-NUMA topology level. However, spreading across domains with cpu
capacity asymmetry isn't desirable, e.g. spreading from high capacity to
low capacity cpus even if high capacity cpus aren't overutilized might
give access to more cache but the cpu will be slower and possibly lead
to worse overall throughput.

To prevent this, we need to remove SD_PREFER_SIBLING on the sched_domain
level immediately below SD_ASYM_CPUCAPACITY.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/topology.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 29c186961345..00c7a08c7f77 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1140,7 +1140,7 @@ sd_init(struct sched_domain_topology_level *tl,
 					| 0*SD_SHARE_CPUCAPACITY
 					| 0*SD_SHARE_PKG_RESOURCES
 					| 0*SD_SERIALIZE
-					| 0*SD_PREFER_SIBLING
+					| 1*SD_PREFER_SIBLING
 					| 0*SD_NUMA
 					| sd_flags
 					,
@@ -1186,17 +1186,21 @@ sd_init(struct sched_domain_topology_level *tl,
 	if (sd->flags & SD_ASYM_CPUCAPACITY) {
 		struct sched_domain *t = sd;
 
+		/*
+		 * Don't attempt to spread across cpus of different capacities.
+		 */
+		if (sd->child)
+			sd->child->flags &= ~SD_PREFER_SIBLING;
+
 		for_each_lower_domain(t)
 			t->flags |= SD_BALANCE_WAKE;
 	}
 
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
-		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 110;
 		sd->smt_gain = 1178; /* ~15% */
 
 	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
-		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 117;
 		sd->cache_nice_tries = 1;
 		sd->busy_idx = 2;
@@ -1207,6 +1211,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->busy_idx = 3;
 		sd->idle_idx = 2;
 
+		sd->flags &= ~SD_PREFER_SIBLING;
 		sd->flags |= SD_SERIALIZE;
 		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
@@ -1216,7 +1221,6 @@ sd_init(struct sched_domain_topology_level *tl,
 
 #endif
 	} else {
-		sd->flags |= SD_PREFER_SIBLING;
 		sd->cache_nice_tries = 1;
 		sd->busy_idx = 2;
 		sd->idle_idx = 1;
-- 
2.7.4

