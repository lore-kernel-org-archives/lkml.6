Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF0AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36942081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v93YzwUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36942081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeKBT5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:57:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33272 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeKBT5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WSfPy9df5G+YivFg77NJPKofp0v8E5AS9/4kYt1NdHk=; b=v93YzwUVHl+RnbQN8qj2yDw6t
        svM63bqlqZqhAEn+jHvJsajJaxReIgJWfysrzm7rgEbrDu8JCbDCo9Y/HF6+DCYMN8YkLlpy6jKDc
        eeotKOJWuH5wx1dsAdxzwSoaCi6OhxypIwfOKQ+WVXzE9WU7QMoSuOcaRyiFn8QvSMpdEKty6cVsx
        WA9BkPo9d2IU93Vw3kqUwXY1GZpEkP4sBsxDxA+Z5klzcQY3NUbH5O/2hpxbE4s6f1ecgUfj1/vwt
        crinwN3jO7f4hEXSxdpX8SO7fsbrHH3qcWgLOpGwOijbnm66RLqDFEGxFar7rkALa6uxnVaELcHMG
        Zv3jRxKew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIX1h-0002Y1-Ss; Fri, 02 Nov 2018 10:50:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 254612029F9FF; Fri,  2 Nov 2018 11:50:03 +0100 (CET)
Date:   Fri, 2 Nov 2018 11:50:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
Message-ID: <20181102105003.GK3178@hirez.programming.kicks-ass.net>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
 <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
 <20181031204622.GB3141@hirez.programming.kicks-ass.net>
 <bf2b890a-4ce7-d0f6-0663-84a1a6e8dbd2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2b890a-4ce7-d0f6-0663-84a1a6e8dbd2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 10:01:05AM +0000, John Garry wrote:
> On 31/10/2018 20:46, Peter Zijlstra wrote:

> > > I also note that if I apply the patch, below, to reject the invalid NUMA
> > > distance, we're still getting a warning/error:
> > > 
> > > [    7.144407] CPU: All CPU(s) started at EL2
> > > [    7.148678] alternatives: patching kernel code
> > > [    7.153557] ERROR: Node-0 not representative
> > > [    7.153557]
> > > [    7.159365]   10 15 20 25
> > > [    7.162097]   15 10 25 30
> > > [    7.164832]   20 25 10 15
> > > [    7.167562]   25 30 15 10
> > 
> > Yeah, that's an 'obviously' broken topology too.
> > 
> 
> AFAICT, this conforms to ACPI spec SLIT rules, and the kernel SLIT
> validation allows this also. So maybe we should shout louder here or even
> mark the SLIT as invalid if totally broken.

Right. Part of the problem is that I only have a few necessary
conditions (symmetry, trace-identity, node0-complete-distance) for the
distance table, but together they are not sufficient to determine if a
topology is 'good'.

(also, strictly speaking, non-symmetric topologies are possible -- think
uni-directional mesh links -- we've just not ever seen and validated
those)

That said; I can certainly make this code give up and warn harder on
those conditions.

How is something like the below?

---

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9d74371e4aad..41e703dd875f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1207,6 +1218,11 @@ sd_init(struct sched_domain_topology_level *tl,
 	return sd;
 }
 
+static const struct cpumask *cpu_system_mask(int cpu)
+{
+	return cpu_online_mask;
+}
+
 /*
  * Topology list, bottom-up.
  */
@@ -1337,7 +1353,7 @@ void sched_init_numa(void)
 	int level = 0;
 	int i, j, k;
 
-	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
+	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);
 	if (!sched_domains_numa_distance)
 		return;
 
@@ -1353,39 +1369,22 @@ void sched_init_numa(void)
 	 * node_distance(i,j) in order to avoid cubic time.
 	 */
 	next_distance = curr_distance;
