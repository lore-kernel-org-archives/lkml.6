Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A04BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE66D206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE66D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeIGOEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:04:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:23986 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbeIGOEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:04:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 02:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="72355804"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2018 02:24:35 -0700
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.163])
        by linux.intel.com (Postfix) with ESMTP id 06B1D5803DA;
        Fri,  7 Sep 2018 02:24:32 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, jglisse@redhat.com,
        yi.z.zhang@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [PATCH V5 2/4] mm: introduce memory type MEMORY_DEVICE_DEV_DAX
Date:   Sat,  8 Sep 2018 02:03:39 +0800
Message-Id: <c0b53c74379e6d654bbe42471fcef8aa5fd22efd.1536342881.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, NVDIMM pages will be marked 'PageReserved'. However, unlike
other reserved PFNs, pages on NVDIMM shall still behave like normal ones
in many cases, i.e. when used as backend memory of KVM guest. This patch
introduces a new memory type, MEMORY_DEVICE_DEV_DAX. And set this flag
while dax driver hotplug the device memory.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/dax/pmem.c       | 1 +
 include/linux/memremap.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index fd49b24..fb3f363 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -111,6 +111,7 @@ static int dax_pmem_probe(struct device *dev)
 		return rc;
 
 	dax_pmem->pgmap.ref = &dax_pmem->ref;
+	dax_pmem->pgmap.type = MEMORY_DEVICE_DEV_DAX;
 	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f91f9e7..cd07ca8 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -53,11 +53,19 @@ struct vmem_altmap {
  * wakeup event whenever a page is unpinned and becomes idle. This
  * wakeup is used to coordinate physical address space management (ex:
  * fs truncate/hole punch) vs pinned pages (ex: device dma).
+ *
+ * MEMORY_DEVICE_DEV_DAX:
+ * Device memory that support raw access to persistent memory. Without need
+ * of an intervening filesystem, it could be directed mapped via an mmap
+ * capable character device. Together with the type MEMORY_DEVICE_FS_DAX,
+ * we could distinguish the persistent memory pages from normal ZONE_DEVICE
+ * pages.
  */
 enum memory_type {
 	MEMORY_DEVICE_PRIVATE = 1,
 	MEMORY_DEVICE_PUBLIC,
 	MEMORY_DEVICE_FS_DAX,
+	MEMORY_DEVICE_DEV_DAX,
 };
 
 /*
-- 
2.7.4

