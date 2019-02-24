Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96860C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B3120663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfBXJOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 04:14:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:8519 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbfBXJOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 04:14:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 01:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="135863164"
Received: from rajeev-desktop.iind.intel.com ([10.223.84.39])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2019 01:14:28 -0800
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        gwendal@google.com, jettrink@chromium.org,
        andriy.shevchenko@intel.com
Subject: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
Date:   Sun, 24 Feb 2019 14:43:49 +0530
Message-Id: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Integrated Sensor Hub (ISH) is also a MCU running EC
having feature bit EC_FEATURE_ISH. Instantiate it as a special
CrOS EC device with device name 'cros_ish'.

Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
---
 drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
 include/linux/mfd/cros_ec.h          |  1 +
 include/linux/mfd/cros_ec_commands.h |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 2d0fee4..be499b8 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -414,6 +414,16 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
+	/* check whether this is actually a Intel ISH rather than an EC */
+	if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
+		dev_info(dev, "Intel ISH MCU detected.\n");
+		/*
+		 * Help userspace differentiating ECs from ISH MCU,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
+	}
+
 	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index de8b588..00c5765 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -24,6 +24,7 @@
 
 #define CROS_EC_DEV_NAME "cros_ec"
 #define CROS_EC_DEV_PD_NAME "cros_pd"
+#define CROS_EC_DEV_ISH_NAME "cros_ish"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082..9276c3c 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -856,6 +856,8 @@ enum ec_feature_code {
 	EC_FEATURE_RTC = 27,
 	/* EC supports CEC commands */
 	EC_FEATURE_CEC = 35,
+	/* The MCU is an Intel Integrated Sensor Hub */
+	EC_FEATURE_ISH = 40,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-- 
1.9.1

