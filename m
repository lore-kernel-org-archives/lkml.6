Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7507C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845D23BFB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7845D23BFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934643AbeGDKSc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:18:32 -0400
Received: from foss.arm.com ([217.140.101.70]:35112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934329AbeGDKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A5FF1650;
        Wed,  4 Jul 2018 03:18:30 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D63183F5AD;
        Wed,  4 Jul 2018 03:18:28 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 11/12] sched/core: Disable SD_ASYM_CPUCAPACITY for root_domains without asymmetry
Date:   Wed,  4 Jul 2018 11:17:49 +0100
Message-Id: <1530699470-29808-12-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hotplugging cpus out or creating exclusive cpusets (disabling
sched_load_balance) systems which were asymmetric at boot might become
symmetric. In this case leaving the flag set might lead to suboptimal
scheduling decisions.

The arch-code proving the flag doesn't have visibility of the cpuset
configuration so it must either be told by passing a cpumask or the
generic topology code has to verify if the flag should still be set
when taking the actual sched_domain_span() into account. This patch
implements the latter approach.

We need to detect capacity based on calling arch_scale_cpu_capacity()
directly as rq->cpu_capacity_orig hasn't been set yet early in the boot
process.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/topology.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 71330e0e41db..29c186961345 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1160,6 +1160,26 @@ sd_init(struct sched_domain_topology_level *tl,
 	sd_id = cpumask_first(sched_domain_span(sd));
 
 	/*
+	 * Check if cpu_map eclipses cpu capacity asymmetry.
+	 */
+
+	if (sd->flags & SD_ASYM_CPUCAPACITY) {
+		int i;
+		bool disable = true;
+		long capacity = arch_scale_cpu_capacity(NULL, sd_id);
+
+		for_each_cpu(i, sched_domain_span(sd)) {
+			if (capacity != arch_scale_cpu_capacity(NULL, i)) {
+				disable = false;
+				break;
+			}
+		}
+
+		if (disable)
+			sd->flags &= ~SD_ASYM_CPUCAPACITY;
+	}
+
+	/*
 	 * Convert topological properties into behaviour.
 	 */
 
-- 
2.7.4

