Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB45C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E820852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494E820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGXG1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:27:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:54467 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388134AbeGXG1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:27:37 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6O55JLK028169;
        Tue, 24 Jul 2018 00:05:34 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/5] fsi: Add cfam char devices
Date:   Tue, 24 Jul 2018 15:05:18 +1000
Message-Id: <20180724050519.31920-5-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724050519.31920-1-benh@kernel.crashing.org>
References: <20180724050519.31920-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This aims to deprecate the "raw" sysfs file used for directly
accessing the CFAM and instead use a char device like the
other sub drivers.

Since it reworks the slave creation code and adds a cfam device
type, we also use the opportunity to convert the attributes
to attribute groups and add a couple more.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-core.c | 264 +++++++++++++++++++++++++++++++++--------
 1 file changed, 213 insertions(+), 51 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index faa1760a5a40..dea5bd48acc5 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -11,6 +11,11 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
+ *
+ * TODO:
+ *  - Rework topology
+ *  - s/chip_id/chip_loc
+ *  - s/cfam/chip (cfam_id -> chip_id etc...)
  */
 
 #include <linux/crc4.h>
@@ -21,6 +26,9 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 #include "fsi-master.h"
 
@@ -78,8 +86,11 @@ static DEFINE_IDA(master_ida);
 struct fsi_slave {
 	struct device		dev;
 	struct fsi_master	*master;
-	int			id;
-	int			link;
+	struct cdev		cdev;
+	int			cdev_idx;
+	int			id;	/* FSI address */
+	int			link;	/* FSI link# */
+	u32			cfam_id;
 	int			chip_id;
 	uint32_t		size;	/* size of slave address space */
 	u8			t_send_delay;
@@ -607,29 +618,6 @@ static const struct bin_attribute fsi_slave_raw_attr = {
 	.write = fsi_slave_sysfs_raw_write,
 };
 
-static ssize_t fsi_slave_sysfs_term_write(struct file *file,
-		struct kobject *kobj, struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
-{
-	struct fsi_slave *slave = to_fsi_slave(kobj_to_dev(kobj));
-	struct fsi_master *master = slave->master;
-
-	if (!master->term)
-		return -ENODEV;
-
-	master->term(master, slave->link, slave->id);
-	return count;
-}
-
-static const struct bin_attribute fsi_slave_term_attr = {
-	.attr = {
-		.name = "term",
-		.mode = 0200,
-	},
-	.size = 0,
-	.write = fsi_slave_sysfs_term_write,
-};
-
 static void fsi_slave_release(struct device *dev)
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
@@ -682,6 +670,127 @@ static struct device_node *fsi_slave_find_of_node(struct fsi_master *master,
 	return NULL;
 }
 
+static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
+			 loff_t *offset)
+{
+	struct fsi_slave *slave = filep->private_data;
+	size_t total_len, read_len;
+	loff_t off = *offset;
+	ssize_t rc;
+
+	if (off < 0)
+		return -EINVAL;
+
+	if (off > 0xffffffff || count > 0xffffffff || off + count > 0xffffffff)
+		return -EINVAL;
+
+	for (total_len = 0; total_len < count; total_len += read_len) {
+		__be32 data;
+
+		read_len = min_t(size_t, count, 4);
+		read_len -= off & 0x3;
+
+		rc = fsi_slave_read(slave, off, &data, read_len);
+		if (rc)
+			goto fail;
+		rc = copy_to_user(buf + total_len, &data, read_len);
+		if (rc) {
+			rc = -EFAULT;
+			goto fail;
+		}
+		off += read_len;
+	}
+	rc = count;
+ fail:
+	*offset = off;
+	return count;
+}
+
+static ssize_t cfam_write(struct file *filep, const char __user *buf,
+			  size_t count, loff_t *offset)
+{
+	struct fsi_slave *slave = filep->private_data;
+	size_t total_len, write_len;
+	loff_t off = *offset;
+	ssize_t rc;
+
+
+	if (off < 0)
+		return -EINVAL;
+
+	if (off > 0xffffffff || count > 0xffffffff || off + count > 0xffffffff)
+		return -EINVAL;
+
+	for (total_len = 0; total_len < count; total_len += write_len) {
+		__be32 data;
+
+		write_len = min_t(size_t, count, 4);
+		write_len -= off & 0x3;
+
+		rc = copy_from_user(&data, buf + total_len, write_len);
+		if (rc) {
+			rc = -EFAULT;
+			goto fail;
+		}
+		rc = fsi_slave_write(slave, off, &data, write_len);
+		if (rc)
+			goto fail;
+		off += write_len;
+	}
+	rc = count;
+ fail:
+	*offset = off;
+	return count;
+}
+
+static loff_t cfam_llseek(struct file *file, loff_t offset, int whence)
+{
+	switch (whence) {
+	case SEEK_CUR:
+		break;
+	case SEEK_SET:
+		file->f_pos = offset;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return offset;
+}
+
+static int cfam_open(struct inode *inode, struct file *file)
+{
+	struct fsi_slave *slave = container_of(inode->i_cdev, struct fsi_slave, cdev);
+
+	file->private_data = slave;
+
+	return 0;
+}
+
+static const struct file_operations cfam_fops = {
+	.owner		= THIS_MODULE,
+	.open		= cfam_open,
+	.llseek		= cfam_llseek,
+	.read		= cfam_read,
+	.write		= cfam_write,
+};
+
+static ssize_t send_term_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+	struct fsi_master *master = slave->master;
+
+	if (!master->term)
+		return -ENODEV;
+
+	master->term(master, slave->link, slave->id);
+	return count;
+}
+
+static DEVICE_ATTR_WO(send_term);
+
 static ssize_t slave_send_echo_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -737,6 +846,52 @@ static ssize_t chip_id_show(struct device *dev,
 
 static DEVICE_ATTR_RO(chip_id);
 
+static ssize_t cfam_id_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+
+	return sprintf(buf, "0x%x\n", slave->cfam_id);
+}
+
+static DEVICE_ATTR_RO(cfam_id);
+
+static struct attribute *cfam_attr[] = {
+	&dev_attr_send_echo_delays.attr,
+	&dev_attr_chip_id.attr,
+	&dev_attr_cfam_id.attr,
+	&dev_attr_send_term.attr,
+	NULL,
+};
+
+static const struct attribute_group cfam_attr_group = {
+	.attrs = cfam_attr,
+};
+
+static const struct attribute_group *cfam_attr_groups[] = {
+	&cfam_attr_group,
+	NULL,
+};
+
+static char *cfam_devnode(struct device *dev, umode_t *mode,
+			  kuid_t *uid, kgid_t *gid)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+
+#ifdef CONFIG_FSI_NEW_DEV_NODE
+	return kasprintf(GFP_KERNEL, "fsi/cfam%d", slave->cdev_idx);
+#else
+	return kasprintf(GFP_KERNEL, "cfam%d", slave->cdev_idx);
+#endif
+}
+
+static const struct device_type cfam_type = {
+	.name = "cfam",
+	.devnode = cfam_devnode,
+	.groups = cfam_attr_groups
+};
+
 static char *fsi_cdev_devnode(struct device *dev, umode_t *mode,
 			      kuid_t *uid, kgid_t *gid)
 {
@@ -808,7 +963,7 @@ EXPORT_SYMBOL_GPL(fsi_free_minor);
 
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
-	uint32_t chip_id;
+	uint32_t cfam_id;
 	struct fsi_slave *slave;
 	uint8_t crc;
 	__be32 data, llmode;
@@ -826,17 +981,17 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 				link, id, rc);
 		return -ENODEV;
 	}
