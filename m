Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5488E20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5488E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIUEQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:16:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:21358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbeIUEQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:16:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 15:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,282,1534834800"; 
   d="scan'208";a="85287175"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2018 15:29:58 -0700
Subject: [PATCH v4 5/5] nvdimm: Schedule device registration on node local
 to the device
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Thu, 20 Sep 2018 15:29:57 -0700
Message-ID: <20180920222951.19464.39241.stgit@localhost.localdomain>
In-Reply-To: <20180920215824.19464.8884.stgit@localhost.localdomain>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
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

One additional change I made is that we hold onto a reference to the parent
while we are going through registration. By doing this we can guarantee we
can complete the registration before we have the parent device removed.

By guaranteeing NUMA locality I see an improvement of as high as 25% for
per-node init of a system with 12TB of persistent memory.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/nvdimm/bus.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 8aae6dcc839f..ca935296d55e 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -487,7 +487,9 @@ static void nd_async_device_register(void *d, async_cookie_t cookie)
 		dev_err(dev, "%s: failed\n", __func__);
 		put_device(dev);
 	}
+
 	put_device(dev);
+	put_device(dev->parent);
 }
 
 static void nd_async_device_unregister(void *d, async_cookie_t cookie)
@@ -504,12 +506,25 @@ static void nd_async_device_unregister(void *d, async_cookie_t cookie)
 
 void __nd_device_register(struct device *dev)
 {
+	int node;
+
 	if (!dev)
 		return;
+
 	dev->bus = &nvdimm_bus_type;
+	get_device(dev->parent);
 	get_device(dev);
-	async_schedule_domain(nd_async_device_register, dev,
-			&nd_async_domain);
+
+	/*
+	 * For a region we can break away from the parent node,
+	 * otherwise for all other devices we just inherit the node from
+	 * the parent.
+	 */
+	node = is_nd_region(dev) ? to_nd_region(dev)->numa_node :
+				   dev_to_node(dev->parent);
+
+	async_schedule_on_domain(nd_async_device_register, dev, node,
+				 &nd_async_domain);
 }
 
 void nd_device_register(struct device *dev)

