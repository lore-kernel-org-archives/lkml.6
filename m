Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EE4B3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A149208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A149208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932738AbeFLFUJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:20:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:51971 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932550AbeFLFUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:20:06 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C5JDa7008698;
        Tue, 12 Jun 2018 00:19:27 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 5/5] fsi/scom: Major overhaul
Date:   Tue, 12 Jun 2018 15:19:11 +1000
Message-Id: <20180612051911.20690-6-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612051911.20690-1-benh@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was too hard to split ... this adds a number of features
to the SCOM user interface:

 - Support for indirect SCOMs

 - read()/write() interface now handle errors and retries

 - New ioctl() "raw" interface for use by debuggers

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-scom.c   | 424 ++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/fsi.h |  56 ++++++
 2 files changed, 450 insertions(+), 30 deletions(-)
 create mode 100644 include/uapi/linux/fsi.h

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index e98573ecdae1..39c74351f1bf 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -24,6 +24,8 @@
 #include <linux/list.h>
 #include <linux/idr.h>
 
+#include <uapi/linux/fsi.h>
+
 #define FSI_ENGID_SCOM		0x5
 
 /* SCOM engine register set */
@@ -41,14 +43,36 @@
 /* Status register bits */
 #define SCOM_STATUS_ERR_SUMMARY		0x80000000
 #define SCOM_STATUS_PROTECTION		0x01000000
+#define SCOM_STATUS_PARITY		0x04000000
 #define SCOM_STATUS_PIB_ABORT		0x00100000
 #define SCOM_STATUS_PIB_RESP_MASK	0x00007000
 #define SCOM_STATUS_PIB_RESP_SHIFT	12
 
 #define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_ERR_SUMMARY | \
 					 SCOM_STATUS_PROTECTION | \
+					 SCOM_STATUS_PARITY |	  \
 					 SCOM_STATUS_PIB_ABORT | \
 					 SCOM_STATUS_PIB_RESP_MASK)
+/* SCOM address encodings */
+#define XSCOM_ADDR_IND_FLAG		BIT_ULL(63)
+#define XSCOM_ADDR_INF_FORM1		BIT_ULL(60)
+
+/* SCOM indirect stuff */
+#define XSCOM_ADDR_DIRECT_PART		0x7fffffffull
+#define XSCOM_ADDR_INDIRECT_PART	0x000fffff00000000ull
+#define XSCOM_DATA_IND_READ		BIT_ULL(63)
+#define XSCOM_DATA_IND_COMPLETE		BIT_ULL(31)
+#define XSCOM_DATA_IND_ERR_MASK		0x70000000ull
+#define XSCOM_DATA_IND_ERR_SHIFT	28
+#define XSCOM_DATA_IND_DATA		0x0000ffffull
+#define XSCOM_DATA_IND_FORM1_DATA	0x000fffffffffffffull
+#define XSCOM_ADDR_FORM1_LOW		0x000ffffffffull
+#define XSCOM_ADDR_FORM1_HI		0xfff00000000ull
+#define XSCOM_ADDR_FORM1_HI_SHIFT	20
+
+/* Retries */
+#define SCOM_MAX_RETRIES		100	/* Retries on busy */
+#define SCOM_MAX_IND_RETRIES		10	/* Retries indirect not ready */
 
 struct scom_device {
 	struct list_head link;
@@ -56,7 +80,7 @@ struct scom_device {
 	struct miscdevice mdev;
 	struct mutex lock;
 	char	name[32];
-	int idx;
+	int	idx;
 };
 
 #define to_scom_dev(x)		container_of((x), struct scom_device, mdev)
@@ -65,80 +89,304 @@ static struct list_head scom_devices;
 
 static DEFINE_IDA(scom_ida);
 
-static int put_scom(struct scom_device *scom_dev, uint64_t value,
-		    uint32_t addr)
+static int __put_scom(struct scom_device *scom_dev, uint64_t value,
+		      uint32_t addr, uint32_t *status)
 {
-	__be32 data;
+	__be32 data, raw_status;
 	int rc;
 
-	mutex_lock(&scom_dev->lock);
-
 	data = cpu_to_be32((value >> 32) & 0xffffffff);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_DATA0_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		goto bail;
+		return rc;
 
 	data = cpu_to_be32(value & 0xffffffff);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_DATA1_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		goto bail;
+		return rc;
 
 	data = cpu_to_be32(SCOM_WRITE_CMD | addr);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
 				sizeof(uint32_t));
- bail:
-	mutex_unlock(&scom_dev->lock);
-	return rc;
+	if (rc)
+		return rc;
+	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_STATUS_REG, &raw_status,
+			     sizeof(uint32_t));
+	if (rc)
+		return rc;
+	*status = be32_to_cpu(raw_status);
+
+	return 0;
 }
 
