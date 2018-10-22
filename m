Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C188C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2553F2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFkkUe6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2553F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJVX2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeJVX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4Adl104035;
        Mon, 22 Oct 2018 15:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ExS1UbHdId9/FAxTu1HMNpgGx2qdx1KCQpsPq6VOJ6s=;
 b=AFkkUe6FkLgBXqhapzNo+niSJDVG6Nb+CvrjDU7fTvmPKl94/iYw7lC4kHWehuBnmXXB
 ui3WJNTSqupzlLXB+ucFDPONhNbMjWBw3hwDa5syEUXgu42GkveyZKHk/QtsTRYdwqLj
 d+PLLTRt2Du+zeQZ+o51srtNtuIvDSSdFiiahNthk0R+qVeTZn3JNpKoloHzc1zkzLVT
 eF58qsBpNainpU4vx755mrZPi63wGxTg+JQX13HK1SO5XdIjgzz+UfWFxI7Wcxky0/eU
 XRPIMp1hJLB7Mic9JHYg1h7qsJVqhsMMUhf7nevLkipkrp8o6dbS/cUXkYj6HHpT5TdM kw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n7w0qf4sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF973b004949
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:07 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MF961e008338;
        Mon, 22 Oct 2018 15:09:07 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:06 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] sched/topology: Provide hooks to allocate data shared per LLC
Date:   Mon, 22 Oct 2018 07:59:33 -0700
Message-Id: <1540220381-424433-3-git-send-email-steven.sistare@oracle.com>
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

