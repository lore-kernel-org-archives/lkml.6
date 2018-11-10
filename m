Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92F62081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92F62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeKKD5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:57:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:15025 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeKKD5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:57:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2018 10:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,488,1534834800"; 
   d="scan'208";a="90126921"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2018 10:11:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C77791AC; Sat, 10 Nov 2018 20:11:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Grant Likely <grant.likely@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Date:   Sat, 10 Nov 2018 20:10:57 +0200
Message-Id: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following scenario.

There are two independent devices coupled together by functional dependencies:
 - USB OTG (dwc3-pci)
 - extcon (tested with extcon-intel-mrfld, not yet in upstream)

Each of the driver services a corresponding device is built as a module. In the
Buildroot environment the modules are probed by alphabetical ordering of their
modaliases. The latter comes to the case when USB OTG driver will be probed
first followed by extcon one.

So, if the platform anticipates extcon device to be appeared, in the above case
we will get deferred probe of USB OTG, because of ordering.

Now, a cherry on top of the cake, the deferred probing list contains
the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
values in the local_trigger_count and deferred_trigger_count are not the same,
and thus provokes deferred probe triggering again and again.

...
[   20.678332] platform dwc3.0.auto: Retrying from deferred list
[   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
[   20.701254] platform dwc3.0.auto: Added to deferred list
[   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
[   20.713732] platform dwc3.0.auto: Retrying from deferred list
[   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
[   20.736540] platform dwc3.0.auto: Added to deferred list
[   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
[   20.748991] platform dwc3.0.auto: Retrying from deferred list
[   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
[   20.771914] platform dwc3.0.auto: Added to deferred list
[   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
...

Deeper investigation shows the culprit commit 58b116bce136
("drivercore: deferral race condition fix") which was dedicated to fix some
other issue while bringing a regression.

This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
we will have better solution.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..9a966e45fda5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -53,7 +53,6 @@
 static DEFINE_MUTEX(deferred_probe_mutex);
 static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
-static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 static struct dentry *deferred_devices;
 static bool initcalls_done;
 
@@ -143,17 +142,6 @@ static bool driver_deferred_probe_enable = false;
  * This functions moves all devices from the pending list to the active
  * list and schedules the deferred probe workqueue to process them.  It
  * should be called anytime a driver is successfully bound to a device.
- *
- * Note, there is a race condition in multi-threaded probe. In the case where
- * more than one device is probing at the same time, it is possible for one
- * probe to complete successfully while another is about to defer. If the second
- * depends on the first, then it will get put on the pending list after the
- * trigger event has already occurred and will be stuck there.
- *
- * The atomic 'deferred_trigger_count' is used to determine if a successful
- * trigger has occurred in the midst of probing a driver. If the trigger count
- * changes in the midst of a probe, then deferred processing should be triggered
- * again.
  */
 static void driver_deferred_probe_trigger(void)
 {
@@ -166,7 +154,6 @@ static void driver_deferred_probe_trigger(void)
 	 * into the active list so they can be retried by the workqueue
 	 */
 	mutex_lock(&deferred_probe_mutex);
-	atomic_inc(&deferred_trigger_count);
 	list_splice_tail_init(&deferred_probe_pending_list,
 			      &deferred_probe_active_list);
 	mutex_unlock(&deferred_probe_mutex);
@@ -434,19 +421,9 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
 static atomic_t probe_count = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
-static void driver_deferred_probe_add_trigger(struct device *dev,
-					      int local_trigger_count)
-{
-	driver_deferred_probe_add(dev);
-	/* Did a trigger occur while probing? Need to re-trigger if yes */
-	if (local_trigger_count != atomic_read(&deferred_trigger_count))
-		driver_deferred_probe_trigger();
-}
-
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
 	int ret = -EPROBE_DEFER;
-	int local_trigger_count = atomic_read(&deferred_trigger_count);
 	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
 			   !drv->suppress_bind_attrs;
 
@@ -463,7 +440,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 	ret = device_links_check_suppliers(dev);
 	if (ret == -EPROBE_DEFER)
-		driver_deferred_probe_add_trigger(dev, local_trigger_count);
+		driver_deferred_probe_add(dev);
 	if (ret)
 		return ret;
 
@@ -559,7 +536,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	case -EPROBE_DEFER:
 		/* Driver requested deferred probing */
 		dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
-		driver_deferred_probe_add_trigger(dev, local_trigger_count);
+		driver_deferred_probe_add(dev);
 		break;
 	case -ENODEV:
 	case -ENXIO:
-- 
2.19.1

