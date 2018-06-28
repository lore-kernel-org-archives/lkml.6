Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7927CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5F92729F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F92729F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965638AbeF1Llc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:41:32 -0400
Received: from foss.arm.com ([217.140.101.70]:45836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965570AbeF1Ll1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81D215AD;
        Thu, 28 Jun 2018 04:41:26 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 908453F266;
        Thu, 28 Jun 2018 04:41:22 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v4 06/12] sched/topology: Lowest energy aware balancing sched_domain level pointer
Date:   Thu, 28 Jun 2018 12:40:37 +0100
Message-Id: <20180628114043.24724-7-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another member to the family of per-cpu sched_domain shortcut
pointers. This one, sd_ea, points to the lowest level at which energy
aware scheduling should be used.

Generally speaking, the largest opportunity to save energy via scheduling
comes from a smarter exploitation of heterogeneous platforms (i.e.
big.LITTLE). Consequently, the sd_ea shortcut is wired to the lowest
scheduling domain at which the SD_ASYM_CPUCAPACITY flag is set. For
example, it is possible to apply energy-aware scheduling within a socket
on a multi-socket system, as long as each socket has an asymmetric
topology. Cross-sockets wake-up balancing will only happen when the
system is over-utilized, or this_cpu and prev_cpu are in different
sockets.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    | 1 +
 kernel/sched/topology.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7038df9fb713..1c32714aed0d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1168,6 +1168,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_ea);
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 357eff55c1a7..368669fbf0f0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -414,6 +414,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_ea);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -439,6 +440,9 @@ static void update_top_cache_domain(int cpu)
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	rcu_assign_pointer(per_cpu(sd_ea, cpu), sd);
 }
 
 /*
-- 
2.17.1

