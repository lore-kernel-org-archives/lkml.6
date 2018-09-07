Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC5BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1AE20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1AE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIHCHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:07:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeIHCHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:07:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5BDF3F01;
        Fri,  7 Sep 2018 21:24:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 4.18 129/145] libnvdimm: Use max contiguous area for namespace size
Date:   Fri,  7 Sep 2018 23:09:55 +0200
Message-Id: <20180907210913.418481128@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 12e3129e29b406c41bc89231092a20d79dbf802c upstream.

This patch will find the max contiguous area to determine the largest
pmem namespace size that can be created. If the requested size exceeds
the largest available, ENOSPC error will be returned.

This fixes the allocation underrun error and wrong error return code
that have otherwise been observed as the following kernel warning:

  WARNING: CPU: <CPU> PID: <PID> at drivers/nvdimm/namespace_devs.c:913 size_store

Fixes: a1f3e4d6a0c3 ("libnvdimm, region: update nd_region_available_dpa() for multi-pmem support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/dimm_devs.c      |   31 +++++++++++++++++++++++++++++++
 drivers/nvdimm/namespace_devs.c |    6 +++---
 drivers/nvdimm/nd-core.h        |    8 ++++++++
 drivers/nvdimm/region_devs.c    |   24 ++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 3 deletions(-)

--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -537,6 +537,37 @@ resource_size_t nd_blk_available_dpa(str
 }
 
 /**
+ * nd_pmem_max_contiguous_dpa - For the given dimm+region, return the max
+ *			   contiguous unallocated dpa range.
+ * @nd_region: constrain available space check to this reference region
+ * @nd_mapping: container of dpa-resource-root + labels
+ */
+resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
+					   struct nd_mapping *nd_mapping)
+{
+	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
+	struct nvdimm_bus *nvdimm_bus;
+	resource_size_t max = 0;
+	struct resource *res;
+
+	/* if a dimm is disabled the available capacity is zero */
+	if (!ndd)
+		return 0;
+
+	nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
+	if (__reserve_free_pmem(&nd_region->dev, nd_mapping->nvdimm))
+		return 0;
+	for_each_dpa_resource(ndd, res) {
+		if (strcmp(res->name, "pmem-reserve") != 0)
+			continue;
+		if (resource_size(res) > max)
+			max = resource_size(res);
+	}
+	release_free_pmem(nvdimm_bus, nd_mapping);
+	return max;
+}
+
+/**
  * nd_pmem_available_dpa - for the given dimm+region account unallocated dpa
  * @nd_mapping: container of dpa-resource-root + labels
  * @nd_region: constrain available space check to this reference region
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -799,7 +799,7 @@ static int merge_dpa(struct nd_region *n
 	return 0;
 }
 
-static int __reserve_free_pmem(struct device *dev, void *data)
+int __reserve_free_pmem(struct device *dev, void *data)
 {
 	struct nvdimm *nvdimm = data;
 	struct nd_region *nd_region;
@@ -836,7 +836,7 @@ static int __reserve_free_pmem(struct de
 	return 0;
 }
 
-static void release_free_pmem(struct nvdimm_bus *nvdimm_bus,
+void release_free_pmem(struct nvdimm_bus *nvdimm_bus,
 		struct nd_mapping *nd_mapping)
 {
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -1032,7 +1032,7 @@ static ssize_t __size_store(struct devic
 
 		allocated += nvdimm_allocated_dpa(ndd, &label_id);
 	}
-	available = nd_region_available_dpa(nd_region);
+	available = nd_region_allocatable_dpa(nd_region);
 
 	if (val > available + allocated)
 		return -ENOSPC;
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -100,6 +100,14 @@ struct nd_region;
 struct nvdimm_drvdata;
 struct nd_mapping;
 void nd_mapping_free_labels(struct nd_mapping *nd_mapping);
+
+int __reserve_free_pmem(struct device *dev, void *data);
+void release_free_pmem(struct nvdimm_bus *nvdimm_bus,
+		       struct nd_mapping *nd_mapping);
+
+resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
+					   struct nd_mapping *nd_mapping);
+resource_size_t nd_region_allocatable_dpa(struct nd_region *nd_region);
 resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 		struct nd_mapping *nd_mapping, resource_size_t *overlap);
 resource_size_t nd_blk_available_dpa(struct nd_region *nd_region);
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -389,6 +389,30 @@ resource_size_t nd_region_available_dpa(
 	return available;
 }
 
+resource_size_t nd_region_allocatable_dpa(struct nd_region *nd_region)
+{
+	resource_size_t available = 0;
+	int i;
+
+	if (is_memory(&nd_region->dev))
+		available = PHYS_ADDR_MAX;
+
+	WARN_ON(!is_nvdimm_bus_locked(&nd_region->dev));
+	for (i = 0; i < nd_region->ndr_mappings; i++) {
+		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+
+		if (is_memory(&nd_region->dev))
+			available = min(available,
+					nd_pmem_max_contiguous_dpa(nd_region,
+								   nd_mapping));
+		else if (is_nd_blk(&nd_region->dev))
+			available += nd_blk_available_dpa(nd_region);
+	}
+	if (is_memory(&nd_region->dev))
+		return available * nd_region->ndr_mappings;
+	return available;
+}
+
 static ssize_t available_size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {


