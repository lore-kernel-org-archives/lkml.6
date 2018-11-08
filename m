Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE71ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779A120844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779A120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeKIGnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:43:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbeKIGnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:43:03 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8L0BN8063481
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 16:05:47 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmudkkf7v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 16:05:47 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Thu, 8 Nov 2018 21:05:44 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 21:05:39 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8L5cJd26935454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 21:05:38 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBAC728064;
        Thu,  8 Nov 2018 21:05:38 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A5428058;
        Thu,  8 Nov 2018 21:05:37 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 21:05:37 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@roeck-us.net, rdunlap@infradead.org,
        benh@kernel.crashing.org, Eddie James <eajames@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v6 06/10] hwmon (occ): Add command transport method for P8 and P9
Date:   Thu,  8 Nov 2018 15:05:25 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
References: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18110821-0040-0000-0000-0000048F46EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010009; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114610; UDB=6.00577119; IPR=6.00894708;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 21:05:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110821-0041-0000-0000-000008984D54
Message-Id: <1541711129-26631-7-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.vnet.ibm.com>

For the P8 OCC, add the procedure to send a command to the OCC over I2C
bus. This involves writing the OCC command registers with serial
communication operations (SCOMs) interpreted by the I2C slave. For the
P9 OCC, add a procedure to use the OCC in-kernel API to send a command
to the OCC through the SBE.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/p8_i2c.c | 185 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/hwmon/occ/p9_sbe.c |  38 +++++++++-
 2 files changed, 221 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
index 4f3937d..e3326ff 100644
--- a/drivers/hwmon/occ/p8_i2c.c
+++ b/drivers/hwmon/occ/p8_i2c.c
@@ -2,11 +2,29 @@
 
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/fsi-occ.h>
 #include <linux/i2c.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/sched.h>
+#include <asm/unaligned.h>
 
 #include "common.h"
 
