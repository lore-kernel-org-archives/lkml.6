Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6D2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE60F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="cLuDWGxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE60F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbeIHCYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:19 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:60236 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbeIHCYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356483; x=1567892483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oU6+ToIHR70hf2UcDbePrNlBRyzUIVcZFSg2fyb9q90=;
  b=cLuDWGxTySdXa3ZToL1+KGZ+WWBGVzEhK/XI1WalXizVwvTJr9mS3/DL
   JWdbZ/OtRtzqVmA/Jo+mncpcNdDrn8Zgl4FzS+kUkqCkbBWKIkuK4xkEh
   s4N2JWS8YJmUlY6tfGUJdbD+NzESV+RF7JbxRiNfjF4R8+ZxxnFL3ssvH
   M=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="355980785"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:22 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfHmi096499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:19 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfFsG027125
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:15 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfEYn027124;
        Fri, 7 Sep 2018 23:41:14 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 04/60] sched: Replace sd_numa_mask() hack with something sane
Date:   Fri,  7 Sep 2018 23:39:51 +0200
Message-Id: <20180907214047.26914-5-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the global variable sched_domains_curr_level, which is used
to pass state into a sd_numa_mask(), which is used as a callback for
sched_domain_topology_level->mask().

Extend the ->mask() callback instead, so that it takes the topology level
as an extra argument. Provide a backward compatible ->simple_mask()
callback, so that existing code can stay as it is.

This enables other users to do queries via ->mask() without having to
worry about the global variable. It also opens up the possibility for
more generic topologies that require a dynamic number of levels (similar
to what NUMA already does on top of the system topology).

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 include/linux/sched/topology.h | 11 ++++++++---
 kernel/sched/topology.c        | 40 ++++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 530ad856372e..f78534f1cc1e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -165,7 +165,11 @@ void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
 bool cpus_share_cache(int this_cpu, int that_cpu);
 
-typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
+struct sched_domain_topology_level;
+
+typedef const struct cpumask *(*sched_domain_simple_mask_f)(int cpu);
+typedef const struct cpumask *(*sched_domain_mask_f)(struct sched_domain_topology_level *tl,
+						     int cpu);
 typedef int (*sched_domain_flags_f)(void);
 
 #define SDTL_OVERLAP	0x01
@@ -178,10 +182,11 @@ struct sd_data {
 };
 
 struct sched_domain_topology_level {
-	sched_domain_mask_f mask;
+	sched_domain_simple_mask_f simple_mask;
 	sched_domain_flags_f sd_flags;
+	sched_domain_mask_f mask;
 	int		    flags;
-	int		    numa_level;
+	int		    level;
 	struct sd_data      data;
 #ifdef CONFIG_SCHED_DEBUG
 	char                *name;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8b64f3f57d50..0f2c3aa0a097 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1043,7 +1043,6 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 enum numa_topology_type sched_numa_topology_type;
 
 static int			sched_domains_numa_levels;
-static int			sched_domains_curr_level;
 
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
@@ -1084,15 +1083,9 @@ sd_init(struct sched_domain_topology_level *tl,
 	struct sd_data *sdd = &tl->data;
 	struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
 	int sd_id, sd_weight, sd_flags = 0;
+	const struct cpumask *mask = tl->mask(tl, cpu);
 
-#ifdef CONFIG_NUMA
-	/*
-	 * Ugly hack to pass state to sd_numa_mask()...
-	 */
-	sched_domains_curr_level = tl->numa_level;
-#endif
-
-	sd_weight = cpumask_weight(tl->mask(cpu));
+	sd_weight = cpumask_weight(mask);
 
 	if (tl->sd_flags)
 		sd_flags = (*tl->sd_flags)();
@@ -1138,7 +1131,7 @@ sd_init(struct sched_domain_topology_level *tl,
 #endif
 	};
 
-	cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
+	cpumask_and(sched_domain_span(sd), cpu_map, mask);
 	sd_id = cpumask_first(sched_domain_span(sd));
 
 	/*
@@ -1170,7 +1163,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->idle_idx = 2;
 
 		sd->flags |= SD_SERIALIZE;
-		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
+		if (sched_domains_numa_distance[tl->level] > RECLAIM_DISTANCE) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
 				       SD_BALANCE_FORK |
 				       SD_WAKE_AFFINE);
@@ -1195,17 +1188,23 @@ sd_init(struct sched_domain_topology_level *tl,
 	return sd;
 }
 
+static const struct cpumask *
+sd_simple_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return tl->simple_mask(cpu);
+}
+
 /*
  * Topology list, bottom-up.
  */
 static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+	{ cpu_smt_mask, cpu_smt_flags, sd_simple_mask, SD_INIT_NAME(SMT) },
 #endif
 #ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+	{ cpu_coregroup_mask, cpu_core_flags, sd_simple_mask, SD_INIT_NAME(MC) },
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, NULL, sd_simple_mask, SD_INIT_NAME(DIE) },
 	{ NULL, },
 };
 
@@ -1221,13 +1220,18 @@ void set_sched_topology(struct sched_domain_topology_level *tl)
 		return;
 
 	sched_domain_topology = tl;
+	for (; tl->mask || tl->simple_mask; tl++) {
+		if (tl->simple_mask)
+			tl->mask = sd_simple_mask;
+	}
 }
 
 #ifdef CONFIG_NUMA
 
-static const struct cpumask *sd_numa_mask(int cpu)
+static const struct cpumask *
+sd_numa_mask(struct sched_domain_topology_level *tl, int cpu)
 {
-	return sched_domains_numa_masks[sched_domains_curr_level][cpu_to_node(cpu)];
+	return sched_domains_numa_masks[tl->level][cpu_to_node(cpu)];
 }
 
 static void sched_numa_warn(const char *str)
@@ -1446,7 +1450,7 @@ void sched_init_numa(void)
 	 */
 	tl[i++] = (struct sched_domain_topology_level){
 		.mask = sd_numa_mask,
-		.numa_level = 0,
+		.level = 0,
 		SD_INIT_NAME(NODE)
 	};
 
@@ -1458,7 +1462,7 @@ void sched_init_numa(void)
 			.mask = sd_numa_mask,
 			.sd_flags = cpu_numa_flags,
 			.flags = SDTL_OVERLAP,
-			.numa_level = j,
+			.level = j,
 			SD_INIT_NAME(NUMA)
 		};
 	}
-- 
2.9.3.1.gcba166c.dirty

