Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D7620870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D7620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeIJPM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:12:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:12:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAIkcW1808678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:18:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAIkUZ1808675;
        Mon, 10 Sep 2018 03:18:46 -0700
Date:   Mon, 10 Sep 2018 03:18:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-9c63e84db29bcf584040931ad97c2edd11e35f6c@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, morten.rasmussen@arm.com, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, morten.rasmussen@arm.com,
          hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Disable SD_PREFER_SIBLING on
 asymmetric CPU capacity domains
Git-Commit-ID: 9c63e84db29bcf584040931ad97c2edd11e35f6c
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

Commit-ID:  9c63e84db29bcf584040931ad97c2edd11e35f6c
Gitweb:     https://git.kernel.org/tip/9c63e84db29bcf584040931ad97c2edd11e35f6c
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:50 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:54 +0200

sched/core: Disable SD_PREFER_SIBLING on asymmetric CPU capacity domains

The 'prefer sibling' sched_domain flag is intended to encourage
spreading tasks to sibling sched_domain to take advantage of more caches
and core for SMT systems. It has recently been changed to be on all
non-NUMA topology level. However, spreading across domains with CPU
capacity asymmetry isn't desirable, e.g. spreading from high capacity to
low capacity CPUs even if high capacity CPUs aren't overutilized might
give access to more cache but the CPU will be slower and possibly lead
to worse overall throughput.

To prevent this, we need to remove SD_PREFER_SIBLING on the sched_domain
level immediately below SD_ASYM_CPUCAPACITY.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-13-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 2536e1b938f9..7ffad0d3a4eb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1126,7 +1126,7 @@ sd_init(struct sched_domain_topology_level *tl,
 					| 0*SD_SHARE_CPUCAPACITY
 					| 0*SD_SHARE_PKG_RESOURCES
 					| 0*SD_SERIALIZE
-					| 0*SD_PREFER_SIBLING
+					| 1*SD_PREFER_SIBLING
 					| 0*SD_NUMA
 					| sd_flags
 					,
@@ -1152,17 +1152,21 @@ sd_init(struct sched_domain_topology_level *tl,
 	if (sd->flags & SD_ASYM_CPUCAPACITY) {
 		struct sched_domain *t = sd;
 
+		/*
+		 * Don't attempt to spread across CPUs of different capacities.
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
@@ -1173,6 +1177,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->busy_idx = 3;
 		sd->idle_idx = 2;
 
+		sd->flags &= ~SD_PREFER_SIBLING;
 		sd->flags |= SD_SERIALIZE;
 		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
@@ -1182,7 +1187,6 @@ sd_init(struct sched_domain_topology_level *tl,
 
 #endif
 	} else {
-		sd->flags |= SD_PREFER_SIBLING;
 		sd->cache_nice_tries = 1;
 		sd->busy_idx = 2;
 		sd->idle_idx = 1;
