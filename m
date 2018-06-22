Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B38C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B3823C60
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqoQeeBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B3823C60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934333AbeFVC13 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:27:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34412 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934277AbeFVC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:27:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so2693479plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 19:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jLsLZ9JhK1nl3CD0x0N4RUNnVdzrPBoDW8trHcHESAs=;
        b=SqoQeeBmTrXHVPIf7AgHp69klYygPTCboJBdy5nCvECACoULmdBqoq8w0KOxipdXlJ
         l0iMt6/60OC0BHs1XHJ7CgOPu/G20BW7UjYEcHLU1mvDEVd8fVLSjyA2JQzqk4RZm+BX
         KXsOCsXXA2pN445NrdUmib8YIndPskOERmpFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jLsLZ9JhK1nl3CD0x0N4RUNnVdzrPBoDW8trHcHESAs=;
        b=qRw5+mm/6aV/SdnqtEhJRqHWzCipeozN/vuyH5SOz7Cpfu2st/H+cie2z2v3+JVdjz
         tWcvuYz9KMVmKSyzMupLnwSvDeMVYQn9iPhN91wztZe27qbo9TxPnVzKin0tcQWOnyOI
         AaWNralPS1vsi+KvnOCTO8jLRkA0euuVuMT52ZaQe+XbjODmRwc6D32wuSxxG6AhqU5U
         9/cKnztTNvaj4uZAHjDT8LQg25RIKA+j3brifbbXN6Y1WjjeLIHY9bERPGlJjgV3Wop3
         SdKj4hbxyq1VZbt8vRLy7dLKznqRPBUCgvUqYnpvL+AkGv9IEUPRttzYzDKm5BgPZlgJ
         V1Qg==
X-Gm-Message-State: APt69E1WTdpV12KHsHLAsXHa0BbkfD2QR9sf7ZLxJiI/teh0XGrUaI+6
        7mURbZt3Q5aUfxDPYjgoEmgGNw==
X-Google-Smtp-Source: ADUXVKJwi0Cc7yv6mLCTVaGEdVXPgQZgcG+8rfve0ll6WPr045iFyptztg15sQ0bK4jYY/BbwxUcAA==
X-Received: by 2002:a17:902:6847:: with SMTP id f7-v6mr30872963pln.173.1529634442128;
        Thu, 21 Jun 2018 19:27:22 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id b74-v6sm13889045pfl.138.2018.06.21.19.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 19:27:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] HID: i2c-hid: Add vddl regulator control
Date:   Thu, 21 Jun 2018 19:27:17 -0700
Message-Id: <20180622022717.134300-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180622022717.134300-1-swboyd@chromium.org>
References: <20180622022717.134300-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some wacom w9013 devices have a vddl supply for "low valtage"
requirements. Add support in this driver to turn on this low voltage
supply. We can also drop a handful of error messages because the
regulator core is already printing an error when bulk regulators fail to
enable or disable.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/input/hid-over-i2c.txt           |  3 +-
 drivers/hid/i2c-hid/i2c-hid.c                 | 48 +++++++++----------
 include/linux/platform_data/i2c-hid.h         |  7 ++-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index 4d3da9d91de4..89e6ab89ba38 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -26,7 +26,8 @@ device-specific compatible properties, which should be used in addition to the
 
 - compatible:
   * "wacom,w9013" (Wacom W9013 digitizer). Supports:
-    - vdd-supply
+    - vdd-supply (3.3V)
+    - vddl-supply (1.8V)
     - post-power-on-delay-ms
 
 - vdd-supply: phandle of the regulator that provides the supply voltage.
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index c7d6738dc524..4f532d9238fb 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1021,21 +1021,20 @@ static int i2c_hid_probe(struct i2c_client *client,
 	/* Parse platform agnostic common properties from ACPI / device tree */
 	i2c_hid_fwnode_probe(client, &ihid->pdata);
 
-	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(ihid->pdata.supply)) {
-		ret = PTR_ERR(ihid->pdata.supply);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "Failed to get regulator: %d\n",
-				ret);
-		goto err;
-	}
+	ihid->pdata.supplies[0].supply = "vdd";
+	ihid->pdata.supplies[1].supply = "vddl";
+
+	ret = devm_regulator_bulk_get(&client->dev,
+				      ARRAY_SIZE(ihid->pdata.supplies),
+				      ihid->pdata.supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ihid->pdata.supplies),
+				    ihid->pdata.supplies);
+	if (ret < 0)
+		return ret;
 
