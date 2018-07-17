Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8CDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22CB20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22CB20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGQQEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730986AbeGQQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:04:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HFTGlm134116
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:31:29 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k9k2vg8vc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:31:28 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 09:31:28 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 09:31:24 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HFVN6h12583322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 08:31:23 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1735A13605D;
        Tue, 17 Jul 2018 09:31:23 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D5D13604F;
        Tue, 17 Jul 2018 09:31:22 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 09:31:22 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>
Subject: [PATCH v12 7/8] i2c: fsi: Add bus recovery
Date:   Tue, 17 Jul 2018 10:31:05 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071715-0036-0000-0000-00000A10AC92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009380; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062145; UDB=6.00545317; IPR=6.00840002;
 MB=3.00022173; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 15:31:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071715-0037-0000-0000-000048225128
Message-Id: <1531841466-9833-8-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>

Bus recovery should reset the bus with the standard i2c recovery
procedure. Populate the necessary fields so that the standard procedure
can perform the reset.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 132 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 27d74a9..1e2be22 100644
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
@@ -522,6 +643,16 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
 		I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
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
@@ -564,6 +695,7 @@ static int fsi_i2c_probe(struct device *dev)
 		port->adapter.dev.of_node = np;
 		port->adapter.dev.parent = dev;
 		port->adapter.algo = &fsi_i2c_algorithm;
+		port->adapter.bus_recovery_info = &fsi_i2c_bus_recovery_info;
 		port->adapter.algo_data = port;
 
 		snprintf(port->adapter.name, sizeof(port->adapter.name),
-- 
1.8.3.1

