Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A70C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB61E2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/cOsm6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeLTJvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:51:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41136 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbeLTJvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:51:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so652674pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bFlrZBjUWwkKVtLETvH1CazL4niyqwbCd/ko3YIed4Y=;
        b=l/cOsm6SNToCov7U0QeU1WV0TKp3YyxFudL5VZe2kcjghnxG63U1wwxavHGZDGiR3i
         Rjixd+sslh+zH/CdsfIGiqp8V6qEixW3sBCVwukb51BTChhgzmHre0G7T5ZSysgY2lWp
         xfiP8HYvNxhv+PpbUhmKm0kuyGBX4mOjlaVM2ePCvepg2pCy7TJGw4JkL5noadc8hwJ0
         k8yVcFt2xRJABe+JXADPcfx0eEjsTYOqkMzxSTZLVVFV6ecJJs2HPpLZbDt5YC38DVl2
         50Ya/bk5/ZQu0qwBUs5G8EcU+n+MajYLy7Wp5QIvxjfgO/CD7qfHpqssKfUJiVzpflEQ
         OHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bFlrZBjUWwkKVtLETvH1CazL4niyqwbCd/ko3YIed4Y=;
        b=AdaGSVSdGXgJa2u41Fo4kF0QWHQtTkZPq/V8H7LW5Pu3nS2/oN/R7s6awaCNy7XYkd
         DxfH3JuVbQBoHUkbAoAoEBA2hvripj/Mm2xhkYVg3cf2uy/8wMJ2A1HD454oQbsPBK7/
         /BYVTPw7dZHuUs0S7QF8dvqLoNAkOIz6fQ465qDy2GQqKLidGQ/4VXLqlD2skZ+Pj4+u
         zdEPxwJavXVVxsKs010pFmhaaOO6FoRXV4Rb78Up73lhkJ61PscjUYUJX1GzSEctPzkk
         96o14NlkTcWJ/qlcJa00rCeUA5NMKfv9rIbLMLrYUkJGAHSfLLNJtDPlUa6dNnjPHX8F
         NNEw==
X-Gm-Message-State: AA+aEWYeIu8TQAOJJEd8WIsoVIZFUZ/3solbjiQGvWtS7LRr4Fxr5MiV
        8GHnjcKH2NMlLS27dvLp0g==
X-Google-Smtp-Source: AFSGD/UgqYyt0OJR1caTO1JzmXFnV5rhJVHinuALAcpjMCINyFM7ITwObGiH2+ykYlNGtjKpzqqSuQ==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr23934902pfb.55.1545299470299;
        Thu, 20 Dec 2018 01:51:10 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 125sm33355206pfx.159.2018.12.20.01.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 01:51:09 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv2 1/3] mm/numa: change the topo of build_zonelist_xx()
Date:   Thu, 20 Dec 2018 17:50:37 +0800
Message-Id: <1545299439-31370-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current build_zonelist_xx func relies on pgdat instance to build
zonelist, if a numa node is offline, there will no pgdat instance for it.
But in some case, there is still requirement for zonelist of offline node,
especially with nr_cpus option.
This patch change these funcs topo to ease the building of zonelist for
offline nodes.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 mm/page_alloc.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ec9cc4..17dbf6e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5049,7 +5049,7 @@ static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
  *
  * Add all populated zones of a node to the zonelist.
  */
