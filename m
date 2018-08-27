Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16447C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A94208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A94208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeH0TOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:14:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:8399 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0TOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:14:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 08:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="68203469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2018 08:27:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 673EFE1; Mon, 27 Aug 2018 18:27:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] driver core: convert printk(KERN_<LEVEL> ...) to pr_<level>
Date:   Mon, 27 Aug 2018 18:27:15 +0300
Message-Id: <20180827152715.57456-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert printk:s to pr_* format.

Note, printk(KERN_DEBUG ...) is left untouched due to side effects
      of pr_debug().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index edfc9f0b1180..f0434695961f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -321,8 +321,8 @@ bool device_is_bound(struct device *dev)
 static void driver_bound(struct device *dev)
 {
 	if (device_is_bound(dev)) {
-		printk(KERN_WARNING "%s: device %s already bound\n",
-			__func__, kobject_name(&dev->kobj));
+		pr_warn("%s: device %s already bound\n", __func__,
+			kobject_name(&dev->kobj));
 		return;
 	}
 
@@ -485,8 +485,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		goto dma_failed;
 
 	if (driver_sysfs_add(dev)) {
-		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
-			__func__, dev_name(dev));
+		pr_err("%s: driver_sysfs_add(%s) failed\n", __func__,
+		       dev_name(dev));
 		goto probe_failed;
 	}
 
@@ -566,9 +566,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		break;
 	default:
 		/* driver matched but the probe failed */
-		printk(KERN_WARNING
-		       "%s: probe of %s failed with error %d\n",
-		       drv->name, dev_name(dev), ret);
+		pr_warn("%s: probe of %s failed with error %d\n",
+			drv->name, dev_name(dev), ret);
 	}
 	/*
 	 * Ignore errors returned by ->probe so that the next driver can try
-- 
2.18.0