-static int get_scom(struct scom_device *scom_dev, uint64_t *value,
-		    uint32_t addr)
+static int __get_scom(struct scom_device *scom_dev, uint64_t *value,
+		      uint32_t addr, uint32_t *status)
 {
-	__be32 result, data;
+	__be32 data, raw_status;
 	int rc;
 
 
-	mutex_lock(&scom_dev->lock);
 	*value = 0ULL;
 	data = cpu_to_be32(SCOM_READ_CMD | addr);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		goto bail;
+		return rc;
+	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_STATUS_REG, &raw_status,
+			     sizeof(uint32_t));
+	if (rc)
+		return rc;
 
-	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA0_REG, &result,
+	/*
+	 * Read the data registers even on error, so we don't have
+	 * to interpret the status register here.
+	 */
+	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA0_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		goto bail;
-
-	*value |= (uint64_t)be32_to_cpu(result) << 32;
-	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA1_REG, &result,
+		return rc;
+	*value |= (uint64_t)be32_to_cpu(data) << 32;
+	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA1_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-		goto bail;
+		return rc;
+	*value |= be32_to_cpu(data);
+	*status = be32_to_cpu(raw_status);
+
+	return rc;
+}
+
+static int put_indirect_scom_form0(struct scom_device *scom, uint64_t value,
+				   uint64_t addr, uint32_t *status)
+{
+	uint64_t ind_data, ind_addr;
+	int rc, retries, err = 0;
+
+	if (value & ~XSCOM_DATA_IND_DATA)
+		return -EINVAL;
+
+	ind_addr = addr & XSCOM_ADDR_DIRECT_PART;
+	ind_data = (addr & XSCOM_ADDR_INDIRECT_PART) | value;
+	rc = __put_scom(scom, ind_data, ind_addr, status);
+	if (rc || (*status & SCOM_STATUS_ANY_ERR))
+		return rc;
+
+	for (retries = 0; retries < SCOM_MAX_IND_RETRIES; retries++) {
+		rc = __get_scom(scom, &ind_data, addr, status);
+		if (rc || (*status & SCOM_STATUS_ANY_ERR))
+			return rc;
+
+		err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
+		*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
+		if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
+			return 0;
+
+		msleep(1);
+	}
+	return rc;
+}
+
+static int put_indirect_scom_form1(struct scom_device *scom, uint64_t value,
+				   uint64_t addr, uint32_t *status)
+{
+	uint64_t ind_data, ind_addr;
+
+	if (value & ~XSCOM_DATA_IND_FORM1_DATA)
+		return -EINVAL;
+
+	ind_addr = addr & XSCOM_ADDR_FORM1_LOW;
+	ind_data = value | (addr & XSCOM_ADDR_FORM1_HI) << XSCOM_ADDR_FORM1_HI_SHIFT;
+	return __put_scom(scom, ind_data, ind_addr, status);
+}
+
+static int get_indirect_scom_form0(struct scom_device *scom, uint64_t *value,
+				   uint64_t addr, uint32_t *status)
+{
+	uint64_t ind_data, ind_addr;
+	int rc, retries, err = 0;
+
+	ind_addr = addr & XSCOM_ADDR_DIRECT_PART;
+	ind_data = (addr & XSCOM_ADDR_INDIRECT_PART) | XSCOM_DATA_IND_READ;
+	rc = __put_scom(scom, ind_data, ind_addr, status);
+	if (rc || (*status & SCOM_STATUS_ANY_ERR))
+		return rc;
+
+	for (retries = 0; retries < SCOM_MAX_IND_RETRIES; retries++) {
+		rc = __get_scom(scom, &ind_data, addr, status);
+		if (rc || (*status & SCOM_STATUS_ANY_ERR))
+			return rc;
+
+		err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
+		*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
+		*value = ind_data & XSCOM_DATA_IND_DATA;
+
+		if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
+			return 0;
+
+		msleep(1);
+	}
+	return rc;
+}
+
+static int raw_put_scom(struct scom_device *scom, uint64_t value,
+			uint64_t addr, uint32_t *status)
+{
+	if (addr & XSCOM_ADDR_IND_FLAG) {
+		if (addr & XSCOM_ADDR_INF_FORM1)
+			return put_indirect_scom_form1(scom, value, addr, status);
+		else
+			return put_indirect_scom_form0(scom, value, addr, status);
+	} else
+		return __put_scom(scom, value, addr, status);
+}
+
+static int raw_get_scom(struct scom_device *scom, uint64_t *value,
+			uint64_t addr, uint32_t *status)
+{
+	if (addr & XSCOM_ADDR_IND_FLAG) {
+		if (addr & XSCOM_ADDR_INF_FORM1)
+			return -ENXIO;
+		return get_indirect_scom_form0(scom, value, addr, status);
+	} else
+		return __get_scom(scom, value, addr, status);
+}
+
+static int handle_fsi2pib_status(struct scom_device *scom, uint32_t status)
+{
+	uint32_t dummy = -1;
+
+	if (status & SCOM_STATUS_PROTECTION)
+		return -EPERM;
+	if (status & SCOM_STATUS_PARITY) {
+		fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
+				 sizeof(uint32_t));
+		return -EIO;
+	}
+	/* Return -EBUSY on PIB abort to force a retry */
+	if (status & SCOM_STATUS_PIB_ABORT)
+		return -EBUSY;
+	if (status & SCOM_STATUS_ERR_SUMMARY) {
+		fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
+				 sizeof(uint32_t));
+		return -EIO;
+	}
+	return 0;
+}
+
+static int handle_pib_status(struct scom_device *scom, uint8_t status)
+{
+	uint32_t dummy = -1;
+
+	if (status == SCOM_PIB_SUCCESS)
+		return 0;
+	if (status == SCOM_PIB_BLOCKED)
+		return -EBUSY;
+
+	/* Reset the bridge */
+	fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
+			 sizeof(uint32_t));
+
+	switch(status) {
+	case SCOM_PIB_OFFLINE:
+		return -ENODEV;
+	case SCOM_PIB_BAD_ADDR:
+		return -ENXIO;
+	case SCOM_PIB_TIMEOUT:
+		return -ETIMEDOUT;
+	case SCOM_PIB_PARTIAL:
+	case SCOM_PIB_CLK_ERR:
+	case SCOM_PIB_PARITY_ERR:
+	default:
+		return -EIO;
+	}
+}
 
