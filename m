Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968F82081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S3/JP+D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968F82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbeKFFkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:40:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40094 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:39:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5KEHfX036164;
        Mon, 5 Nov 2018 20:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=05nnPqw9uRoa9S7czKsl8/9xr5NCLycbSz2FN1K01/U=;
 b=S3/JP+D2RGvPo/tKPcDHI2NzGLKhOs5vxBf+QSBjabmqs6o08kxHIrarx0iu4XmR2MOy
 pnDvMNPT/Dzy88+fOyAO8d7mFsxI+jBRtvo9tlO2prr/v92NmWPJr1EBJybGm5sFHOVn
 MoA847N7g4Y0gFEa2LF0p/huTBN7jrGFjIXQWxOisLhflPLkyvIxCfIyVw+WFQ97VweH
 meiUWCIZciEl73gSI8qOppeiolio/nQNOpr2TQ7f/oaNgdAM8BPpn1Kx613k9hnnDJ7z
 FDsJRUb+rwaje9zzwb7yWV8w+GUK4mi91xR/e13wCk3NNJN6vcM8NjLjdVddW46oJolX Ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4aqh7dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 20:17:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA5KHEfj011824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 20:17:14 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA5KHEsS032060;
        Mon, 5 Nov 2018 20:17:14 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 12:17:14 -0800
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] sched/topology: Provide cfs_overload_cpus bitmap
Date:   Mon,  5 Nov 2018 12:08:02 -0800
Message-Id: <1541448489-19692-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541448489-19692-1-git-send-email-steven.sistare@oracle.com>
References: <1541448489-19692-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050180
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

