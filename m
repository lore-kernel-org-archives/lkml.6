Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeDXAjb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:39:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeDXAjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:39:00 -0400
From: subhra mazumdar <subhra.mazumdar@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, daniel.lezcano@linaro.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, subhra.mazumdar@oracle.com
Subject: [PATCH 2/3] sched: introduce per-cpu var next_cpu to track search limit
Date: Mon, 23 Apr 2018 17:41:15 -0700
Message-Id: <20180424004116.28151-3-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a per-cpu variable to track the limit upto which idle cpu search
was done in select_idle_cpu(). This will help to start the search next time
from there. This is necessary for rotating the search window over entire
LLC domain.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/core.c  | 2 ++
 kernel/sched/sched.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aae..cd5c08d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -17,6 +17,7 @@
 #include <trace/events/sched.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(HAVE_JUMP_LABEL)
 /*
@@ -6018,6 +6019,7 @@ void __init sched_init(void)
 		struct rq *rq;
 
 		rq = cpu_rq(i);
+		per_cpu(next_cpu, i) = -1;
 		raw_spin_lock_init(&rq->lock);
 		rq->nr_running = 0;
 		rq->calc_load_active = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3f1874c..a2db041 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -902,6 +902,7 @@ extern struct static_key_false sched_smt_present;
 #endif
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DECLARE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
-- 
2.9.3