+#define OCC_TIMEOUT_MS			1000
+#define OCC_CMD_IN_PRG_WAIT_MS		50
+
+/* OCB (on-chip control bridge - interface to OCC) registers */
+#define OCB_DATA1			0x6B035
+#define OCB_ADDR			0x6B070
+#define OCB_DATA3			0x6B075
+
+/* OCC SRAM address space */
+#define OCC_SRAM_ADDR_CMD		0xFFFF6000
+#define OCC_SRAM_ADDR_RESP		0xFFFF7000
+
+#define OCC_DATA_ATTN			0x20010000
+
 struct p8_i2c_occ {
 	struct occ occ;
 	struct i2c_client *client;
@@ -14,9 +32,174 @@ struct p8_i2c_occ {
 
 #define to_p8_i2c_occ(x)	container_of((x), struct p8_i2c_occ, occ)
 
+static int p8_i2c_occ_getscom(struct i2c_client *client, u32 address, u8 *data)
+{
+	ssize_t rc;
+	__be64 buf;
+	struct i2c_msg msgs[2];
+
+	/* p8 i2c slave requires shift */
+	address <<= 1;
+
+	msgs[0].addr = client->addr;
+	msgs[0].flags = client->flags & I2C_M_TEN;
+	msgs[0].len = sizeof(u32);
+	/* address is a scom address; bus-endian */
+	msgs[0].buf = (char *)&address;
+
+	/* data from OCC is big-endian */
+	msgs[1].addr = client->addr;
+	msgs[1].flags = (client->flags & I2C_M_TEN) | I2C_M_RD;
+	msgs[1].len = sizeof(u64);
+	msgs[1].buf = (char *)&buf;
+
+	rc = i2c_transfer(client->adapter, msgs, 2);
+	if (rc < 0)
+		return rc;
+
+	*(u64 *)data = be64_to_cpu(buf);
+
+	return 0;
+}
+
+static int p8_i2c_occ_putscom(struct i2c_client *client, u32 address, u8 *data)
+{
+	u32 buf[3];
+	ssize_t rc;
+
+	/* p8 i2c slave requires shift */
+	address <<= 1;
+
+	/* address is bus-endian; data passed through from user as-is */
+	buf[0] = address;
+	memcpy(&buf[1], &data[4], sizeof(u32));
+	memcpy(&buf[2], data, sizeof(u32));
+
+	rc = i2c_master_send(client, (const char *)buf, sizeof(buf));
+	if (rc < 0)
+		return rc;
+	else if (rc != sizeof(buf))
+		return -EIO;
+
+	return 0;
+}
+
+static int p8_i2c_occ_putscom_u32(struct i2c_client *client, u32 address,
+				  u32 data0, u32 data1)
+{
+	u8 buf[8];
+
+	memcpy(buf, &data0, 4);
+	memcpy(buf + 4, &data1, 4);
+
+	return p8_i2c_occ_putscom(client, address, buf);
+}
+
+static int p8_i2c_occ_putscom_be(struct i2c_client *client, u32 address,
+				 u8 *data)
+{
+	__be32 data0, data1;
+
+	memcpy(&data0, data, 4);
+	memcpy(&data1, data + 4, 4);
+
+	return p8_i2c_occ_putscom_u32(client, address, be32_to_cpu(data0),
+				      be32_to_cpu(data1));
+}
+
 static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd)
 {
-	return -EOPNOTSUPP;
+	int i, rc;
+	unsigned long start;
+	u16 data_length;
+	const unsigned long timeout = msecs_to_jiffies(OCC_TIMEOUT_MS);
+	const long wait_time = msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
+	struct p8_i2c_occ *ctx = to_p8_i2c_occ(occ);
+	struct i2c_client *client = ctx->client;
+	struct occ_response *resp = &occ->resp;
+
+	start = jiffies;
+
+	/* set sram address for command */
+	rc = p8_i2c_occ_putscom_u32(client, OCB_ADDR, OCC_SRAM_ADDR_CMD, 0);
+	if (rc)
+		return rc;
+
+	/* write command (expected to already be BE), we need bus-endian... */
+	rc = p8_i2c_occ_putscom_be(client, OCB_DATA3, cmd);
+	if (rc)
+		return rc;
+
+	/* trigger OCC attention */
+	rc = p8_i2c_occ_putscom_u32(client, OCB_DATA1, OCC_DATA_ATTN, 0);
+	if (rc)
+		return rc;
+
+	do {
+		/* set sram address for response */
+		rc = p8_i2c_occ_putscom_u32(client, OCB_ADDR,
+					    OCC_SRAM_ADDR_RESP, 0);
+		if (rc)
+			return rc;
+
+		rc = p8_i2c_occ_getscom(client, OCB_DATA3, (u8 *)resp);
+		if (rc)
+			return rc;
+
+		/* wait for OCC */
+		if (resp->return_status == OCC_RESP_CMD_IN_PRG) {
+			rc = -EALREADY;
+
+			if (time_after(jiffies, start + timeout))
+				break;
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(wait_time);
+		}
+	} while (rc);
+
+	/* check the OCC response */
+	switch (resp->return_status) {
+	case OCC_RESP_CMD_IN_PRG:
+		rc = -ETIMEDOUT;
+		break;
+	case OCC_RESP_SUCCESS:
+		rc = 0;
+		break;
+	case OCC_RESP_CMD_INVAL:
+	case OCC_RESP_CMD_LEN_INVAL:
+	case OCC_RESP_DATA_INVAL:
+	case OCC_RESP_CHKSUM_ERR:
+		rc = -EINVAL;
+		break;
+	case OCC_RESP_INT_ERR:
+	case OCC_RESP_BAD_STATE:
+	case OCC_RESP_CRIT_EXCEPT:
+	case OCC_RESP_CRIT_INIT:
+	case OCC_RESP_CRIT_WATCHDOG:
+	case OCC_RESP_CRIT_OCB:
+	case OCC_RESP_CRIT_HW:
+		rc = -EREMOTEIO;
+		break;
+	default:
+		rc = -EPROTO;
+	}
+
+	if (rc < 0)
+		return rc;
+
+	data_length = get_unaligned_be16(&resp->data_length);
+	if (data_length > OCC_RESP_DATA_BYTES)
+		return -EMSGSIZE;
+
+	/* fetch the rest of the response data */
+	for (i = 8; i < data_length + 7; i += 8) {
+		rc = p8_i2c_occ_getscom(client, OCB_DATA3, ((u8 *)resp) + i);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
 }
 
 static int p8_i2c_occ_probe(struct i2c_client *client,
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index c2fa34e..0ed5e22 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -2,6 +2,7 @@
 
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/fsi-occ.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -16,7 +17,42 @@ struct p9_sbe_occ {
 
 static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd)
 {
-	return -EOPNOTSUPP;
+	struct occ_response *resp = &occ->resp;
+	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
+	size_t resp_len = sizeof(*resp);
+	int rc;
+
+	rc = fsi_occ_submit(ctx->sbe, cmd, 8, resp, &resp_len);
+	if (rc < 0)
+		return rc;
+
+	switch (resp->return_status) {
+	case OCC_RESP_CMD_IN_PRG:
+		rc = -ETIMEDOUT;
+		break;
+	case OCC_RESP_SUCCESS:
+		rc = 0;
+		break;
+	case OCC_RESP_CMD_INVAL:
+	case OCC_RESP_CMD_LEN_INVAL:
+	case OCC_RESP_DATA_INVAL:
+	case OCC_RESP_CHKSUM_ERR:
+		rc = -EINVAL;
+		break;
+	case OCC_RESP_INT_ERR:
+	case OCC_RESP_BAD_STATE:
+	case OCC_RESP_CRIT_EXCEPT:
+	case OCC_RESP_CRIT_INIT:
+	case OCC_RESP_CRIT_WATCHDOG:
+	case OCC_RESP_CRIT_OCB:
+	case OCC_RESP_CRIT_HW:
+		rc = -EREMOTEIO;
+		break;
+	default:
+		rc = -EPROTO;
+	}
+
+	return rc;
 }
 
 static int p9_sbe_occ_probe(struct platform_device *pdev)
-- 
1.8.3.1

