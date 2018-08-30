Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD68CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2482082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2482082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHaBhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:37:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727648AbeHaBhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:37:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ULTjRn074128
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:32:55 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6nm46x96-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:32:55 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 17:32:54 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 17:32:49 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ULWmpf23855320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 21:32:48 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE2C124053;
        Thu, 30 Aug 2018 18:33:25 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D73A8124052;
        Thu, 30 Aug 2018 18:33:24 -0400 (EDT)
Received: from oc6728276242.ibm.com (unknown [9.85.221.248])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 18:33:24 -0400 (EDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux@roeck-us.net, joel@jms.id.au, benh@kernel.crashing.org,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v5 02/10] fsi: Add On-Chip Controller (OCC) driver
Date:   Thu, 30 Aug 2018 16:32:33 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18083021-0064-0000-0000-00000344B691
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009641; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081201; UDB=6.00557772; IPR=6.00861186;
 MB=3.00023023; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 21:32:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083021-0065-0000-0000-00003A7B2902
Message-Id: <1535664761-86018-3-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OCC is a device embedded on a POWER processor that collects and
aggregates sensor data from the processor and system. The OCC can
provide the raw sensor data as well as perform thermal and power
management on the system.

This driver provides an atomic communications channel between a service
processor (e.g. a BMC) and the OCC. The driver is dependent on the FSI
SBEFIFO driver to get hardware access through the SBE to the OCC SRAM.
Commands are issued to the SBE to send or fetch data to the SRAM.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/Kconfig     |  10 +
 drivers/fsi/Makefile    |   1 +
 drivers/fsi/fsi-occ.c   | 599 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsi-occ.h |  25 ++
 4 files changed, 635 insertions(+)
 create mode 100644 drivers/fsi/fsi-occ.c
 create mode 100644 include/linux/fsi-occ.h

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index af3a20d..ea2f4a1 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -64,4 +64,14 @@ config FSI_SBEFIFO
 	a pipe-like FSI device for communicating with the self boot engine
 	(SBE) on POWER processors.
 
+config FSI_OCC
+	tristate "OCC SBEFIFO client device driver"
+	depends on FSI_SBEFIFO
+	---help---
+	This option enables an SBEFIFO based On-Chip Controller (OCC) device
+	driver. The OCC is a device embedded on a POWER processor that collects
+	and aggregates sensor data from the processor and system. The OCC can
+	provide the raw sensor data as well as perform thermal and power
+	management on the system.
+
 endif
diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
index a50d6ce..62687ec 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
 obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
 obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
