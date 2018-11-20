Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC8BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F135420671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="hlh8V0bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F135420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeKTUuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:50:14 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25316 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeKTUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:50:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542709266; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=a6eNsrEllAIGuZL1CE5Pqd2LFSC4nWJVS5Of5X7S2GkKz+Uvrauq4hk/574CKOLRBW8wv8RNNeAIxp3hMkjOPNn+vNjhREYD7C9ZI/EGjeAp7tY6R6hoBRkNruRJjLe/uozb1a492L73u3CLMsSbjiAslWCw+Vst3KFUnll1yJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542709266; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Vg83GLY1TOcUwu8LjDRYZyK2VKe0/QCPhNa/U9/9R6M=; 
        b=JIPH+MyavnKmBwIA/HazuIEwozZ6Z6OkgOgfbdIeQ7pq+tZ2TCFMRTNpmoVB4GFzB5Aq6LK7mM/n+WL/UDPNBXe6e3qwhOiQwhZvlmwINNI6CghyBRpin6o0/ANkYTLoN3G0PKDTv1gnJRZWWbp5xc+cFHvhVzJLRIb9mAZmpaU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=mOVLI4C+sn4d7a8duqge+unEuTghEoHiR3EyaJ7WninqreTigjuxgZCZ0t5RQn8NBhq+mK5l/+Eq
    0OWkPNNtqNVM06JtSrHYRB/scDU+ljtWtCSTT6syuQmvYpvic2qi  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1542709266;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=3603; bh=Vg83GLY1TOcUwu8LjDRYZyK2VKe0/QCPhNa/U9/9R6M=;
        b=hlh8V0bBj+T3E7thp9EChvsdGBCJ/LqkUeLOAqXHfQ1akM5t6N9u6qFDOv4licFm
        D8zyauf2xbFUZQwpC/3wY+6Odvy37M3TTx21OOtKKGtme8lHA9OE5a5Ii2NFS2FwJ7V
        ktAdaKYR5S6A5ijodWjwxs/bOXPA3jwq539om9+8=
Received: from YEHS1XR956R00D1.lenovo.com (58.243.153.247 [58.243.153.247]) by mx.zohomail.com
        with SMTPS id 1542709265287568.4244900576812; Tue, 20 Nov 2018 02:21:05 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, dan.j.williams@intel.com, willy@infradead.org,
        zwisler@kernel.org, jack@suse.cz, dave.jiang@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH 1/3] dm: enable dax_operations for dm-snapshot
Date:   Tue, 20 Nov 2018 18:20:35 +0800
Message-Id: <20181120102037.4536-2-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20181120102037.4536-1-yehs2007@zoho.com>
References: <20181120102037.4536-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Reconstruct origin_dax_direct_access and expand functions
origin_dax_copy_to/from_iter for DAX operations of dm-snapshot.

Here is the call trace of origin_dax_copy_to_iter,
origin_dax_copy_to_iter will callin dm-linear (-real) for further
dax_operation.

[518597.924019] Call Trace:
[518597.927320]  dump_stack+0x65/0x7e
[518597.931592]  origin_dax_copy_to_iter+0x51/0x78 [dm_snapshot]
[518597.938494]  dm_dax_copy_to_iter+0x86/0xc5 [dm_mod]
[518597.944519]  dax_copy_to_iter+0x27/0x29
[518597.949371]  dax_iomap_actor+0x264/0x326
[518597.954308]  ? trace_event_raw_event_dax_pmd_load_hole_class+0xd0/0xd0
[518597.962159]  iomap_apply+0xc7/0x128
[518597.966609]  ? trace_event_raw_event_dax_pmd_load_hole_class+0xd0/0xd0
[518597.974447]  dax_iomap_rw+0x66/0xa8
[518597.978893]  ? trace_event_raw_event_dax_pmd_load_hole_class+0xd0/0xd0
[518597.986741]  ext2_file_read_iter+0x4f/0x83 [ext2]
[518597.992552]  __vfs_read+0x130/0x168
[518597.997001]  vfs_read+0x92/0x146
[518598.001155]  ksys_read+0x4f/0xa5
[518598.005308]  __x64_sys_read+0x16/0x18
[518598.009942]  do_syscall_64+0x88/0x15f
[518598.014575]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-snap.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index ae4b33d..75738b3 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/log2.h>
 #include <linux/dm-kcopyd.h>
+#include <linux/dax.h>
 
 #include "dm.h"
 
@@ -2319,8 +2320,45 @@ static int origin_map(struct dm_target *ti, struct bio *bio)
 static long origin_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
 {
-	DMWARN("device does not support dax.");
-	return -EIO;
+	long ret = 0;
+	struct dm_origin *o = ti->private;
+	struct block_device *bdev = o->dev->bdev;
+	struct dax_device *dax_dev = o->dev->dax_dev;
+	sector_t sector = pgoff * PAGE_SECTORS;
+
+	ret = bdev_dax_pgoff(bdev, sector, nr_pages * PAGE_SIZE, &pgoff);
+	if (ret)
+		return ret;
+
+	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+}
+
+static size_t origin_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dm_origin *o = ti->private;
+	struct block_device *bdev = o->dev->bdev;
+	struct dax_device *dax_dev = o->dev->dax_dev;
+	sector_t sector = pgoff * PAGE_SECTORS;
+
+	if (bdev_dax_pgoff(bdev, sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+		return 0;
+
+	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
+}
+
+static size_t origin_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dm_origin *o = ti->private;
+	struct block_device *bdev = o->dev->bdev;
+	struct dax_device *dax_dev = o->dev->dax_dev;
+	sector_t sector = pgoff * PAGE_SECTORS;
+
+	if (bdev_dax_pgoff(bdev, sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
+		return 0;
+
+	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 /*
@@ -2383,6 +2421,8 @@ static int origin_iterate_devices(struct dm_target *ti,
 	.status  = origin_status,
 	.iterate_devices = origin_iterate_devices,
 	.direct_access = origin_dax_direct_access,
+	.dax_copy_to_iter = origin_dax_copy_to_iter,
+	.dax_copy_from_iter = origin_dax_copy_from_iter,
 };
 
 static struct target_type snapshot_target = {
-- 
1.8.3.1


