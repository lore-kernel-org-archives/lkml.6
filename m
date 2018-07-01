Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F82C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B742253EA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B742253EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032344AbeGAQnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:43:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032261AbeGAQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:43:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1402BA73;
        Sun,  1 Jul 2018 16:43:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.17 146/220] libnvdimm, pmem: Unconditionally deep flush on *sync
Date:   Sun,  1 Jul 2018 18:22:50 +0200
Message-Id: <20180701160914.407149719@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Zwisler <ross.zwisler@linux.intel.com>

commit ce7f11a230d5b7165480b96c0cc7a90358b5b5e2 upstream.

Prior to this commit we would only do a "deep flush" (have nvdimm_flush()
write to each of the flush hints for a region) in response to an
msync/fsync/sync call if the nvdimm_has_cache() returned true at the time
we were setting up the request queue.  This happens due to the write cache
value passed in to blk_queue_write_cache(), which then causes the block
layer to send down BIOs with REQ_FUA and REQ_PREFLUSH set.  We do have a
"write_cache" sysfs entry for namespaces, i.e.:

  /sys/bus/nd/devices/pfn0.1/block/pmem0/dax/write_cache

which can be used to control whether or not the kernel thinks a given
namespace has a write cache, but this didn't modify the deep flush behavior
that we set up when the driver was initialized.  Instead, it only modified
whether or not DAX would flush CPU caches via dax_flush() in response to
*sync calls.

Simplify this by making the *sync deep flush always happen, regardless of
the write cache setting of a namespace.  The DAX CPU cache flushing will
still be controlled the write_cache setting of the namespace.

Cc: <stable@vger.kernel.org>
Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/pmem.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -299,7 +299,7 @@ static int pmem_attach_disk(struct devic
 {
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	struct nd_region *nd_region = to_nd_region(dev->parent);
-	int nid = dev_to_node(dev), fua, wbc;
+	int nid = dev_to_node(dev), fua;
 	struct resource *res = &nsio->res;
 	struct resource bb_res;
 	struct nd_pfn *nd_pfn = NULL;
@@ -335,7 +335,6 @@ static int pmem_attach_disk(struct devic
 		dev_warn(dev, "unable to guarantee persistence of writes\n");
 		fua = 0;
 	}
-	wbc = nvdimm_has_cache(nd_region);
 
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
 				dev_name(&ndns->dev))) {
@@ -382,7 +381,7 @@ static int pmem_attach_disk(struct devic
 		return PTR_ERR(addr);
 	pmem->virt_addr = addr;
 
-	blk_queue_write_cache(q, wbc, fua);
+	blk_queue_write_cache(q, true, fua);
 	blk_queue_make_request(q, pmem_make_request);
 	blk_queue_physical_block_size(q, PAGE_SIZE);
 	blk_queue_logical_block_size(q, pmem_sector_size(ndns));
@@ -413,7 +412,7 @@ static int pmem_attach_disk(struct devic
 		put_disk(disk);
 		return -ENOMEM;
 	}
-	dax_write_cache(dax_dev, wbc);
+	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	pmem->dax_dev = dax_dev;
 
 	gendev = disk_to_dev(disk);


