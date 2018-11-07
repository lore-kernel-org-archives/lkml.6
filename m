Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA79DC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F9520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F9520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeKGUVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:21:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53233 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeKGUVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:21:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 67760224CB; Wed,  7 Nov 2018 11:51:46 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 33B0620701;
        Wed,  7 Nov 2018 11:51:36 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] nvmem: add type attribute
Date:   Wed,  7 Nov 2018 11:51:33 +0100
Message-Id: <20181107105133.3789-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a type attribute so userspace is able to know how the data is stored as
this can help taking the correct decision when selecting which device to
use. This will also help program display the proper warnings when burning
fuses for example.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/nvmem/core.c           | 20 ++++++++++++++++++++
 include/linux/nvmem-provider.h | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9b18ce90f907..9c1682feee38 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -28,6 +28,7 @@ struct nvmem_device {
 	size_t			size;
 	bool			read_only;
 	int			flags;
+	enum nvmem_type		type;
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
 	struct list_head	cells;
@@ -82,6 +83,21 @@ static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
 	return -EINVAL;
 }
 
+static ssize_t type_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
+}
+
+static DEVICE_ATTR_RO(type);
+
+static struct attribute *nvmem_attrs[] = {
+	&dev_attr_type.attr,
+	NULL,
+};
+
 static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 				    struct bin_attribute *attr,
 				    char *buf, loff_t pos, size_t count)
@@ -167,6 +183,7 @@ static struct bin_attribute *nvmem_bin_rw_attributes[] = {
 
 static const struct attribute_group nvmem_bin_rw_group = {
 	.bin_attrs	= nvmem_bin_rw_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_rw_dev_groups[] = {
@@ -190,6 +207,7 @@ static struct bin_attribute *nvmem_bin_ro_attributes[] = {
 
 static const struct attribute_group nvmem_bin_ro_group = {
 	.bin_attrs	= nvmem_bin_ro_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_ro_dev_groups[] = {
@@ -214,6 +232,7 @@ static struct bin_attribute *nvmem_bin_rw_root_attributes[] = {
 
 static const struct attribute_group nvmem_bin_rw_root_group = {
 	.bin_attrs	= nvmem_bin_rw_root_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
@@ -237,6 +256,7 @@ static struct bin_attribute *nvmem_bin_ro_root_attributes[] = {
 
 static const struct attribute_group nvmem_bin_ro_root_group = {
 	.bin_attrs	= nvmem_bin_ro_root_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
@@ -602,6 +622,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->dev.bus = &nvmem_bus_type;
 	nvmem->dev.parent = config->dev;
 	nvmem->priv = config->priv;
+	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
 	nvmem->dev.of_node = config->dev->of_node;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 1e3283c2af77..00ff92571683 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -19,6 +19,20 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 
+enum nvmem_type {
+	NVMEM_TYPE_UNKNOWN = 0,
+	NVMEM_TYPE_EEPROM,
+	NVMEM_TYPE_OTP,
+	NVMEM_TYPE_BATTERY_BACKED,
+};
+
+static const char * const nvmem_type_str[] = {
+	[NVMEM_TYPE_UNKNOWN] = "Unknown",
+	[NVMEM_TYPE_EEPROM] = "EEPROM",
+	[NVMEM_TYPE_OTP] = "OTP",
+	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
+};
+
 /**
  * struct nvmem_config - NVMEM device configuration
  *
@@ -28,6 +42,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
  * @owner:	Pointer to exporter module. Used for refcounting.
  * @cells:	Optional array of pre-defined NVMEM cells.
  * @ncells:	Number of elements in cells.
+ * @type:	Type of the nvmem storage
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
  * @reg_read:	Callback to read data.
@@ -51,6 +66,7 @@ struct nvmem_config {
 	struct module		*owner;
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
+	enum nvmem_type		type;
 	bool			read_only;
 	bool			root_only;
 	nvmem_reg_read_t	reg_read;
-- 
2.19.1

