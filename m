Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A38CC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED04220652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED04220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbeJWEin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:38:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:17885 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeJWEim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:38:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 13:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="90396632"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Oct 2018 13:18:42 -0700
Subject: [PATCH 5/9] dax/kmem: add more nd dax kmem infrastructure
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 22 Oct 2018 13:13:26 -0700
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Message-Id: <20181022201326.5E3F2752@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Each DAX mode has a set of wrappers and helpers.  Add them
for the kmem mode.

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

 b/drivers/nvdimm/bus.c      |    2 ++
 b/drivers/nvdimm/dax_devs.c |   35 +++++++++++++++++++++++++++++++++++
 b/drivers/nvdimm/nd.h       |    6 ++++++
 3 files changed, 43 insertions(+)

diff -puN drivers/nvdimm/bus.c~dax-kmem-try-again-2018-4-bus-dev-type-kmem drivers/nvdimm/bus.c
--- a/drivers/nvdimm/bus.c~dax-kmem-try-again-2018-4-bus-dev-type-kmem	2018-10-22 13:12:23.024930389 -0700
+++ b/drivers/nvdimm/bus.c	2018-10-22 13:12:23.031930389 -0700
@@ -46,6 +46,8 @@ static int to_nd_device_type(struct devi
 		return ND_DEVICE_REGION_BLK;
 	else if (is_nd_dax(dev))
 		return ND_DEVICE_DAX_PMEM;
+	else if (is_nd_dax_kmem(dev))
+		return ND_DEVICE_DAX_KMEM;
 	else if (is_nd_region(dev->parent))
 		return nd_region_to_nstype(to_nd_region(dev->parent));
 
diff -puN drivers/nvdimm/dax_devs.c~dax-kmem-try-again-2018-4-bus-dev-type-kmem drivers/nvdimm/dax_devs.c
--- a/drivers/nvdimm/dax_devs.c~dax-kmem-try-again-2018-4-bus-dev-type-kmem	2018-10-22 13:12:23.026930389 -0700
+++ b/drivers/nvdimm/dax_devs.c	2018-10-22 13:12:23.031930389 -0700
@@ -51,6 +51,41 @@ struct nd_dax *to_nd_dax(struct device *
 }
 EXPORT_SYMBOL(to_nd_dax);
 
+/* nd_dax_kmem */
+static void nd_dax_kmem_release(struct device *dev)
+{
+	struct nd_region *nd_region = to_nd_region(dev->parent);
+	struct nd_dax_kmem *nd_dax_kmem = to_nd_dax_kmem(dev);
+	struct nd_pfn *nd_pfn = &nd_dax_kmem->nd_pfn;
+
+	dev_dbg(dev, "trace\n");
+	nd_detach_ndns(dev, &nd_pfn->ndns);
+	ida_simple_remove(&nd_region->dax_ida, nd_pfn->id);
+	kfree(nd_pfn->uuid);
+	kfree(nd_dax_kmem);
+}
+
+static struct device_type nd_dax_kmem_device_type = {
+	.name = "nd_dax_kmem",
+	.release = nd_dax_kmem_release,
+};
+
+bool is_nd_dax_kmem(struct device *dev)
+{
+	return dev ? dev->type == &nd_dax_kmem_device_type : false;
+}
+EXPORT_SYMBOL(is_nd_dax_kmem);
+
+struct nd_dax_kmem *to_nd_dax_kmem(struct device *dev)
+{
+	struct nd_dax_kmem *nd_dax_kmem = container_of(dev, struct nd_dax_kmem, nd_pfn.dev);
+
+	WARN_ON(!is_nd_dax_kmem(dev));
+	return nd_dax_kmem;
+}
+EXPORT_SYMBOL(to_nd_dax_kmem);
+/* end nd_dax_kmem */
+
 static const struct attribute_group *nd_dax_attribute_groups[] = {
 	&nd_pfn_attribute_group,
 	&nd_device_attribute_group,
diff -puN drivers/nvdimm/nd.h~dax-kmem-try-again-2018-4-bus-dev-type-kmem drivers/nvdimm/nd.h
--- a/drivers/nvdimm/nd.h~dax-kmem-try-again-2018-4-bus-dev-type-kmem	2018-10-22 13:12:23.027930389 -0700
+++ b/drivers/nvdimm/nd.h	2018-10-22 13:12:23.031930389 -0700
@@ -215,6 +215,10 @@ struct nd_dax {
 	struct nd_pfn nd_pfn;
 };
 
+struct nd_dax_kmem {
+	struct nd_pfn nd_pfn;
+};
+
 enum nd_async_mode {
 	ND_SYNC,
 	ND_ASYNC,
@@ -318,9 +322,11 @@ static inline int nd_pfn_validate(struct
 #endif
 
 struct nd_dax *to_nd_dax(struct device *dev);
+struct nd_dax_kmem *to_nd_dax_kmem(struct device *dev);
 #if IS_ENABLED(CONFIG_NVDIMM_DAX)
 int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns);
 bool is_nd_dax(struct device *dev);
+bool is_nd_dax_kmem(struct device *dev);
 struct device *nd_dax_create(struct nd_region *nd_region);
 #else
 static inline int nd_dax_probe(struct device *dev,
_
