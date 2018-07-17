Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC938ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A242083D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="tujyUZ7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A242083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeGQJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:13:35 -0400
Received: from onstation.org ([52.200.56.107]:58228 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbeGQJNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:13:34 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4236A3AE;
        Tue, 17 Jul 2018 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531816923;
        bh=EIwMpXwnjN+mz6+6RewBfybKa96QWnv7we6Qik1tGAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tujyUZ7eFNRal9URerb4h+bhtmCaoNOeodwdM3tMeFv8LWoKRrMEuzlqKTyTTH0Qc
         tI8DZDVQewVZnV6zezHciEGp4NcoivtDQBsRRULPjqR5FrNTqI+MQzpLftU4t+zChO
         5wv0E9OJtFiPvBjw0Nn8YhLsUdKTSkTcmDft6St8=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: [PATCH v2 1/7] iio: imu: mpu6050: add support for regulator framework
Date:   Tue, 17 Jul 2018 04:41:52 -0400
Message-Id: <20180717084158.23532-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717084158.23532-1-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the regulator framework to the mpu6050
driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
Changes since v1:
- Use devm_regulator_get() instead of devm_regulator_get_optional()
- Use devm_add_action() for cleaning up the regulator.
- Correct ordering of resume code.
- Add regulator_enabled flag to ensure regulator is not disabled twice,
  specifically the case where the device is suspended and then the
  driver is removed.

Original extra changelog from v1:

This is a variation of Jonathan Marek's patch from postmarketOS
https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
with the following changes:

- Stripped out 6515 variant code.
- Add the regulator to the mpu core instead of only the i2c variant.
- Add error handling.
- Release the regulator on suspend, device remove, etc.
- Device tree documentation.

 .../bindings/iio/imu/inv_mpu6050.txt          |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 73 +++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  3 +
 3 files changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index b7def51c8ad9..d39907b12a46 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -21,6 +21,7 @@ Required properties:
   bindings.
 
 Optional properties:
+ - vddio-supply: regulator phandle for VDDIO supply
  - mount-matrix: an optional 3x3 mounting rotation matrix
  - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is
    simple enough to be described using the i2c-gate binding. See
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 12c1b9507007..e1fbab4bc0a0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -23,6 +23,7 @@
 #include <linux/iio/iio.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include "inv_mpu_iio.h"
 
 /*
@@ -926,6 +927,46 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	return result;
 }
 
+static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
+{
+	int result;
+
+	result = regulator_enable(st->vddio_supply);
+	if (result) {
+		dev_err(regmap_get_device(st->map),
+			"Failed to enable regulator: %d\n", result);
+	} else {
+		st->regulator_enabled = true;
+
+		/* Give the device a little bit of time to start up. */
+		usleep_range(35000, 70000);
+	}
+
+	return result;
+}
+
+static int inv_mpu_core_disable_regulator(struct inv_mpu6050_state *st)
+{
+	int result;
+
+	if (!st->regulator_enabled)
+		return 0;
+
+	result = regulator_disable(st->vddio_supply);
+	if (result)
+		dev_err(regmap_get_device(st->map),
+			"Failed to disable regulator: %d\n", result);
+
+	st->regulator_enabled = false;
+
+	return result;
+}
+
+static void inv_mpu_core_disable_regulator_action(void *_data)
+{
+	inv_mpu_core_disable_regulator(_data);
+}
+
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
 {
@@ -990,6 +1031,28 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return -EINVAL;
 	}
 
+	st->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(st->vddio_supply)) {
+		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vddio regulator %d\n",
+				(int)PTR_ERR(st->vddio_supply));
+
+		return PTR_ERR(st->vddio_supply);
+	}
+
+	result = inv_mpu_core_enable_regulator(st);
+	if (result)
+		return result;
+
+	result = devm_add_action(dev, inv_mpu_core_disable_regulator_action,
+				 st);
+	if (result) {
+		inv_mpu_core_disable_regulator_action(st);
+		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
+			result);
+		return result;
+	}
+
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st);
 	if (result)
@@ -1049,7 +1112,12 @@ static int inv_mpu_resume(struct device *dev)
 	int result;
 
 	mutex_lock(&st->lock);
+	result = inv_mpu_core_enable_regulator(st);
+	if (result)
+		goto out_unlock;
+
 	result = inv_mpu6050_set_power_itg(st, true);
+out_unlock:
 	mutex_unlock(&st->lock);
 
 	return result;
@@ -1062,6 +1130,11 @@ static int inv_mpu_suspend(struct device *dev)
 
 	mutex_lock(&st->lock);
 	result = inv_mpu6050_set_power_itg(st, false);
+	if (result)
+		goto out_unlock;
+
+	result = inv_mpu_core_disable_regulator(st);
+out_unlock:
 	mutex_unlock(&st->lock);
 
 	return result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e69a59659dbc..01c8fe9b4fa0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
  *  @chip_period:	chip internal period estimation (~1kHz).
  *  @it_timestamp:	timestamp from previous interrupt.
  *  @data_timestamp:	timestamp for next data sample.
+ *  @vddio_supply	voltage regulator for the chip.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -149,6 +150,8 @@ struct inv_mpu6050_state {
 	s64 chip_period;
 	s64 it_timestamp;
 	s64 data_timestamp;
+	struct regulator *vddio_supply;
+	bool regulator_enabled;
 };
 
 /*register and associated bit definition*/
-- 
2.17.1

