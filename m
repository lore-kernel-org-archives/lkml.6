Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970851AbeEXPaB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:30:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37615 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966825AbeEXP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:29:57 -0400
X-Google-Smtp-Source: AB8JxZqti1kvsrYY/LK/tAmJL9ub1WR70MhM3VEdUoeoUEuyO1iP77oUDK07v6R9CybETKOeUjk8ww==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sched/topology: Clarify root domain(s) debug string
Date: Thu, 24 May 2018 17:29:36 +0200
Message-Id: <20180524152936.17611-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scheduler debug is enabled, building scheduling domains outputs
information about how the domains are laid out and to which root domain
each CPU (or sets of CPUs) belongs, e.g.:

 CPU0 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
 CPU1 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }

 [...]

 span: 0-5 (max cpu_capacity = 1024)

The fact that latest line refers to CPUs 0-5 root domain doesn't however look
immediately obvious to me: one might wonder why span 0-5 is reported "again".

Make it more clear by adding "root domain" to it, as to end with the
following.

 CPU0 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
 CPU1 attaching sched-domain(s):
  domain-0: span=0-5 level=MC
   groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }

 [...]

 root domain span: 0-5 (max cpu_capacity = 1024)

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..61a1125c1ae4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1708,7 +1708,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	rcu_read_unlock();
 
 	if (rq && sched_debug_enabled) {
-		pr_info("span: %*pbl (max cpu_capacity = %lu)\n",
+		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
 	}
 
-- 
2.14.3
