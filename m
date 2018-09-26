Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24FC004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F70821537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F70821537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeI0EHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:07:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:7372 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbeI0EHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:07:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 14:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="94009170"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.154])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 14:52:01 -0700
Subject: [RFC workqueue/driver-core PATCH 5/5] nvdimm: Schedule device
 registration on node local to the device
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
Cc:     len.brown@intel.com, dave.jiang@intel.com, rafael@kernel.org,
        vishal.l.verma@intel.com, jiangshanlai@gmail.com, pavel@ucw.cz,
        zwisler@kernel.org, dan.j.williams@intel.com
Date:   Wed, 26 Sep 2018 14:52:01 -0700
Message-ID: <20180926215201.13512.55945.stgit@localhost.localdomain>
In-Reply-To: <20180926214433.13512.30289.stgit@localhost.localdomain>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
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
index 96154670bf07..f663d6ff524e 100644
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

