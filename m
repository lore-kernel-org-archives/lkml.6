Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBB7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A4E20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A4E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeGTWmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:18 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48149 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbeGTWmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:18 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJmfIgPAWLW2gdJnf5XFd; Fri, 20 Jul 2018 22:52:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=A3-LDzXwAAAA:8 a=A3I9UrruRtFbHBQDeOQA:9
 a=PQrrThv6e6vlBFiu:21 a=xnGkizWhtxF9dybg:21 a=_UVLBGXn8Au_dgoMdIS7:22
 a=LycaIqhzDZpX3FTtPRdu:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:52:06 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 07/10] Input: atmel_mxt_ts - zero terminate config firmware file
Date:   Fri, 20 Jul 2018 22:51:19 +0100
Message-Id: <20180720215122.23558-7-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfGwVfyunw3eJB8zxOhF6es32ReCQKflAnn33YJopQksZGxOQEAr8jbi0Wd+5Y1DTy7c5ic2KE2QeIA6yOds6nCDzwgbMQ4qAUN9ypW9RMwS0YKVNKivg
 +iQB6hCenagPYpitTx5+SAbY69ZZKGA6nW8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

We use sscanf to parse the configuration file, so it's necessary to zero
terminate the configuration otherwise a truncated file can cause the
parser to run off into uninitialised memory.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 36 +++++++++++++++++-------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0ce126e918f1..2d1fddafb7f9 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -279,7 +279,7 @@ enum mxt_suspend_mode {
 
 /* Config update context */
 struct mxt_cfg {
-	const u8 *raw;
+	u8 *raw;
 	size_t raw_size;
 	off_t raw_pos;
 
@@ -1451,14 +1451,21 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 	u32 info_crc, config_crc, calculated_crc;
 	u16 crc_start = 0;
 
-	cfg.raw = fw->data;
+	/* Make zero terminated copy of the OBP_RAW file */
+	cfg.raw = kzalloc(fw->size + 1, GFP_KERNEL);
+	if (!cfg.raw)
+		return -ENOMEM;
+
+	memcpy(cfg.raw, fw->data, fw->size);
+	cfg.raw[fw->size] = '\0';
 	cfg.raw_size = fw->size;
 
 	mxt_update_crc(data, MXT_COMMAND_REPORTALL, 1);
 
 	if (strncmp(cfg.raw, MXT_CFG_MAGIC, strlen(MXT_CFG_MAGIC))) {
 		dev_err(dev, "Unrecognised config file\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 
 	cfg.raw_pos = strlen(MXT_CFG_MAGIC);
@@ -1470,7 +1477,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 			     &offset);
 		if (ret != 1) {
 			dev_err(dev, "Bad format\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto release_raw;
 		}
 
 		cfg.raw_pos += offset;
@@ -1478,26 +1486,30 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 
 	if (cfg.info.family_id != data->info->family_id) {
 		dev_err(dev, "Family ID mismatch!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 
 	if (cfg.info.variant_id != data->info->variant_id) {
 		dev_err(dev, "Variant ID mismatch!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 
 	/* Read CRCs */
 	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &info_crc, &offset);
 	if (ret != 1) {
 		dev_err(dev, "Bad format: failed to parse Info CRC\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 	cfg.raw_pos += offset;
 
 	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &config_crc, &offset);
 	if (ret != 1) {
 		dev_err(dev, "Bad format: failed to parse Config CRC\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_raw;
 	}
 	cfg.raw_pos += offset;
 
@@ -1530,8 +1542,10 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 			MXT_INFO_CHECKSUM_SIZE;
 	cfg.mem_size = data->mem_size - cfg.start_ofs;
 	cfg.mem = kzalloc(cfg.mem_size, GFP_KERNEL);
-	if (!cfg.mem)
-		return -ENOMEM;
+	if (!cfg.mem) {
+		ret = -ENOMEM;
+		goto release_raw;
+	}
 
 	ret = mxt_prepare_cfg_mem(data, &cfg);
 	if (ret)
@@ -1570,6 +1584,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 	/* T7 config may have changed */
 	mxt_init_t7_power_cfg(data);
 
+release_raw:
+	kfree(cfg.raw);
 release_mem:
 	kfree(cfg.mem);
 	return ret;
-- 
2.17.1

