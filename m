Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B0C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A30A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfA3HW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:22:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:2560 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfA3HWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:22:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 23:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="130055606"
Received: from shbuild999.sh.intel.com ([10.239.147.118])
  by orsmga002.jf.intel.com with ESMTP; 29 Jan 2019 23:22:53 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3] async: Add cmdline option to specify drivers to be async probed
Date:   Wed, 30 Jan 2019 15:23:11 +0800
Message-Id: <1548832991-31718-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asynchronous driver probing can help much on kernel fastboot, and
this option can provide a flexible way to optimize and quickly verify
async driver probe.

Also it will help in below cases:
* Some driver actually covers several families of HWs, some of which
  could use async probing while others don't. So we can't simply
  turn on the PROBE_PREFER_ASYNCHRONOUS flag in driver, but use this
  cmdline option, like igb driver async patch discussed at
  https://www.spinics.net/lists/netdev/msg545986.html

* For SOC (System on Chip) with multiple spi or i2c controllers, most
  of the slave spi/i2c devices will be assigned with fixed controller
  number, while async probing may make those controllers get different
  index for each boot, which prevents those controller drivers to be
  async probed. For platforms not using these spi/i2c slave devices,
  they can use this cmdline option to benefit from the async probing.

Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:
  v3: 
     move the cmdline_requested_async_probing() into "default:"
     part to enforce the PROBE_FORCE_SYNCHRONOUS check, as suggested
     by Alexander Duyck
    
  v2:
    * change Alexander Duyck's email to alexander.h.duyck@linux.intel.com
    * fix the parameter for strlcpy()

 drivers/base/dd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8ac10af..e99d781 100644
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
@@ -674,6 +678,22 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static inline bool cmdline_requested_async_probing(const char *drv_name)
+{
+	return parse_option_str(async_probe_drv_names, drv_name);
+}
+
+/* The format is like driver_async_probe=drv_name1,drv_name2,drv_name3 */
+static int __init save_async_options(char *buf)
+{
+	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
+		printk(KERN_WARNING "Too long list for async_probe_drv_names!\n");
+
+	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
+	return 0;
+}
+__setup("driver_async_probe=", save_async_options);
+
 bool driver_allows_async_probing(struct device_driver *drv)
 {
 	switch (drv->probe_type) {
@@ -684,6 +704,9 @@ bool driver_allows_async_probing(struct device_driver *drv)
 		return false;
 
 	default:
+		if (cmdline_requested_async_probing(drv->name))
+			return true;
+
 		if (module_requested_async_probing(drv->owner))
 			return true;
 
-- 
2.7.4

