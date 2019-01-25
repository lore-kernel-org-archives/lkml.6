Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C161E218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfAYNUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:20:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:13283 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYNUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:20:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:20:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="112615098"
Received: from shbuild999.sh.intel.com ([10.239.147.118])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2019 05:20:00 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH] async: Add cmdline option to specify drivers to be async probed
Date:   Fri, 25 Jan 2019 21:20:16 +0800
Message-Id: <1548422416-44786-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asynchronous driver probing can help much on kerenl fastboot, and
this option can provide a flexible way to optimize and quickly verify
async driver probe.

Also it will help in below cases:
* Some driver actually covers several family of HWs, some of which
  could use async probling while others don't. So we can't simply
  turn on the PROBE_PREFER_ASYNCHRONOUS flag in driver, but use this
  cmdline option, like igb driver discussed at
  https://www.spinics.net/lists/netdev/msg545986.html

* For SOC (System on Chip) with multiple spi or i2c controllers, most
  of the slave spi/i2c devices will be assigned with fixed controller
  number, which prevents these spi/i2c controller drivers to be async
  probed. For plaforms not using these spi/i2c slave devices, they can
  use this cmdline option to benefit from the async probing.

Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/base/dd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8ac10af..1f257561 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -57,6 +57,10 @@ static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 static struct dentry *deferred_devices;
 static bool initcalls_done;
 
+/* Save the async probe drivers' name from kernel cmdline */
+#define ASYNC_DRV_NAMES_MAX_LEN	256
+static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
+
 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
  * to prohibit probing of devices as it could be unsafe.
@@ -674,8 +678,26 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static inline bool cmdline_requested_async_probing(const char *drv_name)
+{
+	return parse_option_str(async_probe_drv_names, drv_name);
+}
+
+static int __init save_async_options(char *buf)
+{
+	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
+		printk(KERN_WARNING "Too long list for async_probe_drv_names!");
+
+	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN - 1);
+	return 0;
+}
+__setup("driver_async_probe=", save_async_options);
+
 bool driver_allows_async_probing(struct device_driver *drv)
 {
+	if (unlikely(cmdline_requested_async_probing(drv->name)))
+		return true;
+
 	switch (drv->probe_type) {
 	case PROBE_PREFER_ASYNCHRONOUS:
 		return true;
-- 
2.7.4

