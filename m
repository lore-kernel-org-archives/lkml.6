Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932158AbeFEX6J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:58:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:62554 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeFEX6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:58:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,481,1520924400";
   d="scan'208";a="205631346"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH v2 1/3] libnvdimm: unconditionally deep flush on *sync
Date: Tue,  5 Jun 2018 17:58:00 -0600
Message-Id: <20180605235802.14531-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this commit we would only do a "deep flush" in response to an
msync/fsync/sync call if the nvdimm_has_cache() returned true at the time
we were setting up the request queue.  This happens due to the write cache
value passed in to blk_queue_write_cache().  We do have a "write_cache"
sysfs entry for namespaces, i.e.:

  /sys/bus/nd/devices/pfn0.1/block/pmem0/dax/write_cache

which can be used to control whether or not the kernel thinks a given
namespace has a write cache, but this didn't modify the deep flush behavior
that we set up when the driver was initialized.  Instead, it only modified
whether or not DAX would flush CPU caches in response to *sync calls.

Simplify this by making the *sync "deep flush" always happen, regardless of
the write cache setting of a namespace.  The DAX CPU cache flushing will be
controlled by a combination of the write_cache setting as well as whether
the platform supports flush-on-fail CPU caches.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9d714926ecf5..a152dd9e4134 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -299,7 +299,7 @@ static int pmem_attach_disk(struct device *dev,
 {
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	struct nd_region *nd_region = to_nd_region(dev->parent);
-	int nid = dev_to_node(dev), fua, wbc;
+	int nid = dev_to_node(dev), fua;
 	struct resource *res = &nsio->res;
 	struct resource bb_res;
 	struct nd_pfn *nd_pfn = NULL;
@@ -335,7 +335,6 @@ static int pmem_attach_disk(struct device *dev,
 		dev_warn(dev, "unable to guarantee persistence of writes\n");
 		fua = 0;
 	}
-	wbc = nvdimm_has_cache(nd_region);
 
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
 				dev_name(&ndns->dev))) {
@@ -382,7 +381,7 @@ static int pmem_attach_disk(struct device *dev,
 		return PTR_ERR(addr);
 	pmem->virt_addr = addr;
 
-	blk_queue_write_cache(q, wbc, fua);
+	blk_queue_write_cache(q, true, fua);
 	blk_queue_make_request(q, pmem_make_request);
 	blk_queue_physical_block_size(q, PAGE_SIZE);
 	blk_queue_logical_block_size(q, pmem_sector_size(ndns));
@@ -413,7 +412,7 @@ static int pmem_attach_disk(struct device *dev,
 		put_disk(disk);
 		return -ENOMEM;
 	}
-	dax_write_cache(dax_dev, wbc);
+	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	pmem->dax_dev = dax_dev;
 
 	gendev = disk_to_dev(disk);
-- 
2.14.4
