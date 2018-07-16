Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ECCECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2E8208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhjbSq7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2E8208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbeGPQQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:16:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39347 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeGPQQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:16:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id j8-v6so1848740pff.6;
        Mon, 16 Jul 2018 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fu29GW2q15UmpBl+y0JQjWFcbaEJXtb2i/nqmjS7Su8=;
        b=IhjbSq7LdWCvf3TR4L9Mzi7CUoWaWXKT8sPSIBSoSIvZbDRKAheDHE1w4sA1/UIVPI
         Fkfurd/0aUziM4i5giyU7RjsFKqn0rA/ryCDaaGR8PbOBHaLVRmqKliuexy35ZRvjA9E
         T8+M5geNSex+9a45mGpU9FjaPaIINBTS/gPonMbIIRgiX3qbjKLWDqinsVHi/pX8LwNE
         AG67IQbus7tV//E5MZedmMy3UglXA/7/rrt9LdRZkhONbg02/tN4o/sqUZydgNV1KNkB
         CpEd21n2EFjPfRwrOV2SMLpf86KaBTVTUEf5b/HJcuxI+u+gmoxtYOJdfs/VJxU5939e
         uW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fu29GW2q15UmpBl+y0JQjWFcbaEJXtb2i/nqmjS7Su8=;
        b=GwnaTCSTg4zkeuSaMWvyLAWWXCYujVFkbCA73VNsFKldgQnn/pCuNvy54EjZ/sU+5U
         v4GC7ikThSg1lTBzjLHBE5CoDC3qKlZX3uSJ89Sx7udC2vkDTF0JbOwqIpYvbP8QwREF
         zvq1mjYI9XYeFzdKDgQklQeXZWBMIzlN+oKFlgy7CgNVCcNHSK6qdLvQLkh5TKKZ7XIC
         rMTQLgbC7b0TOurd/dc4l7IQBN8iJCk7Ez9ikVq9bkz7XXHnixe1H+ZSmUI5QhJAggAz
         G3l0Wv50a8r3rI0WSLxiMXy+vKI6VW6sDf2loEXPvXmIayevTElNn/JYylLtq0Tjcjqs
         /PQw==
X-Gm-Message-State: AOUpUlHzhHE84xqy7S+cKvz7q/DHmPURsUO1T/zW93hUjazNBIeNAlNR
        74N4jCHJ9nRWT2fNo3HqR2lsfw==
X-Google-Smtp-Source: AAOMgpdizhGktydgBT3IplqAjYk3Rw17KmcgCNjGMvDvB7I1RvxETKiy6YzNLMRexdfVDEPjO28ZMg==
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr12868883pfd.32.1531756093516;
        Mon, 16 Jul 2018 08:48:13 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:91ac:ef2:819b:3d04])
        by smtp.gmail.com with ESMTPSA id r64-v6sm6195001pfk.157.2018.07.16.08.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 08:48:12 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH -next v4 1/3] regmap: add SCCB support
Date:   Tue, 17 Jul 2018 00:47:48 +0900
Message-Id: <1531756070-8560-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Serial Camera Control Bus (SCCB) support for regmap API that
is intended to be used by some of Omnivision sensor drivers.

The ov772x and ov9650 drivers are going to use this SCCB regmap API.

