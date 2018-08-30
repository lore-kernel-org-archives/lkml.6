Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75CBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9789320839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9789320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeHaBhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:37:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbeHaBhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:37:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ULTP5D108368
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:33:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6q8730ft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:33:05 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 17:33:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 17:32:59 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ULWw8n42270764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 21:32:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0515B124053;
        Thu, 30 Aug 2018 18:33:36 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21514124055;
        Thu, 30 Aug 2018 18:33:35 -0400 (EDT)
Received: from oc6728276242.ibm.com (unknown [9.85.221.248])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 18:33:35 -0400 (EDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux@roeck-us.net, joel@jms.id.au, benh@kernel.crashing.org,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v5 07/10] hwmon (occ): Parse OCC poll response
Date:   Thu, 30 Aug 2018 16:32:38 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18083021-0068-0000-0000-0000033270C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009641; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081201; UDB=6.00557772; IPR=6.00861186;
 MB=3.00023023; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 21:33:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083021-0069-0000-0000-00004591F9DC
Message-Id: <1535664761-86018-8-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add method to parse the response from the OCC poll command. This only
needs to be done during probe(), since the OCC shouldn't change the
number or format of sensors while it's running. The parsed response
allows quick access to sensor data, as well as information on the
number and version of sensors, which we need to instantiate hwmon
attributes.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/hwmon/occ/common.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/common.h | 55 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 81acd4b..a066509 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/device.h>
+#include <linux/kernel.h>
 
 #include "common.h"
 
@@ -22,6 +23,64 @@ static int occ_poll(struct occ *occ)
 	return occ->send_cmd(occ, cmd);
 }
 
+/* only need to do this once at startup, as OCC won't change sensors on us */
+static void occ_parse_poll_response(struct occ *occ)
+{
+	unsigned int i, old_offset, offset = 0, size = 0;
+	struct occ_sensor *sensor;
+	struct occ_sensors *sensors = &occ->sensors;
+	struct occ_response *resp = &occ->resp;
+	struct occ_poll_response *poll =
+		(struct occ_poll_response *)&resp->data[0];
+	struct occ_poll_response_header *header = &poll->header;
+	struct occ_sensor_data_block *block = &poll->block;
+
+	dev_info(occ->bus_dev, "OCC found, code level: %.16s\n",
+		 header->occ_code_level);
+
+	for (i = 0; i < header->num_sensor_data_blocks; ++i) {
+		block = (struct occ_sensor_data_block *)((u8 *)block + offset);
+		old_offset = offset;
+		offset = (block->header.num_sensors *
+			  block->header.sensor_length) + sizeof(block->header);
+		size += offset;
+
+		/* validate all the length/size fields */
+		if ((size + sizeof(*header)) >= OCC_RESP_DATA_BYTES) {
+			dev_warn(occ->bus_dev, "exceeded response buffer\n");
+			return;
+		}
+
+		dev_dbg(occ->bus_dev, " %04x..%04x: %.4s (%d sensors)\n",
+			old_offset, offset - 1, block->header.eye_catcher,
+			block->header.num_sensors);
+
+		/* match sensor block type */
+		if (strncmp(block->header.eye_catcher, "TEMP", 4) == 0)
+			sensor = &sensors->temp;
+		else if (strncmp(block->header.eye_catcher, "FREQ", 4) == 0)
+			sensor = &sensors->freq;
+		else if (strncmp(block->header.eye_catcher, "POWR", 4) == 0)
+			sensor = &sensors->power;
+		else if (strncmp(block->header.eye_catcher, "CAPS", 4) == 0)
+			sensor = &sensors->caps;
+		else if (strncmp(block->header.eye_catcher, "EXTN", 4) == 0)
+			sensor = &sensors->extended;
+		else {
+			dev_warn(occ->bus_dev, "sensor not supported %.4s\n",
+				 block->header.eye_catcher);
+			continue;
+		}
+
+		sensor->num_sensors = block->header.num_sensors;
+		sensor->version = block->header.sensor_format;
+		sensor->data = &block->data;
+	}
+
+	dev_dbg(occ->bus_dev, "Max resp size: %u+%zd=%zd\n", size,
+		sizeof(*header), size + sizeof(*header));
+}
+
 int occ_setup(struct occ *occ, const char *name)
 {
 	int rc;
@@ -36,5 +95,7 @@ int occ_setup(struct occ *occ, const char *name)
 		return rc;
 	}
 
+	occ_parse_poll_response(occ);
+
 	return 0;
 }
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index b44fee2..0a7a107 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -20,10 +20,65 @@ struct occ_response {
 	__be16 checksum;
 } __packed;
 
+struct occ_sensor_data_block_header {
+	u8 eye_catcher[4];
+	u8 reserved;
+	u8 sensor_format;
+	u8 sensor_length;
+	u8 num_sensors;
+} __packed;
+
+struct occ_sensor_data_block {
+	struct occ_sensor_data_block_header header;
+	u32 data;
+} __packed;
+
+struct occ_poll_response_header {
+	u8 status;
+	u8 ext_status;
+	u8 occs_present;
+	u8 config_data;
+	u8 occ_state;
+	u8 mode;
+	u8 ips_status;
+	u8 error_log_id;
+	__be32 error_log_start_address;
+	__be16 error_log_length;
+	u16 reserved;
+	u8 occ_code_level[16];
+	u8 eye_catcher[6];
+	u8 num_sensor_data_blocks;
+	u8 sensor_data_block_header_version;
+} __packed;
+
+struct occ_poll_response {
+	struct occ_poll_response_header header;
+	struct occ_sensor_data_block block;
+} __packed;
+
+struct occ_sensor {
+	u8 num_sensors;
+	u8 version;
+	void *data;	/* pointer to sensor data start within response */
+};
+
+/*
+ * OCC only provides one sensor data block of each type, but any number of
+ * sensors within that block.
+ */
+struct occ_sensors {
+	struct occ_sensor temp;
+	struct occ_sensor freq;
+	struct occ_sensor power;
+	struct occ_sensor caps;
+	struct occ_sensor extended;
+};
+
 struct occ {
 	struct device *bus_dev;
 
 	struct occ_response resp;
+	struct occ_sensors sensors;
 
 	u8 poll_cmd_data;		/* to perform OCC poll command */
 	int (*send_cmd)(struct occ *occ, u8 *cmd);
-- 
1.8.3.1