-	ret = regulator_enable(ihid->pdata.supply);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to enable regulator: %d\n",
-			ret);
-		goto err;
-	}
 	if (ihid->pdata.post_power_delay_ms)
 		msleep(ihid->pdata.post_power_delay_ms);
 
@@ -1122,9 +1121,8 @@ static int i2c_hid_probe(struct i2c_client *client,
 	pm_runtime_disable(&client->dev);
 
 err_regulator:
-	regulator_disable(ihid->pdata.supply);
-
-err:
+	regulator_bulk_disable(ARRAY_SIZE(ihid->pdata.supplies),
+			       ihid->pdata.supplies);
 	i2c_hid_free_buffers(ihid);
 	return ret;
 }
@@ -1147,7 +1145,8 @@ static int i2c_hid_remove(struct i2c_client *client)
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
 
-	regulator_disable(ihid->pdata.supply);
+	regulator_bulk_disable(ARRAY_SIZE(ihid->pdata.supplies),
+			       ihid->pdata.supplies);
 
 	return 0;
 }
@@ -1198,9 +1197,8 @@ static int i2c_hid_suspend(struct device *dev)
 			hid_warn(hid, "Failed to enable irq wake: %d\n",
 				wake_status);
 	} else {
-		ret = regulator_disable(ihid->pdata.supply);
-		if (ret < 0)
-			hid_warn(hid, "Failed to disable supply: %d\n", ret);
+		regulator_bulk_disable(ARRAY_SIZE(ihid->pdata.supplies),
+				       ihid->pdata.supplies);
 	}
 
 	return 0;
@@ -1215,9 +1213,11 @@ static int i2c_hid_resume(struct device *dev)
 	int wake_status;
 
 	if (!device_may_wakeup(&client->dev)) {
-		ret = regulator_enable(ihid->pdata.supply);
-		if (ret < 0)
-			hid_warn(hid, "Failed to enable supply: %d\n", ret);
+		ret = regulator_bulk_enable(ARRAY_SIZE(ihid->pdata.supplies),
+					    ihid->pdata.supplies);
+		if (ret)
+			hid_warn(hid, "Failed to enable supplies: %d\n", ret);
+
 		if (ihid->pdata.post_power_delay_ms)
 			msleep(ihid->pdata.post_power_delay_ms);
 	} else if (ihid->irq_wake_enabled) {
diff --git a/include/linux/platform_data/i2c-hid.h b/include/linux/platform_data/i2c-hid.h
index 1fb088239d12..c628bb5e1061 100644
--- a/include/linux/platform_data/i2c-hid.h
+++ b/include/linux/platform_data/i2c-hid.h
@@ -12,14 +12,13 @@
 #ifndef __LINUX_I2C_HID_H
 #define __LINUX_I2C_HID_H
 
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
-struct regulator;
-
 /**
  * struct i2chid_platform_data - used by hid over i2c implementation.
  * @hid_descriptor_address: i2c register where the HID descriptor is stored.
- * @supply: regulator for powering on the device.
+ * @supplies: regulators for powering on the device.
  * @post_power_delay_ms: delay after powering on before device is usable.
  *
  * Note that it is the responsibility of the platform driver (or the acpi 5.0
@@ -35,7 +34,7 @@ struct regulator;
  */
 struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
-	struct regulator *supply;
+	struct regulator_bulk_data supplies[2];
 	int post_power_delay_ms;
 };
 
-- 
Sent by a computer through tubes