-static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
+static int build_zonerefs_node(int nid, struct zoneref *zonerefs)
 {
 	struct zone *zone;
 	enum zone_type zone_type = MAX_NR_ZONES;
@@ -5057,7 +5057,7 @@ static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
 
 	do {
 		zone_type--;
-		zone = pgdat->node_zones + zone_type;
+		zone = NODE_DATA(nid)->node_zones + zone_type;
 		if (managed_zone(zone)) {
 			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
 			check_highest_zone(zone_type);
@@ -5186,20 +5186,20 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
  * This results in maximum locality--normal zone overflows into local
  * DMA zone, if any--but risks exhausting DMA zone.
  */
-static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
-		unsigned nr_nodes)
+static void build_zonelists_in_node_order(struct zonelist *node_zonelists,
+	int *node_order, unsigned int nr_nodes)
 {
 	struct zoneref *zonerefs;
 	int i;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK]._zonerefs;
+	zonerefs = node_zonelists[ZONELIST_FALLBACK]._zonerefs;
 
 	for (i = 0; i < nr_nodes; i++) {
 		int nr_zones;
 
 		pg_data_t *node = NODE_DATA(node_order[i]);
 
-		nr_zones = build_zonerefs_node(node, zonerefs);
+		nr_zones = build_zonerefs_node(node->node_id, zonerefs);
 		zonerefs += nr_zones;
 	}
 	zonerefs->zone = NULL;
@@ -5209,13 +5209,14 @@ static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
 /*
  * Build gfp_thisnode zonelists
  */
-static void build_thisnode_zonelists(pg_data_t *pgdat)
+static void build_thisnode_zonelists(struct zonelist *node_zonelists,
+	int nid)
 {
 	struct zoneref *zonerefs;
 	int nr_zones;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
+	zonerefs = node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
+	nr_zones = build_zonerefs_node(nid, zonerefs);
 	zonerefs += nr_zones;
 	zonerefs->zone = NULL;
 	zonerefs->zone_idx = 0;
@@ -5228,15 +5229,14 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
  * may still exist in local DMA zone.
  */
 
-static void build_zonelists(pg_data_t *pgdat)
+static void build_zonelists(struct zonelist *node_zonelists, int local_node)
 {
 	static int node_order[MAX_NUMNODES];
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask;
-	int local_node, prev_node;
+	int prev_node;
 
 	/* NUMA-aware ordering of nodes */
-	local_node = pgdat->node_id;
 	load = nr_online_nodes;
 	prev_node = local_node;
 	nodes_clear(used_mask);
@@ -5257,8 +5257,8 @@ static void build_zonelists(pg_data_t *pgdat)
 		load--;
 	}
 
-	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
-	build_thisnode_zonelists(pgdat);
+	build_zonelists_in_node_order(node_zonelists, node_order, nr_nodes);
+	build_thisnode_zonelists(node_zonelists, local_node);
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
@@ -5283,16 +5283,14 @@ static void setup_min_unmapped_ratio(void);
 static void setup_min_slab_ratio(void);
 #else	/* CONFIG_NUMA */
 
-static void build_zonelists(pg_data_t *pgdat)
+static void build_zonelists(struct zonelist *node_zonelists, int local_node)
 {
 	int node, local_node;
 	struct zoneref *zonerefs;
 	int nr_zones;
 
-	local_node = pgdat->node_id;
-
-	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
+	zonerefs = node_zonelists[ZONELIST_FALLBACK]._zonerefs;
+	nr_zones = build_zonerefs_node(local_node, zonerefs);
 	zonerefs += nr_zones;
 
 	/*
@@ -5306,13 +5304,13 @@ static void build_zonelists(pg_data_t *pgdat)
 	for (node = local_node + 1; node < MAX_NUMNODES; node++) {
 		if (!node_online(node))
 			continue;
-		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs);
+		nr_zones = build_zonerefs_node(node, zonerefs);
 		zonerefs += nr_zones;
 	}
 	for (node = 0; node < local_node; node++) {
 		if (!node_online(node))
 			continue;
-		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs);
+		nr_zones = build_zonerefs_node(node, zonerefs);
 		zonerefs += nr_zones;
 	}
 
@@ -5359,12 +5357,12 @@ static void __build_all_zonelists(void *data)
 	 * building zonelists is fine - no need to touch other nodes.
 	 */
 	if (self && !node_online(self->node_id)) {
-		build_zonelists(self);
+		build_zonelists(self->node_zonelists, self->node_id);
 	} else {
 		for_each_online_node(nid) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
-			build_zonelists(pgdat);
+			build_zonelists(pgdat->node_zonelists, pgdat->node_id);
 		}
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.7.4

