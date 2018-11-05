Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DEFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903E2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7903E2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbeKFGeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:34:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:26013 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387862AbeKFGeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:34:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 13:12:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="97838551"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2018 13:12:25 -0800
Subject: [driver-core PATCH v5 9/9] libnvdimm: Schedule device registration
 on node local to the device
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Mon, 05 Nov 2018 13:12:25 -0800
Message-ID: <154145234526.29224.2575533246153120029.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is meant to force the device registration for nvdimm devices to
be closer to the actual device. This is achieved by using either the NUMA
node ID of the region, or of the parent. By doing this we can have
everything above the region based on the region, and everything below the
region based on the nvdimm bus.

By guaranteeing NUMA locality I see an improvement of as high as 25% for
per-node init of a system with 12TB of persistent memory.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/nvdimm/bus.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index f1fb39921236..b1e193541874 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -23,6 +23,7 @@
 #include <linux/ndctl.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -513,11 +514,15 @@ void __nd_device_register(struct device *dev)
 		set_dev_node(dev, to_nd_region(dev)->numa_node);
 
 	dev->bus = &nvdimm_bus_type;
-	if (dev->parent)
+	if (dev->parent) {
 		get_device(dev->parent);
+		if (dev_to_node(dev) == NUMA_NO_NODE)
+			set_dev_node(dev, dev_to_node(dev->parent));
+	}
 	get_device(dev);
-	async_schedule_domain(nd_async_device_register, dev,
-			&nd_async_domain);
+
+	async_schedule_dev_domain(nd_async_device_register, dev,
+				  &nd_async_domain);
 }
 
 void nd_device_register(struct device *dev)

