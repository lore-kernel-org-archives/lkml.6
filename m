Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFFAECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC7520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC7520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeGTWmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:16 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48150 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbeGTWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:15 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJkfIgP1WLW2gdJlf5XFU; Fri, 20 Jul 2018 22:52:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=A3-LDzXwAAAA:8 a=pmVvdF8ALP9yjLerFucA:9
 a=sCu6lF1gEILHf6LK:21 a=51nAGivuf5nX_8qp:21 a=_UVLBGXn8Au_dgoMdIS7:22
 a=LycaIqhzDZpX3FTtPRdu:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:52:04 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 06/10] Input: atmel_mxt_ts - refactor config update code to add context struct
Date:   Fri, 20 Jul 2018 22:51:18 +0100
Message-Id: <20180720215122.23558-6-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfKWC0aFVaa31kpHxxqZgGuhILiFH0WknRoNMuhtrA6RU3gkv4TAoy0X//W0v04hUlvMNFezzguwWQrXI60g3nuc/BAZOydjOUHnZ8aAD9CzHIg7VHCyJ
 54tmc55ucEh2ZBClEX9dyfSSg5kJldz60MaCaospZgabE38FDxcmJQ72
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 108 ++++++++++++-----------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 560d4997ef8c..0ce126e918f1 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -277,6 +277,19 @@ enum mxt_suspend_mode {
 	MXT_SUSPEND_T9_CTRL	= 1,
 };
 
+/* Config update context */
+struct mxt_cfg {
+	const u8 *raw;
+	size_t raw_size;
+	off_t raw_pos;
+
+	u8 *mem;
+	size_t mem_size;
+	int start_ofs;
+
+	struct mxt_info info;
+};
+
 /* Each client has this additional data */
 struct mxt_data {
 	struct i2c_client *client;
@@ -1282,12 +1295,7 @@ static u32 mxt_calculate_crc(u8 *base, off_t start_off, off_t end_off)
 	return crc;
 }
 
