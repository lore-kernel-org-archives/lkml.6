Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF152ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F78220881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F78220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbeGXNcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:32:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50000 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388264AbeGXNcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:32:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DF5C80D;
        Tue, 24 Jul 2018 05:25:59 -0700 (PDT)
Received: from e108498-lin.Emea.Arm.com (e108498-lin.emea.arm.com [10.4.13.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 747533F6A8;
        Tue, 24 Jul 2018 05:25:55 -0700 (PDT)
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
Subject: [PATCH v5 06/14] sched/topology: Lowest energy aware balancing sched_domain level pointer
Date:   Tue, 24 Jul 2018 13:25:13 +0100
Message-Id: <20180724122521.22109-7-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
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
example, it is possible to apply Energy-Aware Scheduling within a socket
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
index fdf6924d53e7..25d64a0b6fe0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1198,6 +1198,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_ea);
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ade1eae9d21b..8f3f746b0d5e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -514,6 +514,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_ea);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -539,6 +540,9 @@ static void update_top_cache_domain(int cpu)
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	rcu_assign_pointer(per_cpu(sd_ea, cpu), sd);
 }
 
 /*
-- 
2.18.0

