Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5222086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5222086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIZDCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:02:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:21422 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeIZDCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:02:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 13:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="77236383"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2018 13:53:07 -0700
Subject: [PATCH 2/2] nvdimm: Set device node in nd_device_register
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org
Date:   Tue, 25 Sep 2018 13:53:07 -0700
Message-ID: <20180925205307.6182.26453.stgit@localhost.localdomain>
In-Reply-To: <20180925204801.6182.73167.stgit@localhost.localdomain>
References: <20180925204801.6182.73167.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes it so that we don't repeatedly overwrite the device node
for nvdimm regions. The earliest we can set the node is immediately after
calling device init, so I have moved the code there so we can avoid
rewriting the node with each uevent.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/nvdimm/bus.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 9148015ed803..96f4d0e1706a 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -54,12 +54,6 @@ static int to_nd_device_type(struct device *dev)
 
 static int nvdimm_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	/*
-	 * Ensure that region devices always have their numa node set as
-	 * early as possible.
-	 */
-	if (is_nd_region(dev))
-		set_dev_node(dev, to_nd_region(dev)->numa_node);
 	return add_uevent_var(env, "MODALIAS=" ND_DEVICE_MODALIAS_FMT,
 			to_nd_device_type(dev));
 }
@@ -519,6 +513,16 @@ void __nd_device_register(struct device *dev)
 void nd_device_register(struct device *dev)
 {
 	device_initialize(dev);
+
+	/*
+	 * Ensure that region devices always have their NUMA node set as
+	 * early as possible. This way we are able to make certain that any
+	 * memory associated with the creation and the creation itself of
+	 * the region is associated with the correct node.
+	 */
+	if (is_nd_region(dev))
+		set_dev_node(dev, to_nd_region(dev)->numa_node);
+
 	__nd_device_register(dev);
 }
 EXPORT_SYMBOL(nd_device_register);