-static int mxt_prepare_cfg_mem(struct mxt_data *data,
-			       const struct firmware *cfg,
-			       unsigned int data_pos,
-			       unsigned int cfg_start_ofs,
-			       u8 *config_mem,
-			       size_t config_mem_size)
+static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 {
 	struct device *dev = &data->client->dev;
 	struct mxt_object *object;
@@ -1298,9 +1306,9 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 	u16 reg;
 	u8 val;
 
-	while (data_pos < cfg->size) {
+	while (cfg->raw_pos < cfg->raw_size) {
 		/* Read type, instance, length */
-		ret = sscanf(cfg->data + data_pos, "%x %x %x%n",
+		ret = sscanf(cfg->raw + cfg->raw_pos, "%x %x %x%n",
 			     &type, &instance, &size, &offset);
 		if (ret == 0) {
 			/* EOF */
@@ -1309,20 +1317,20 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 			dev_err(dev, "Bad format: failed to parse object\n");
 			return -EINVAL;
 		}
-		data_pos += offset;
+		cfg->raw_pos += offset;
 
 		object = mxt_get_object(data, type);
 		if (!object) {
 			/* Skip object */
 			for (i = 0; i < size; i++) {
-				ret = sscanf(cfg->data + data_pos, "%hhx%n",
+				ret = sscanf(cfg->raw + cfg->raw_pos, "%hhx%n",
 					     &val, &offset);
 				if (ret != 1) {
 					dev_err(dev, "Bad format in T%d at %d\n",
 						type, i);
 					return -EINVAL;
 				}
-				data_pos += offset;
+				cfg->raw_pos += offset;
 			}
 			continue;
 		}
@@ -1357,7 +1365,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 		reg = object->start_address + mxt_obj_size(object) * instance;
 
 		for (i = 0; i < size; i++) {
-			ret = sscanf(cfg->data + data_pos, "%hhx%n",
+			ret = sscanf(cfg->raw + cfg->raw_pos, "%hhx%n",
 				     &val,
 				     &offset);
 			if (ret != 1) {
@@ -1365,15 +1373,15 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 					type, i);
 				return -EINVAL;
 			}
-			data_pos += offset;
+			cfg->raw_pos += offset;
 
 			if (i > mxt_obj_size(object))
 				continue;
 
-			byte_offset = reg + i - cfg_start_ofs;
+			byte_offset = reg + i - cfg->start_ofs;
 
-			if (byte_offset >= 0 && byte_offset < config_mem_size) {
-				*(config_mem + byte_offset) = val;
+			if (byte_offset >= 0 && byte_offset < cfg->mem_size) {
+				*(cfg->mem + byte_offset) = val;
 			} else {
 				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
 					reg, object->type, byte_offset);
@@ -1385,22 +1393,21 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 	return 0;
 }
 
-static int mxt_upload_cfg_mem(struct mxt_data *data, unsigned int cfg_start,
-			      u8 *config_mem, size_t config_mem_size)
+static int mxt_upload_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 {
 	unsigned int byte_offset = 0;
 	int error;
 
 	/* Write configuration as blocks */
-	while (byte_offset < config_mem_size) {
-		unsigned int size = config_mem_size - byte_offset;
+	while (byte_offset < cfg->mem_size) {
+		unsigned int size = cfg->mem_size - byte_offset;
 
 		if (size > MXT_MAX_BLOCK_WRITE)
 			size = MXT_MAX_BLOCK_WRITE;
 
 		error = __mxt_write_reg(data->client,
-					cfg_start + byte_offset,
-					size, config_mem + byte_offset);
+					cfg->start_ofs + byte_offset,
+					size, cfg->mem + byte_offset);
 		if (error) {
 			dev_err(&data->client->dev,
 				"Config write error, ret=%d\n", error);
@@ -1434,66 +1441,65 @@ static int mxt_init_t7_power_cfg(struct mxt_data *data);
  *   <SIZE> - 2-byte object size as hex
  *   <CONTENTS> - array of <SIZE> 1-byte hex values
  */
-static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
+static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 {
 	struct device *dev = &data->client->dev;
-	struct mxt_info cfg_info;
+	struct mxt_cfg cfg;
 	int ret;
 	int offset;
-	int data_pos;
 	int i;
-	int cfg_start_ofs;
 	u32 info_crc, config_crc, calculated_crc;
-	u8 *config_mem;
-	size_t config_mem_size;
 	u16 crc_start = 0;
 
+	cfg.raw = fw->data;
+	cfg.raw_size = fw->size;
+
 	mxt_update_crc(data, MXT_COMMAND_REPORTALL, 1);
 
-	if (strncmp(cfg->data, MXT_CFG_MAGIC, strlen(MXT_CFG_MAGIC))) {
+	if (strncmp(cfg.raw, MXT_CFG_MAGIC, strlen(MXT_CFG_MAGIC))) {
 		dev_err(dev, "Unrecognised config file\n");
 		return -EINVAL;
 	}
 
-	data_pos = strlen(MXT_CFG_MAGIC);
+	cfg.raw_pos = strlen(MXT_CFG_MAGIC);
 
 	/* Load information block and check */
 	for (i = 0; i < sizeof(struct mxt_info); i++) {
-		ret = sscanf(cfg->data + data_pos, "%hhx%n",
-			     (unsigned char *)&cfg_info + i,
+		ret = sscanf(cfg.raw + cfg.raw_pos, "%hhx%n",
+			     (unsigned char *)&cfg.info + i,
 			     &offset);
 		if (ret != 1) {
 			dev_err(dev, "Bad format\n");
 			return -EINVAL;
 		}
 
-		data_pos += offset;
+		cfg.raw_pos += offset;
 	}
 
-	if (cfg_info.family_id != data->info->family_id) {
+	if (cfg.info.family_id != data->info->family_id) {
 		dev_err(dev, "Family ID mismatch!\n");
 		return -EINVAL;
 	}
 
-	if (cfg_info.variant_id != data->info->variant_id) {
+	if (cfg.info.variant_id != data->info->variant_id) {
 		dev_err(dev, "Variant ID mismatch!\n");
 		return -EINVAL;
 	}
 
 	/* Read CRCs */
-	ret = sscanf(cfg->data + data_pos, "%x%n", &info_crc, &offset);
+	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &info_crc, &offset);
 	if (ret != 1) {
 		dev_err(dev, "Bad format: failed to parse Info CRC\n");
 		return -EINVAL;
 	}
-	data_pos += offset;
+	cfg.raw_pos += offset;
 
-	ret = sscanf(cfg->data + data_pos, "%x%n", &config_crc, &offset);
+	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &config_crc, &offset);
 	if (ret != 1) {
 		dev_err(dev, "Bad format: failed to parse Config CRC\n");
 		return -EINVAL;
 	}
-	data_pos += offset;
+	cfg.raw_pos += offset;
 
 	/*
 	 * The Info Block CRC is calculated over mxt_info and the object
@@ -1519,16 +1525,15 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 	}
 
 	/* Malloc memory to store configuration */
-	cfg_start_ofs = MXT_OBJECT_START +
+	cfg.start_ofs = MXT_OBJECT_START +
 			data->info->object_num * sizeof(struct mxt_object) +
 			MXT_INFO_CHECKSUM_SIZE;
-	config_mem_size = data->mem_size - cfg_start_ofs;
-	config_mem = kzalloc(config_mem_size, GFP_KERNEL);
-	if (!config_mem)
+	cfg.mem_size = data->mem_size - cfg.start_ofs;
+	cfg.mem = kzalloc(cfg.mem_size, GFP_KERNEL);
+	if (!cfg.mem)
 		return -ENOMEM;
 
-	ret = mxt_prepare_cfg_mem(data, cfg, data_pos, cfg_start_ofs,
-				  config_mem, config_mem_size);
+	ret = mxt_prepare_cfg_mem(data, &cfg);
 	if (ret)
 		goto release_mem;
 
@@ -1540,18 +1545,17 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 	else
 		dev_warn(dev, "Could not find CRC start\n");
 
-	if (crc_start > cfg_start_ofs) {
-		calculated_crc = mxt_calculate_crc(config_mem,
-						   crc_start - cfg_start_ofs,
-						   config_mem_size);
+	if (crc_start > cfg.start_ofs) {
+		calculated_crc = mxt_calculate_crc(cfg.mem,
+						   crc_start - cfg.start_ofs,
+						   cfg.mem_size);
 
 		if (config_crc > 0 && config_crc != calculated_crc)
 			dev_warn(dev, "Config CRC in file inconsistent, calculated=%06X, file=%06X\n",
 				 calculated_crc, config_crc);
 	}
 
-	ret = mxt_upload_cfg_mem(data, cfg_start_ofs,
-				 config_mem, config_mem_size);
+	ret = mxt_upload_cfg_mem(data, &cfg);
 	if (ret)
 		goto release_mem;
 
@@ -1567,7 +1571,7 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 	mxt_init_t7_power_cfg(data);
 
 release_mem:
-	kfree(config_mem);
+	kfree(cfg.mem);
 	return ret;
 }
 
-- 
2.17.1

