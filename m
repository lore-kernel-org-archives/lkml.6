Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E5421726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfAVSjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:39:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:27985 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfAVSjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:39:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 10:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,507,1539673200"; 
   d="scan'208";a="120435520"
Received: from ahduyck-desk1.jf.intel.com (HELO ahduyck-desk1.amr.corp.intel.com) ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 22 Jan 2019 10:39:47 -0800
Subject: [driver-core PATCH v10 8/9] libnvdimm: Schedule device registration
 on node local to the device
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Tue, 22 Jan 2019 10:39:47 -0800
Message-ID: <154818238742.18753.12796774960063459729.stgit@ahduyck-desk1.amr.corp.intel.com>
In-Reply-To: <154818223154.18753.12374915684623789884.stgit@ahduyck-desk1.amr.corp.intel.com>
References: <154818223154.18753.12374915684623789884.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force the device registration for nvdimm devices to be closer to the actual
device. This is achieved by using either the NUMA node ID of the region, or
of the parent. By doing this we can have everything above the region based
on the region, and everything below the region based on the nvdimm bus.

By guaranteeing NUMA locality I see an improvement of as high as 25% for
per-node init of a system with 12TB of persistent memory.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/nvdimm/bus.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index dca5f7a805cb..7bbff0af29b2 100644
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
@@ -534,11 +535,15 @@ void __nd_device_register(struct device *dev)
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

