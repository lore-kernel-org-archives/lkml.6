Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DB02EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AF2208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AF2208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964818AbeFMThf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:37:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935679AbeFMTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:36:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DJYU5W075376
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:36:38 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jk8ubsrj2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:36:38 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 13:36:37 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 13:36:32 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DJaVpI1835274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 12:36:31 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CEAFC605D;
        Wed, 13 Jun 2018 13:36:31 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D784FC6059;
        Wed, 13 Jun 2018 13:36:30 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 13:36:30 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v10 5/7] i2c: fsi: Add transfer implementation
Date:   Wed, 13 Jun 2018 14:36:17 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061319-0020-0000-0000-00000E2D67B6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009184; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046493; UDB=6.00535962; IPR=6.00825469;
 MB=3.00021628; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 19:36:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061319-0021-0000-0000-000061ED1368
Message-Id: <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Execute I2C transfers from the FSI-attached I2C master. Use polling
instead of interrupts as we have no hardware IRQ over FSI.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 4611a0b..8c0a6cb 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -155,6 +155,7 @@ struct fsi_i2c_port {
 	struct i2c_adapter	adapter;
 	struct fsi_i2c_master	*master;
 	u16			port;
+	u16			xfrd;
 };
 
 static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
@@ -230,6 +231,99 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
 	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
 }
 
+static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			 bool stop)
+{
+	struct fsi_i2c_master *i2c = port->master;
+	u32 cmd = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR;
+
+	port->xfrd = 0;
+
+	if (msg->flags & I2C_M_RD)
+		cmd |= I2C_CMD_READ;
+
+	if (stop || msg->flags & I2C_M_STOP)
+		cmd |= I2C_CMD_WITH_STOP;
+
+	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
+	cmd |= FIELD_PREP(I2C_CMD_LEN, msg->len);
+
+	return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_CMD, &cmd);
+}
+
+static int fsi_i2c_get_op_bytes(int op_bytes)
+{
+	/* fsi is limited to max 4 byte aligned ops */
+	if (op_bytes > 4)
+		return 4;
+	else if (op_bytes == 3)
+		return 2;
+	return op_bytes;
+}
+
+static int fsi_i2c_write_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			      u8 fifo_count)
+{
+	int write;
+	int rc;
+	struct fsi_i2c_master *i2c = port->master;
+	int bytes_to_write = i2c->fifo_size - fifo_count;
+	int bytes_remaining = msg->len - port->xfrd;
+
+	bytes_to_write = min(bytes_to_write, bytes_remaining);
+
+	while (bytes_to_write) {
+		write = fsi_i2c_get_op_bytes(bytes_to_write);
+
+		rc = fsi_device_write(i2c->fsi, I2C_FSI_FIFO,
+				      &msg->buf[port->xfrd], write);
+		if (rc)
+			return rc;
+
+		port->xfrd += write;
+		bytes_to_write -= write;
+	}
+
+	return 0;
+}
+
+static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			     u8 fifo_count)
+{
+	int read;
+	int rc;
+	struct fsi_i2c_master *i2c = port->master;
+	int bytes_to_read;
+	int xfr_remaining = msg->len - port->xfrd;
+	u32 dummy;
+
+	bytes_to_read = min_t(int, fifo_count, xfr_remaining);
+
+	while (bytes_to_read) {
+		read = fsi_i2c_get_op_bytes(bytes_to_read);
+
+		if (xfr_remaining) {
+			rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO,
+					     &msg->buf[port->xfrd], read);
+			if (rc)
+				return rc;
+
+			port->xfrd += read;
+			xfr_remaining -= read;
+		} else {
+			/* no more buffer but data in fifo, need to clear it */
+			rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO, &dummy,
+					     read);
+			if (rc)
+				return rc;
+		}
+
+		bytes_to_read -= read;
+	}
+
+	return 0;
+}
+
 static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c)
 {
 	int i, rc;
@@ -393,17 +487,114 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 	return -ETIMEDOUT;
 }
 
+static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
+				 struct i2c_msg *msg, u32 status)
+{
+	int rc;
+	u8 fifo_count;
+
+	if (status & I2C_STAT_ERR) {
+		rc = fsi_i2c_abort(port, status);
+		if (rc)
+			return rc;
+
+		if (status & I2C_STAT_INV_CMD)
+			return -EINVAL;
+
+		if (status & (I2C_STAT_PARITY | I2C_STAT_BE_OVERRUN |
+		    I2C_STAT_BE_ACCESS))
+			return -EPROTO;
+
+		if (status & I2C_STAT_NACK)
+			return -ENXIO;
+
+		if (status & I2C_STAT_LOST_ARB)
+			return -EAGAIN;
+
+		if (status & I2C_STAT_STOP_ERR)
+			return -EBADMSG;
+
+		return -EIO;
+	}
+
+	if (status & I2C_STAT_DAT_REQ) {
+		fifo_count = FIELD_GET(I2C_STAT_FIFO_COUNT, status);
+
+		if (msg->flags & I2C_M_RD)
+			return fsi_i2c_read_fifo(port, msg, fifo_count);
+
+		return fsi_i2c_write_fifo(port, msg, fifo_count);
+	}
+
+	if (status & I2C_STAT_CMD_COMP) {
+		if (port->xfrd < msg->len)
+			return -ENODATA;
+
+		return msg->len;
+	}
+
+	return 0;
+}
+
+static int fsi_i2c_wait(struct fsi_i2c_port *port, struct i2c_msg *msg,
+			unsigned long timeout)
+{
+	u32 status = 0;
+	int rc;
+	unsigned long start = jiffies;
+
+	do {
+		rc = fsi_i2c_read_reg(port->master->fsi, I2C_FSI_STAT,
+				      &status);
+		if (rc)
+			return rc;
+
+		if (status & I2C_STAT_ANY_RESP) {
+			rc = fsi_i2c_handle_status(port, msg, status);
+			if (rc < 0)
+				return rc;
+
+			/* cmd complete and all data xfrd */
+			if (rc == msg->len)
+				return 0;
+
+			/* need to xfr more data, but maybe don't need wait */
+			continue;
+		}
+
+		usleep_range(I2C_CMD_SLEEP_MIN_US, I2C_CMD_SLEEP_MAX_US);
+	} while (time_after(start + timeout, jiffies));
+
+	return -ETIMEDOUT;
+}
+
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
-	int rc;
+	int i, rc;
+	unsigned long start_time;
 	struct fsi_i2c_port *port = adap->algo_data;
+	struct i2c_msg *msg;
 
 	rc = fsi_i2c_set_port(port);
 	if (rc)
 		return rc;
 
-	return -EOPNOTSUPP;
+	for (i = 0; i < num; i++) {
+		msg = msgs + i;
+		start_time = jiffies;
+
+		rc = fsi_i2c_start(port, msg, i == num - 1);
+		if (rc)
+			return rc;
+
+		rc = fsi_i2c_wait(port, msg,
+				  adap->timeout - (jiffies - start_time));
+		if (rc)
+			return rc;
+	}
+
+	return num;
 }
 
 static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
-- 
1.8.3.1

