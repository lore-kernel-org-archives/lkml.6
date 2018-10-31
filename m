Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641FAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B9120821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B9120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJaMUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:20:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:25667 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJaMUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:20:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104138659"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 30 Oct 2018 20:24:42 -0700
Subject: [PATCH 1/8] device-dax: Kill dax_region ida
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
Date:   Tue, 30 Oct 2018 20:12:54 -0700
Message-ID: <154095557491.3271337.10354816564776020500.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bbb3be170ac2 "device-dax: fix sysfs duplicate warnings" arranged
for passing a dax instance-id to devm_create_dax_dev(), rather than
generating one internally. Remove the dax_region ida and related code.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |    3 ---
 drivers/dax/device.c      |   24 +++---------------------
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index b6fc4f04636d..d1b36a42132f 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -28,7 +28,6 @@
  */
 struct dax_region {
 	int id;
-	struct ida ida;
 	void *base;
 	struct kref kref;
 	struct device *dev;
@@ -42,7 +41,6 @@ struct dax_region {
  * @region - parent region
  * @dax_dev - core dax functionality
  * @dev - device core
- * @id - child id in the region
  * @num_resources - number of physical address extents in this device
  * @res - array of physical address ranges
  */
@@ -50,7 +48,6 @@ struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
 	struct device dev;
-	int id;
 	int num_resources;
 	struct resource res[0];
 };
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 948806e57cee..a5a670c1cd58 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -128,7 +128,6 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 	dax_region->pfn_flags = pfn_flags;
 	kref_init(&dax_region->kref);
 	dax_region->id = region_id;
-	ida_init(&dax_region->ida);
 	dax_region->align = align;
 	dax_region->dev = parent;
 	dax_region->base = addr;
@@ -582,8 +581,6 @@ static void dev_dax_release(struct device *dev)
 	struct dax_region *dax_region = dev_dax->region;
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 
-	if (dev_dax->id >= 0)
-		ida_simple_remove(&dax_region->ida, dev_dax->id);
 	dax_region_put(dax_region);
 	put_dax(dax_dev);
 	kfree(dev_dax);
@@ -642,19 +639,7 @@ struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
 	}
 
 	if (i < count)
-		goto err_id;
-
-	if (id < 0) {
-		id = ida_simple_get(&dax_region->ida, 0, 0, GFP_KERNEL);
-		dev_dax->id = id;
-		if (id < 0) {
-			rc = id;
-			goto err_id;
-		}
-	} else {
-		/* region provider owns @id lifetime */
-		dev_dax->id = -1;
-	}
+		goto err;
 
 	/*
 	 * No 'host' or dax_operations since there is no access to this
@@ -663,7 +648,7 @@ struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
 	dax_dev = alloc_dax(dev_dax, NULL, NULL);
 	if (!dax_dev) {
 		rc = -ENOMEM;
-		goto err_dax;
+		goto err;
 	}
 
 	/* from here on we're committed to teardown via dax_dev_release() */
@@ -700,10 +685,7 @@ struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
 
 	return dev_dax;
 
- err_dax:
-	if (dev_dax->id >= 0)
-		ida_simple_remove(&dax_region->ida, dev_dax->id);
- err_id:
+ err:
 	kfree(dev_dax);
 
 	return ERR_PTR(rc);

