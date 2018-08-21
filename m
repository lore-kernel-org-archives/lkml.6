Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBCF217C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBCF217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeHUSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:23:16 -0400
Received: from sauhun.de ([88.99.104.3]:42446 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeHUSXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:23:16 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id 2BDF72D8F94;
        Tue, 21 Aug 2018 17:02:44 +0200 (CEST)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] i2c: remove deprecated attach_adapter callback
Date:   Tue, 21 Aug 2018 17:02:40 +0200
Message-Id: <20180821150240.19964-3-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180821150240.19964-1-wsa@the-dreams.de>
References: <20180821150240.19964-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't any users left. Remove this callback from the 2.4 times.
Phew, finally, that took years to reach...

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-base.c | 11 +----------
 include/linux/i2c.h         |  6 ------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5a937109a289..f15737763608 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -62,7 +62,7 @@
 
 /*
  * core_lock protects i2c_adapter_idr, and guarantees that device detection,
- * deletion of detected devices, and attach_adapter calls are serialized
+ * deletion of detected devices are serialized
  */
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
@@ -1124,15 +1124,6 @@ static int i2c_do_add_adapter(struct i2c_driver *driver,
 	/* Detect supported devices on that bus, and instantiate them */
 	i2c_detect(adap, driver);
 
-	/* Let legacy drivers scan this bus for matching devices */
-	if (driver->attach_adapter) {
-		dev_warn(&adap->dev, "%s: attach_adapter method is deprecated\n",
-			 driver->driver.name);
-		dev_warn(&adap->dev,
-			 "Please use another way to instantiate your i2c_client\n");
-		/* We ignore the return code; if it fails, too bad */
-		driver->attach_adapter(adap);
-	}
 	return 0;
 }
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 36f357ecdf67..b79387fd57da 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -231,7 +231,6 @@ enum i2c_alert_protocol {
 /**
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
- * @attach_adapter: Callback for bus addition (deprecated)
  * @probe: Callback for device binding - soon to be deprecated
  * @probe_new: New callback for device binding
  * @remove: Callback for device unbinding
@@ -268,11 +267,6 @@ enum i2c_alert_protocol {
 struct i2c_driver {
 	unsigned int class;
 
-	/* Notifies the driver that a new bus has appeared. You should avoid
-	 * using this, it will be removed in a near future.
-	 */
-	int (*attach_adapter)(struct i2c_adapter *) __deprecated;
-
 	/* Standard driver model interfaces */
 	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
 	int (*remove)(struct i2c_client *);
-- 
2.11.0

