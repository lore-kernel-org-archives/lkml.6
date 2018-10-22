Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5A6C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A8820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A8820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeJWEij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:38:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:37683 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeJWEih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:38:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 13:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="101509365"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2018 13:18:38 -0700
Subject: [PATCH 2/9] dax: kernel memory driver for mm ownership of DAX
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 22 Oct 2018 13:13:20 -0700
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Message-Id: <20181022201320.45C9785C@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add the actual driver to which will own the DAX range.  This
allows very nice party with the other possible "owners" of
a DAX region: device DAX and filesystem DAX.  It also greatly
simplifies the process of handing off control of the memory
between the different owners since it's just a matter of
unbinding and rebinding the device to different drivers.

I tried to do this all internally to the kernel and the
locking and "self-destruction" of the old device context was
a nightmare.  Having userspace drive it is a wonderful
simplification.

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

 b/drivers/dax/kmem.c |  152 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff -puN /dev/null drivers/dax/kmem.c
--- /dev/null	2018-09-18 12:39:53.059362935 -0700
+++ b/drivers/dax/kmem.c	2018-10-22 13:12:21.502930393 -0700
@@ -0,0 +1,152 @@
+// this just just a copy of drivers/dax/pmem.c with
+// s/dax_pmem/dax_kmem' for now.
+//
+// need real license
+/*
+ * Copyright(c) 2016-2018 Intel Corporation. All rights reserved.
+ */
+#include <linux/percpu-refcount.h>
+#include <linux/memremap.h>
+#include <linux/module.h>
+#include <linux/pfn_t.h>
+#include "../nvdimm/pfn.h"
+#include "../nvdimm/nd.h"
+#include "device-dax.h"
+
+struct dax_kmem {
+	struct device *dev;
+	struct percpu_ref ref;
+	struct dev_pagemap pgmap;
+	struct completion cmp;
+};
+
+static struct dax_kmem *to_dax_kmem(struct percpu_ref *ref)
+{
+	return container_of(ref, struct dax_kmem, ref);
+}
+
+static void dax_kmem_percpu_release(struct percpu_ref *ref)
+{
+	struct dax_kmem *dax_kmem = to_dax_pmem(ref);
+
+	dev_dbg(dax_kmem->dev, "trace\n");
+	complete(&dax_kmem->cmp);
+}
+
+static void dax_kmem_percpu_exit(void *data)
+{
+	struct percpu_ref *ref = data;
+	struct dax_kmem *dax_kmem = to_dax_pmem(ref);
+
+	dev_dbg(dax_kmem->dev, "trace\n");
+	wait_for_completion(&dax_kmem->cmp);
+	percpu_ref_exit(ref);
+}
+
+static void dax_kmem_percpu_kill(void *data)
+{
+	struct percpu_ref *ref = data;
+	struct dax_kmem *dax_kmem = to_dax_pmem(ref);
+
+	dev_dbg(dax_kmem->dev, "trace\n");
+	percpu_ref_kill(ref);
+}
+
+static int dax_kmem_probe(struct device *dev)
+{
+	void *addr;
+	struct resource res;
+	int rc, id, region_id;
+	struct nd_pfn_sb *pfn_sb;
+	struct dev_dax *dev_dax;
+	struct dax_kmem *dax_kmem;
+	struct nd_namespace_io *nsio;
+	struct dax_region *dax_region;
+	struct nd_namespace_common *ndns;
+	struct nd_dax *nd_dax = to_nd_dax(dev);
+	struct nd_pfn *nd_pfn = &nd_dax->nd_pfn;
+
+	ndns = nvdimm_namespace_common_probe(dev);
+	if (IS_ERR(ndns))
+		return PTR_ERR(ndns);
+	nsio = to_nd_namespace_io(&ndns->dev);
+
+	dax_kmem = devm_kzalloc(dev, sizeof(*dax_kmem), GFP_KERNEL);
+	if (!dax_kmem)
+		return -ENOMEM;
+
+	/* parse the 'pfn' info block via ->rw_bytes */
+	rc = devm_nsio_enable(dev, nsio);
+	if (rc)
+		return rc;
+	rc = nvdimm_setup_pfn(nd_pfn, &dax_kmem->pgmap);
+	if (rc)
+		return rc;
+	devm_nsio_disable(dev, nsio);
+
+	pfn_sb = nd_pfn->pfn_sb;
+
+	if (!devm_request_mem_region(dev, nsio->res.start,
+				resource_size(&nsio->res),
+				dev_name(&ndns->dev))) {
+		dev_warn(dev, "could not reserve region %pR\n", &nsio->res);
+		return -EBUSY;
+	}
+
+	dax_kmem->dev = dev;
+	init_completion(&dax_kmem->cmp);
+	rc = percpu_ref_init(&dax_kmem->ref, dax_kmem_percpu_release, 0,
+			GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(dev, dax_kmem_percpu_exit,
+							&dax_kmem->ref);
+	if (rc)
+		return rc;
+
+	dax_kmem->pgmap.ref = &dax_kmem->ref;
+	addr = devm_memremap_pages(dev, &dax_kmem->pgmap);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+
+	rc = devm_add_action_or_reset(dev, dax_kmem_percpu_kill,
+							&dax_kmem->ref);
+	if (rc)
+		return rc;
+
+	/* adjust the dax_region resource to the start of data */
+	memcpy(&res, &dax_kmem->pgmap.res, sizeof(res));
+	res.start += le64_to_cpu(pfn_sb->dataoff);
+
+	rc = sscanf(dev_name(&ndns->dev), "namespace%d.%d", &region_id, &id);
+	if (rc != 2)
+		return -EINVAL;
+
+	dax_region = alloc_dax_region(dev, region_id, &res,
+			le32_to_cpu(pfn_sb->align), addr, PFN_DEV|PFN_MAP);
+	if (!dax_region)
+		return -ENOMEM;
+
+	/* TODO: support for subdividing a dax region... */
+	dev_dax = devm_create_dev_dax(dax_region, id, &res, 1);
+
+	/* child dev_dax instances now own the lifetime of the dax_region */
+	dax_region_put(dax_region);
+
+	return PTR_ERR_OR_ZERO(dev_dax);
+}
+
+static struct nd_device_driver dax_kmem_driver = {
+	.probe = dax_kmem_probe,
+	.drv = {
+		.name = "dax_kmem",
+	},
+	.type = ND_DRIVER_DAX_PMEM,
+};
+
+module_nd_driver(dax_kmem_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_ALIAS_ND_DEVICE(ND_DEVICE_DAX_PMEM);
_
