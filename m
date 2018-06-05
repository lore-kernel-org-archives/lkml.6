Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbeFEX6c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:58:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:62554 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeFEX6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:58:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,481,1520924400";
   d="scan'208";a="205631352"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH v2 3/3] libnvdimm: don't flush power-fail protected CPU caches
Date: Tue,  5 Jun 2018 17:58:02 -0600
Message-Id: <20180605235802.14531-3-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180605235802.14531-1-ross.zwisler@linux.intel.com>
References: <20180605235802.14531-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit:

5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")

intended to make sure that deep flush was always available even on
platforms which support a power-fail protected CPU cache.  An unintended
side effect of this change was that we also lost the ability to skip
flushing CPU caches on those power-fail protected CPU cache.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
---
 drivers/dax/super.c   | 14 +++++++++++++-
 drivers/nvdimm/pmem.c |  2 ++
 include/linux/dax.h   |  4 ++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c2c46f96b18c..80253c531a9b 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -152,6 +152,8 @@ enum dax_device_flags {
 	DAXDEV_ALIVE,
 	/* gate whether dax_flush() calls the low level flush routine */
 	DAXDEV_WRITE_CACHE,
+	/* only flush the CPU caches if they are not power fail protected */
+	DAXDEV_FLUSH_ON_SYNC,
 };
 
 /**
@@ -283,7 +285,8 @@ EXPORT_SYMBOL_GPL(dax_copy_from_iter);
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
 {
-	if (unlikely(!dax_write_cache_enabled(dax_dev)))
+	if (unlikely(!dax_write_cache_enabled(dax_dev)) ||
+			!test_bit(DAXDEV_FLUSH_ON_SYNC, &dax_dev->flags))
 		return;
 
 	arch_wb_cache_pmem(addr, size);
@@ -310,6 +313,15 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
 
+void dax_flush_on_sync(struct dax_device *dax_dev, bool flush)
+{
+	if (flush)
+		set_bit(DAXDEV_FLUSH_ON_SYNC, &dax_dev->flags);
+	else
+		clear_bit(DAXDEV_FLUSH_ON_SYNC, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(dax_flush_on_sync);
+
 bool dax_alive(struct dax_device *dax_dev)
 {
 	lockdep_assert_held(&dax_srcu);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index a152dd9e4134..e8c2795bf766 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -413,6 +413,8 @@ static int pmem_attach_disk(struct device *dev,
 		return -ENOMEM;
 	}
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
+	dax_flush_on_sync(dax_dev,
+			!test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags));
 	pmem->dax_dev = dax_dev;
 
 	gendev = disk_to_dev(disk);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index f9eb22ad341e..4575742508b0 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -32,6 +32,7 @@ void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
+void dax_flush_on_sync(struct dax_device *dax_dev, bool flush);
 #else
 static inline struct dax_device *dax_get_by_host(const char *host)
 {
@@ -59,6 +60,9 @@ static inline bool dax_write_cache_enabled(struct dax_device *dax_dev)
 {
 	return false;
 }
+static inline void dax_flush_on_sync(struct dax_device *dax_dev, bool flush)
+{
+}
 #endif
 
 struct writeback_control;
-- 
2.14.4
