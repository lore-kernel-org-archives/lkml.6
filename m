Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E4ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936D620825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936D620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeKIDoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:44:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:46195 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeKIDoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:44:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 10:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="272479086"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2018 10:07:21 -0800
Subject: [driver-core PATCH v6 8/9] PM core: Use new async_schedule_dev
 command
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Thu, 08 Nov 2018 10:07:21 -0800
Message-ID: <154170044143.12967.7385910787360171117.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the device specific version of the async_schedule commands to defer
various tasks related to power management. By doing this we should see a
slight improvement in performance as any device that is sensitive to
latency/locality in the setup will now be initializing on the node closest
to the device.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/power/main.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a690fd400260..ebb8b61b52e9 100644
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
 
@@ -1833,7 +1833,7 @@ static int device_suspend(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend, dev);
+		async_schedule_dev(async_suspend, dev);
 		return 0;
 	}
 

