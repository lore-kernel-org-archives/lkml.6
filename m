Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFCC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7AC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DnL62sEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7AC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeJVX2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeJVX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4YuI151290;
        Mon, 22 Oct 2018 15:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=WprJOzlJBPWGc258cQJnYTco77PZ7HYOi4XDj4rVY3Y=;
 b=DnL62sEbKZh2hc+noFvdAPE/LvUofOyYdzCtwRrBNUufe1heil287hqpJHu1OScxuaBD
 +ItWYE2cA/MNV8nWVOKNd3vChxKGB5iVZkHBUpvwjkhMn4U9rkEF1TvO3Cc6MJoh0ttG
 MAjaCTKtGCXHXiqovJB6+WZCNwAUwCdPJY8CdHFNBzafLTjGWCUNjO1tVYG4JdY4d05O
 9p04ccyK7M7MiCw45+cZ90cHJerPTgTG0hdFjfBQ2lAgNdj1ICoXWU/pmHCSyTnzTM1p
 YnrtD49TLNdysDYMDOZTLYrVRPuaIJug/HpN8G91D/yvFUwnX14CRP+DwcSaL1AisoRb CQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usty8gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF98mu004997
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:08 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MF97pY029265;
        Mon, 22 Oct 2018 15:09:07 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:07 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] sched/topology: Provide cfs_overload_cpus bitmap
Date:   Mon, 22 Oct 2018 07:59:34 -0700
Message-Id: <1540220381-424433-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define and initialize a sparse bitmap of overloaded CPUs, per
last-level-cache scheduling domain, for use by the CFS scheduling class.
Save a pointer to cfs_overload_cpus in the rq for efficient access.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 21 +++++++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2634774..8bac15d 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -72,6 +72,7 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+	struct sparsemask *cfs_overload_cpus;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 455fa33..aadfe68 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -81,6 +81,7 @@
 
 struct rq;
 struct cpuidle_state;
+struct sparsemask;
 
 /* task_struct::on_rq states: */
 #define TASK_ON_RQ_QUEUED	1
@@ -805,6 +806,7 @@ struct rq {
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
+	struct sparsemask	*cfs_overload_cpus;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a2363f6..f18c416 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3,6 +3,7 @@
  * Scheduler topology setup/handling methods
  */
 #include "sched.h"
+#include <linux/sparsemask.h>
 
 DEFINE_MUTEX(sched_domains_mutex);
 
@@ -440,6 +441,7 @@ static void update_top_cache_domain(int cpu)
 static void
 cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
+	struct sparsemask *cfs_overload_cpus;
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
 
@@ -481,6 +483,10 @@ static void update_top_cache_domain(int cpu)
 	dirty_sched_domain_sysctl(cpu);
 	destroy_sched_domains(tmp);
 
+	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
+	cfs_overload_cpus = (sd ? sd->shared->cfs_overload_cpus : NULL);
+	rcu_assign_pointer(rq->cfs_overload_cpus, cfs_overload_cpus);
+
 	update_top_cache_domain(cpu);
 }
 
@@ -1611,9 +1617,19 @@ static void __sdt_free(const struct cpumask *cpu_map)
 	}
 }
 
+#define ZALLOC_MASK(maskp, nelems, node)				  \
+	(!*(maskp) && !zalloc_sparsemask_node(maskp, nelems,		  \
+					      SPARSEMASK_DENSITY_DEFAULT, \
+					      GFP_KERNEL, node))	  \
+
 static int sd_llc_alloc(struct sched_domain *sd)
 {
-	/* Allocate sd->shared data here. Empty for now. */
+	struct sched_domain_shared *sds = sd->shared;
+	struct cpumask *span = sched_domain_span(sd);
+	int nid = cpu_to_node(cpumask_first(span));
+
+	if (ZALLOC_MASK(&sds->cfs_overload_cpus, nr_cpu_ids, nid))
+		return 1;
 
 	return 0;
 }
@@ -1625,7 +1641,8 @@ static void sd_llc_free(struct sched_domain *sd)
 	if (!sds)
 		return;
 
-	/* Free data here. Empty for now. */
+	free_sparsemask(sds->cfs_overload_cpus);
+	sds->cfs_overload_cpus = NULL;
 }
 
 static int sd_llc_alloc_all(const struct cpumask *cpu_map, struct s_data *d)
-- 
1.8.3.1

