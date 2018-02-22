Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBVVXC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:23:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:35633 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBVVXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:23:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="19713333"
From: Wenkai Du <wenkai.du@intel.com>
To: Benson Leung <bleung@chromium.org>
Cc: Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Wenkai Du <wenkai.du@intel.com>
Subject: [PATCH] platform/chrome: cros_ec_lpc: wake up from s2idle on Chrome EC
Date: Thu, 22 Feb 2018 13:21:17 -0800
Message-Id: <20180222212117.122560-1-wenkai.du@intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chrome platform installed a Chrome EC notify handler which prevents
default EC GPE handler getting called. Add pm_system_wakeup to the
Chrome EC notify handler so wake up from s2idle can happen.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Wenkai Du <wenkai.du@intel.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index af89e82eecd2..2a40c2b1a7ff 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/suspend.h>
 
 #define DRV_NAME "cros_ec_lpcs"
 #define ACPI_DRV_NAME "GOOG0004"
@@ -235,6 +236,9 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 	    cros_ec_get_next_event(ec_dev, NULL) > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
 					     ec_dev);
+
+	if (value == ACPI_NOTIFY_DEVICE_WAKE)
+		pm_system_wakeup();
 }
 
 static int cros_ec_lpc_probe(struct platform_device *pdev)
-- 
2.16.1
