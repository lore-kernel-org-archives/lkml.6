Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C70C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9AA218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeLZNi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:38:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:33944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeLZNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185462"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:01 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005OT-CD; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.521151384@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:54 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 08/21] mm: introduce and export pgdat peer_node
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0019-mm-Introduce-and-export-peer_node-for-pgdat.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Du <fan.du@intel.com>

Each CPU socket can have 1 DRAM and 1 PMEM node, we call them "peer nodes".
Migration between DRAM and PMEM will by default happen between peer nodes.

It's a temp solution. In multiple memory layers, a node can have both
promotion and demotion targets instead of a single peer node. User space
may also be able to infer promotion/demotion targets based on future
HMAT info.

Signed-off-by: Fan Du <fan.du@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/base/node.c    |   11 +++++++++++
 include/linux/mmzone.h |   12 ++++++++++++
 mm/page_alloc.c        |   29 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

--- linux.orig/drivers/base/node.c	2018-12-23 19:39:51.647261099 +0800
+++ linux/drivers/base/node.c	2018-12-23 19:39:51.643261112 +0800
@@ -242,6 +242,16 @@ static ssize_t type_show(struct device *
 }
 static DEVICE_ATTR(type, S_IRUGO, type_show, NULL);
 
+static ssize_t peer_node_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int nid = dev->id;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+
+	return sprintf(buf, "%d\n", pgdat->peer_node);
+}
+static DEVICE_ATTR(peer_node, S_IRUGO, peer_node_show, NULL);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_cpumap.attr,
 	&dev_attr_cpulist.attr,
@@ -250,6 +260,7 @@ static struct attribute *node_dev_attrs[
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
 	&dev_attr_type.attr,
+	&dev_attr_peer_node.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(node_dev);
--- linux.orig/include/linux/mmzone.h	2018-12-23 19:39:51.647261099 +0800
+++ linux/include/linux/mmzone.h	2018-12-23 19:39:51.643261112 +0800
@@ -713,6 +713,18 @@ typedef struct pglist_data {
 	/* Per-node vmstats */
 	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
 	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
+
+	/*
+	 * Points to the nearest node in terms of latency
+	 * E.g. peer of node 0 is node 2 per SLIT
+	 * node distances:
+	 * node   0   1   2   3
+	 *   0:  10  21  17  28
+	 *   1:  21  10  28  17
+	 *   2:  17  28  10  28
+	 *   3:  28  17  28  10
+	 */
+	int	peer_node;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
--- linux.orig/mm/page_alloc.c	2018-12-23 19:39:51.647261099 +0800
+++ linux/mm/page_alloc.c	2018-12-23 19:39:51.643261112 +0800
@@ -6926,6 +6926,34 @@ static void check_for_memory(pg_data_t *
 	}
 }
 
+/*
+ * Return the nearest peer node in terms of *locality*
+ * E.g. peer of node 0 is node 2 per SLIT
+ * node distances:
+ * node   0   1   2   3
+ *   0:  10  21  17  28
+ *   1:  21  10  28  17
+ *   2:  17  28  10  28
+ *   3:  28  17  28  10
+ */
+static int find_best_peer_node(int nid)
+{
+	int n, val;
+	int min_val = INT_MAX;
+	int peer = NUMA_NO_NODE;
+
+	for_each_online_node(n) {
+		if (n == nid)
+			continue;
+		val = node_distance(nid, n);
+		if (val < min_val) {
+			min_val = val;
+			peer = n;
+		}
+	}
+	return peer;
+}
+
 /**
  * free_area_init_nodes - Initialise all pg_data_t and zone data
  * @max_zone_pfn: an array of max PFNs for each zone
@@ -7012,6 +7040,7 @@ void __init free_area_init_nodes(unsigne
 		if (pgdat->node_present_pages)
 			node_set_state(nid, N_MEMORY);
 		check_for_memory(pgdat, nid);
+		pgdat->peer_node = find_best_peer_node(nid);
 	}
 }
 


