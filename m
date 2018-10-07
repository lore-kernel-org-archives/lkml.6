Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD9C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910FA2087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910FA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeJHAM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:12:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727707AbeJHAM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:12:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58CA7AE39;
        Sun,  7 Oct 2018 17:05:02 +0000 (UTC)
Date:   Sun, 7 Oct 2018 19:05:00 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] eeprom: New ee1004 driver for DDR4 memory
Message-ID: <20181007190500.4433779e@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EEPROMs which hold the SPD data on DDR4 memory modules are no
longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
which use only 1 I2C address for data access. You need to switch
between the lower page and the upper page of data by sending commands
on the SMBus.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
It was suggested that this driver could maybe use regmap, however I'm
not familiar with that and do not have the time to look into it. The
driver is functional, so please include it as is, and whoever cares and
has the knowledge can convert it to use regmap later. Thanks.

 drivers/misc/eeprom/Kconfig  |   11 +
 drivers/misc/eeprom/Makefile |    1 
 drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-4.19-rc6/drivers/misc/eeprom/ee1004.c	2018-10-06 17:15:31.616623775 +0200
@@ -0,0 +1,281 @@
+/*
+ * ee1004 - driver for DDR4 SPD EEPROMs
+ *
+ * Copyright (C) 2017 Jean Delvare
+ *
+ * Based on the at24 driver:
+ * Copyright (C) 2005-2007 David Brownell
+ * Copyright (C) 2008 Wolfram Sang, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+/*
+ * DDR4 memory modules use special EEPROMs following the Jedec EE1004
+ * specification. These are 512-byte EEPROMs using a single I2C address
+ * in the 0x50-0x57 range for data. One of two 256-byte page is selected
+ * by writing a command to I2C address 0x36 or 0x37 on the same I2C bus.
+ *
+ * Therefore we need to request these 2 additional addresses, and serialize
+ * access to all such EEPROMs with a single mutex.
+ *
+ * We assume it is safe to read up to 32 bytes at once from these EEPROMs.
+ * We use SMBus access even if I2C is available, these EEPROMs are small
+ * enough, and reading from them infrequent enough, that we favor simplicity
+ * over performance.
+ */
+
+#define EE1004_ADDR_SET_PAGE		0x36
+#define EE1004_EEPROM_SIZE		512
+#define EE1004_PAGE_SIZE		256
+#define EE1004_PAGE_SHIFT		8
+
+/*
+ * Mutex protects ee1004_set_page and ee1004_dev_count, and must be held
+ * from page selection to end of read.
+ */
+static DEFINE_MUTEX(ee1004_bus_lock);
+static struct i2c_client *ee1004_set_page[2];
+static unsigned int ee1004_dev_count;
+static int ee1004_current_page;
+
+static const struct i2c_device_id ee1004_ids[] = {
+	{ "ee1004", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ee1004_ids);
+
+/*-------------------------------------------------------------------------*/
+
+static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
+				  unsigned int offset, size_t count)
+{
+	int status;
+
+	if (count > I2C_SMBUS_BLOCK_MAX)
+		count = I2C_SMBUS_BLOCK_MAX;
+	/* Can't cross page boundaries */
+	if (unlikely(offset + count > EE1004_PAGE_SIZE))
+		count = EE1004_PAGE_SIZE - offset;
+
+	status = i2c_smbus_read_i2c_block_data_or_emulated(client, offset,
+							   count, buf);
+	dev_dbg(&client->dev, "read %zu@%d --> %d\n", count, offset, status);
+
+	return status;
+}
+
+static ssize_t ee1004_read(struct file *filp, struct kobject *kobj,
+			   struct bin_attribute *bin_attr,
+			   char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+	size_t requested = count;
+	int page;
+
+	if (unlikely(!count))
+		return count;
+
+	page = off >> EE1004_PAGE_SHIFT;
+	if (unlikely(page > 1))
+		return 0;
+	off &= (1 << EE1004_PAGE_SHIFT) - 1;
+
+	/*
+	 * Read data from chip, protecting against concurrent access to
+	 * other EE1004 SPD EEPROMs on the same adapter.
+	 */
+	mutex_lock(&ee1004_bus_lock);
+
+	while (count) {
+		int status;
+
+		/* Select page */
+		if (page != ee1004_current_page) {
+			/* Data is ignored */
+			status = i2c_smbus_write_byte(ee1004_set_page[page],
+						      0x00);
+			if (status < 0) {
+				dev_err(dev, "Failed to select page %d (%d)\n",
+					page, status);
+				mutex_unlock(&ee1004_bus_lock);
+				return status;
+			}
+			dev_dbg(dev, "Selected page %d\n", page);
+			ee1004_current_page = page;
+		}
+
+		status = ee1004_eeprom_read(client, buf, off, count);
+		if (status < 0) {
+			mutex_unlock(&ee1004_bus_lock);
+			return status;
+		}
+		buf += status;
+		off += status;
+		count -= status;
+
+		if (off == EE1004_PAGE_SIZE) {
+			page++;
+			off = 0;
+		}
+	}
+
+	mutex_unlock(&ee1004_bus_lock);
+
+	return requested;
+}
+
+static const struct bin_attribute eeprom_attr = {
+	.attr = {
+		.name = "eeprom",
+		.mode = 0444,
+	},
+	.size = EE1004_EEPROM_SIZE,
+	.read = ee1004_read,
+};
+
+static int ee1004_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int err, cnr = 0;
+	const char *slow = NULL;
+
+	/* Make sure we can operate on this adapter */
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE |
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		if (i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+			slow = "word";
+		else if (i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE |
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
+			slow = "byte";
+		else
+			return -EPFNOSUPPORT;
+	}
+
+	/* Use 2 dummy devices for page select command */
+	mutex_lock(&ee1004_bus_lock);
+	if (++ee1004_dev_count == 1) {
+		for (cnr = 0; cnr < 2; cnr++) {
+			ee1004_set_page[cnr] = i2c_new_dummy(client->adapter,
+						EE1004_ADDR_SET_PAGE + cnr);
+			if (!ee1004_set_page[cnr]) {
+				dev_err(&client->dev,
+					"address 0x%02x unavailable\n",
+					EE1004_ADDR_SET_PAGE + cnr);
+				err = -EADDRINUSE;
+				goto err_clients;
+			}
+		}
+	} else if (i2c_adapter_id(client->adapter) !=
+		   i2c_adapter_id(ee1004_set_page[0]->adapter)) {
+		dev_err(&client->dev,
+			"Driver only supports devices on a single I2C bus\n");
+		err = -EOPNOTSUPP;
+		goto err_clients;
+	}
+
+	/* Remember current page to avoid unneeded page select */
+	err = i2c_smbus_read_byte(ee1004_set_page[0]);
+	if (err == -ENXIO) {
+		/* Nack means page 1 is selected */
+		ee1004_current_page = 1;
+	} else if (err < 0) {
+		/* Anything else is a real error, bail out */
+		goto err_clients;
+	} else {
+		/* Ack means page 0 is selected, returned value meaningless */
+		ee1004_current_page = 0;
+	}
+	dev_dbg(&client->dev, "Currently selected page: %d\n",
+		ee1004_current_page);
+	mutex_unlock(&ee1004_bus_lock);
+
+	/* Create the sysfs eeprom file */
+	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
+	if (err)
+		goto err_clients_lock;
+
+	dev_info(&client->dev,
+		 "%u byte EE1004-compliant SPD EEPROM, read-only\n",
+		 EE1004_EEPROM_SIZE);
+	if (slow)
+		dev_notice(&client->dev,
+			   "Falling back to %s reads, performance will suffer\n",
+			   slow);
+
+	return 0;
+
+ err_clients_lock:
+	mutex_lock(&ee1004_bus_lock);
+ err_clients:
+	if (--ee1004_dev_count == 0) {
+		for (cnr--; cnr >= 0; cnr--) {
+			i2c_unregister_device(ee1004_set_page[cnr]);
+			ee1004_set_page[cnr] = NULL;
+		}
+	}
+	mutex_unlock(&ee1004_bus_lock);
+
+	return err;
+}
+
+static int ee1004_remove(struct i2c_client *client)
+{
+	int i;
+
+	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
+
+	/* Remove page select clients if this is the last device */
+	mutex_lock(&ee1004_bus_lock);
+	if (--ee1004_dev_count == 0) {
+		for (i = 0; i < 2; i++) {
+			i2c_unregister_device(ee1004_set_page[i]);
+			ee1004_set_page[i] = NULL;
+		}
+	}
+	mutex_unlock(&ee1004_bus_lock);
+
+	return 0;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static struct i2c_driver ee1004_driver = {
+	.driver = {
+		.name = "ee1004",
+	},
+	.probe = ee1004_probe,
+	.remove = ee1004_remove,
+	.id_table = ee1004_ids,
+};
+
+static int __init ee1004_init(void)
+{
+	return i2c_add_driver(&ee1004_driver);
+}
+module_init(ee1004_init);
+
+static void __exit ee1004_exit(void)
+{
+	i2c_del_driver(&ee1004_driver);
+}
+module_exit(ee1004_exit);
+
+MODULE_DESCRIPTION("Driver for EE1004-compliant DDR4 SPD EEPROMs");
+MODULE_AUTHOR("Jean Delvare");
+MODULE_LICENSE("GPL");
--- linux-4.19-rc6.orig/drivers/misc/eeprom/Kconfig	2018-10-06 13:49:51.182039691 +0200
+++ linux-4.19-rc6/drivers/misc/eeprom/Kconfig	2018-10-06 17:15:31.618623804 +0200
@@ -111,4 +111,15 @@ config EEPROM_IDT_89HPESX
 	  This driver can also be built as a module. If so, the module
 	  will be called idt_89hpesx.
 
+config EEPROM_EE1004
+	tristate "SPD EEPROMs on DDR4 memory modules"
+	depends on I2C && SYSFS
+	help
+	  Enable this driver to get read support to SPD EEPROMs following
+	  the JEDEC EE1004 standard. These are typically found on DDR4
+	  SDRAM memory modules.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ee1004.
+
 endmenu
--- linux-4.19-rc6.orig/drivers/misc/eeprom/Makefile	2018-10-06 13:49:51.182039691 +0200
+++ linux-4.19-rc6/drivers/misc/eeprom/Makefile	2018-10-06 17:15:31.618623804 +0200
@@ -7,3 +7,4 @@ obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93c
 obj-$(CONFIG_EEPROM_93XX46)	+= eeprom_93xx46.o
 obj-$(CONFIG_EEPROM_DIGSY_MTC_CFG) += digsy_mtc_eeprom.o
 obj-$(CONFIG_EEPROM_IDT_89HPESX) += idt_89hpesx.o
+obj-$(CONFIG_EEPROM_EE1004)	+= ee1004.o


-- 
Jean Delvare
SUSE L3 Support
