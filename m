Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B520819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xPdplUBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2B520819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeKFFi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:38:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeKFFi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:38:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5KDvuM088303;
        Mon, 5 Nov 2018 20:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ExS1UbHdId9/FAxTu1HMNpgGx2qdx1KCQpsPq6VOJ6s=;
 b=xPdplUBFtOGwPudUmDg+EsjE0XQ3WMvvsYvDLWjVEUINFPJ+wDLajnXs5xfNUoAQ6Kpk
 rxCOnHhzk+AdKyFMT2DvC5qM0qKrQjTh6yG7zRA9PAayIX12JRamnyq90IJ/w8rRdxPO
 FdfaQmsQFTJsGRw1OlFnjntOPMZDBQd1HYZzOrRboC5XCGBu7fVI+pbo72VAl71srECb
 CJf8+6tt18ymC56wz6v7vgC2ZQ6OrtKG2hjxvIRzUto6ABED2vNvigew6uxrEHYKZstU
 b1nt/+0eWyr33CnOGmEfsOSPXjGdZtK8pTZ4wnyT55Ms/Ddr3Q2rCCpIOT/M4mXQqoji KQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mphae1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 20:17:14 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA5KHDrY015406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 20:17:13 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA5KHD79032055;
        Mon, 5 Nov 2018 20:17:13 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 12:17:13 -0800
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] sched/topology: Provide hooks to allocate data shared per LLC
Date:   Mon,  5 Nov 2018 12:08:01 -0800
Message-Id: <1541448489-19692-3-git-send-email-steven.sistare@oracle.com>
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

Add functions sd_llc_alloc_all() and sd_llc_free_all() to allocate and
free data pointed to by struct sched_domain_shared at the last-level-cache
domain.  sd_llc_alloc_all() is called after the SD hierarchy is known, to
eliminate the unnecessary allocations that would occur if we instead
allocated in __sdt_alloc() and then figured out which shared nodes are
redundant.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/topology.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 505a41c..a2363f6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -10,6 +10,12 @@
 cpumask_var_t sched_domains_tmpmask;
 cpumask_var_t sched_domains_tmpmask2;
 
+struct s_data;
+static int sd_llc_alloc(struct sched_domain *sd);
+static void sd_llc_free(struct sched_domain *sd);
+static int sd_llc_alloc_all(const struct cpumask *cpu_map, struct s_data *d);
+static void sd_llc_free_all(const struct cpumask *cpu_map);
+
 #ifdef CONFIG_SCHED_DEBUG
 
 static int __init sched_debug_setup(char *str)
@@ -361,8 +367,10 @@ static void destroy_sched_domain(struct sched_domain *sd)
 	 */
 	free_sched_groups(sd->groups, 1);
 
-	if (sd->shared && atomic_dec_and_test(&sd->shared->ref))
+	if (sd->shared && atomic_dec_and_test(&sd->shared->ref)) {
+		sd_llc_free(sd);
 		kfree(sd->shared);
+	}
 	kfree(sd);
 }
 
@@ -993,6 +1001,7 @@ static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
 		free_percpu(d->sd);
 		/* Fall through */
 	case sa_sd_storage:
+		sd_llc_free_all(cpu_map);
 		__sdt_free(cpu_map);
 		/* Fall through */
 	case sa_none:
@@ -1602,6 +1611,62 @@ static void __sdt_free(const struct cpumask *cpu_map)
 	}
 }
 
+static int sd_llc_alloc(struct sched_domain *sd)
+{
+	/* Allocate sd->shared data here. Empty for now. */
+
+	return 0;
+}
+
+static void sd_llc_free(struct sched_domain *sd)
+{
+	struct sched_domain_shared *sds = sd->shared;
+
+	if (!sds)
+		return;
+
+	/* Free data here. Empty for now. */
+}
+
+static int sd_llc_alloc_all(const struct cpumask *cpu_map, struct s_data *d)
+{
+	struct sched_domain *sd, *hsd;
+	int i;
+
+	for_each_cpu(i, cpu_map) {
+		/* Find highest domain that shares resources */
+		hsd = NULL;
+		for (sd = *per_cpu_ptr(d->sd, i); sd; sd = sd->parent) {
+			if (!(sd->flags & SD_SHARE_PKG_RESOURCES))
+				break;
+			hsd = sd;
+		}
+		if (hsd && sd_llc_alloc(hsd))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void sd_llc_free_all(const struct cpumask *cpu_map)
+{
+	struct sched_domain_topology_level *tl;
+	struct sched_domain *sd;
+	struct sd_data *sdd;
+	int j;
+
+	for_each_sd_topology(tl) {
+		sdd = &tl->data;
+		if (!sdd)
+			continue;
+		for_each_cpu(j, cpu_map) {
+			sd = *per_cpu_ptr(sdd->sd, j);
+			if (sd)
+				sd_llc_free(sd);
+		}
+	}
+}
+
 static struct sched_domain *build_sched_domain(struct sched_domain_topology_level *tl,
 		const struct cpumask *cpu_map, struct sched_domain_attr *attr,
 		struct sched_domain *child, int cpu)
@@ -1690,6 +1755,14 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 		}
 	}
 
+	/*
+	 * Allocate shared sd data at last level cache.  Must be done after
+	 * domains are built above, but before the data is used in
+	 * cpu_attach_domain and descendants below.
+	 */
+	if (sd_llc_alloc_all(cpu_map, &d))
+		goto error;
+
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
-- 
1.8.3.1

