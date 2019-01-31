Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8613C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BA42184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfAaDH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:07:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:53061 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfAaDH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:07:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 19:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208,223";a="129933867"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2019 19:07:23 -0800
Date:   Thu, 31 Jan 2019 11:08:31 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] async: Add cmdline option to specify drivers to be
 async probed
Message-ID: <20190131030831.ewdokhe5u67tieh7@shbuild888>
References: <1548902630-5550-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548902630-5550-1-git-send-email-feng.tang@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 05e8ce911859e65d3b96348b0772f307daaeba77 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Fri, 25 Jan 2019 16:48:54 +0800
Subject: [PATCH v4] async: Add cmdline option to specify drivers to be async
 probed

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
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:
  v4:
     Add description to kernel-parameters.txt and refine the
     prink message, as suggested by Randy Dunlap 

  v3: 
     move the cmdline_requested_async_probing() into "default:"
     part to enforce the PROBE_FORCE_SYNCHRONOUS check, as suggested
     by Alexander Duyck
    
  v2:
    * change Alexander Duyck's email to alexander.h.duyck@linux.intel.com
    * fix the parameter for strlcpy()

 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/base/dd.c                               | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf..a5b2112 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -910,6 +910,10 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	driver_async_probe=  [KNL]
+			List of driver names to be probed asynchronously.
+			Format: <driver_name1>,<driver_name2>...
+
 	drm.edid_firmware=[<connector>:]<file>[,[<connector>:]<file>]
 			Broken monitors, graphic adapters, KVMs and EDIDless
 			panels may send no or incorrect EDID data sets.
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8ac10af..279204a 100644
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
@@ -674,6 +678,23 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static inline bool cmdline_requested_async_probing(const char *drv_name)
+{
+	return parse_option_str(async_probe_drv_names, drv_name);
+}
+
+/* The option format is "driver_async_probe=drv_name1,drv_name2,..." */
+static int __init save_async_options(char *buf)
+{
+	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
+		printk(KERN_WARNING
+			"Too long list of driver names for 'driver_async_probe'!\n");
+
+	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
+	return 0;
+}
+__setup("driver_async_probe=", save_async_options);
+
 bool driver_allows_async_probing(struct device_driver *drv)
 {
 	switch (drv->probe_type) {
@@ -684,6 +705,9 @@ bool driver_allows_async_probing(struct device_driver *drv)
 		return false;
 
 	default:
+		if (cmdline_requested_async_probing(drv->name))
+			return true;
+
 		if (module_requested_async_probing(drv->owner))
 			return true;
 
-- 
2.7.4
