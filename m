Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D32C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C2F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C2F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJPSFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJPSFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 657F8A78;
        Tue, 16 Oct 2018 03:15:50 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B813F59C;
        Tue, 16 Oct 2018 03:15:46 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v8 06/15] sched/topology: Lowest CPU asymmetry sched_domain level pointer
Date:   Tue, 16 Oct 2018 11:15:04 +0100
Message-Id: <20181016101513.26919-7-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another member to the family of per-cpu sched_domain shortcut
pointers. This one, sd_asym_cpucapacity, points to the lowest level
at which the SD_ASYM_CPUCAPACITY flag is set. While at it, rename the
sd_asym shortcut to sd_asym_packing to avoid confusions.

Generally speaking, the largest opportunity to save energy via
scheduling comes from a smarter exploitation of heterogeneous platforms
(i.e. big.LITTLE). Consequently, the sd_asym_cpucapacity shortcut will
be used at first as the lowest domain where Energy-Aware Scheduling
(EAS) should be applied. For example, it is possible to apply EAS within
a socket on a multi-socket system, as long as each socket has an
asymmetric topology. Energy-aware cross-sockets wake-up balancing can
only happen if this_cpu and prev_cpu are in different sockets.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 3 ++-
 kernel/sched/topology.c | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d59307ecd67d..e60858745071 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9221,7 +9221,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
-	sd = rcu_dereference(per_cpu(sd_asym, cpu));
+	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
 		for_each_cpu(i, sched_domain_span(sd)) {
 			if (i == cpu ||
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e82c7d464dc1..dcf4ec24f719 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1203,7 +1203,8 @@ DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9d17d0989e48..b5aa56437758 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,7 +508,8 @@ DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
@@ -534,7 +535,10 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
-	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
+
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
 /*
-- 
2.19.1

