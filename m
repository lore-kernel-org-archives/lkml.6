Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53277C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046C32403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046C32403A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeGESk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:40:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754221AbeGESky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:40:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65IYPw6027134
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 14:40:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k1pxn4fvy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:40:53 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:40:53 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:40:49 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65Iem5I22348250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 11:40:48 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A6DC136051;
        Thu,  5 Jul 2018 12:40:48 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8278613604F;
        Thu,  5 Jul 2018 12:40:47 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 12:40:47 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v11 7/8] i2c: fsi: Add bus recovery
Date:   Thu,  5 Jul 2018 13:40:29 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070518-0016-0000-0000-000009045D98
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009314; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057019; UDB=6.00542279; IPR=6.00834939;
 MB=3.00022012; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 18:40:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070518-0017-0000-0000-00003F86DF3D
Message-Id: <1530816030-13010-8-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus recovery should reset the bus with the standard i2c recovery
procedure. Populate the necessary fields so that the standard procedure
can perform the reset.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 132 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 5520251..42c387d 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -326,6 +326,115 @@ static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
 	return 0;
 }
 
+static int fsi_i2c_get_scl(struct i2c_adapter *adap)
+{
+	u32 stat = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+
+	return !!(stat & I2C_STAT_SCL_IN);
+}
+
+static void fsi_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+	u32 dummy = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	if (val)
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
+	else
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
+}
+
+static int fsi_i2c_get_sda(struct i2c_adapter *adap)
+{
+	u32 stat = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+
+	return !!(stat & I2C_STAT_SDA_IN);
+}
+
+static void fsi_i2c_set_sda(struct i2c_adapter *adap, int val)
+{
+	u32 dummy = 0;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	if (val)
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SDA, &dummy);
+	else
+		fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SDA, &dummy);
+}
+
+static void fsi_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	int rc;
+	u32 mode;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return;
+
+	mode |= I2C_MODE_DIAG;
+	fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+}
+
+static void fsi_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	int rc;
+	u32 mode;
+	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_master *i2c = port->master;
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	if (rc)
+		return;
+
+	mode &= ~I2C_MODE_DIAG;
+	fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+}
+
+static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c,
+			     struct fsi_i2c_port *port)
+{
+	int rc;
+	u32 stat, dummy = 0;
+
+	/* force bus reset, ignore errors */
+	i2c_recover_bus(&port->adapter);
+
+	/* reset errors */
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
+	if (rc)
+		return rc;
+
+	/* wait for command complete */
+	usleep_range(I2C_RESET_SLEEP_MIN_US, I2C_RESET_SLEEP_MAX_US);
+
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+	if (rc)
+		return rc;
+
+	if (stat & I2C_STAT_CMD_COMP)
+		return 0;
+
+	/* failed to get command complete; reset engine again */
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, &dummy);
+	if (rc)
+		return rc;
+
+	/* re-init engine again */
+	return fsi_i2c_dev_init(i2c);
+}
+
 static int fsi_i2c_reset_engine(struct fsi_i2c_master *i2c, u16 port)
 {
 	int rc;
@@ -368,6 +477,7 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 	int rc;
 	unsigned long start;
 	u32 cmd = I2C_CMD_WITH_STOP;
+	u32 stat;
 	struct fsi_i2c_master *i2c = port->master;
 	struct fsi_device *fsi = i2c->fsi;
 
@@ -375,6 +485,17 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 	if (rc)
 		return rc;
 
+	rc = fsi_i2c_read_reg(fsi, I2C_FSI_STAT, &stat);
+	if (rc)
+		return rc;
+
+	/* if sda is low, peform full bus reset */
+	if (!(stat & I2C_STAT_SDA_IN)) {
+		rc = fsi_i2c_reset_bus(i2c, port);
+		if (rc)
+			return rc;
+	}
+
 	/* skip final stop command for these errors */
 	if (status & (I2C_STAT_PARITY | I2C_STAT_LOST_ARB | I2C_STAT_STOP_ERR))
 		return 0;
@@ -523,6 +644,16 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 		I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+static struct i2c_bus_recovery_info fsi_i2c_bus_recovery_info = {
+	.recover_bus = i2c_generic_scl_recovery,
+	.get_scl = fsi_i2c_get_scl,
+	.set_scl = fsi_i2c_set_scl,
+	.get_sda = fsi_i2c_get_sda,
+	.set_sda = fsi_i2c_set_sda,
+	.prepare_recovery = fsi_i2c_prepare_recovery,
+	.unprepare_recovery = fsi_i2c_unprepare_recovery,
+};
+
 static const struct i2c_algorithm fsi_i2c_algorithm = {
 	.master_xfer = fsi_i2c_xfer,
 	.functionality = fsi_i2c_functionality,
@@ -565,6 +696,7 @@ static int fsi_i2c_probe(struct device *dev)
 		port->adapter.dev.of_node = np;
 		port->adapter.dev.parent = dev;
 		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.bus_recovery_info = &fsi_i2c_bus_recovery_info;
 		port->adapter.algo_data = port;
 
 		snprintf(port->adapter.name, sizeof(port->adapter.name),
-- 
1.8.3.1