-	*value |= be32_to_cpu(result);
- bail:
-	mutex_unlock(&scom_dev->lock);
+static int put_scom(struct scom_device *scom, uint64_t value,
+		    uint64_t addr)
+{
+	uint32_t status, dummy = -1;
+	int rc, retries;
+
+	for (retries = 0; retries < SCOM_MAX_RETRIES; retries++) {
+		rc = raw_put_scom(scom, value, addr, &status);
+		if (rc) {
+			/* Try resetting the bridge if FSI fails */
+			if (rc != -ENODEV && retries == 0) {
+				fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG,
+						 &dummy, sizeof(uint32_t));
+				rc = -EBUSY;
+			} else
+				return rc;
+		} else
+			rc = handle_fsi2pib_status(scom, status);
+		if (rc && rc != -EBUSY)
+			break;
+		if (rc == 0) {
+			rc = handle_pib_status(scom,
+					       (status & SCOM_STATUS_PIB_RESP_MASK)
+					       >> SCOM_STATUS_PIB_RESP_SHIFT);
+			if (rc && rc != -EBUSY)
+				break;
+		}
+		if (rc == 0)
+			break;
+		msleep(1);
+	}
+	return rc;
+}
+
+static int get_scom(struct scom_device *scom, uint64_t *value,
+		    uint64_t addr)
+{
+	uint32_t status, dummy = -1;
+	int rc, retries;
+
+	for (retries = 0; retries < SCOM_MAX_RETRIES; retries++) {
+		rc = raw_get_scom(scom, value, addr, &status);
+		if (rc) {
+			/* Try resetting the bridge if FSI fails */
+			if (rc != -ENODEV && retries == 0) {
+				fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG,
+						 &dummy, sizeof(uint32_t));
+				rc = -EBUSY;
+			} else
+				return rc;
+		} else
+			rc = handle_fsi2pib_status(scom, status);
+		if (rc && rc != -EBUSY)
+			break;
+		if (rc == 0) {
+			rc = handle_pib_status(scom,
+					       (status & SCOM_STATUS_PIB_RESP_MASK)
+					       >> SCOM_STATUS_PIB_RESP_SHIFT);
+			if (rc && rc != -EBUSY)
+				break;
+		}
+		if (rc == 0)
+			break;
+		msleep(1);
+	}
 	return rc;
 }
 
 static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
 			 loff_t *offset)
 {
-	int rc;
 	struct miscdevice *mdev =
 				(struct miscdevice *)filep->private_data;
 	struct scom_device *scom = to_scom_dev(mdev);
 	struct device *dev = &scom->fsi_dev->dev;
 	uint64_t val;
+	int rc;
 
 	if (len != sizeof(uint64_t))
 		return -EINVAL;
 
+	mutex_lock(&scom->lock);
 	rc = get_scom(scom, &val, *offset);
+	mutex_unlock(&scom->lock);
 	if (rc) {
 		dev_dbg(dev, "get_scom fail:%d\n", rc);
 		return rc;
@@ -169,7 +417,9 @@ static ssize_t scom_write(struct file *filep, const char __user *buf,
 		return -EINVAL;
 	}
 
+	mutex_lock(&scom->lock);
 	rc = put_scom(scom, val, *offset);
+	mutex_unlock(&scom->lock);
 	if (rc) {
 		dev_dbg(dev, "put_scom failed with:%d\n", rc);
 		return rc;
@@ -193,11 +443,125 @@ static loff_t scom_llseek(struct file *file, loff_t offset, int whence)
 	return offset;
 }
 
+static void raw_convert_status(struct scom_access *acc, uint32_t status)
+{
+	acc->pib_status = (status & SCOM_STATUS_PIB_RESP_MASK) >>
+		SCOM_STATUS_PIB_RESP_SHIFT;
+	acc->intf_errors = 0;
+
+	if (status & SCOM_STATUS_PROTECTION)
+		acc->intf_errors |= SCOM_INTF_ERR_PROTECTION;
+	else if (status & SCOM_STATUS_PARITY)
+		acc->intf_errors |= SCOM_INTF_ERR_PARITY;
+	else if (status & SCOM_STATUS_PIB_ABORT)
+		acc->intf_errors |= SCOM_INTF_ERR_ABORT;
+	else if (status & SCOM_STATUS_ERR_SUMMARY)
+		acc->intf_errors |= SCOM_INTF_ERR_UNKNOWN;
+}
+
+static int scom_raw_read(struct scom_device *scom, void __user *argp)
+{
+	struct scom_access acc;
+	uint32_t status;
+	int rc;
+
+	if (copy_from_user(&acc, argp, sizeof(struct scom_access)))
+		return -EFAULT;
+
+	rc = raw_get_scom(scom, &acc.data, acc.addr, &status);
+	if (rc)
+		return rc;
+	raw_convert_status(&acc, status);
+	if (copy_to_user(argp, &acc, sizeof(struct scom_access)))
+		return -EFAULT;
+	return 0;
+}
+
+static int scom_raw_write(struct scom_device *scom, void __user *argp)
+{
+	u64 prev_data, mask, data;
+	struct scom_access acc;
+	uint32_t status;
+	int rc;
+
+	if (copy_from_user(&acc, argp, sizeof(struct scom_access)))
+		return -EFAULT;
+
+	if (acc.mask) {
+		rc = raw_get_scom(scom, &prev_data, acc.addr, &status);
+		if (rc)
+			return rc;
+		if (status & SCOM_STATUS_ANY_ERR)
+			goto fail;
+		mask = acc.mask;
+	} else {
+		prev_data = mask = -1ull;
+	}
+	data = (prev_data & ~mask) | (acc.data & mask);
+	rc = raw_put_scom(scom, data, acc.addr, &status);
+	if (rc)
+		return rc;
+ fail:
+	raw_convert_status(&acc, status);
+	if (copy_to_user(argp, &acc, sizeof(struct scom_access)))
+		return -EFAULT;
+	return 0;
+}
+
+static int scom_reset(struct scom_device *scom, void __user *argp)
+{
+	uint32_t flags, dummy = -1;
+	int rc = 0;
+
+	if (get_user(flags, (__u32 __user *)argp))
+		return -EFAULT;
+	if (flags & SCOM_RESET_PIB)
+		rc = fsi_device_write(scom->fsi_dev, SCOM_PIB_RESET_REG, &dummy,
+				      sizeof(uint32_t));
+	if (!rc && (flags & (SCOM_RESET_PIB | SCOM_RESET_INTF)))
+		rc = fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
+				      sizeof(uint32_t));
+	return rc;
+}
+
+static int scom_check(struct scom_device *scom, void __user *argp)
+{
+	/* Still need to find out how to get "protected" */
+	return put_user(SCOM_CHECK_SUPPORTED, (__u32 __user *)argp);
+}
+
+static long scom_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct miscdevice *mdev = file->private_data;
+	struct scom_device *scom = to_scom_dev(mdev);
+	void __user *argp = (void __user *)arg;
+	int rc = -ENOTTY;
+
+	mutex_lock(&scom->lock);
+	switch(cmd) {
+	case FSI_SCOM_CHECK:
+		rc = scom_check(scom, argp);
+		break;
+	case FSI_SCOM_READ:
+		rc = scom_raw_read(scom, argp);
+		break;
+	case FSI_SCOM_WRITE:
+		rc = scom_raw_write(scom, argp);
+		break;
+	case FSI_SCOM_RESET:
+		rc = scom_reset(scom, argp);
+		break;
+	}
+	mutex_unlock(&scom->lock);
+	return rc;
+}
+
 static const struct file_operations scom_fops = {
-	.owner	= THIS_MODULE,
-	.llseek	= scom_llseek,
-	.read	= scom_read,
-	.write	= scom_write,
+	.owner		= THIS_MODULE,
+	.llseek		= scom_llseek,
+	.read		= scom_read,
+	.write		= scom_write,
+	.unlocked_ioctl	= scom_ioctl,
 };
 
 static int scom_probe(struct device *dev)
diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
new file mode 100644
index 000000000000..6008d93f2e48
--- /dev/null
+++ b/include/uapi/linux/fsi.h
@@ -0,0 +1,56 @@
+#ifndef _UAPI_LINUX_FSI_H
+#define _UAPI_LINUX_FSI_H
+
+#include <linux/ioctl.h>
+
+/*
+ * /dev/scom "raw" ioctl interface
+ *
+ * The driver supports a high level "read/write" interface which
+ * handles retries and converts the status to Linux error codes,
+ * however low level tools an debugger need to access the "raw"
+ * HW status information and interpret it themselves, so this
+ * ioctl interface is also provided for their use case.
+ */
+
+/* Structure for SCOM read/write */
+struct scom_access {
+	__u64	addr;		/* SCOM address, supports indirect */
+	__u64	data;		/* SCOM data (in for write, out for read) */
+	__u64	mask;		/* Data mask for writes */
+	__u32	intf_errors;	/* Interface error flags */
+#define SCOM_INTF_ERR_PARITY		0x00000001 /* Parity error */
+#define SCOM_INTF_ERR_PROTECTION	0x00000002 /* Blocked by secure boot */
+#define SCOM_INTF_ERR_ABORT		0x00000004 /* PIB reset during access */
+#define SCOM_INTF_ERR_UNKNOWN		0x80000000 /* Unknown error */
+	/*
+	 * Note: Any other bit set in intf_errors need to be considered as an
+	 * error. Future implementations may define new error conditions. The
+	 * pib_status below is only valid if intf_errors is 0.
+	 */
+	__u8	pib_status;	/* 3-bit PIB status */
+#define SCOM_PIB_SUCCESS	0	/* Access successful */
+#define SCOM_PIB_BLOCKED	1	/* PIB blocked, pls retry */
+#define SCOM_PIB_OFFLINE	2	/* Chiplet offline */
+#define SCOM_PIB_PARTIAL	3	/* Partial good */
+#define SCOM_PIB_BAD_ADDR	4	/* Invalid address */
+#define SCOM_PIB_CLK_ERR	5	/* Clock error */
+#define SCOM_PIB_PARITY_ERR	6	/* Parity error on the PIB bus */
+#define SCOM_PIB_TIMEOUT	7	/* Bus timeout */
+	__u8	pad;
+};
+
+/* Flags for SCOM check */
+#define SCOM_CHECK_SUPPORTED	0x00000001	/* Interface supported */
+#define SCOM_CHECK_PROTECTED	0x00000002	/* Interface blocked by secure boot */
+
+/* Flags for SCOM reset */
+#define SCOM_RESET_INTF		0x00000001	/* Reset interface */
+#define SCOM_RESET_PIB		0x00000002	/* Reset PIB */
+
+#define FSI_SCOM_CHECK	_IOR('s', 0x00, __u32)
+#define FSI_SCOM_READ	_IOWR('s', 0x01, struct scom_access)
+#define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
+#define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
+
+#endif /* _UAPI_LINUX_FSI_H */
-- 
2.17.0