The ov772x driver was previously only worked with the i2c controller
drivers that support I2C_FUNC_PROTOCOL_MANGLING, because the ov772x
device doesn't support repeated starts.  After commit 0b964d183cbf
("media: ov772x: allow i2c controllers without
I2C_FUNC_PROTOCOL_MANGLING"), reading ov772x register is replaced with
issuing two separated i2c messages in order to avoid repeated start.
Using this SCCB regmap hides the implementation detail.

The ov9650 driver also issues two separated i2c messages to read the
registers as the device doesn't support repeated start.  So it can
make use of this SCCB regmap.

Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/base/regmap/Kconfig       |   4 ++
 drivers/base/regmap/Makefile      |   1 +
 drivers/base/regmap/regmap-sccb.c | 128 ++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h            |  35 +++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-sccb.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index aff34c0..6ad5ef4 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -45,3 +45,7 @@ config REGMAP_IRQ
 config REGMAP_SOUNDWIRE
 	tristate
 	depends on SOUNDWIRE_BUS
+
+config REGMAP_SCCB
+	tristate
+	depends on I2C
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 5ed0023..f5b4e88 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
 obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
 obj-$(CONFIG_REGMAP_SOUNDWIRE) += regmap-sdw.o
+obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
diff --git a/drivers/base/regmap/regmap-sccb.c b/drivers/base/regmap/regmap-sccb.c
new file mode 100644
index 0000000..b6eb876
--- /dev/null
+++ b/drivers/base/regmap/regmap-sccb.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+// Register map access API - SCCB support
+
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "internal.h"
+
+/**
+ * sccb_is_available - Check if the adapter supports SCCB protocol
+ * @adap: I2C adapter
+ *
+ * Return true if the I2C adapter is capable of using SCCB helper functions,
+ * false otherwise.
+ */
+static bool sccb_is_available(struct i2c_adapter *adap)
+{
+	u32 needed_funcs = I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA;
+
+	/*
+	 * If we ever want support for hardware doing SCCB natively, we will
+	 * introduce a sccb_xfer() callback to struct i2c_algorithm and check
+	 * for it here.
+	 */
+
+	return (i2c_get_functionality(adap) & needed_funcs) == needed_funcs;
+}
+
+/**
+ * regmap_sccb_read - Read data from SCCB slave device
+ * @context: Device that will be interacted wit
+ * @reg: Register to be read from
+ * @val: Pointer to store read value
+ *
+ * This executes the 2-phase write transmission cycle that is followed by a
+ * 2-phase read transmission cycle, returning negative errno else zero on
+ * success.
+ */
+static int regmap_sccb_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	int ret;
+	union i2c_smbus_data data;
+
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
+
+	ret = __i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
+			       I2C_SMBUS_WRITE, reg, I2C_SMBUS_BYTE, NULL);
+	if (ret < 0)
+		goto out;
+
+	ret = __i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
+			       I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data);
+	if (ret < 0)
+		goto out;
+
+	*val = data.byte;
+out:
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
+
+	return ret;
+}
+
+/**
+ * regmap_sccb_write - Write data to SCCB slave device
+ * @context: Device that will be interacted wit
+ * @reg: Register to write to
+ * @val: Value to be written
+ *
+ * This executes the SCCB 3-phase write transmission cycle, returning negative
+ * errno else zero on success.
+ */
+static int regmap_sccb_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	return i2c_smbus_write_byte_data(i2c, reg, val);
+}
+
+static struct regmap_bus regmap_sccb_bus = {
+	.reg_write = regmap_sccb_write,
+	.reg_read = regmap_sccb_read,
+};
+
+static const struct regmap_bus *regmap_get_sccb_bus(struct i2c_client *i2c,
+					const struct regmap_config *config)
+{
+	if (config->val_bits == 8 && config->reg_bits == 8 &&
+			sccb_is_available(i2c->adapter))
+		return &regmap_sccb_bus;
+
+	return ERR_PTR(-ENOTSUPP);
+}
+
+struct regmap *__regmap_init_sccb(struct i2c_client *i2c,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_sccb_bus(i2c, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(&i2c->dev, bus, &i2c->dev, config,
+			     lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_sccb);
+
+struct regmap *__devm_regmap_init_sccb(struct i2c_client *i2c,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_sccb_bus(i2c, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(&i2c->dev, bus, &i2c->dev, config,
+				  lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_sccb);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..52bf358 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -514,6 +514,10 @@ struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__regmap_init_sccb(struct i2c_client *i2c,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name);
 struct regmap *__regmap_init_slimbus(struct slim_device *slimbus,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
@@ -558,6 +562,10 @@ struct regmap *__devm_regmap_init_i2c(struct i2c_client *i2c,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name);
+struct regmap *__devm_regmap_init_sccb(struct i2c_client *i2c,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name);
 struct regmap *__devm_regmap_init_spi(struct spi_device *dev,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
@@ -646,6 +654,19 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 				i2c, config)
 
 /**
+ * regmap_init_sccb() - Initialise register map
+ *
+ * @i2c: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_sccb(i2c, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_sccb, #config,		\
+				i2c, config)
+
+/**
  * regmap_init_slimbus() - Initialise register map
  *
  * @slimbus: Device that will be interacted with
@@ -798,6 +819,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 				i2c, config)
 
 /**
+ * devm_regmap_init_sccb() - Initialise managed register map
+ *
+ * @i2c: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_sccb(i2c, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_sccb, #config,	\
+				i2c, config)
+
+/**
  * devm_regmap_init_spi() - Initialise register map
  *
  * @dev: Device that will be interacted with
-- 
2.7.4