-	chip_id = be32_to_cpu(data);
+	cfam_id = be32_to_cpu(data);
 
-	crc = crc4(0, chip_id, 32);
+	crc = crc4(0, cfam_id, 32);
 	if (crc) {
-		dev_warn(&master->dev, "slave %02x:%02x invalid chip id CRC!\n",
+		dev_warn(&master->dev, "slave %02x:%02x invalid cfam id CRC!\n",
 				link, id);
 		return -EIO;
 	}
 
 	dev_dbg(&master->dev, "fsi: found chip %08x at %02x:%02x:%02x\n",
-			chip_id, master->idx, link, id);
+			cfam_id, master->idx, link, id);
 
 	/* If we're behind a master that doesn't provide a self-running bus
 	 * clock, put the slave into async mode
@@ -859,10 +1014,14 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	if (!slave)
 		return -ENOMEM;
 
-	slave->master = master;
+	dev_set_name(&slave->dev, "slave@%02x:%02x", link, id);
+	slave->dev.type = &cfam_type;
 	slave->dev.parent = &master->dev;
 	slave->dev.of_node = fsi_slave_find_of_node(master, link, id);
 	slave->dev.release = fsi_slave_release;
+	device_initialize(&slave->dev);
+	slave->cfam_id = cfam_id;
+	slave->master = master;
 	slave->link = link;
 	slave->id = id;
 	slave->size = FSI_SLAVE_SIZE_23b;
@@ -877,6 +1036,21 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 			slave->chip_id = prop;
 
 	}
+
+	/* Allocate a minor in the FSI space */
+	rc = __fsi_get_new_minor(slave, fsi_dev_cfam, &slave->dev.devt,
+				 &slave->cdev_idx);
+	if (rc)
+		goto err_free;
+
+	/* Create chardev for userspace access */
+	cdev_init(&slave->cdev, &cfam_fops);
+	rc = cdev_device_add(&slave->cdev, &slave->dev);
+	if (rc) {
+		dev_err(&slave->dev, "Error %d creating slave device\n", rc);
+		goto err_free;
+	}
+
 	rc = fsi_slave_set_smode(slave);
 	if (rc) {
 		dev_warn(&master->dev,
@@ -890,30 +1064,11 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 				    slave->t_send_delay,
 				    slave->t_echo_delay);
 
-	dev_set_name(&slave->dev, "slave@%02x:%02x", link, id);
-	rc = device_register(&slave->dev);
-	if (rc < 0) {
-		dev_warn(&master->dev, "failed to create slave device: %d\n",
-				rc);
-		put_device(&slave->dev);
-		return rc;
-	}
-
+	/* Legacy raw file -> to be removed */
 	rc = device_create_bin_file(&slave->dev, &fsi_slave_raw_attr);
 	if (rc)
 		dev_warn(&slave->dev, "failed to create raw attr: %d\n", rc);
 
-	rc = device_create_bin_file(&slave->dev, &fsi_slave_term_attr);
-	if (rc)
-		dev_warn(&slave->dev, "failed to create term attr: %d\n", rc);
-
-	rc = device_create_file(&slave->dev, &dev_attr_send_echo_delays);
-	if (rc)
-		dev_warn(&slave->dev, "failed to create delay attr: %d\n", rc);
-
-	rc = device_create_file(&slave->dev, &dev_attr_chip_id);
-	if (rc)
-		dev_warn(&slave->dev, "failed to create chip id: %d\n", rc);
 
 	rc = fsi_slave_scan(slave);
 	if (rc)
@@ -921,6 +1076,10 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 				rc);
 
 	return rc;
+
+ err_free:
+	put_device(&slave->dev);
+	return rc;
 }
 
 /* FSI master support */
@@ -1029,7 +1188,10 @@ static int fsi_slave_remove_device(struct device *dev, void *arg)
 
 static int fsi_master_remove_slave(struct device *dev, void *arg)
 {
+	struct fsi_slave *slave = to_fsi_slave(dev);
+
 	device_for_each_child(dev, NULL, fsi_slave_remove_device);
+	cdev_device_del(&slave->cdev, &slave->dev);
 	put_device(dev);
 	return 0;
 }
-- 
2.17.1

