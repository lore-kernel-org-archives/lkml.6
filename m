Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C0C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCED20665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCED20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeJWEiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:38:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:15663 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeJWEiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:38:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 13:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="273527112"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 22 Oct 2018 13:18:47 -0700
Subject: [PATCH 7/9] dax/kmem: actually perform memory hotplug
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 22 Oct 2018 13:13:29 -0700
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Message-Id: <20181022201329.518577A4@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is the meat of this whole series.  When the "kmem" device's
probe function is called and we know we have a good persistent
memory device, hotplug the memory back into the main kernel.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Huang Ying <ying.huang@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>

---

 b/drivers/dax/kmem.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff -puN drivers/dax/kmem.c~dax-kmem-hotplug drivers/dax/kmem.c
--- a/drivers/dax/kmem.c~dax-kmem-hotplug	2018-10-22 13:12:24.069930387 -0700
+++ b/drivers/dax/kmem.c	2018-10-22 13:12:24.072930387 -0700
@@ -55,10 +55,12 @@ static void dax_kmem_percpu_kill(void *d
 static int dax_kmem_probe(struct device *dev)
 {
 	void *addr;
+	int numa_node;
 	struct resource res;
 	int rc, id, region_id;
 	struct nd_pfn_sb *pfn_sb;
 	struct dev_dax *dev_dax;
+	struct resource *new_res;
 	struct dax_kmem *dax_kmem;
 	struct nd_namespace_io *nsio;
 	struct dax_region *dax_region;
@@ -86,13 +88,30 @@ static int dax_kmem_probe(struct device
 
 	pfn_sb = nd_pfn->pfn_sb;
 
-	if (!devm_request_mem_region(dev, nsio->res.start,
-				resource_size(&nsio->res),
-				dev_name(&ndns->dev))) {
+	new_res = devm_request_mem_region(dev, nsio->res.start,
+					  resource_size(&nsio->res),
+					  "System RAM (pmem)");
+	if (!new_res) {
 		dev_warn(dev, "could not reserve region %pR\n", &nsio->res);
 		return -EBUSY;
 	}
 
+	/*
+	 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
+	 * so that add_memory() can add a child resource.
+	 */
+	new_res->flags = IORESOURCE_SYSTEM_RAM;
+
+	numa_node = dev_to_node(dev);
+	if (numa_node < 0) {
+		pr_warn_once("bad numa_node: %d, forcing to 0\n", numa_node);
+		numa_node = 0;
+	}
+
+	rc = add_memory(numa_node, nsio->res.start, resource_size(&nsio->res));
+	if (rc)
+		return rc;
+
 	dax_kmem->dev = dev;
 	init_completion(&dax_kmem->cmp);
 	rc = percpu_ref_init(&dax_kmem->ref, dax_kmem_percpu_release, 0,
@@ -106,6 +125,9 @@ static int dax_kmem_probe(struct device
 		return rc;
 
 	dax_kmem->pgmap.ref = &dax_kmem->ref;
+
+	dax_kmem->pgmap.res.name = "name_kmem_override2";
+
 	addr = devm_memremap_pages(dev, &dax_kmem->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
_
