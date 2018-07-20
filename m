Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE2520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE2520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeGTWmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:14 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48149 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbeGTWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:13 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJhfIgOqWLW2gdJif5XFM; Fri, 20 Jul 2018 22:52:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=tz4d504UodbfInwy5ZAA:9
 a=ZmZ497wAoQ5oK-9T:21 a=CvC5TZjrB9Qcm86M:21 a=_UVLBGXn8Au_dgoMdIS7:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:52:01 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 05/10] Input: atmel_mxt_ts - config CRC may start at T71
Date:   Fri, 20 Jul 2018 22:51:17 +0100
Message-Id: <20180720215122.23558-5-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfMPFG2hN5HnL3YHXI3RKXt+ree8zM2Ve17qMtiMkbZrgqxXOaMBA0kFSxDjXqr1MBudpzHn/9VbRtF5qE7EaW9/iPh/+F8BsDQT+tRTmZYuMNaXaJQW+
 dkeUe3jpIMB59TqLNBDhmKz+a2rOQNm1Vlr/g53EPS9G2Kv4RteJKhz0LfEmcVMgMHn3MN5LwLuwzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

On devices with the T71 object, the config CRC will start there, rather
than at T7.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 34 +++++++++++++++---------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 92661aa910ae..560d4997ef8c 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -75,6 +75,7 @@
 #define MXT_SPT_DIGITIZER_T43		43
 #define MXT_SPT_MESSAGECOUNT_T44	44
 #define MXT_SPT_CTECONFIG_T46		46
+#define MXT_SPT_DYNAMICCONFIGURATIONCONTAINER_T71 71
 #define MXT_TOUCH_MULTITOUCHSCREEN_T100 100
 
 /* MXT_GEN_MESSAGE_T5 object */
@@ -317,6 +318,7 @@ struct mxt_data {
 	u8 T6_reportid;
 	u16 T6_address;
 	u16 T7_address;
+	u16 T71_address;
 	u8 T9_reportid_min;
 	u8 T9_reportid_max;
 	u8 T19_reportid;
@@ -382,6 +384,7 @@ static bool mxt_object_readable(unsigned int type)
 	case MXT_SPT_USERDATA_T38:
 	case MXT_SPT_DIGITIZER_T43:
 	case MXT_SPT_CTECONFIG_T46:
+	case MXT_SPT_DYNAMICCONFIGURATIONCONTAINER_T71:
 		return true;
 	default:
 		return false;
@@ -1443,6 +1446,7 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 	u32 info_crc, config_crc, calculated_crc;
 	u8 *config_mem;
 	size_t config_mem_size;
+	u16 crc_start = 0;
 
 	mxt_update_crc(data, MXT_COMMAND_REPORTALL, 1);
 
@@ -1529,20 +1533,22 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 		goto release_mem;
 
 	/* Calculate crc of the received configs (not the raw config file) */
-	if (data->T7_address < cfg_start_ofs) {
-		dev_err(dev, "Bad T7 address, T7addr = %x, config offset %x\n",
-			data->T7_address, cfg_start_ofs);
-		ret = 0;
-		goto release_mem;
-	}
+	if (data->T71_address)
+		crc_start = data->T71_address;
+	else if (data->T7_address)
+		crc_start = data->T7_address;
+	else
+		dev_warn(dev, "Could not find CRC start\n");
 
-	calculated_crc = mxt_calculate_crc(config_mem,
-					   data->T7_address - cfg_start_ofs,
-					   config_mem_size);
+	if (crc_start > cfg_start_ofs) {
+		calculated_crc = mxt_calculate_crc(config_mem,
+						   crc_start - cfg_start_ofs,
+						   config_mem_size);
 
-	if (config_crc > 0 && config_crc != calculated_crc)
-		dev_warn(dev, "Config CRC error, calculated=%06X, file=%06X\n",
-			 calculated_crc, config_crc);
+		if (config_crc > 0 && config_crc != calculated_crc)
+			dev_warn(dev, "Config CRC in file inconsistent, calculated=%06X, file=%06X\n",
+				 calculated_crc, config_crc);
+	}
 
 	ret = mxt_upload_cfg_mem(data, cfg_start_ofs,
 				 config_mem, config_mem_size);
@@ -1589,6 +1595,7 @@ static void mxt_free_object_table(struct mxt_data *data)
 	data->T5_msg_size = 0;
 	data->T6_reportid = 0;
 	data->T7_address = 0;
+	data->T71_address = 0;
 	data->T9_reportid_min = 0;
 	data->T9_reportid_max = 0;
 	data->T19_reportid = 0;
@@ -1654,6 +1661,9 @@ static int mxt_parse_object_table(struct mxt_data *data,
 		case MXT_GEN_POWER_T7:
 			data->T7_address = object->start_address;
 			break;
+		case MXT_SPT_DYNAMICCONFIGURATIONCONTAINER_T71:
+			data->T71_address = object->start_address;
+			break;
 		case MXT_TOUCH_MULTI_T9:
 			data->multitouch = MXT_TOUCH_MULTI_T9;
 			/* Only handle messages from first T9 instance */
-- 
2.17.1

