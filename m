Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8541CC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485D220839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeHaRiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:38:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbeHaRiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 399C580823E3;
        Fri, 31 Aug 2018 13:30:47 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (dhcp193-198.pnq.redhat.com [10.65.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F6D7F3D01;
        Fri, 31 Aug 2018 13:30:38 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc:     jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, nilal@redhat.com, kwolf@redhat.com,
        pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com,
        xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        imammedo@redhat.com, eblake@redhat.com, pagupta@redhat.com
Subject: [PATCH 1/3] nd: move nd_region to common header 
Date:   Fri, 31 Aug 2018 19:00:16 +0530
Message-Id: <20180831133019.27579-2-pagupta@redhat.com>
In-Reply-To: <20180831133019.27579-1-pagupta@redhat.com>
References: <20180831133019.27579-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 31 Aug 2018 13:30:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 31 Aug 2018 13:30:47 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pagupta@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves nd_region definition to common header
include/linux/nd.h file. This is required for flush callback 
support for both virtio-pmem & pmem driver.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/nvdimm/nd.h | 39 ---------------------------------------
 include/linux/nd.h  | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 98317e7..d079a2b 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -123,45 +123,6 @@ enum nd_mapping_lock_class {
 	ND_MAPPING_UUID_SCAN,
 };
 
-struct nd_mapping {
-	struct nvdimm *nvdimm;
-	u64 start;
-	u64 size;
-	int position;
-	struct list_head labels;
-	struct mutex lock;
-	/*
-	 * @ndd is for private use at region enable / disable time for
-	 * get_ndd() + put_ndd(), all other nd_mapping to ndd
-	 * conversions use to_ndd() which respects enabled state of the
-	 * nvdimm.
-	 */
-	struct nvdimm_drvdata *ndd;
-};
-
-struct nd_region {
-	struct device dev;
-	struct ida ns_ida;
-	struct ida btt_ida;
-	struct ida pfn_ida;
-	struct ida dax_ida;
-	unsigned long flags;
-	struct device *ns_seed;
-	struct device *btt_seed;
-	struct device *pfn_seed;
-	struct device *dax_seed;
-	u16 ndr_mappings;
-	u64 ndr_size;
-	u64 ndr_start;
-	int id, num_lanes, ro, numa_node;
-	void *provider_data;
-	struct kernfs_node *bb_state;
-	struct badblocks bb;
-	struct nd_interleave_set *nd_set;
-	struct nd_percpu_lane __percpu *lane;
-	struct nd_mapping mapping[0];
-};
-
 struct nd_blk_region {
 	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 	int (*do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
diff --git a/include/linux/nd.h b/include/linux/nd.h
index 43c181a..b9da9f7 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -120,6 +120,46 @@ struct nd_namespace_blk {
 	struct resource **res;
 };
 
+struct nd_mapping {
+	struct nvdimm *nvdimm;
+	u64 start;
+	u64 size;
+	int position;
+	struct list_head labels;
+	struct mutex lock;
+	/*
+	 * @ndd is for private use at region enable / disable time for
+	 * get_ndd() + put_ndd(), all other nd_mapping to ndd
+	 * conversions use to_ndd() which respects enabled state of the
+	 * nvdimm.
+	 */
+	struct nvdimm_drvdata *ndd;
+};
+
+struct nd_region {
+	struct device dev;
+	struct ida ns_ida;
+	struct ida btt_ida;
+	struct ida pfn_ida;
+	struct ida dax_ida;
+	unsigned long flags;
+	struct device *ns_seed;
+	struct device *btt_seed;
+	struct device *pfn_seed;
+	struct device *dax_seed;
+	u16 ndr_mappings;
+	u64 ndr_size;
+	u64 ndr_start;
+	int id, num_lanes, ro, numa_node;
+	void *provider_data;
+	struct kernfs_node *bb_state;
+	struct badblocks bb;
+	struct nd_interleave_set *nd_set;
+	struct nd_percpu_lane __percpu *lane;
+	int (*flush)(struct nd_region *nd_region);
+	struct nd_mapping mapping[0];
+};
+
 static inline struct nd_namespace_io *to_nd_namespace_io(const struct device *dev)
 {
 	return container_of(dev, struct nd_namespace_io, common.dev);
-- 
2.9.3

