Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFF9C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464CA20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rx29F5om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464CA20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLFViv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:38:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33740 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeLFVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:38:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6LYiJh159474;
        Thu, 6 Dec 2018 21:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Q92XsM559slBxkunNq5q8saE7LteeOstRPtlDtl+k4g=;
 b=rx29F5om0uUK7q2Fpinp6be8Han7DhVVPpd1N1ffmy3VScO/Vmi8Br4xN+jU+Xzc/Dcv
 gGlUQyvRrGnm+M6rmUazysbD9xVddAm6V7exZQ8rBljGehEYJTELVs1EIUwwNiv+t9d/
 kxfek3kYfzLYOVoZ83/bW8Pa1A7mvH3GY6F9BXbLtZu7s2pCWlmS0K0CaCE4CPeaR/iX
 lzCe53jmCrOyB/3WW+4y/dX/9DWi/ukZMZRuIXaxCLnKfcYm7aa+jEFKFGpN1BiE2uT3
 ORWKWWHSu0BpWM4XKrc5aqg6Xcf15+b37gCrADjA9l0pcmr+UfQJh787CuFr1gZJmqdI yw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2p3ftfenfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 21:38:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcI2d007204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 21:38:18 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB6LcHEj001035;
        Thu, 6 Dec 2018 21:38:17 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 21:38:17 +0000
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] sched/topology: Provide cfs_overload_cpus bitmap
Date:   Thu,  6 Dec 2018 13:28:09 -0800
Message-Id: <1544131696-2888-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Sistare <steve.sistare@oracle.com>

Define and initialize a sparse bitmap of overloaded CPUs, per
last-level-cache scheduling domain, for use by the CFS scheduling class.
Save a pointer to cfs_overload_cpus in the rq for efficient access.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 25 +++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6b99761..b173a77 100644
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
index 618577f..eacf5db 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -81,6 +81,7 @@
 
 struct rq;
 struct cpuidle_state;
+struct sparsemask;
 
 /* task_struct::on_rq states: */
 #define TASK_ON_RQ_QUEUED	1
@@ -812,6 +813,7 @@ struct rq {
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
+	struct sparsemask	*cfs_overload_cpus;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3e72ce0..89a78ce 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3,6 +3,7 @@
  * Scheduler topology setup/handling methods
  */
 #include "sched.h"
+#include "sparsemask.h"
 
 DEFINE_MUTEX(sched_domains_mutex);
 
@@ -410,7 +411,9 @@ static void destroy_sched_domains(struct sched_domain *sd)
 
 static void update_top_cache_domain(int cpu)
 {
+	struct sparsemask *cfs_overload_cpus = NULL;
 	struct sched_domain_shared *sds = NULL;
+	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *sd;
 	int id = cpu;
 	int size = 1;
@@ -420,8 +423,10 @@ static void update_top_cache_domain(int cpu)
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
 		sds = sd->shared;
+		cfs_overload_cpus = sds->cfs_overload_cpus;
 	}
 
+	rcu_assign_pointer(rq->cfs_overload_cpus, cfs_overload_cpus);
 	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
 	per_cpu(sd_llc_size, cpu) = size;
 	per_cpu(sd_llc_id, cpu) = id;
@@ -1621,7 +1626,22 @@ static void __sdt_free(const struct cpumask *cpu_map)
 
 static int sd_llc_alloc(struct sched_domain *sd)
 {
-	/* Allocate sd->shared data here. Empty for now. */
+	struct sched_domain_shared *sds = sd->shared;
+	struct cpumask *span = sched_domain_span(sd);
+	int nid = cpu_to_node(cpumask_first(span));
+	int flags = __GFP_ZERO | GFP_KERNEL;
+	struct sparsemask *mask;
+
+	/*
+	 * Allocate the bitmap if not already allocated.  This is called for
+	 * every CPU in the LLC but only allocates once per sd_llc_shared.
+	 */
+	if (!sds->cfs_overload_cpus) {
+		mask = sparsemask_alloc_node(nr_cpu_ids, 3, flags, nid);
+		if (!mask)
+			return 1;
+		sds->cfs_overload_cpus = mask;
+	}
 
 	return 0;
 }
@@ -1633,7 +1653,8 @@ static void sd_llc_free(struct sched_domain *sd)
 	if (!sds)
 		return;
 
-	/* Free data here. Empty for now. */
+	sparsemask_free(sds->cfs_overload_cpus);
+	sds->cfs_overload_cpus = NULL;
 }
 
 static int sd_llc_alloc_all(const struct cpumask *cpu_map, struct s_data *d)
-- 
1.8.3.1

