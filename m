Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28583C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF87206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF87206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeI2AlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:41:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:26694 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI2AlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:41:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 11:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="94378353"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2018 11:16:04 -0700
Subject: [PATCH] libnvdimm,
 region: Fail badblocks listing for inactive regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:04:17 -0700
Message-ID: <153815785702.2023323.12153027860843602654.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While experimenting with region driver loading the following backtrace
was triggered:

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
 [..]
 Call Trace:
  dump_stack+0x85/0xcb
  register_lock_class+0x571/0x580
  ? __lock_acquire+0x2ba/0x1310
  ? kernfs_seq_start+0x2a/0x80
  __lock_acquire+0xd4/0x1310
  ? dev_attr_show+0x1c/0x50
  ? __lock_acquire+0x2ba/0x1310
  ? kernfs_seq_start+0x2a/0x80
  ? lock_acquire+0x9e/0x1a0
  lock_acquire+0x9e/0x1a0
  ? dev_attr_show+0x1c/0x50
  badblocks_show+0x70/0x190
  ? dev_attr_show+0x1c/0x50
  dev_attr_show+0x1c/0x50

This results from a missing successful call to devm_init_badblocks()
from nd_region_probe(). Block attempts to show badblocks while the
region is not enabled.

Fixes: 6a6bef90425e ("libnvdimm: add mechanism to publish badblocks...")
Cc: <stable@vger.kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/region_devs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index fa37afcd43ff..174a418cb171 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -560,10 +560,17 @@ static ssize_t region_badblocks_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
+	ssize_t rc;
 
-	return badblocks_show(&nd_region->bb, buf, 0);
-}
+	device_lock(dev);
+	if (dev->driver)
+		rc = badblocks_show(&nd_region->bb, buf, 0);
+	else
+		rc = -ENXIO;
+	device_unlock(dev);
 
+	return rc;
+}
 static DEVICE_ATTR(badblocks, 0444, region_badblocks_show, NULL);
 
 static ssize_t resource_show(struct device *dev,

