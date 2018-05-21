Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeEUO0x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:26:53 -0400
Received: from foss.arm.com ([217.140.101.70]:51080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753017AbeEUOZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:25:57 -0400
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com,
        joelaf@google.com, smuckle@google.com, adharmap@quicinc.com,
        skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v3 08/10] sched: Lowest energy aware balancing sched_domain level pointer
Date: Mon, 21 May 2018 15:25:03 +0100
Message-Id: <20180521142505.6522-9-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521142505.6522-1-quentin.perret@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index 0dd895554f78..31535198f545 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1151,6 +1151,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_ea);
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3e22c798f18d..8e7ee37771bb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -398,6 +398,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_ea);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -423,6 +424,9 @@ static void update_top_cache_domain(int cpu)
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	rcu_assign_pointer(per_cpu(sd_ea, cpu), sd);
 }
 
 /*
-- 
2.17.0
