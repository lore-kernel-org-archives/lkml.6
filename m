Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82918C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455EA21570
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455EA21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeI0EG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:06:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:15296 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbeI0EG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:06:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 14:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="94009149"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.154])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 14:51:55 -0700
Subject: [RFC workqueue/driver-core PATCH 4/5] driver core: Use new
 async_schedule_dev command
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
Cc:     len.brown@intel.com, dave.jiang@intel.com, rafael@kernel.org,
        vishal.l.verma@intel.com, jiangshanlai@gmail.com, pavel@ucw.cz,
        zwisler@kernel.org, dan.j.williams@intel.com
Date:   Wed, 26 Sep 2018 14:51:55 -0700
Message-ID: <20180926215155.13512.30900.stgit@localhost.localdomain>
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

This change makes it so that we use the device specific version of the
async_schedule commands to defer various tasks related to devices. By doing
this we should see a slight improvement in performance as any device that
is sensitive to latency/locality in the setup will now be initializing on
the node closest to the device.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c         |    4 ++--
 drivers/base/power/main.c |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 5ba366c1cb83..81472dc44a70 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -826,7 +826,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
-			async_schedule(__device_attach_async_helper, dev);
+			async_schedule_dev(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
 		}
@@ -927,7 +927,7 @@ static int __driver_attach(struct device *dev, void *data)
 		if (!dev->driver) {
 			get_device(dev);
 			dev_set_drvdata(dev, drv);
-			async_schedule(__driver_attach_async_helper, dev);
+			async_schedule_dev(__driver_attach_async_helper, dev);
 		}
 		device_unlock(dev);
 		return 0;
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f68e2919dc5..8495d9b1e9d0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -726,7 +726,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_noirq, dev);
+			async_schedule_dev(async_resume_noirq, dev);
 		}
 	}
 
@@ -883,7 +883,7 @@ void dpm_resume_early(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_early, dev);
+			async_schedule_dev(async_resume_early, dev);
 		}
 	}
 
@@ -1047,7 +1047,7 @@ void dpm_resume(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume, dev);
+			async_schedule_dev(async_resume, dev);
 		}
 	}
 
@@ -1366,7 +1366,7 @@ static int device_suspend_noirq(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_noirq, dev);
+		async_schedule_dev(async_suspend_noirq, dev);
 		return 0;
 	}
 	return __device_suspend_noirq(dev, pm_transition, false);
@@ -1569,7 +1569,7 @@ static int device_suspend_late(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_late, dev);
+		async_schedule_dev(async_suspend_late, dev);
 		return 0;
 	}
 
@@ -1830,7 +1830,7 @@ static int device_suspend(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend, dev);
+		async_schedule_dev(async_suspend, dev);
 		return 0;
 	}
 

