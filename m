Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66939C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212152146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="URlN7obK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212152146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeK3XCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:02:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44164 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3XCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so4585179edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Cu0F8XcCviwOyppZmYtR99atTDBIspjwFBk1xADlAk=;
        b=URlN7obKYy3HnB1wqabdcVyIohNNVJPe5lQU5bVTgAXOf087+lv/Z9fUXoeo9JCSaN
         S70jYgr1GmFx97jM9QiC8Gxmo8KCCiAktAh58IaNa68t/btHNPEVMqPKxY0UR/0/b660
         editZsa0NpDOA2806PJYSlkLfc2c+iCfBGCwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Cu0F8XcCviwOyppZmYtR99atTDBIspjwFBk1xADlAk=;
        b=oag7rHiUP09hRhLpuE35qV18YiKXSMHnytnnYUXaEKOdNCbIfEAumceKVeYDCufOBi
         2gumrQjhr1G/KZo+xJi/2E0UwR7Rmb1X0po44agwuUBEAWpkqVC1qWtHRs/O4taNGaGN
         eFBFagOBw8OIwtSLB1H6m3xS2BwoOB4ApbtBsuPmKoPreWEtZrXWx2xRFv0hvgDiZx+0
         D/D7pDc0f0O4SseyMBvlXRvuVuSeATBMJYxwZnrtyXIsuA4IzcbmkNuOvh9yBjTTjNPT
         Q9yxkvivnFyWcs0A0Zw083z/s7FqZWSUY5bJmeC/L53MoZeY25jXeKNFWrjmFaO2FfKq
         1iaA==
X-Gm-Message-State: AA+aEWbD5GCNE8U/s0+awuseQ/hMhkrQb9l3E0zSvqN7sL/R15PIQ8Rs
        TZzj31wVu76oKnrSHT+UUmMy5U6KDDY=
X-Google-Smtp-Source: AFSGD/Vufhk57i65FoxfjMsifbIK3TDhj4jUk0fs7AYDeyu7TPi4nwAnyWiq9PUBbrt4unDKlZuqSQ==
X-Received: by 2002:a50:a844:: with SMTP id j62mr5255098edc.2.1543578817333;
        Fri, 30 Nov 2018 03:53:37 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t10-v6sm767932ejg.41.2018.11.30.03.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:53:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] nvmem: add type attribute
Date:   Fri, 30 Nov 2018 11:53:20 +0000
Message-Id: <20181130115325.16539-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
References: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Add a type attribute so userspace is able to know how the data is stored as
this can help taking the correct decision when selecting which device to
use. This will also help program display the proper warnings when burning
fuses for example.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 21 +++++++++++++++++++++
 include/linux/nvmem-provider.h | 16 ++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 27f67dfa649d..d9fd11033c1c 100644
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
@@ -83,6 +84,21 @@ static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
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
@@ -168,6 +184,7 @@ static struct bin_attribute *nvmem_bin_rw_attributes[] = {
 
 static const struct attribute_group nvmem_bin_rw_group = {
 	.bin_attrs	= nvmem_bin_rw_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_rw_dev_groups[] = {
@@ -191,6 +208,7 @@ static struct bin_attribute *nvmem_bin_ro_attributes[] = {
 
 static const struct attribute_group nvmem_bin_ro_group = {
 	.bin_attrs	= nvmem_bin_ro_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_ro_dev_groups[] = {
@@ -215,6 +233,7 @@ static struct bin_attribute *nvmem_bin_rw_root_attributes[] = {
 
 static const struct attribute_group nvmem_bin_rw_root_group = {
 	.bin_attrs	= nvmem_bin_rw_root_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
@@ -238,6 +257,7 @@ static struct bin_attribute *nvmem_bin_ro_root_attributes[] = {
 
 static const struct attribute_group nvmem_bin_ro_root_group = {
 	.bin_attrs	= nvmem_bin_ro_root_attributes,
+	.attrs		= nvmem_attrs,
 };
 
 static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
@@ -605,6 +625,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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
2.19.2