+obj-$(CONFIG_FSI_OCC) += fsi-occ.o
diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
new file mode 100644
index 0000000..2a2049d
--- /dev/null
+++ b/drivers/fsi/fsi-occ.c
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/fsi-sbefifo.h>
+#include <linux/gfp.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/fsi-occ.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <asm/unaligned.h>
+
+#define OCC_SRAM_BYTES		4096
+#define OCC_CMD_DATA_BYTES	4090
+#define OCC_RESP_DATA_BYTES	4089
+
+#define OCC_SRAM_CMD_ADDR	0xFFFBE000
+#define OCC_SRAM_RSP_ADDR	0xFFFBF000
+
+/*
+ * Assume we don't have much FFDC, if we do we'll overflow and
+ * fail the command. This needs to be big enough for simple
+ * commands as well.
+ */
+#define OCC_SBE_STATUS_WORDS	32
+
+#define OCC_TIMEOUT_MS		1000
+#define OCC_CMD_IN_PRG_WAIT_MS	50
+
+struct occ {
+	struct device *dev;
+	struct device *sbefifo;
+	char name[32];
+	int idx;
+	struct miscdevice mdev;
+	struct mutex occ_lock;
+};
+
+#define to_occ(x)	container_of((x), struct occ, mdev)
+
+struct occ_response {
+	u8 seq_no;
+	u8 cmd_type;
+	u8 return_status;
+	__be16 data_length;
+	u8 data[OCC_RESP_DATA_BYTES + 2];	/* two bytes checksum */
+} __packed;
+
+struct occ_client {
+	struct occ *occ;
+	struct mutex lock;
+	size_t data_size;
+	size_t read_offset;
+	u8 *buffer;
+};
+
+#define to_client(x)	container_of((x), struct occ_client, xfr)
+
+static DEFINE_IDA(occ_ida);
+
+static int occ_open(struct inode *inode, struct file *file)
+{
+	struct occ_client *client = kzalloc(sizeof(*client), GFP_KERNEL);
+	struct miscdevice *mdev = file->private_data;
+	struct occ *occ = to_occ(mdev);
+
+	if (!client)
+		return -ENOMEM;
+
+	client->buffer = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!client->buffer) {
+		kfree(client);
+		return -ENOMEM;
+	}
+
+	client->occ = occ;
+	mutex_init(&client->lock);
+	file->private_data = client;
+
+	/* We allocate a 1-page buffer, make sure it all fits */
+	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
+	BUILD_BUG_ON((OCC_RESP_DATA_BYTES + 7) > PAGE_SIZE);
+
+	return 0;
+}
+
+static ssize_t occ_read(struct file *file, char __user *buf, size_t len,
+			loff_t *offset)
+{
+	struct occ_client *client = file->private_data;
+	ssize_t rc = 0;
+
+	if (!client)
+		return -ENODEV;
+
+	if (len > OCC_SRAM_BYTES)
+		return -EINVAL;
+
+	mutex_lock(&client->lock);
+
+	/* This should not be possible ... */
+	if (WARN_ON_ONCE(client->read_offset > client->data_size)) {
+		rc = -EIO;
+		goto done;
+	}
+
+	/* Grab how much data we have to read */
+	rc = min(len, client->data_size - client->read_offset);
+	if (copy_to_user(buf, client->buffer + client->read_offset, rc))
+		rc = -EFAULT;
+	else
+		client->read_offset += rc;
+
+ done:
+	mutex_unlock(&client->lock);
+
+	return rc;
+}
+
+static ssize_t occ_write(struct file *file, const char __user *buf,
+			 size_t len, loff_t *offset)
+{
+	struct occ_client *client = file->private_data;
+	size_t rlen, data_length;
+	u16 checksum = 0;
+	ssize_t rc, i;
+	u8 *cmd;
+
+	if (!client)
+		return -ENODEV;
+
+	if (len > (OCC_CMD_DATA_BYTES + 3) || len < 3)
+		return -EINVAL;
+
+	mutex_lock(&client->lock);
+
+	/* Construct the command */
+	cmd = client->buffer;
+
+	/* Sequence number (we could increment and compare with response) */
+	cmd[0] = 1;
+
+	/*
+	 * Copy the user command (assume user data follows the occ command
+	 * format)
+	 * byte 0: command type
+	 * bytes 1-2: data length (msb first)
+	 * bytes 3-n: data
+	 */
+	if (copy_from_user(&cmd[1], buf, len)) {
+		rc = -EFAULT;
+		goto done;
+	}
+
+	/* Extract data length */
+	data_length = (cmd[2] << 8) + cmd[3];
+	if (data_length > OCC_CMD_DATA_BYTES) {
+		rc = -EINVAL;
+		goto done;
+	}
+
+	/* Calculate checksum */
+	for (i = 0; i < data_length + 4; ++i)
+		checksum += cmd[i];
+
+	cmd[data_length + 4] = checksum >> 8;
+	cmd[data_length + 5] = checksum & 0xFF;
+
+	/* Submit command */
+	rlen = PAGE_SIZE;
+	rc = fsi_occ_submit(client->occ->dev, cmd, data_length + 6, cmd,
+			    &rlen);
+	if (rc)
+		goto done;
+
+	/* Set read tracking data */
+	client->data_size = rlen;
+	client->read_offset = 0;
+
+	/* Done */
+	rc = len;
+
+ done:
+	mutex_unlock(&client->lock);
+
+	return rc;
+}
+
+static int occ_release(struct inode *inode, struct file *file)
+{
+	struct occ_client *client = file->private_data;
+
+	free_page((unsigned long)client->buffer);
+	kfree(client);
+
+	return 0;
+}
+
+static const struct file_operations occ_fops = {
+	.owner = THIS_MODULE,
+	.open = occ_open,
+	.read = occ_read,
+	.write = occ_write,
+	.release = occ_release,
+};
+
+static int occ_verify_checksum(struct occ_response *resp, u16 data_length)
+{
+	/* Fetch the two bytes after the data for the checksum. */
+	u16 checksum_resp = get_unaligned_be16(&resp->data[data_length]);
+	u16 checksum;
+	u16 i;
+
+	checksum = resp->seq_no;
+	checksum += resp->cmd_type;
+	checksum += resp->return_status;
+	checksum += (data_length >> 8) + (data_length & 0xFF);
+
+	for (i = 0; i < data_length; ++i)
+		checksum += resp->data[i];
+
+	if (checksum != checksum_resp)
+		return -EBADMSG;
+
+	return 0;
+}
+
+static int occ_getsram(struct occ *occ, u32 address, void *data, ssize_t len)
+{
+	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
+	size_t resp_len, resp_data_len;
+	__be32 *resp, cmd[5];
+	int rc;
+
+	/*
+	 * Magic sequence to do SBE getsram command. SBE will fetch data from
+	 * specified SRAM address.
+	 */
+	cmd[0] = cpu_to_be32(0x5);
+	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_OCC_SRAM);
+	cmd[2] = cpu_to_be32(1);
+	cmd[3] = cpu_to_be32(address);
+	cmd[4] = cpu_to_be32(data_len);
+
+	resp_len = (data_len >> 2) + OCC_SBE_STATUS_WORDS;
+	resp = kzalloc(resp_len << 2, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	rc = sbefifo_submit(occ->sbefifo, cmd, 5, resp, &resp_len);
+	if (rc)
+		goto free;
+
+	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_GET_OCC_SRAM,
+				  resp, resp_len, &resp_len);
+	if (rc)
+		goto free;
+
+	resp_data_len = be32_to_cpu(resp[resp_len - 1]);
+	if (resp_data_len != data_len) {
+		dev_err(occ->dev, "SRAM read expected %d bytes got %zd\n",
+			data_len, resp_data_len);
+		rc = -EBADMSG;
+	} else {
+		memcpy(data, resp, len);
+	}
+
+free:
+	/* Convert positive SBEI status */
+	if (rc > 0) {
+		dev_err(occ->dev, "SRAM read returned failure status: %08x\n",
+			rc);
+		rc = -EBADMSG;
+	}
+
+	kfree(resp);
+	return rc;
+}
+
+static int occ_putsram(struct occ *occ, u32 address, const void *data,
+		       ssize_t len)
+{
+	size_t cmd_len, buf_len, resp_len, resp_data_len;
+	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
+	__be32 *buf;
+	int rc;
+
+	/*
+	 * We use the same buffer for command and response, make
+	 * sure it's big enough
+	 */
+	resp_len = OCC_SBE_STATUS_WORDS;
+	cmd_len = (data_len >> 2) + 5;
+	buf_len = max(cmd_len, resp_len);
+	buf = kzalloc(buf_len << 2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/*
+	 * Magic sequence to do SBE putsram command. SBE will transfer
+	 * data to specified SRAM address.
+	 */
+	buf[0] = cpu_to_be32(cmd_len);
+	buf[1] = cpu_to_be32(SBEFIFO_CMD_PUT_OCC_SRAM);
+	buf[2] = cpu_to_be32(1);
+	buf[3] = cpu_to_be32(address);
+	buf[4] = cpu_to_be32(data_len);
+
+	memcpy(&buf[5], data, len);
+
+	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
+	if (rc)
+		goto free;
+
+	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
+				  buf, resp_len, &resp_len);
+	if (rc)
+		goto free;
+
+	if (resp_len != 1) {
+		dev_err(occ->dev, "SRAM write response length invalid: %zd\n",
+			resp_len);
+		rc = -EBADMSG;
+	} else {
+		resp_data_len = be32_to_cpu(buf[0]);
+		if (resp_data_len != data_len) {
+			dev_err(occ->dev,
+				"SRAM write expected %d bytes got %zd\n",
+				data_len, resp_data_len);
+			rc = -EBADMSG;
+		}
+	}
+
+free:
+	/* Convert positive SBEI status */
+	if (rc > 0) {
+		dev_err(occ->dev, "SRAM write returned failure status: %08x\n",
+			rc);
+		rc = -EBADMSG;
+	}
+
+	kfree(buf);
+	return rc;
+}
+
+static int occ_trigger_attn(struct occ *occ)
+{
+	__be32 buf[OCC_SBE_STATUS_WORDS];
+	size_t resp_len, resp_data_len;
+	int rc;
+
+	BUILD_BUG_ON(OCC_SBE_STATUS_WORDS < 7);
+	resp_len = OCC_SBE_STATUS_WORDS;
+
+	buf[0] = cpu_to_be32(0x5 + 0x2);        /* Chip-op length in words */
+	buf[1] = cpu_to_be32(SBEFIFO_CMD_PUT_OCC_SRAM);
+	buf[2] = cpu_to_be32(0x3);              /* Mode: Circular */
+	buf[3] = cpu_to_be32(0x0);              /* Address: ignore in mode 3 */
+	buf[4] = cpu_to_be32(0x8);              /* Data length in bytes */
+	buf[5] = cpu_to_be32(0x20010000);       /* Trigger OCC attention */
+	buf[6] = 0;
+
+	rc = sbefifo_submit(occ->sbefifo, buf, 7, buf, &resp_len);
+	if (rc)
+		goto error;
+
+	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
+				  buf, resp_len, &resp_len);
+	if (rc)
+		goto error;
+
+	if (resp_len != 1) {
+		dev_err(occ->dev, "SRAM attn response length invalid: %zd\n",
+			resp_len);
+		rc = -EBADMSG;
+	} else {
+		resp_data_len = be32_to_cpu(buf[0]);
+		if (resp_data_len != 8) {
+			dev_err(occ->dev,
+				"SRAM attn expected 8 bytes got %zd\n",
+				resp_data_len);
+			rc = -EBADMSG;
+		}
+	}
+
+ error:
+	/* Convert positive SBEI status */
+	if (rc > 0) {
+		dev_err(occ->dev, "SRAM attn returned failure status: %08x\n",
+			rc);
+		rc = -EBADMSG;
+	}
+
+	return rc;
+}
+
+int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
+		   void *response, size_t *resp_len)
+{
+	const unsigned long timeout = msecs_to_jiffies(OCC_TIMEOUT_MS);
+	const unsigned long wait_time =
+		msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_response *resp = response;
+	u16 resp_data_length;
+	unsigned long start;
+	int rc;
+
+	if (!occ)
+		return -ENODEV;
+
+	if (*resp_len < 7) {
+		dev_dbg(dev, "Bad resplen %zd\n", *resp_len);
+		return -EINVAL;
+	}
+
+	mutex_lock(&occ->occ_lock);
+
+	rc = occ_putsram(occ, OCC_SRAM_CMD_ADDR, request, req_len);
+	if (rc)
+		goto done;
+
+	rc = occ_trigger_attn(occ);
+	if (rc)
+		goto done;
+
+	/* Read occ response header */
+	start = jiffies;
+	do {
+		rc = occ_getsram(occ, OCC_SRAM_RSP_ADDR, resp, 8);
+		if (rc)
+			goto done;
+
+		if (resp->return_status == OCC_RESP_CMD_IN_PRG) {
+			rc = -ETIMEDOUT;
+
+			if (time_after(jiffies, start + timeout))
+				break;
+
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(wait_time);
+		}
+	} while (rc);
+
+	/* Extract size of response data */
+	resp_data_length = get_unaligned_be16(&resp->data_length);
+
+	/* Message size is data length + 5 bytes header + 2 bytes checksum */
+	if ((resp_data_length + 7) > *resp_len) {
+		rc = -EMSGSIZE;
+		goto done;
+	}
+
+	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
+		resp->return_status, resp_data_length);
+
+	/* Grab the rest */
+	if (resp_data_length > 1) {
+		/* already got 3 bytes resp, also need 2 bytes checksum */
+		rc = occ_getsram(occ, OCC_SRAM_RSP_ADDR + 8,
+				 &resp->data[3], resp_data_length - 1);
+		if (rc)
+			goto done;
+	}
+
+	*resp_len = resp_data_length + 7;
+	rc = occ_verify_checksum(resp, resp_data_length);
+
+ done:
+	mutex_unlock(&occ->occ_lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(fsi_occ_submit);
+
+static int occ_unregister_child(struct device *dev, void *data)
+{
+	struct platform_device *hwmon_dev = to_platform_device(dev);
+
+	platform_device_unregister(hwmon_dev);
+
+	return 0;
+}
+
+static int occ_probe(struct platform_device *pdev)
+{
+	int rc;
+	u32 reg;
+	struct occ *occ;
+	struct platform_device *hwmon_dev;
+	struct device *dev = &pdev->dev;
+	struct platform_device_info hwmon_dev_info = {
+		.parent = dev,
+		.name = "occ-hwmon",
+	};
+
+	occ = devm_kzalloc(dev, sizeof(*occ), GFP_KERNEL);
+	if (!occ)
+		return -ENOMEM;
+
+	occ->dev = dev;
+	occ->sbefifo = dev->parent;
+	mutex_init(&occ->occ_lock);
+
+	if (dev->of_node) {
+		rc = of_property_read_u32(dev->of_node, "reg", &reg);
+		if (!rc) {
+			/* make sure we don't have a duplicate from dts */
+			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
+						  GFP_KERNEL);
+			if (occ->idx < 0)
+				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
+							  GFP_KERNEL);
+		} else {
+			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
+						  GFP_KERNEL);
+		}
+	} else {
+		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
+	}
+
+	platform_set_drvdata(pdev, occ);
+
+	snprintf(occ->name, sizeof(occ->name), "occ%d", occ->idx);
+	occ->mdev.fops = &occ_fops;
+	occ->mdev.minor = MISC_DYNAMIC_MINOR;
+	occ->mdev.name = occ->name;
+	occ->mdev.parent = dev;
+
+	rc = misc_register(&occ->mdev);
+	if (rc) {
+		dev_err(dev, "failed to register miscdevice: %d\n", rc);
+		ida_simple_remove(&occ_ida, occ->idx);
+		return rc;
+	}
+
+	hwmon_dev_info.id = occ->idx;
+	hwmon_dev = platform_device_register_full(&hwmon_dev_info);
+	if (!hwmon_dev)
+		dev_warn(dev, "failed to create hwmon device\n");
+
+	return 0;
+}
+
+static int occ_remove(struct platform_device *pdev)
+{
+	struct occ *occ = platform_get_drvdata(pdev);
+
+	misc_deregister(&occ->mdev);
+
+	device_for_each_child(&pdev->dev, NULL, occ_unregister_child);
+
+	ida_simple_remove(&occ_ida, occ->idx);
+
+	return 0;
+}
+
+static const struct of_device_id occ_match[] = {
+	{ .compatible = "ibm,p9-occ" },
+	{ },
+};
+
+static struct platform_driver occ_driver = {
+	.driver = {
+		.name = "occ",
+		.of_match_table	= occ_match,
+	},
+	.probe	= occ_probe,
+	.remove = occ_remove,
+};
+
+static int occ_init(void)
+{
+	return platform_driver_register(&occ_driver);
+}
+
+static void occ_exit(void)
+{
+	platform_driver_unregister(&occ_driver);
+
+	ida_destroy(&occ_ida);
+}
+
+module_init(occ_init);
+module_exit(occ_exit);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("BMC P9 OCC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fsi-occ.h b/include/linux/fsi-occ.h
new file mode 100644
index 0000000..d4cdc2a
--- /dev/null
+++ b/include/linux/fsi-occ.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef LINUX_FSI_OCC_H
+#define LINUX_FSI_OCC_H
+
+struct device;
+
+#define OCC_RESP_CMD_IN_PRG		0xFF
+#define OCC_RESP_SUCCESS		0
+#define OCC_RESP_CMD_INVAL		0x11
+#define OCC_RESP_CMD_LEN_INVAL		0x12
+#define OCC_RESP_DATA_INVAL		0x13
+#define OCC_RESP_CHKSUM_ERR		0x14
+#define OCC_RESP_INT_ERR		0x15
+#define OCC_RESP_BAD_STATE		0x16
+#define OCC_RESP_CRIT_EXCEPT		0xE0
+#define OCC_RESP_CRIT_INIT		0xE1
+#define OCC_RESP_CRIT_WATCHDOG		0xE2
+#define OCC_RESP_CRIT_OCB		0xE3
+#define OCC_RESP_CRIT_HW		0xE4
+
+int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
+		   void *response, size_t *resp_len);
+
+#endif /* LINUX_FSI_OCC_H */
-- 
1.8.3.1