+
 	for (i = 0; i < nr_node_ids; i++) {
 		for (j = 0; j < nr_node_ids; j++) {
-			for (k = 0; k < nr_node_ids; k++) {
-				int distance = node_distance(i, k);
-
-				if (distance > curr_distance &&
-				    (distance < next_distance ||
-				     next_distance == curr_distance))
-					next_distance = distance;
-
-				/*
-				 * While not a strong assumption it would be nice to know
-				 * about cases where if node A is connected to B, B is not
-				 * equally connected to A.
-				 */
-				if (sched_debug() && node_distance(k, i) != distance)
-					sched_numa_warn("Node-distance not symmetric");
-
-				if (sched_debug() && i && !find_numa_distance(distance))
-					sched_numa_warn("Node-0 not representative");
-			}
-			if (next_distance != curr_distance) {
-				sched_domains_numa_distance[level++] = next_distance;
-				sched_domains_numa_levels = level;
-				curr_distance = next_distance;
-			} else break;
-		}
+			int distance = node_distance(0, j);
 
-		/*
-		 * In case of sched_debug() we verify the above assumption.
-		 */
-		if (!sched_debug())
-			break;
+			if (distance > curr_distance &&
+			    (distance < next_distance ||
+			     next_distance == curr_distance))
+				next_distance = distance;
+
+		}
+		if (next_distance != curr_distance) {
+			sched_domains_numa_distance[level++] = next_distance;
+			sched_domains_numa_levels = level;
+			curr_distance = next_distance;
+		} else break;
 	}
 
 	/*
@@ -1428,7 +1427,24 @@ void sched_init_numa(void)
 			sched_domains_numa_masks[i][j] = mask;
 
 			for_each_node(k) {
-				if (node_distance(j, k) > sched_domains_numa_distance[i])
+				int distance = node_distance(j, k);
+
+				if (!i && j != k) {
+					sched_numa_warn("Non-trace locality\n");
+					goto fail;
+				}
+
+				if (distance > curr_distance) {
+					sched_numa_warn("Node-0 not complete\n");
+					goto fail;
+				}
+
+				if (distance != node_distance(k, j)) {
+					sched_numa_warn("Non symmetric\n");
+					goto fail;
+				}
+
+				if (distance > sched_domains_numa_distance[i])
 					continue;
 
 				cpumask_or(mask, mask, cpumask_of_node(k));
@@ -1437,9 +1453,10 @@ void sched_init_numa(void)
 	}
 
 	/* Compute default topology size */
-	for (i = 0; sched_domain_topology[i].mask; i++);
+	for (k = 0; sched_domain_topology[k].mask; k++)
+		;
 
-	tl = kzalloc((i + level + 1) *
+	tl = kzalloc((k + level + 1) *
 			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
 	if (!tl)
 		return;
@@ -1447,7 +1464,7 @@ void sched_init_numa(void)
 	/*
 	 * Copy the default topology bits..
 	 */
-	for (i = 0; sched_domain_topology[i].mask; i++)
+	for (i = 0; i < k; i++)
 		tl[i] = sched_domain_topology[i];
 
 	/*
@@ -1478,6 +1495,31 @@ void sched_init_numa(void)
 	sched_max_numa_distance = sched_domains_numa_distance[level - 1];
 
 	init_numa_topology_type();
+
+	return;
+
+fail:
+	/* Compute default topology size */
+	for (k = 0; sched_domain_topology[k].mask; k++)
+		;
+
+	tl = kzalloc((k + 2) *
+			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
+	if (!tl)
+		return;
+
+	/*
+	 * Copy the default topology bits..
+	 */
+	for (i = 0; i < k; i++)
+		tl[i] = sched_domain_topology[i];
+
+	tl[i] = (struct sched_domain_topology_level){
+		.mask = cpu_system_mask,
+		SD_INIT_NAME(SYSTEM)
+	};
+
+	sched_domain_topology = tl;
 }
 
 void sched_domains_numa_masks_set(unsigned int cpu)
