Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50F22077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50F22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeJKRxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJKRxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:53:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7C6EC05D3E5;
        Thu, 11 Oct 2018 10:26:39 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DDAE26FDE;
        Thu, 11 Oct 2018 10:26:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] i2c: designware: Cleanup bus lock handling
Date:   Thu, 11 Oct 2018 12:26:27 +0200
Message-Id: <20181011102627.7418-4-hdegoede@redhat.com>
In-Reply-To: <20181011102627.7418-1-hdegoede@redhat.com>
References: <20181011102627.7418-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 11 Oct 2018 10:26:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that most of the special Bay- / Cherry-Trail bus lock handling has
been moved to the iosf_mbi code we can simplify the remaining code a bit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 18 ++----------------
 drivers/i2c/busses/i2c-designware-common.c   |  4 ++--
 drivers/i2c/busses/i2c-designware-core.h     |  9 ++-------
 drivers/i2c/busses/i2c-designware-platdrv.c  |  2 --
 4 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 8c84fa0b0384..33da07d64494 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -12,16 +12,6 @@
 
 #include "i2c-designware-core.h"
 
-static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
-{
-	return iosf_mbi_block_punit_i2c_access();
-}
-
-static void baytrail_i2c_release(struct dw_i2c_dev *dev)
-{
-	iosf_mbi_unblock_punit_i2c_access();
-}
-
 int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 {
 	acpi_status status;
@@ -46,13 +36,9 @@ int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 		return -EPROBE_DEFER;
 
 	dev_info(dev->dev, "I2C bus managed by PUNIT\n");
-	dev->acquire_lock = baytrail_i2c_acquire;
-	dev->release_lock = baytrail_i2c_release;
+	dev->acquire_lock = iosf_mbi_block_punit_i2c_access;
+	dev->release_lock = iosf_mbi_unblock_punit_i2c_access;
 	dev->shared_with_punit = true;
 
 	return 0;
 }
-
-void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
-{
-}
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 36271cd75342..a4730111d290 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -269,7 +269,7 @@ int i2c_dw_acquire_lock(struct dw_i2c_dev *dev)
 	if (!dev->acquire_lock)
 		return 0;
 
-	ret = dev->acquire_lock(dev);
+	ret = dev->acquire_lock();
 	if (!ret)
 		return 0;
 
@@ -281,7 +281,7 @@ int i2c_dw_acquire_lock(struct dw_i2c_dev *dev)
 void i2c_dw_release_lock(struct dw_i2c_dev *dev)
 {
 	if (dev->release_lock)
-		dev->release_lock(dev);
+		dev->release_lock();
 }
 
 /*
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9ec8394f4787..b4a0b2b99a78 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -10,7 +10,6 @@
  */
 
 #include <linux/i2c.h>
-#include <linux/pm_qos.h>
 
 #define DW_IC_DEFAULT_FUNCTIONALITY (I2C_FUNC_I2C |			\
 					I2C_FUNC_SMBUS_BYTE |		\
@@ -209,7 +208,6 @@
  * @fp_lcnt: fast plus LCNT value
  * @hs_hcnt: high speed HCNT value
  * @hs_lcnt: high speed LCNT value
- * @pm_qos: pm_qos_request used while holding a hardware lock on the bus
  * @acquire_lock: function to acquire a hardware lock on the bus
  * @release_lock: function to release a hardware lock on the bus
  * @shared_with_punit: true if this bus is shared with the SoCs PUNIT
@@ -263,9 +261,8 @@ struct dw_i2c_dev {
 	u16			fp_lcnt;
 	u16			hs_hcnt;
 	u16			hs_lcnt;
-	struct pm_qos_request	pm_qos;
-	int			(*acquire_lock)(struct dw_i2c_dev *dev);
-	void			(*release_lock)(struct dw_i2c_dev *dev);
+	int			(*acquire_lock)(void);
+	void			(*release_lock)(void);
 	bool			shared_with_punit;
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
@@ -322,8 +319,6 @@ static inline int i2c_dw_probe_slave(struct dw_i2c_dev *dev) { return -EINVAL; }
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 extern int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev);
-extern void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev);
 #else
 static inline int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev) { return 0; }
-static inline void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev) {}
 #endif
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 997bbb3d925f..9eaac3be1f63 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -418,8 +418,6 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 	if (!IS_ERR_OR_NULL(dev->rst))
 		reset_control_assert(dev->rst);
 
-	i2c_dw_remove_lock_support(dev);
-
 	return 0;
 }
 
-- 
2.19.0

