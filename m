Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217CDC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9631A240B8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9631A240B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933897AbeFVKwo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:52:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933196AbeFVKtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:49:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2FF9220DC1; Fri, 22 Jun 2018 12:49:44 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4D9D9206FF;
        Fri, 22 Jun 2018 12:49:33 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v5 01/10] i3c: Add core I3C infrastructure
Date:   Fri, 22 Jun 2018 12:49:21 +0200
Message-Id: <20180622104930.32050-2-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180622104930.32050-1-boris.brezillon@bootlin.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core infrastructure to support I3C in Linux and document it.

This infrastructure is not complete yet and will be extended over
time.

There are a few design choices that are worth mentioning because they
impact the way I3C device drivers can interact with their devices:

- all functions used to send I3C/I2C frames must be called in
  non-atomic context. Mainly done this way to ease implementation, but
  this is still open to discussion. Please let me know if you think
  it's worth considering an asynchronous model here
- the bus element is a separate object and is not implicitly described
  by the master (as done in I2C). The reason is that I want to be able
  to handle multiple master connected to the same bus and visible to
  Linux.
  In this situation, we should only have one instance of the device and
  not one per master, and sharing the bus object would be part of the
  solution to gracefully handle this case.
  I'm not sure we will ever need to deal with multiple masters
  controlling the same bus and exposed under Linux, but separating the
  bus and master concept is pretty easy, hence the decision to do it
  like that.
  The other benefit of separating the bus and master concepts is that
  master devices appear under the bus directory in sysfs.
- I2C backward compatibility has been designed to be transparent to I2C
  drivers and the I2C subsystem. The I3C master just registers an I2C
  adapter which creates a new I2C bus. I'd say that, from a
  representation PoV it's not ideal because what should appear as a
  single I3C bus exposing I3C and I2C devices here appears as 2
  different busses connected to each other through the parenting (the
  I3C master is the parent of the I2C and I3C busses).
  On the other hand, I don't see a better solution if we want something
  that is not invasive.

Missing features in this preliminary version:
- I3C HDR modes are not supported
- no support for multi-master and the associated concepts (mastership
  handover, support for secondary masters, ...)
- I2C devices can only be described using DT because this is the only
  use case I have. However, the framework can easily be extended with
  ACPI and board info support
- I3C slave framework. This has been completely omitted, but shouldn't
  have a huge impact on the I3C framework because I3C slaves don't see
  the whole bus, it's only about handling master requests and generating
  IBIs. Some of the struct, constant and enum definitions could be
  shared, but most of the I3C slave framework logic will be different

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v5:
- Rename the address sysfs entry into dynamic_address to clarify things
- Document that we expect buffers passed to i3c_device_do_priv_xfers()
  to be DMA-able
- Fix DEFSLVS CCC command
- s/2017/2018/ in copyright headers
- Fix SPDX header in internals.h
- Fix coding style issues

Changes in v4:
- none

Changes in v3:
- Fix locking issues
- Explicitly include a bunch of headers (reported by Randy Dunlap)
- Rename {i2c,i3c}-scl-frequency DT prop into {i2c,i3c}-scl-hz
- Do not use BIT() macro in mod_devicetable.h
- Fix typos
- Fix/enhance some kernel doc headers
- Rework the bus initialization code to simplify master drivers
- Assign dynamic address with SETDASA if the device has a static
  address and the DT has a valid assigned-address property
- Rework the LVR extraction in DT parsing code
- Add code to detect when a device is re-attached to the bus after
  losing its dynamic address. In this case we know try to re-assign the
  old address, and most importantly, the I3C device driver sees the same
  device instance, not a new one
- Add an ->i2c_funcs() hook to let the master declare which I2C features
  it supports
- Unexport a few functions
- Remove support for HDR mode since we have no real user yet

Changes in v2:
- Fix a bunch of mistake I made with the device model (pointed by GKH)
- Move the documentation out of this commit (pointed by GKH)
- only source drivers/i3c/master/Kconfig when CONFIG_I3C is enabled
  (pointed by GKH)
- Add IBI infrastructure
- Add helpers to ease support for Hot Join (most of the logic is
  delegated to I3C controller drivers)
- move the doc out of this commit to improve readability
- Fix a few bugs in device probing/remove (detected after trying to
  load/unload modules in various orders)
- Add a module_i3c_i2c_driver() macro to ease integration of drivers
  for devices that support both I3C and I2C mode
---
 drivers/Kconfig                 |    2 +
 drivers/Makefile                |    2 +-
 drivers/i3c/Kconfig             |   24 +
 drivers/i3c/Makefile            |    4 +
 drivers/i3c/core.c              |  620 ++++++++++++++
 drivers/i3c/device.c            |  294 +++++++
 drivers/i3c/internals.h         |   28 +
 drivers/i3c/master.c            | 1722 +++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig      |    0
 drivers/i3c/master/Makefile     |    0
 include/linux/i3c/ccc.h         |  382 +++++++++
 include/linux/i3c/device.h      |  307 +++++++
 include/linux/i3c/master.h      |  587 +++++++++++++
 include/linux/mod_devicetable.h |   17 +
 14 files changed, 3988 insertions(+), 1 deletion(-)
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/core.c
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 95b9ccc08165..80f6aebc896f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -55,6 +55,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/spi/Kconfig"
 
 source "drivers/spmi/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..999239dc29d4 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -111,7 +111,7 @@ obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
-obj-y				+= i2c/ media/
+obj-y				+= i2c/ i3c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-y				+= ptp/
 obj-$(CONFIG_W1)		+= w1/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 000000000000..30a441506f61
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
+	  This I3C support can also be built as a module.  If so, the module
+	  will be called i3c.
+
+if I3C
+source "drivers/i3c/master/Kconfig"
+endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 000000000000..3b6d1502d6e6
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+i3c-y				:= core.o device.o master.o
+obj-$(CONFIG_I3C)		+= i3c.o
+obj-$(CONFIG_I3C)		+= master/
diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
new file mode 100644
index 000000000000..8c0b71f45700
--- /dev/null
+++ b/drivers/i3c/core.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+
+#include "internals.h"
+
+static DEFINE_IDR(i3c_bus_idr);
+static DEFINE_MUTEX(i3c_core_lock);
+
+/**
+ * i3c_bus_maintenance_lock - Lock the bus for a maintenance operation
+ * @bus: I3C bus to take the lock on
+ *
+ * This function takes the bus lock so that no other operations can occur on
+ * the bus. This is needed for all kind of bus maintenance operation, like
+ * - enabling/disabling slave events
+ * - re-triggering DAA
+ * - changing the dynamic address of a device
+ * - relinquishing mastership
+ * - ...
+ *
+ * The reason for this kind of locking is that we don't want drivers and core
+ * logic to rely on I3C device information that could be changed behind their
+ * back.
+ */
+void i3c_bus_maintenance_lock(struct i3c_bus *bus)
+{
+	down_write(&bus->lock);
+}
+EXPORT_SYMBOL_GPL(i3c_bus_maintenance_lock);
+
+/**
+ * i3c_bus_maintenance_unlock - Release the bus lock after a maintenance
+ *			      operation
+ * @bus: I3C bus to release the lock on
+ *
+ * Should be called when the bus maintenance operation is done. See
+ * i3c_bus_maintenance_lock() for more details on what these maintenance
+ * operations are.
+ */
+void i3c_bus_maintenance_unlock(struct i3c_bus *bus)
+{
+	up_write(&bus->lock);
+}
+EXPORT_SYMBOL_GPL(i3c_bus_maintenance_unlock);
+
+/**
+ * i3c_bus_normaluse_lock - Lock the bus for a normal operation
+ * @bus: I3C bus to take the lock on
+ *
+ * This function takes the bus lock for any operation that is not a maintenance
+ * operation (see i3c_bus_maintenance_lock() for a non-exhaustive list of
+ * maintenance operations). Basically all communications with I3C devices are
+ * normal operations (HDR, SDR transfers or CCC commands that do not change bus
+ * state or I3C dynamic address).
+ *
+ * Note that this lock is not guaranteeing serialization of normal operations.
+ * In other words, transfer requests passed to the I3C master can be submitted
+ * in parallel and I3C master drivers have to use their own locking to make
+ * sure two different communications are not inter-mixed, or access to the
+ * output/input queue is not done while the engine is busy.
+ */
+void i3c_bus_normaluse_lock(struct i3c_bus *bus)
+{
+	down_read(&bus->lock);
+}
+EXPORT_SYMBOL_GPL(i3c_bus_normaluse_lock);
+
+/**
+ * i3c_bus_normaluse_unlock - Release the bus lock after a normal operation
+ * @bus: I3C bus to release the lock on
+ *
+ * Should be called when a normal operation is done. See
+ * i3c_bus_normaluse_lock() for more details on what these normal operations
+ * are.
+ */
+void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
+{
+	up_read(&bus->lock);
+}
+EXPORT_SYMBOL_GPL(i3c_bus_normaluse_unlock);
+
+static ssize_t bcr_show(struct device *dev,
+			struct device_attribute *da,
+			char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(bus);
+	ret = sprintf(buf, "%x\n", i3cdev->info.bcr);
+	i3c_bus_normaluse_unlock(bus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(bcr);
+
+static ssize_t dcr_show(struct device *dev,
+			struct device_attribute *da,
+			char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(bus);
+	ret = sprintf(buf, "%x\n", i3cdev->info.dcr);
+	i3c_bus_normaluse_unlock(bus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(dcr);
+
+static ssize_t pid_show(struct device *dev,
+			struct device_attribute *da,
+			char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(bus);
+	ret = sprintf(buf, "%llx\n", i3cdev->info.pid);
+	i3c_bus_normaluse_unlock(bus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(pid);
+
+static ssize_t dynamic_address_show(struct device *dev,
+				    struct device_attribute *da,
+				    char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(bus);
+	ret = sprintf(buf, "%02x\n", i3cdev->info.dyn_addr);
+	i3c_bus_normaluse_unlock(bus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(dynamic_address);
+
+static const char * const hdrcap_strings[] = {
+	"hdr-ddr", "hdr-tsp", "hdr-tsl",
+};
+
+static ssize_t hdrcap_show(struct device *dev,
+			   struct device_attribute *da,
+			   char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	unsigned long caps = i3cdev->info.hdr_cap;
+	ssize_t offset = 0, ret;
+	int mode;
+
+	i3c_bus_normaluse_lock(bus);
+	for_each_set_bit(mode, &caps, 8) {
+		if (mode >= ARRAY_SIZE(hdrcap_strings))
+			break;
+
+		if (!hdrcap_strings[mode])
+			continue;
+
+		ret = sprintf(buf + offset, offset ? " %s" : "%s",
+			      hdrcap_strings[mode]);
+		if (ret < 0)
+			goto out;
+
+		offset += ret;
+	}
+
+	ret = sprintf(buf + offset, "\n");
+	if (ret < 0)
+		goto out;
+
+	ret = offset + ret;
+
+out:
+	i3c_bus_normaluse_unlock(bus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(hdrcap);
+
+static struct attribute *i3c_device_attrs[] = {
+	&dev_attr_bcr.attr,
+	&dev_attr_dcr.attr,
+	&dev_attr_pid.attr,
+	&dev_attr_dynamic_address.attr,
+	&dev_attr_hdrcap.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(i3c_device);
+
+static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
+	u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
+	u16 ext = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
+
+	if (I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid))
+		return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
+				      i3cdev->info.dcr, manuf);
+
+	return add_uevent_var(env,
+			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
+			      i3cdev->info.dcr, manuf, part, ext);
+}
+
+const struct device_type i3c_device_type = {
+	.groups	= i3c_device_groups,
+	.uevent = i3c_device_uevent,
+};
+
+const struct device_type i3c_master_type = {
+	.groups	= i3c_device_groups,
+};
+
+static const struct i3c_device_id *
+i3c_device_match_id(struct i3c_device *i3cdev,
+		    const struct i3c_device_id *id_table)
+{
+	const struct i3c_device_id *id;
+
+	/*
+	 * The lower 32bits of the provisional ID is just filled with a random
+	 * value, try to match using DCR info.
+	 */
+	if (!I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid)) {
+		u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
+		u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
+		u16 ext_info = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
+
+		/* First try to match by manufacturer/part ID. */
+		for (id = id_table; id->match_flags != 0; id++) {
+			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
+			    I3C_MATCH_MANUF_AND_PART)
+				continue;
+
+			if (manuf != id->manuf_id || part != id->part_id)
+				continue;
+
+			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
+			    ext_info != id->extra_info)
+				continue;
+
+			return id;
+		}
+	}
+
+	/* Fallback to DCR match. */
+	for (id = id_table; id->match_flags != 0; id++) {
+		if ((id->match_flags & I3C_MATCH_DCR) &&
+		    id->dcr == i3cdev->info.dcr)
+			return id;
+	}
+
+	return NULL;
+}
+
+static int i3c_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct i3c_device *i3cdev;
+	struct i3c_driver *i3cdrv;
+
+	if (dev->type != &i3c_device_type)
+		return 0;
+
+	i3cdev = dev_to_i3cdev(dev);
+	i3cdrv = drv_to_i3cdrv(drv);
+	if (i3c_device_match_id(i3cdev, i3cdrv->id_table))
+		return 1;
+
+	return 0;
+}
+
+static int i3c_device_probe(struct device *dev)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
+
+	return driver->probe(i3cdev);
+}
+
+static int i3c_device_remove(struct device *dev)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
+	int ret;
+
+	ret = driver->remove(i3cdev);
+	if (ret)
+		return ret;
+
+	if (WARN_ON(i3cdev->ibi))
+		i3c_device_free_ibi(i3cdev);
+
+	return ret;
+}
+
+struct bus_type i3c_bus_type = {
+	.name = "i3c",
+	.match = i3c_device_match,
+	.probe = i3c_device_probe,
+	.remove = i3c_device_remove,
+};
+
+enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus *bus,
+						       u16 addr)
+{
+	int status, bitpos = addr * 2;
+
+	if (addr > I2C_MAX_ADDR)
+		return I3C_ADDR_SLOT_RSVD;
+
+	status = bus->addrslots[bitpos / BITS_PER_LONG];
+	status >>= bitpos % BITS_PER_LONG;
+
+	return status & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+				  enum i3c_addr_slot_status status)
+{
+	int bitpos = addr * 2;
+	unsigned long *ptr;
+
+	if (addr > I2C_MAX_ADDR)
+		return;
+
+	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
+	*ptr &= ~(I3C_ADDR_SLOT_STATUS_MASK << (bitpos % BITS_PER_LONG));
+	*ptr |= status << (bitpos % BITS_PER_LONG);
+}
+
+bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
+{
+	enum i3c_addr_slot_status status;
+
+	status = i3c_bus_get_addr_slot_status(bus, addr);
+
+	return status == I3C_ADDR_SLOT_FREE;
+}
+
+int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
+{
+	enum i3c_addr_slot_status status;
+	u8 addr;
+
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	return -ENOMEM;
+}
+
+static void i3c_bus_init_addrslots(struct i3c_bus *bus)
+{
+	int i;
+
+	/* Addresses 0 to 7 are reserved. */
+	for (i = 0; i < 8; i++)
+		i3c_bus_set_addr_slot_status(bus, i, I3C_ADDR_SLOT_RSVD);
+
+	/*
+	 * Reserve broadcast address and all addresses that might collide
+	 * with the broadcast address when facing a single bit error.
+	 */
+	i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR,
+				     I3C_ADDR_SLOT_RSVD);
+	for (i = 0; i < 7; i++)
+		i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR ^ BIT(i),
+					     I3C_ADDR_SLOT_RSVD);
+}
+
+static const char * const i3c_bus_mode_strings[] = {
+	[I3C_BUS_MODE_PURE] = "pure",
+	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
+	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
+};
+
+static ssize_t mode_show(struct device *dev,
+			 struct device_attribute *da,
+			 char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	if (i3cbus->mode < 0 ||
+	    i3cbus->mode > ARRAY_SIZE(i3c_bus_mode_strings) ||
+	    !i3c_bus_mode_strings[i3cbus->mode])
+		ret = sprintf(buf, "unknown\n");
+	else
+		ret = sprintf(buf, "%s\n", i3c_bus_mode_strings[i3cbus->mode]);
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(mode);
+
+static ssize_t current_master_show(struct device *dev,
+				   struct device_attribute *da,
+				   char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	ret = sprintf(buf, "%s\n", dev_name(&i3cbus->cur_master->dev));
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(current_master);
+
+static ssize_t i3c_scl_frequency_show(struct device *dev,
+				      struct device_attribute *da,
+				      char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i3c);
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(i3c_scl_frequency);
+
+static ssize_t i2c_scl_frequency_show(struct device *dev,
+				      struct device_attribute *da,
+				      char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i2c);
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(i2c_scl_frequency);
+
+static struct attribute *i3c_busdev_attrs[] = {
+	&dev_attr_mode.attr,
+	&dev_attr_current_master.attr,
+	&dev_attr_i3c_scl_frequency.attr,
+	&dev_attr_i2c_scl_frequency.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(i3c_busdev);
+
+static void i3c_busdev_release(struct device *dev)
+{
+	struct i3c_bus *bus = container_of(dev, struct i3c_bus, dev);
+
+	while (!list_empty(&bus->devs.i2c)) {
+		struct i2c_device *i2cdev;
+
+		i2cdev = list_first_entry(&bus->devs.i2c, struct i2c_device,
+					  common.node);
+		list_del(&i2cdev->common.node);
+		of_node_put(i2cdev->info.of_node);
+		kfree(i2cdev);
+	}
+
+	while (!list_empty(&bus->devs.i3c)) {
+		struct i3c_device *i3cdev;
+
+		i3cdev = list_first_entry(&bus->devs.i3c, struct i3c_device,
+					  common.node);
+		list_del(&i3cdev->common.node);
+		put_device(&i3cdev->dev);
+	}
+
+	mutex_lock(&i3c_core_lock);
+	idr_remove(&i3c_bus_idr, bus->id);
+	mutex_unlock(&i3c_core_lock);
+
+	of_node_put(bus->dev.of_node);
+	kfree(bus);
+}
+
+static const struct device_type i3c_busdev_type = {
+	.groups	= i3c_busdev_groups,
+};
+
+void i3c_bus_unref(struct i3c_bus *bus)
+{
+	put_device(&bus->dev);
+}
+
+struct i3c_bus *i3c_bus_create(struct device *parent)
+{
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
+	if (!i3cbus)
+		return ERR_PTR(-ENOMEM);
+
+	init_rwsem(&i3cbus->lock);
+	INIT_LIST_HEAD(&i3cbus->devs.i2c);
+	INIT_LIST_HEAD(&i3cbus->devs.i3c);
+	i3c_bus_init_addrslots(i3cbus);
+	i3cbus->mode = I3C_BUS_MODE_PURE;
+	i3cbus->dev.parent = parent;
+	i3cbus->dev.of_node = of_node_get(parent->of_node);
+	i3cbus->dev.bus = &i3c_bus_type;
+	i3cbus->dev.type = &i3c_busdev_type;
+	i3cbus->dev.release = i3c_busdev_release;
+
+	mutex_lock(&i3c_core_lock);
+	ret = idr_alloc(&i3c_bus_idr, i3cbus, 0, 0, GFP_KERNEL);
+	mutex_unlock(&i3c_core_lock);
+	if (ret < 0)
+		goto err_free_bus;
+
+	i3cbus->id = ret;
+	device_initialize(&i3cbus->dev);
+
+	return i3cbus;
+
+err_free_bus:
+	kfree(i3cbus);
+
+	return ERR_PTR(ret);
+}
+
+void i3c_bus_unregister(struct i3c_bus *bus)
+{
+	device_unregister(&bus->dev);
+}
+
+int i3c_bus_register(struct i3c_bus *i3cbus)
+{
+	struct i2c_device *i2cdev;
+
+	i3c_bus_for_each_i2cdev(i3cbus, i2cdev) {
+		switch (i2cdev->lvr & I3C_LVR_I2C_INDEX_MASK) {
+		case I3C_LVR_I2C_INDEX(0):
+			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
+				i3cbus->mode = I3C_BUS_MODE_MIXED_FAST;
+			break;
+
+		case I3C_LVR_I2C_INDEX(1):
+		case I3C_LVR_I2C_INDEX(2):
+			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
+				i3cbus->mode = I3C_BUS_MODE_MIXED_SLOW;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (!i3cbus->scl_rate.i3c)
+		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
+
+	if (!i3cbus->scl_rate.i2c) {
+		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
+			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
+		else
+			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	}
+
+	/*
+	 * I3C/I2C frequency may have been overridden, check that user-provided
+	 * values are not exceeding max possible frequency.
+	 */
+	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
+	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
+		return -EINVAL;
+	}
+
+	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
+
+	return device_add(&i3cbus->dev);
+}
+
+static int __init i3c_init(void)
+{
+	return bus_register(&i3c_bus_type);
+}
+subsys_initcall(i3c_init);
+
+static void __exit i3c_exit(void)
+{
+	idr_destroy(&i3c_bus_idr);
+	bus_unregister(&i3c_bus_type);
+}
+module_exit(i3c_exit);
+
+MODULE_AUTHOR("Boris Brezillon <boris.brezillon@bootlin.com>");
+MODULE_DESCRIPTION("I3C core");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
new file mode 100644
index 000000000000..280e2af8beac
--- /dev/null
+++ b/drivers/i3c/device.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include "internals.h"
+
+/**
+ * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
+ *				specific device
+ *
+ * @dev: device with which the transfers should be done
+ * @xfers: array of transfers
+ * @nxfers: number of transfers
+ *
+ * Initiate one or several private SDR transfers with @dev.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_do_priv_xfers(struct i3c_device *dev,
+			     struct i3c_priv_xfer *xfers,
+			     int nxfers)
+{
+	struct i3c_master_controller *master;
+	int ret, i;
+
+	if (nxfers < 1)
+		return 0;
+
+	master = i3c_device_get_master(dev);
+	if (!master || !xfers)
+		return -EINVAL;
+
+	if (!master->ops->priv_xfers)
+		return -ENOTSUPP;
+
+	for (i = 0; i < nxfers; i++) {
+		if (!xfers[i].len || !xfers[i].data.in)
+			return -EINVAL;
+	}
+
+	i3c_bus_normaluse_lock(master->bus);
+	ret = master->ops->priv_xfers(dev, xfers, nxfers);
+	i3c_bus_normaluse_unlock(master->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+
+/**
+ * i3c_device_get_info() - get I3C device information
+ *
+ * @dev: device we want information on
+ * @info: the information object to fill in
+ *
+ * Retrieve I3C dev info.
+ */
+void i3c_device_get_info(struct i3c_device *dev,
+			 struct i3c_device_info *info)
+{
+	if (info)
+		*info = dev->info;
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_info);
+
+/**
+ * i3c_device_disable_ibi() - Disable IBIs coming from a specific device
+ * @dev: device on which IBIs should be disabled
+ *
+ * This function disable IBIs coming from a specific device and wait for
+ * all pending IBIs to be processed.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_disable_ibi(struct i3c_device *dev)
+{
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+	int ret;
+
+	i3c_bus_normaluse_lock(master->bus);
+	mutex_lock(&dev->ibi_lock);
+	if (!dev->ibi) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = master->ops->disable_ibi(dev);
+	if (ret)
+		goto out;
+
+	reinit_completion(&dev->ibi->all_ibis_handled);
+	if (atomic_read(&dev->ibi->pending_ibis))
+		wait_for_completion(&dev->ibi->all_ibis_handled);
+
+	dev->ibi->enabled = false;
+
+out:
+	mutex_unlock(&dev->ibi_lock);
+	i3c_bus_normaluse_unlock(master->bus);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_device_disable_ibi);
+
+/**
+ * i3c_device_enable_ibi() - Enable IBIs coming from a specific device
+ * @dev: device on which IBIs should be enabled
+ *
+ * This function enable IBIs coming from a specific device and wait for
+ * all pending IBIs to be processed. This should be called on a device
+ * where i3c_device_request_ibi() has succeeded.
+ *
+ * Note that IBIs from this device might be received before this function
+ * returns to its caller.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_enable_ibi(struct i3c_device *dev)
+{
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+	int ret;
+
+	i3c_bus_normaluse_lock(master->bus);
+	mutex_lock(&dev->ibi_lock);
+	if (!dev->ibi) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = master->ops->enable_ibi(dev);
+	if (!ret)
+		dev->ibi->enabled = true;
+
+out:
+	mutex_unlock(&dev->ibi_lock);
+	i3c_bus_normaluse_unlock(master->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_enable_ibi);
+
+/**
+ * i3c_device_request_ibi() - Request an IBI
+ * @dev: device for which we should enable IBIs
+ * @req: setup requested for this IBI
+ *
+ * This function is responsible for pre-allocating all resources needed to
+ * process IBIs coming from @dev. When this function returns, the IBI is not
+ * enabled until i3c_device_enable_ibi() is called.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_request_ibi(struct i3c_device *dev,
+			   const struct i3c_ibi_setup *req)
+{
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+	struct i3c_device_ibi_info *ibi;
+	int ret;
+
+	if (!master->ops->request_ibi)
+		return -ENOTSUPP;
+
+	if (!req->handler || !req->num_slots)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(master->bus);
+	mutex_lock(&dev->ibi_lock);
+	if (dev->ibi) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ibi = kzalloc(sizeof(*ibi), GFP_KERNEL);
+	if (!ibi) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	atomic_set(&ibi->pending_ibis, 0);
+	init_completion(&ibi->all_ibis_handled);
+	ibi->handler = req->handler;
+	ibi->max_payload_len = req->max_payload_len;
+
+	dev->ibi = ibi;
+	ret = master->ops->request_ibi(dev, req);
+	if (ret) {
+		kfree(ibi);
+		dev->ibi = NULL;
+	}
+
+out:
+	mutex_unlock(&dev->ibi_lock);
+	i3c_bus_normaluse_unlock(master->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_request_ibi);
+
+/**
+ * i3c_device_free_ibi() - Free all resources needed for IBI handling
+ * @dev: device on which you want to release IBI resources
+ *
+ * This function is responsible for de-allocating resources previously
+ * allocated by i3c_device_request_ibi(). It should be called after disabling
+ * IBIs with i3c_device_disable_ibi().
+ */
+void i3c_device_free_ibi(struct i3c_device *dev)
+{
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+
+	i3c_bus_normaluse_lock(master->bus);
+	mutex_lock(&dev->ibi_lock);
+	if (!dev->ibi)
+		goto out;
+
+	if (WARN_ON(dev->ibi->enabled))
+		BUG_ON(i3c_device_disable_ibi(dev));
+
+	master->ops->free_ibi(dev);
+	kfree(dev->ibi);
+	dev->ibi = NULL;
+
+out:
+	mutex_unlock(&dev->ibi_lock);
+	i3c_bus_normaluse_unlock(master->bus);
+}
+EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
+
+/**
+ * i3cdev_to_dev() - Returns the device embedded in @i3cdev
+ * @i3cdev: I3C device
+ *
+ * Return: a pointer to a device object.
+ */
+struct device *i3cdev_to_dev(struct i3c_device *i3cdev)
+{
+	return &i3cdev->dev;
+}
+EXPORT_SYMBOL_GPL(i3cdev_to_dev);
+
+/**
+ * dev_to_i3cdev() - Returns the I3C device containing @dev
+ * @dev: device object
+ *
+ * Return: a pointer to an I3C device object.
+ */
+struct i3c_device *dev_to_i3cdev(struct device *dev)
+{
+	return container_of(dev, struct i3c_device, dev);
+}
+EXPORT_SYMBOL_GPL(dev_to_i3cdev);
+
+/**
+ * i3c_driver_register_with_owner() - register an I3C device driver
+ *
+ * @drv: driver to register
+ * @owner: module that owns this driver
+ *
+ * Register @drv to the core.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_driver_register_with_owner(struct i3c_driver *drv, struct module *owner)
+{
+	drv->driver.owner = owner;
+	drv->driver.bus = &i3c_bus_type;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(i3c_driver_register_with_owner);
+
+/**
+ * i3c_driver_unregister() - unregister an I3C device driver
+ *
+ * @drv: driver to unregister
+ *
+ * Unregister @drv.
+ */
+void i3c_driver_unregister(struct i3c_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(i3c_driver_unregister);
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
new file mode 100644
index 000000000000..312724822404
--- /dev/null
+++ b/drivers/i3c/internals.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_INTERNALS_H
+#define I3C_INTERNALS_H
+
+#include <linux/i3c/master.h>
+
+extern struct bus_type i3c_bus_type;
+extern const struct device_type i3c_master_type;
+extern const struct device_type i3c_device_type;
+
+void i3c_bus_unref(struct i3c_bus *bus);
+struct i3c_bus *i3c_bus_create(struct device *parent);
+void i3c_bus_unregister(struct i3c_bus *bus);
+int i3c_bus_register(struct i3c_bus *i3cbus);
+int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr);
+bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr);
+void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+				  enum i3c_addr_slot_status status);
+enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus *bus,
+						       u16 addr);
+
+#endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
new file mode 100644
index 000000000000..1a62bdb2b25a
--- /dev/null
+++ b/drivers/i3c/master.c
@@ -0,0 +1,1722 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "internals.h"
+
+static struct i3c_master_controller *
+i2c_adapter_to_i3c_master(struct i2c_adapter *adap)
+{
+	return container_of(adap, struct i3c_master_controller, i2c);
+}
+
+static struct i2c_adapter *
+i3c_master_to_i2c_adapter(struct i3c_master_controller *master)
+{
+	return &master->i2c;
+}
+
+static struct i2c_device *
+i3c_master_alloc_i2c_dev(struct i3c_master_controller *master,
+			 const struct i2c_board_info *info, u8 lvr)
+{
+	struct i2c_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->common.bus = master->bus;
+	dev->info = *info;
+	dev->lvr = lvr;
+	dev->info.of_node = of_node_get(info->of_node);
+	i3c_bus_set_addr_slot_status(master->bus, info->addr,
+				     I3C_ADDR_SLOT_I2C_DEV);
+
+	return dev;
+}
+
+static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
+					  struct i3c_ccc_cmd *cmd)
+{
+	if (!cmd || !master)
+		return -EINVAL;
+
+	if (WARN_ON(master->init_done &&
+		    !rwsem_is_locked(&master->bus->lock)))
+		return -EINVAL;
+
+	if (!master->ops->send_ccc_cmd)
+		return -ENOTSUPP;
+
+	if ((cmd->id & I3C_CCC_DIRECT) && (!cmd->dests || !cmd->ndests))
+		return -EINVAL;
+
+	if (master->ops->supports_ccc_cmd &&
+	    !master->ops->supports_ccc_cmd(master, cmd))
+		return -ENOTSUPP;
+
+	return master->ops->send_ccc_cmd(master, cmd);
+}
+
+static struct i2c_device *
+i3c_master_find_i2c_dev_by_addr(const struct i3c_master_controller *master,
+				u16 addr)
+{
+	struct i2c_device *dev;
+
+	i3c_bus_for_each_i2cdev(master->bus, dev) {
+		if (dev->client->addr == addr)
+			return dev;
+	}
+
+	return NULL;
+}
+
+/**
+ * i3c_master_get_free_addr() - get a free address on the bus
+ * @master: I3C master object
+ * @start_addr: where to start searching
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: the first free address starting at @start_addr (included) or -ENOMEM
+ * if there's no more address available.
+ */
+int i3c_master_get_free_addr(struct i3c_master_controller *master,
+			     u8 start_addr)
+{
+	return i3c_bus_get_free_addr(master->bus, start_addr);
+}
+EXPORT_SYMBOL_GPL(i3c_master_get_free_addr);
+
+static void i3c_device_release(struct device *dev)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+
+	if (i3cdev->info.static_addr)
+		i3c_bus_set_addr_slot_status(i3cdev->common.bus,
+					     i3cdev->info.static_addr,
+					     I3C_ADDR_SLOT_FREE);
+
+	if (i3cdev->info.dyn_addr)
+		i3c_bus_set_addr_slot_status(i3cdev->common.bus,
+					     i3cdev->info.dyn_addr,
+					     I3C_ADDR_SLOT_FREE);
+
+	of_node_put(dev->of_node);
+	kfree(i3cdev);
+}
+
+static struct i3c_device *
+i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
+			 const struct i3c_device_info *info,
+			 const struct device_type *devtype)
+{
+	struct i3c_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->common.bus = master->bus;
+	dev->dev.parent = &master->bus->dev;
+	dev->dev.type = devtype;
+	dev->dev.bus = &i3c_bus_type;
+	dev->dev.release = i3c_device_release;
+	dev->info = *info;
+	mutex_init(&dev->ibi_lock);
+	dev_set_name(&dev->dev, "%d-%llx", master->bus->id, info->pid);
+
+	device_initialize(&dev->dev);
+
+	if (info->static_addr)
+		i3c_bus_set_addr_slot_status(master->bus, info->static_addr,
+					     I3C_ADDR_SLOT_I3C_DEV);
+
+	if (info->dyn_addr)
+		i3c_bus_set_addr_slot_status(master->bus, info->dyn_addr,
+					     I3C_ADDR_SLOT_I3C_DEV);
+
+	return dev;
+}
+
+/**
+ * i3c_master_set_info() - set master device information
+ * @master: master used to send frames on the bus
+ * @info: I3C device information
+ *
+ * Set master device info. This should be called from
+ * &i3c_master_controller_ops->bus_init().
+ *
+ * Not all &i3c_device_info fields are meaningful for a master device.
+ * Here is a list of fields that should be properly filled:
+ *
+ * - &i3c_device_info->dyn_addr
+ * - &i3c_device_info->bcr
+ * - &i3c_device_info->dcr
+ * - &i3c_device_info->pid
+ * - &i3c_device_info->hdr_cap if %I3C_BCR_HDR_CAP bit is set in
+ *   &i3c_device_info->bcr
+ *
+ * This function must be called with the bus lock held in maintenance mode.
+ *
+ * Return: 0 if @info contains valid information (not every piece of
+ * information can be checked, but we can at least make sure @info->dyn_addr
+ * and @info->bcr are correct), -EINVAL otherwise.
+ */
+int i3c_master_set_info(struct i3c_master_controller *master,
+			const struct i3c_device_info *info)
+{
+	struct i3c_device *i3cdev;
+
+	if (!i3c_bus_dev_addr_is_avail(master->bus, info->dyn_addr))
+		return -EINVAL;
+
+	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
+	    master->secondary)
+		return -EINVAL;
+
+	if (master->this)
+		return -EINVAL;
+
+	i3cdev = i3c_master_alloc_i3c_dev(master, info,	&i3c_master_type);
+	if (IS_ERR(i3cdev))
+		return PTR_ERR(i3cdev);
+
+	master->this = i3cdev;
+	master->bus->cur_master = master->this;
+	i3cdev->common.bus = master->bus;
+	i3cdev->common.master = master;
+	list_add_tail(&i3cdev->common.node, &master->bus->devs.i3c);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_set_info);
+
+static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
+				    u8 addr)
+{
+	struct i3c_ccc_cmd_dest dest = { };
+	struct i3c_ccc_cmd cmd = { };
+	enum i3c_addr_slot_status addrstat;
+	int ret;
+
+	if (!master)
+		return -EINVAL;
+
+	addrstat = i3c_bus_get_addr_slot_status(master->bus, addr);
+	if (addr != I3C_BROADCAST_ADDR && addrstat != I3C_ADDR_SLOT_I3C_DEV)
+		return -EINVAL;
+
+	dest.addr = addr;
+	cmd.dests = &dest;
+	cmd.ndests = 1;
+	cmd.rnw = false;
+	cmd.id = I3C_CCC_RSTDAA(addr == I3C_BROADCAST_ADDR);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignment)
+ *				procedure
+ * @master: master used to send frames on the bus
+ *
+ * Send a ENTDAA CCC command to start a DAA procedure.
+ *
+ * Note that this function only sends the ENTDAA CCC command, all the logic
+ * behind dynamic address assignment has to be handled in the I3C master
+ * driver.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_entdaa_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest = { };
+	struct i3c_ccc_cmd cmd = { };
+	int ret;
+
+	dest.addr = I3C_BROADCAST_ADDR;
+	cmd.dests = &dest;
+	cmd.ndests = 1;
+	cmd.rnw = false;
+	cmd.id = I3C_CCC_ENTDAA;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked);
+
+/**
+ * i3c_master_disec_locked() - send a DISEC CCC command
+ * @master: master used to send frames on the bus
+ * @addr: a valid I3C slave address or %I3C_BROADCAST_ADDR
+ * @evts: events to disable
+ *
+ * Send a DISEC CCC command to disable some or all events coming from a
+ * specific slave, or all devices if @addr is %I3C_BROADCAST_ADDR.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_disec_locked(struct i3c_master_controller *master, u8 addr,
+			    u8 evts)
+{
+	struct i3c_ccc_events events = {
+		.events = evts,
+	};
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = addr,
+		.payload.len = sizeof(events),
+		.payload.data = &events,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.id = I3C_CCC_DISEC(addr == I3C_BROADCAST_ADDR),
+		.dests = &dest,
+		.ndests = 1,
+	};
+
+	return i3c_master_send_ccc_cmd_locked(master, &cmd);
+}
+EXPORT_SYMBOL_GPL(i3c_master_disec_locked);
+
+/**
+ * i3c_master_enec_locked() - send an ENEC CCC command
+ * @master: master used to send frames on the bus
+ * @addr: a valid I3C slave address or %I3C_BROADCAST_ADDR
+ * @evts: events to disable
+ *
+ * Sends an ENEC CCC command to enable some or all events coming from a
+ * specific slave, or all devices if @addr is %I3C_BROADCAST_ADDR.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_enec_locked(struct i3c_master_controller *master, u8 addr,
+			   u8 evts)
+{
+	struct i3c_ccc_events events = {
+		.events = evts,
+	};
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = addr,
+		.payload.len = sizeof(events),
+		.payload.data = &events,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.id = I3C_CCC_ENEC(addr == I3C_BROADCAST_ADDR),
+		.dests = &dest,
+		.ndests = 1,
+	};
+
+	return i3c_master_send_ccc_cmd_locked(master, &cmd);
+}
+EXPORT_SYMBOL_GPL(i3c_master_enec_locked);
+
+/**
+ * i3c_master_defslvs_locked() - send a DEFSLVS CCC command
+ * @master: master used to send frames on the bus
+ *
+ * Send a DEFSLVS CCC command containing all the devices known to the @master.
+ * This is useful when you have secondary masters on the bus to propagate
+ * device information.
+ *
+ * This should be called after all I3C devices have been discovered (in other
+ * words, after the DAA procedure has finished) and instantiated in
+ * i3c_master_controller_ops->bus_init().
+ * It should also be called if a master ACKed an Hot-Join request and assigned
+ * a dynamic address to the device joining the bus.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_defslvs_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = I3C_BROADCAST_ADDR,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.id = I3C_CCC_DEFSLVS,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	struct i3c_ccc_defslvs *defslvs;
+	struct i3c_ccc_dev_desc *desc;
+	struct i3c_device *i3cdev;
+	struct i2c_device *i2cdev;
+	struct i3c_bus *bus;
+	bool send = false;
+	int ndevs = 0, ret;
+
+	if (!master)
+		return -EINVAL;
+
+	bus = i3c_master_get_bus(master);
+	i3c_bus_for_each_i3cdev(bus, i3cdev) {
+		ndevs++;
+		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) == I3C_BCR_I3C_MASTER)
+			send = true;
+	}
+
+	/* No other master on the bus, skip DEFSLVS. */
+	if (!send)
+		return 0;
+
+	i3c_bus_for_each_i2cdev(bus, i2cdev)
+		ndevs++;
+
+	dest.payload.len = sizeof(*defslvs) +
+			   ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc));
+	defslvs = kzalloc(dest.payload.len, GFP_KERNEL);
+	if (!defslvs)
+		return -ENOMEM;
+
+	dest.payload.data = defslvs;
+
+	defslvs->count = ndevs;
+	defslvs->master.bcr = master->this->info.bcr;
+	defslvs->master.dcr = master->this->info.dcr;
+	defslvs->master.dyn_addr = master->this->info.dyn_addr << 1;
+	defslvs->master.static_addr = I3C_BROADCAST_ADDR << 1;
+
+	desc = defslvs->slaves;
+	i3c_bus_for_each_i2cdev(bus, i2cdev) {
+		desc->lvr = i2cdev->lvr;
+		desc->static_addr = i2cdev->info.addr << 1;
+		desc++;
+	}
+
+	i3c_bus_for_each_i3cdev(bus, i3cdev) {
+		/* Skip the I3C dev representing this master. */
+		if (i3cdev == master->this)
+			continue;
+
+		desc->bcr = i3cdev->info.bcr;
+		desc->dcr = i3cdev->info.dcr;
+		desc->dyn_addr = i3cdev->info.dyn_addr << 1;
+		desc->static_addr = i3cdev->info.static_addr << 1;
+		desc++;
+	}
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	kfree(defslvs);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_defslvs_locked);
+
+static int i3c_master_setdasa_locked(struct i3c_master_controller *master,
+				     u8 static_addr, u8 dyn_addr)
+{
+	struct i3c_ccc_setda setda = {
+		.addr = dyn_addr << 1,
+	};
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = static_addr,
+		.payload.len = sizeof(setda),
+		.payload.data = &setda,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = false,
+		.id = I3C_CCC_SETDASA,
+		.dests = &dest,
+		.ndests = 1,
+	};
+
+	if (!dyn_addr || !static_addr)
+		return -EINVAL;
+
+	return i3c_master_send_ccc_cmd_locked(master, &cmd);
+}
+
+static int i3c_master_setnewda_locked(struct i3c_master_controller *master,
+				      u8 oldaddr, u8 newaddr)
+{
+	struct i3c_ccc_setda setda = {
+		.addr = newaddr << 1,
+	};
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = oldaddr,
+		.payload.len = sizeof(setda),
+		.payload.data = &setda,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = false,
+		.id = I3C_CCC_SETNEWDA,
+		.dests = &dest,
+		.ndests = 1,
+	};
+
+	if (!oldaddr || !newaddr)
+		return -EINVAL;
+
+	return i3c_master_send_ccc_cmd_locked(master, &cmd);
+}
+
+static int i3c_master_getmrl_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_mrl mrl;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(mrl),
+		.payload.data = &mrl,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETMRL,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	/*
+	 * When the device does not have IBI payload GETMRL only returns 2
+	 * bytes of data.
+	 */
+	if (!(info->bcr & I3C_BCR_IBI_PAYLOAD))
+		dest.payload.len -= 1;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != sizeof(mrl))
+		return -EIO;
+
+	info->max_read_len = be16_to_cpu(mrl.read_len);
+
+	if (info->bcr & I3C_BCR_IBI_PAYLOAD)
+		info->max_ibi_len = mrl.ibi_len;
+
+	return 0;
+}
+
+static int i3c_master_getmwl_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_mwl mwl;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(mwl),
+		.payload.data = &mwl,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETMWL,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != sizeof(mwl))
+		return -EIO;
+
+	info->max_write_len = be16_to_cpu(mwl.len);
+
+	return 0;
+}
+
+static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
+				     struct i3c_device_info *info)
+{
+	struct i3c_ccc_getmxds getmaxds;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(getmaxds),
+		.payload.data = &getmaxds,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETMXDS,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != 2 && dest.payload.len != 5)
+		return -EIO;
+
+	info->max_read_ds = getmaxds.maxrd;
+	info->max_read_ds = getmaxds.maxwr;
+	if (dest.payload.len == 5)
+		info->max_read_turnaround = getmaxds.maxrdturn[0] |
+					    ((u32)getmaxds.maxrdturn[1] << 8) |
+					    ((u32)getmaxds.maxrdturn[2] << 16);
+
+	return 0;
+}
+
+static int i3c_master_gethdrcap_locked(struct i3c_master_controller *master,
+				       struct i3c_device_info *info)
+{
+	struct i3c_ccc_gethdrcap gethdrcap;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(gethdrcap),
+		.payload.data = &gethdrcap,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETHDRCAP,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != 1)
+		return -EIO;
+
+	info->hdr_cap = gethdrcap.modes;
+
+	return 0;
+}
+
+static int i3c_master_getpid_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getpid getpid;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(struct i3c_ccc_getpid),
+		.payload.data = &getpid,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETPID,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret, i;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	info->pid = 0;
+	for (i = 0; i < sizeof(getpid.pid); i++) {
+		int sft = (sizeof(getpid.pid) - i - 1) * 8;
+
+		info->pid |= (u64)getpid.pid[i] << sft;
+	}
+
+	return 0;
+}
+
+static int i3c_master_getbcr_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getbcr getbcr;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(struct i3c_ccc_getbcr),
+		.payload.data = &getbcr,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETBCR,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	info->bcr = getbcr.bcr;
+
+	return 0;
+}
+
+static int i3c_master_getdcr_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getdcr getdcr;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(struct i3c_ccc_getdcr),
+		.payload.data = &getdcr,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETDCR,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	info->dcr = getdcr.dcr;
+
+	return 0;
+}
+
+static int i3c_master_retrieve_dev_info(struct i3c_master_controller *master,
+					struct i3c_device_info *info, u8 addr)
+{
+	enum i3c_addr_slot_status slot_status;
+	int ret;
+
+	if (!master || !info)
+		return -EINVAL;
+
+	memset(info, 0, sizeof(*info));
+	info->dyn_addr = addr;
+
+	slot_status = i3c_bus_get_addr_slot_status(master->bus,
+						   info->dyn_addr);
+	if (slot_status == I3C_ADDR_SLOT_RSVD ||
+	    slot_status == I3C_ADDR_SLOT_I2C_DEV)
+		return -EINVAL;
+
+	ret = i3c_master_getpid_locked(master, info);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_getbcr_locked(master, info);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_getdcr_locked(master, info);
+	if (ret)
+		return ret;
+
+	if (info->bcr & I3C_BCR_MAX_DATA_SPEED_LIM) {
+		ret = i3c_master_getmxds_locked(master, info);
+		if (ret)
+			return ret;
+	}
+
+	if (info->bcr & I3C_BCR_IBI_PAYLOAD)
+		info->max_ibi_len = 1;
+
+	i3c_master_getmrl_locked(master, info);
+	i3c_master_getmwl_locked(master, info);
+
+	if (info->bcr & I3C_BCR_HDR_CAP) {
+		ret = i3c_master_gethdrcap_locked(master, info);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int i3c_master_attach_i3c_dev(struct i3c_master_controller *master,
+				     struct i3c_device *dev)
+{
+	int ret;
+
+	/*
+	 * We don't attach devices to the controller until they are
+	 * addressable on the bus.
+	 */
+	if (!dev->info.static_addr && !dev->info.dyn_addr)
+		return 0;
+
+	dev->common.master = master;
+
+	/* Do not attach the master device itself. */
+	if (master->this == dev)
+		return 0;
+
+	if (!master->ops->attach_i3c_dev)
+		return 0;
+
+	ret = master->ops->attach_i3c_dev(dev);
+	if (ret)
+		dev->common.master = NULL;
+
+	return ret;
+}
+
+static void i3c_master_reattach_i3c_dev(struct i3c_device *dev,
+					u8 old_dyn_addr)
+{
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+
+	if (master->ops->reattach_i3c_dev)
+		master->ops->reattach_i3c_dev(dev, old_dyn_addr);
+
+	if (old_dyn_addr)
+		i3c_bus_set_addr_slot_status(master->bus, old_dyn_addr,
+					     I3C_ADDR_SLOT_FREE);
+}
+
+static void i3c_master_detach_i3c_dev(struct i3c_device *dev)
+{
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+
+	if (!master)
+		return;
+
+	/* Do not detach the master device itself. */
+	if (master->this == dev)
+		return;
+
+	if (master->ops->detach_i3c_dev)
+		master->ops->detach_i3c_dev(dev);
+
+	dev->common.master = NULL;
+}
+
+static int i3c_master_attach_i2c_dev(struct i3c_master_controller *master,
+				     struct i2c_device *dev)
+{
+	int ret;
+
+	dev->common.master = master;
+
+	if (!master->ops->attach_i2c_dev)
+		return 0;
+
+	ret = master->ops->attach_i2c_dev(dev);
+	if (ret)
+		dev->common.master = NULL;
+
+	return ret;
+}
+
+static void i3c_master_detach_i2c_dev(struct i2c_device *dev)
+{
+	struct i3c_master_controller *master = i2c_device_get_master(dev);
+
+	if (!master)
+		return;
+
+	if (master->ops->detach_i2c_dev)
+		master->ops->detach_i2c_dev(dev);
+
+	dev->common.master = NULL;
+}
+
+static void i3c_master_pre_assign_dyn_addr(struct i3c_device *dev)
+{
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+	struct i3c_device_info info;
+	int ret;
+
+	if (!dev->init_dyn_addr || !dev->info.static_addr ||
+	    dev->info.dyn_addr)
+		return;
+
+	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
+					dev->init_dyn_addr);
+	if (ret)
+		return;
+
+	ret = i3c_master_retrieve_dev_info(master, &info, dev->init_dyn_addr);
+	if (ret)
+		goto err_rstdaa;
+
+	dev->info = info;
+
+	i3c_master_reattach_i3c_dev(dev, 0);
+
+	return;
+
+err_rstdaa:
+	i3c_master_rstdaa_locked(master, dev->init_dyn_addr);
+}
+
+static void
+i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
+{
+	struct i3c_device *i3cdev;
+	int ret;
+
+	if (!master->init_done)
+		return;
+
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev) {
+		if (i3cdev->regfailed || device_is_registered(&i3cdev->dev) ||
+		    !i3cdev->info.dyn_addr)
+			continue;
+
+		ret = device_add(&i3cdev->dev);
+		if (ret) {
+			dev_err(master->parent,
+				"Failed to add I3C device (err = %d)\n", ret);
+			i3cdev->regfailed = true;
+		}
+	}
+}
+
+/**
+ * i3c_master_do_daa() - do a DAA (Dynamic Address Assignment)
+ * @master: master doing the DAA
+ *
+ * This function is instantiating an I3C device object and adding it to the
+ * I3C device list. All device information are automatically retrieved using
+ * standard CCC commands.
+ *
+ * The I3C device object is returned in case the master wants to attach
+ * private data to it using i3c_device_set_master_data().
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+int i3c_master_do_daa(struct i3c_master_controller *master)
+{
+	int ret;
+
+	i3c_bus_maintenance_lock(master->bus);
+	ret = master->ops->do_daa(master);
+	i3c_bus_maintenance_unlock(master->bus);
+
+	if (ret)
+		return ret;
+
+	i3c_bus_normaluse_lock(master->bus);
+	i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(master->bus);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_do_daa);
+
+/**
+ * i3c_master_bus_init() - initialize an I3C bus
+ * @master: main master initializing the bus
+ *
+ * This function is following all initialisation steps described in the I3C
+ * specification:
+ *
+ * 1/ Attach I2C and statically defined I3C devs to the master so that the
+ *    master can fill its internal device table appropriately
+ * 2/ Call master's ->bus_init() method to initialize the master controller.
+ *    That's usually where the bus mode is selected (pure bus or mixed
+ *    fast/slow bus)
+ * 3/ Instruct all devices on the bus to drop their dynamic address. This is
+ *    particularly important when the bus was previously configured by someone
+ *    else (for example the bootloader)
+ * 4/ Disable all slave events.
+ * 5/ Pre-assign dynamic addresses requested by the FW with SETDASA for I3C
+ *    devices that have a static address
+ * 6/ Do a DAA (Dynamic Address Assignment) to assign dynamic addresses to all
+ *    remaining I3C devices
+ *
+ * Once this is done, all I3C and I2C devices should be usable.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+static int i3c_master_bus_init(struct i3c_master_controller *master)
+{
+	struct i3c_device *i3cdev;
+	struct i2c_device *i2cdev;
+	int ret;
+
+	/*
+	 * First attach all devices with static definitions provided by the
+	 * FW.
+	 */
+	i3c_bus_for_each_i2cdev(master->bus, i2cdev) {
+		ret = i3c_master_attach_i2c_dev(master, i2cdev);
+		if (ret)
+			goto err_detach_devs;
+	}
+
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev) {
+		ret = i3c_master_attach_i3c_dev(master, i3cdev);
+		if (ret)
+			goto err_detach_devs;
+	}
+
+	/*
+	 * Now execute the controller specific ->bus_init() routine, which
+	 * might configure its internal logic to match the bus limitations.
+	 */
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_detach_devs;
+
+	/*
+	 * The master device should have been instantiated in ->bus_init(),
+	 * complain if this was not the case.
+	 */
+	if (!master->this) {
+		dev_err(master->parent,
+			"master_set_info() was not called in ->bus_init()\n");
+		ret = -EINVAL;
+		goto err_bus_cleanup;
+	}
+
+	/*
+	 * Reset all dynamic address that may have been assigned before
+	 * (assigned by the bootloader for example).
+	 */
+	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
+	if (ret)
+		goto err_bus_cleanup;
+
+	/* Disable all slave events before starting DAA. */
+	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
+				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
+				      I3C_CCC_EVENT_HJ);
+	if (ret)
+		goto err_bus_cleanup;
+
+	/*
+	 * Pre-assign dynamic address and retrieve device information if
+	 * needed.
+	 */
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev)
+		i3c_master_pre_assign_dyn_addr(i3cdev);
+
+	ret = i3c_master_do_daa(master);
+	if (ret)
+		goto err_rstdaa;
+
+	return 0;
+
+err_rstdaa:
+	i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
+
+err_bus_cleanup:
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+err_detach_devs:
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev)
+		i3c_master_detach_i3c_dev(i3cdev);
+
+	i3c_bus_for_each_i2cdev(master->bus, i2cdev)
+		i3c_master_detach_i2c_dev(i2cdev);
+
+	return ret;
+}
+
+static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
+{
+	struct i3c_device *i3cdev;
+	struct i2c_device *i2cdev;
+
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev)
+		i3c_master_detach_i3c_dev(i3cdev);
+
+	i3c_bus_for_each_i2cdev(master->bus, i2cdev)
+		i3c_master_detach_i2c_dev(i2cdev);
+}
+
+static struct i3c_device *
+i3c_master_search_i3c_dev_by_pid(struct i3c_master_controller *master, u64 pid)
+{
+	struct i3c_device *i3cdev;
+
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev) {
+		if (i3cdev->info.pid == pid)
+			return i3cdev;
+	}
+
+	return NULL;
+}
+
+/**
+ * i3c_master_add_i3c_dev_locked() - add an I3C slave to the bus
+ * @master: master used to send frames on the bus
+ * @addr: I3C slave dynamic address assigned to the device
+ *
+ * This function is instantiating an I3C device object and adding it to the
+ * I3C device list. All device information are automatically retrieved using
+ * standard CCC commands.
+ *
+ * The I3C device object is returned in case the master wants to attach
+ * private data to it using i3c_device_set_master_data().
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
+				  u8 addr)
+{
+	u8 old_dyn_addr, expected_dyn_addr;
+	enum i3c_addr_slot_status status;
+	struct i3c_device *i3cdev;
+	struct i3c_device_info info;
+	int ret;
+
+	if (!master)
+		return -EINVAL;
+
+	status = i3c_bus_get_addr_slot_status(master->bus, addr);
+	if (status != I3C_ADDR_SLOT_FREE)
+		return -EINVAL;
+
+	ret = i3c_master_retrieve_dev_info(master, &info, addr);
+	if (ret)
+		return ret;
+
+	i3cdev = i3c_master_search_i3c_dev_by_pid(master, info.pid);
+	if (!i3cdev) {
+		i3cdev = i3c_master_alloc_i3c_dev(master, &info,
+						  &i3c_device_type);
+		if (IS_ERR(i3cdev))
+			return PTR_ERR(i3cdev);
+
+		list_add_tail(&i3cdev->common.node, &master->bus->devs.i3c);
+	}
+
+	old_dyn_addr = i3cdev->info.dyn_addr;
+	i3cdev->info.dyn_addr = addr;
+
+	if (!i3cdev->common.master) {
+		ret = i3c_master_attach_i3c_dev(master, i3cdev);
+		if (ret)
+			goto err_put_dev;
+	} else {
+		i3c_master_reattach_i3c_dev(i3cdev, old_dyn_addr);
+	}
+
+	/*
+	 * Depending on our previous state, the expected dynamic address might
+	 * differ:
+	 * - if the device already had a dynamic address assigned, let's try to
+	 *   re-apply this one
+	 * - if the device did not have a dynamic address and the firmware
+	 *   requested a specific address, pick this one
+	 * - in any other case, keep the address automatically assigned by the
+	 *   master
+	 */
+	if (old_dyn_addr)
+		expected_dyn_addr = old_dyn_addr;
+	else if (i3cdev->init_dyn_addr)
+		expected_dyn_addr = i3cdev->init_dyn_addr;
+	else
+		expected_dyn_addr = i3cdev->info.dyn_addr;
+
+	if (i3cdev->info.dyn_addr != expected_dyn_addr) {
+		/*
+		 * Try to apply the expected dynamic address. If it fails, keep
+		 * the address assigned by the master.
+		 */
+		ret = i3c_master_setnewda_locked(master,
+						 i3cdev->info.dyn_addr,
+						 expected_dyn_addr);
+		if (!ret) {
+			old_dyn_addr = i3cdev->info.dyn_addr;
+			i3cdev->info.dyn_addr = expected_dyn_addr;
+			i3c_master_reattach_i3c_dev(i3cdev, old_dyn_addr);
+		}
+	}
+
+	return 0;
+
+err_put_dev:
+	list_del(&i3cdev->common.node);
+	put_device(&i3cdev->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_add_i3c_dev_locked);
+
+#define OF_I3C_REG1_IS_I2C_DEV			BIT(31)
+
+static int of_i3c_master_add_i2c_dev(struct i3c_master_controller *master,
+				     struct device_node *node, u32 *reg)
+{
+	struct device *dev = master->parent;
+	struct i2c_board_info info = { };
+	struct i2c_device *i2cdev;
+	/* LVR is encoded in the lowest byte of reg[1]. */
+	u8 lvr = reg[1];
+	int ret;
+
+	ret = of_i2c_get_board_info(master->parent, node, &info);
+	if (ret)
+		return ret;
+
+	/*
+	 * We do not register the I2C device here, because the bus is not
+	 * necessarily ready to transmit I2C frames, and the I2C adapter has
+	 * not been registered yet.
+	 * This is done in i3c_master_i2c_adapter_init() once everything is
+	 * ready.
+	 */
+	i2cdev = i3c_master_alloc_i2c_dev(master, &info, lvr);
+	if (IS_ERR(i2cdev)) {
+		dev_err(dev, "Failed to allocate device %04x\n", info.addr);
+		return ret;
+	}
+
+	if (lvr & I3C_LVR_I2C_FM_MODE)
+		master->bus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
+
+	list_add_tail(&i2cdev->common.node, &master->bus->devs.i2c);
+
+	return 0;
+}
+
+static int of_i3c_master_add_i3c_dev(struct i3c_master_controller *master,
+				     struct device_node *node, u32 *reg)
+{
+	struct i3c_device_info info = { };
+	enum i3c_addr_slot_status addrstatus;
+	struct i3c_device *i3cdev;
+	u32 init_dyn_addr = 0;
+
+	if (reg[0]) {
+		if (reg[0] > I3C_MAX_ADDR)
+			return -EINVAL;
+
+		addrstatus = i3c_bus_get_addr_slot_status(master->bus, reg[0]);
+		if (addrstatus != I3C_ADDR_SLOT_FREE)
+			return -EINVAL;
+	}
+
+	info.static_addr = reg[0];
+
+	if (!of_property_read_u32(node, "assigned-address", &init_dyn_addr)) {
+		if (init_dyn_addr > I3C_MAX_ADDR)
+			return -EINVAL;
+
+		addrstatus = i3c_bus_get_addr_slot_status(master->bus,
+							  init_dyn_addr);
+		if (addrstatus != I3C_ADDR_SLOT_FREE)
+			return -EINVAL;
+	}
+
+	info.pid = ((u64)reg[1] << 32) | reg[2];
+
+	if ((info.pid & GENMASK_ULL(63, 48)) ||
+	    I3C_PID_RND_LOWER_32BITS(info.pid))
+		return -EINVAL;
+
+	i3cdev = i3c_master_alloc_i3c_dev(master, &info, &i3c_device_type);
+	if (IS_ERR(i3cdev))
+		return PTR_ERR(i3cdev);
+
+	i3cdev->init_dyn_addr = init_dyn_addr;
+	i3cdev->dev.of_node = node;
+	list_add_tail(&i3cdev->common.node, &master->bus->devs.i3c);
+
+	return 0;
+}
+
+static int of_i3c_master_add_dev(struct i3c_master_controller *master,
+				 struct device_node *node)
+{
+	u32 reg[3];
+	int ret;
+
+	if (!master || !node)
+		return -EINVAL;
+
+	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
+	if (ret)
+		return ret;
+
+	if (reg[1] & OF_I3C_REG1_IS_I2C_DEV)
+		ret = of_i3c_master_add_i2c_dev(master, node, reg);
+	else
+		ret = of_i3c_master_add_i3c_dev(master, node, reg);
+
+	return ret;
+}
+
+static int of_populate_i3c_bus(struct i3c_master_controller *master)
+{
+	struct device *dev = &master->bus->dev;
+	struct device_node *i3cbus_np = dev->of_node;
+	struct device_node *node;
+	int ret;
+	u32 val;
+
+	if (!i3cbus_np)
+		return 0;
+
+	for_each_available_child_of_node(i3cbus_np, node) {
+		ret = of_i3c_master_add_dev(master, node);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * The user might want to limit I2C and I3C speed in case some devices
+	 * on the bus are not supporting typical rates, or if the bus topology
+	 * prevents it from using max possible rate.
+	 */
+	if (!of_property_read_u32(i3cbus_np, "i2c-scl-hz", &val))
+		master->bus->scl_rate.i2c = val;
+
+	if (!of_property_read_u32(i3cbus_np, "i3c-scl-hz", &val))
+		master->bus->scl_rate.i3c = val;
+
+	return 0;
+}
+
+static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
+				       struct i2c_msg *xfers, int nxfers)
+{
+	struct i3c_master_controller *master = i2c_adapter_to_i3c_master(adap);
+	struct i2c_device *dev;
+	int i, ret;
+	u16 addr;
+
+	if (!xfers || !master || nxfers <= 0)
+		return -EINVAL;
+
+	if (!master->ops->i2c_xfers)
+		return -ENOTSUPP;
+
+	/* Doing transfers to different devices is not supported. */
+	addr = xfers[0].addr;
+	for (i = 1; i < nxfers; i++) {
+		if (addr != xfers[i].addr)
+			return -ENOTSUPP;
+	}
+
+	i3c_bus_normaluse_lock(master->bus);
+	dev = i3c_master_find_i2c_dev_by_addr(master, addr);
+	if (!dev)
+		ret = -ENOENT;
+	else
+		ret = master->ops->i2c_xfers(dev, xfers, nxfers);
+	i3c_bus_normaluse_unlock(master->bus);
+
+	return ret ? ret : nxfers;
+}
+
+static u32 i3c_master_i2c_functionalities(struct i2c_adapter *adap)
+{
+	struct i3c_master_controller *master = i2c_adapter_to_i3c_master(adap);
+
+	return master->ops->i2c_funcs(master);
+}
+
+static const struct i2c_algorithm i3c_master_i2c_algo = {
+	.master_xfer = i3c_master_i2c_adapter_xfer,
+	.functionality = i3c_master_i2c_functionalities,
+};
+
+static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
+{
+	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
+	struct i2c_device *i2cdev;
+	int ret;
+
+	adap->dev.parent = master->parent;
+	adap->owner = master->parent->driver->owner;
+	adap->algo = &i3c_master_i2c_algo;
+	strncpy(adap->name, dev_name(master->parent), sizeof(adap->name));
+
+	/* FIXME: Should we allow i3c masters to override these values? */
+	adap->timeout = 1000;
+	adap->retries = 3;
+
+	ret = i2c_add_adapter(adap);
+	if (ret)
+		return ret;
+
+	/*
+	 * We silently ignore failures here. The bus should keep working
+	 * correctly even if one or more i2c devices are not registered.
+	 */
+	i3c_bus_for_each_i2cdev(master->bus, i2cdev)
+		i2cdev->client = i2c_new_device(adap, &i2cdev->info);
+
+	return 0;
+}
+
+static void i3c_master_i2c_adapter_cleanup(struct i3c_master_controller *master)
+{
+	i2c_del_adapter(&master->i2c);
+}
+
+static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
+{
+	struct i3c_device *i3cdev;
+
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev) {
+		if (device_is_registered(&i3cdev->dev))
+			device_del(&i3cdev->dev);
+	}
+}
+
+/**
+ * i3c_master_queue_ibi() - Queue an IBI
+ * @dev: the device this IBI is coming from
+ * @slot: the IBI slot used to store the payload
+ *
+ * Queue an IBI to the controller workqueue. The IBI handler attached to
+ * the dev will be called from a workqueue context.
+ */
+void i3c_master_queue_ibi(struct i3c_device *dev, struct i3c_ibi_slot *slot)
+{
+	atomic_inc(&dev->ibi->pending_ibis);
+	queue_work(dev->common.master->wq, &slot->work);
+}
+EXPORT_SYMBOL_GPL(i3c_master_queue_ibi);
+
+static void i3c_master_handle_ibi(struct work_struct *work)
+{
+	struct i3c_ibi_slot *slot = container_of(work, struct i3c_ibi_slot,
+						 work);
+	struct i3c_device *dev = slot->dev;
+	struct i3c_master_controller *master = i3c_device_get_master(dev);
+	struct i3c_ibi_payload payload;
+
+	payload.data = slot->data;
+	payload.len = slot->len;
+
+	dev->ibi->handler(dev, &payload);
+	master->ops->recycle_ibi_slot(dev, slot);
+	if (atomic_dec_and_test(&dev->ibi->pending_ibis))
+		complete(&dev->ibi->all_ibis_handled);
+}
+
+static void i3c_master_init_ibi_slot(struct i3c_device *dev,
+				     struct i3c_ibi_slot *slot)
+{
+	slot->dev = dev;
+	INIT_WORK(&slot->work, i3c_master_handle_ibi);
+}
+
+struct i3c_generic_ibi_slot {
+	struct list_head node;
+	struct i3c_ibi_slot base;
+};
+
+struct i3c_generic_ibi_pool {
+	spinlock_t lock;
+	unsigned int num_slots;
+	struct list_head free_slots;
+	struct list_head pending;
+};
+
+/**
+ * i3c_generic_ibi_free_pool() - Free a generic IBI pool
+ * @pool: the IBI pool to free
+ *
+ * Free all IBI slots allated by a generic IBI pool.
+ */
+void i3c_generic_ibi_free_pool(struct i3c_generic_ibi_pool *pool)
+{
+	struct i3c_generic_ibi_slot *slot;
+	unsigned int nslots = 0;
+
+	while (!list_empty(&pool->free_slots)) {
+		slot = list_first_entry(&pool->free_slots,
+					struct i3c_generic_ibi_slot, node);
+		list_del(&slot->node);
+		kfree(slot->base.data);
+		kfree(slot);
+		nslots++;
+	}
+
+	/*
+	 * If the number of freed slots is not equal to the number of allocated
+	 * slots we have a leak somewhere.
+	 */
+	WARN_ON(nslots != pool->num_slots);
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_free_pool);
+
+/**
+ * i3c_generic_ibi_alloc_pool() - Create a generic IBI pool
+ * @dev: the device this pool will be used for
+ * @req: IBI setup request describing what the device driver expects
+ *
+ * Create a generic IBI pool based on the information provided in @req.
+ *
+ * Return: a valid IBI pool in case of success, an ERR_PTR() otherwise.
+ */
+struct i3c_generic_ibi_pool *
+i3c_generic_ibi_alloc_pool(struct i3c_device *dev,
+			   const struct i3c_ibi_setup *req)
+{
+	struct i3c_generic_ibi_pool *pool;
+	struct i3c_generic_ibi_slot *slot;
+	unsigned int i;
+	int ret;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&pool->lock);
+	INIT_LIST_HEAD(&pool->free_slots);
+	INIT_LIST_HEAD(&pool->pending);
+
+	for (i = 0; i < req->num_slots; i++) {
+		slot = kzalloc(sizeof(*slot), GFP_KERNEL);
+		if (!slot)
+			return ERR_PTR(-ENOMEM);
+
+		i3c_master_init_ibi_slot(dev, &slot->base);
+
+		if (req->max_payload_len) {
+			slot->base.data = kzalloc(req->max_payload_len,
+						  GFP_KERNEL);
+			if (!slot->base.data) {
+				kfree(slot);
+				ret = -ENOMEM;
+				goto err_free_pool;
+			}
+		}
+
+		list_add_tail(&slot->node, &pool->free_slots);
+		pool->num_slots++;
+	}
+
+	return pool;
+
+err_free_pool:
+	i3c_generic_ibi_free_pool(pool);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_alloc_pool);
+
+/**
+ * i3c_generic_ibi_get_free_slot() - Get a free slot from a generic IBI pool
+ * @pool: the pool to query an IBI slot on
+ *
+ * Search for a free slot in a generic IBI pool.
+ * The slot should be returned to the pool using i3c_generic_ibi_recycle_slot()
+ * when it's no longer needed.
+ *
+ * Return: a pointer to a free slot, or NULL if there's no free slot available.
+ */
+struct i3c_ibi_slot *
+i3c_generic_ibi_get_free_slot(struct i3c_generic_ibi_pool *pool)
+{
+	struct i3c_generic_ibi_slot *slot;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	slot = list_first_entry_or_null(&pool->free_slots,
+					struct i3c_generic_ibi_slot, node);
+	if (slot)
+		list_del(&slot->node);
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	return slot ? &slot->base : NULL;
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_get_free_slot);
+
+/**
+ * i3c_generic_ibi_recycle_slot() - Return a slot to a generic IBI pool
+ * @pool: the pool to return the IBI slot to
+ * @s: IBI slot to recycle
+ *
+ * Add an IBI slot back to its generic IBI pool. Should be called from the
+ * master driver struct_master_controller_ops->recycle_ibi() method.
+ */
+void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
+				  struct i3c_ibi_slot *s)
+{
+	struct i3c_generic_ibi_slot *slot;
+	unsigned long flags;
+
+	if (!s)
+		return;
+
+	slot = container_of(s, struct i3c_generic_ibi_slot, base);
+	spin_lock_irqsave(&pool->lock, flags);
+	list_add_tail(&slot->node, &pool->free_slots);
+	spin_unlock_irqrestore(&pool->lock, flags);
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
+
+static void i3c_master_destroy_bus(struct i3c_master_controller *master)
+{
+	i3c_bus_unregister(master->bus);
+}
+
+static int i3c_master_create_bus(struct i3c_master_controller *master)
+{
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	i3cbus = i3c_bus_create(master->parent);
+	if (IS_ERR(i3cbus))
+		return PTR_ERR(i3cbus);
+
+	master->bus = i3cbus;
+
+	if (i3cbus->dev.of_node) {
+		ret = of_populate_i3c_bus(master);
+		if (ret)
+			goto err_destroy_bus;
+	}
+
+	ret = i3c_bus_register(i3cbus);
+	if (ret)
+		goto err_destroy_bus;
+
+	return 0;
+
+err_destroy_bus:
+	i3c_bus_unref(i3cbus);
+
+	return ret;
+}
+
+static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
+{
+	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers ||
+	    !ops->i2c_funcs)
+		return -EINVAL;
+
+	if (ops->request_ibi &&
+	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
+	     !ops->recycle_ibi_slot))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * i3c_master_register() - register an I3C master
+ * @master: master used to send frames on the bus
+ * @parent: the parent device (the one that provides this I3C master
+ *	    controller)
+ * @ops: the master controller operations
+ * @secondary: true if you are registering a secondary master. Will return
+ *	       -ENOTSUPP if set to true since secondary masters are not yet
+ *	       supported
+ *
+ * This function takes care of everything for you:
+ *
+ * - creates and initializes the I3C bus
+ * - populates the bus with static I2C devs if @parent->of_node is not
+ *   NULL
+ * - registers all I3C devices added by the controller during bus
+ *   initialization
+ * - registers the I2C adapter and all I2C devices
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_register(struct i3c_master_controller *master,
+			struct device *parent,
+			const struct i3c_master_controller_ops *ops,
+			bool secondary)
+{
+	int ret;
+
+	/* We do not support secondary masters yet. */
+	if (secondary)
+		return -ENOTSUPP;
+
+	ret = i3c_master_check_ops(ops);
+	if (ret)
+		return ret;
+
+	master->parent = parent;
+	master->ops = ops;
+	master->secondary = secondary;
+
+	ret = i3c_master_create_bus(master);
+	if (ret)
+		return ret;
+
+	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
+	if (!master->wq) {
+		ret = -ENOMEM;
+		goto err_destroy_bus;
+	}
+
+	ret = i3c_master_bus_init(master);
+	if (ret)
+		goto err_destroy_wq;
+
+	/*
+	 * Expose our I3C bus as an I2C adapter so that I2C devices are exposed
+	 * through the I2C subsystem.
+	 */
+	ret = i3c_master_i2c_adapter_init(master);
+	if (ret)
+		goto err_cleanup_bus;
+
+	/*
+	 * We're done initializing the bus and the controller, we can now
+	 * register I3C devices dicovered during the initial DAA.
+	 */
+	master->init_done = true;
+	i3c_bus_normaluse_lock(master->bus);
+	i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(master->bus);
+
+	return 0;
+
+err_cleanup_bus:
+	i3c_master_bus_cleanup(master);
+
+err_destroy_wq:
+	destroy_workqueue(master->wq);
+
+err_destroy_bus:
+	i3c_master_destroy_bus(master);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_register);
+
+/**
+ * i3c_master_unregister() - unregister an I3C master
+ * @master: master used to send frames on the bus
+ *
+ * Basically undo everything done in i3c_master_register().
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_unregister(struct i3c_master_controller *master)
+{
+	i3c_master_i2c_adapter_cleanup(master);
+	i3c_master_unregister_i3c_devs(master);
+	i3c_master_bus_cleanup(master);
+	destroy_workqueue(master->wq);
+	i3c_master_destroy_bus(master);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_unregister);
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
new file mode 100644
index 000000000000..b64e024b84aa
--- /dev/null
+++ b/include/linux/i3c/ccc.h
@@ -0,0 +1,382 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_CCC_H
+#define I3C_CCC_H
+
+#include <linux/bitops.h>
+
+/* I3C CCC (Common Command Codes) related definitions */
+#define I3C_CCC_DIRECT			BIT(7)
+
+#define I3C_CCC_ID(id, broadcast)	\
+	((id) | ((broadcast) ? 0 : I3C_CCC_DIRECT))
+
+/* Commands valid in both broadcast and unicast modes */
+#define I3C_CCC_ENEC(broadcast)		I3C_CCC_ID(0x0, broadcast)
+#define I3C_CCC_DISEC(broadcast)	I3C_CCC_ID(0x1, broadcast)
+#define I3C_CCC_ENTAS(as, broadcast)	I3C_CCC_ID(0x2 + (as), broadcast)
+#define I3C_CCC_RSTDAA(broadcast)	I3C_CCC_ID(0x6, broadcast)
+#define I3C_CCC_SETMWL(broadcast)	I3C_CCC_ID(0x9, broadcast)
+#define I3C_CCC_SETMRL(broadcast)	I3C_CCC_ID(0xa, broadcast)
+#define I3C_CCC_SETXTIME(broadcast)	((broadcast) ? 0x28 : 0x98)
+#define I3C_CCC_VENDOR(id, broadcast)	((id) + ((broadcast) ? 0x61 : 0xe0))
+
+/* Broadcast-only commands */
+#define I3C_CCC_ENTDAA			I3C_CCC_ID(0x7, true)
+#define I3C_CCC_DEFSLVS			I3C_CCC_ID(0x8, true)
+#define I3C_CCC_ENTTM			I3C_CCC_ID(0xb, true)
+#define I3C_CCC_ENTHDR(x)		I3C_CCC_ID(0x20 + (x), true)
+
+/* Unicast-only commands */
+#define I3C_CCC_SETDASA			I3C_CCC_ID(0x7, false)
+#define I3C_CCC_SETNEWDA		I3C_CCC_ID(0x8, false)
+#define I3C_CCC_GETMWL			I3C_CCC_ID(0xb, false)
+#define I3C_CCC_GETMRL			I3C_CCC_ID(0xc, false)
+#define I3C_CCC_GETPID			I3C_CCC_ID(0xd, false)
+#define I3C_CCC_GETBCR			I3C_CCC_ID(0xe, false)
+#define I3C_CCC_GETDCR			I3C_CCC_ID(0xf, false)
+#define I3C_CCC_GETSTATUS		I3C_CCC_ID(0x10, false)
+#define I3C_CCC_GETACCMST		I3C_CCC_ID(0x11, false)
+#define I3C_CCC_SETBRGTGT		I3C_CCC_ID(0x13, false)
+#define I3C_CCC_GETMXDS			I3C_CCC_ID(0x14, false)
+#define I3C_CCC_GETHDRCAP		I3C_CCC_ID(0x15, false)
+#define I3C_CCC_GETXTIME		I3C_CCC_ID(0x19, false)
+
+#define I3C_CCC_EVENT_SIR		BIT(0)
+#define I3C_CCC_EVENT_MR		BIT(1)
+#define I3C_CCC_EVENT_HJ		BIT(3)
+
+/**
+ * struct i3c_ccc_events - payload passed to ENEC/DISEC CCC
+ *
+ * @events: bitmask of I3C_CCC_EVENT_xxx events.
+ *
+ * Depending on the CCC command, the specific events coming from all devices
+ * (broadcast version) or a specific device (unicast version) will be
+ * enabled (ENEC) or disabled (DISEC).
+ */
+struct i3c_ccc_events {
+	u8 events;
+} __packed;
+
+/**
+ * struct i3c_ccc_mwl - payload passed to SETMWL/GETMWL CCC
+ *
+ * @len: maximum write length in bytes
+ *
+ * The maximum write length is only applicable to SDR private messages or
+ * extended Write CCCs (like SETXTIME).
+ */
+struct i3c_ccc_mwl {
+	__be16 len;
+} __packed;
+
+/**
+ * struct i3c_ccc_mrl - payload passed to SETMRL/GETMRL CCC
+ *
+ * @len: maximum read length in bytes
+ * @ibi_len: maximum IBI payload length
+ *
+ * The maximum read length is only applicable to SDR private messages or
+ * extended Read CCCs (like GETXTIME).
+ * The IBI length is only valid if the I3C slave is IBI capable
+ * (%I3C_BCR_IBI_REQ_CAP is set).
+ */
+struct i3c_ccc_mrl {
+	__be16 read_len;
+	u8 ibi_len;
+} __packed;
+
+/**
+ * struct i3c_ccc_dev_desc - I3C/I2C device descriptor used for DEFSLVS
+ *
+ * @dyn_addr: dynamic address assigned to the I3C slave or 0 if the entry is
+ *	      describing an I2C slave.
+ * @dcr: DCR value (not applicable to entries describing I2C devices)
+ * @lvr: LVR value (not applicable to entries describing I3C devices)
+ * @bcr: BCR value or 0 if this entry is describing an I2C slave
+ * @static_addr: static address or 0 if the device does not have a static
+ *		 address
+ *
+ * The DEFSLVS command should be passed an array of i3c_ccc_dev_desc
+ * descriptors (one entry per I3C/I2C dev controlled by the master).
+ */
+struct i3c_ccc_dev_desc {
+	u8 dyn_addr;
+	union {
+		u8 dcr;
+		u8 lvr;
+	};
+	u8 bcr;
+	u8 static_addr;
+} __packed;
+
+/**
+ * struct i3c_ccc_defslvs - payload passed to DEFSLVS CCC
+ *
+ * @count: number of dev descriptors
+ * @master: descriptor describing the current master
+ * @slaves: array of descriptors describing slaves controlled by the
+ *	    current master
+ *
+ * Information passed to the broadcast DEFSLVS to propagate device
+ * information to all masters currently acting as slaves on the bus.
+ * This is only meaningful if you have more than one master.
+ */
+struct i3c_ccc_defslvs {
+	u8 count;
+	struct i3c_ccc_dev_desc master;
+	struct i3c_ccc_dev_desc slaves[0];
+} __packed;
+
+/**
+ * enum i3c_ccc_test_mode - enum listing all available test modes
+ *
+ * @I3C_CCC_EXIT_TEST_MODE: exit test mode
+ * @I3C_CCC_VENDOR_TEST_MODE: enter vendor test mode
+ */
+enum i3c_ccc_test_mode {
+	I3C_CCC_EXIT_TEST_MODE,
+	I3C_CCC_VENDOR_TEST_MODE,
+};
+
+/**
+ * struct i3c_ccc_enttm - payload passed to ENTTM CCC
+ *
+ * @mode: one of the &enum i3c_ccc_test_mode modes
+ *
+ * Information passed to the ENTTM CCC to instruct an I3C device to enter a
+ * specific test mode.
+ */
+struct i3c_ccc_enttm {
+	u8 mode;
+} __packed;
+
+/**
+ * struct i3c_ccc_setda - payload passed to SETNEWDA and SETDASA CCCs
+ *
+ * @addr: dynamic address to assign to an I3C device
+ *
+ * Information passed to the SETNEWDA and SETDASA CCCs to assign/change the
+ * dynamic address of an I3C device.
+ */
+struct i3c_ccc_setda {
+	u8 addr;
+} __packed;
+
+/**
+ * struct i3c_ccc_getpid - payload passed to GETPID CCC
+ *
+ * @pid: 48 bits PID in big endian
+ */
+struct i3c_ccc_getpid {
+	u8 pid[6];
+} __packed;
+
+/**
+ * struct i3c_ccc_getbcr - payload passed to GETBCR CCC
+ *
+ * @bcr: BCR (Bus Characteristic Register) value
+ */
+struct i3c_ccc_getbcr {
+	u8 bcr;
+} __packed;
+
+/**
+ * struct i3c_ccc_getdcr - payload passed to GETDCR CCC
+ *
+ * @dcr: DCR (Device Characteristic Register) value
+ */
+struct i3c_ccc_getdcr {
+	u8 dcr;
+} __packed;
+
+#define I3C_CCC_STATUS_PENDING_INT(status)	((status) & GENMASK(3, 0))
+#define I3C_CCC_STATUS_PROTOCOL_ERROR		BIT(5)
+#define I3C_CCC_STATUS_ACTIVITY_MODE(status)	\
+	(((status) & GENMASK(7, 6)) >> 6)
+
+/**
+ * struct i3c_ccc_getstatus - payload passed to GETSTATUS CCC
+ *
+ * @status: status of the I3C slave (see I3C_CCC_STATUS_xxx macros for more
+ *	    information).
+ */
+struct i3c_ccc_getstatus {
+	__be16 status;
+} __packed;
+
+/**
+ * struct i3c_ccc_getaccmst - payload passed to GETACCMST CCC
+ *
+ * @newmaster: address of the master taking bus ownership
+ */
+struct i3c_ccc_getaccmst {
+	u8 newmaster;
+} __packed;
+
+/**
+ * struct i3c_ccc_bridged_slave_desc - bridged slave descriptor
+ *
+ * @addr: dynamic address of the bridged device
+ * @id: ID of the slave device behind the bridge
+ */
+struct i3c_ccc_bridged_slave_desc {
+	u8 addr;
+	__be16 id;
+} __packed;
+
+/**
+ * struct i3c_ccc_setbrgtgt - payload passed to SETBRGTGT CCC
+ *
+ * @count: number of bridged slaves
+ * @bslaves: bridged slave descriptors
+ */
+struct i3c_ccc_setbrgtgt {
+	u8 count;
+	struct i3c_ccc_bridged_slave_desc bslaves[0];
+} __packed;
+
+/**
+ * enum i3c_sdr_max_data_rate - max data rate values for private SDR transfers
+ */
+enum i3c_sdr_max_data_rate {
+	I3C_SDR0_FSCL_MAX,
+	I3C_SDR1_FSCL_8MHZ,
+	I3C_SDR2_FSCL_6MHZ,
+	I3C_SDR3_FSCL_4MHZ,
+	I3C_SDR4_FSCL_2MHZ,
+};
+
+/**
+ * enum i3c_tsco - clock to data turn-around
+ */
+enum i3c_tsco {
+	I3C_TSCO_8NS,
+	I3C_TSCO_9NS,
+	I3C_TSCO_10NS,
+	I3C_TSCO_11NS,
+	I3C_TSCO_12NS,
+};
+
+#define I3C_CCC_MAX_SDR_FSCL_MASK	GENMASK(2, 0)
+#define I3C_CCC_MAX_SDR_FSCL(x)		((x) & I3C_CCC_MAX_SDR_FSCL_MASK)
+
+/**
+ * struct i3c_ccc_getmxds - payload passed to GETMXDS CCC
+ *
+ * @maxwr: write limitations
+ * @maxrd: read limitations
+ * @maxrdturn: maximum read turn-around expressed micro-seconds and
+ *	       little-endian formatted
+ */
+struct i3c_ccc_getmxds {
+	u8 maxwr;
+	u8 maxrd;
+	u8 maxrdturn[3];
+} __packed;
+
+#define I3C_CCC_HDR_MODE(mode)		BIT(mode)
+
+/**
+ * struct i3c_ccc_gethdrcap - payload passed to GETHDRCAP CCC
+ *
+ * @modes: bitmap of supported HDR modes
+ */
+struct i3c_ccc_gethdrcap {
+	u8 modes;
+} __packed;
+
+/**
+ * enum i3c_ccc_setxtime_subcmd - SETXTIME sub-commands
+ */
+enum i3c_ccc_setxtime_subcmd {
+	I3C_CCC_SETXTIME_ST = 0x7f,
+	I3C_CCC_SETXTIME_DT = 0xbf,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE0 = 0xdf,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE1 = 0xef,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE2 = 0xf7,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE3 = 0xfb,
+	I3C_CCC_SETXTIME_ASYNC_TRIGGER = 0xfd,
+	I3C_CCC_SETXTIME_TPH = 0x3f,
+	I3C_CCC_SETXTIME_TU = 0x9f,
+	I3C_CCC_SETXTIME_ODR = 0x8f,
+};
+
+/**
+ * struct i3c_ccc_setxtime - payload passed to SETXTIME CCC
+ *
+ * @subcmd: one of the sub-commands ddefined in &enum i3c_ccc_setxtime_subcmd
+ * @data: sub-command payload. Amount of data is determined by
+ *	  &i3c_ccc_setxtime->subcmd
+ */
+struct i3c_ccc_setxtime {
+	u8 subcmd;
+	u8 data[0];
+} __packed;
+
+#define I3C_CCC_GETXTIME_SYNC_MODE	BIT(0)
+#define I3C_CCC_GETXTIME_ASYNC_MODE(x)	BIT((x) + 1)
+#define I3C_CCC_GETXTIME_OVERFLOW	BIT(7)
+
+/**
+ * struct i3c_ccc_getxtime - payload retrieved from GETXTIME CCC
+ *
+ * @supported_modes: bitmap describing supported XTIME modes
+ * @state: current status (enabled mode and overflow status)
+ * @frequency: slave's internal oscillator frequency in 500KHz steps
+ * @inaccuracy: slave's internal oscillator inaccuracy in 0.1% steps
+ */
+struct i3c_ccc_getxtime {
+	u8 supported_modes;
+	u8 state;
+	u8 frequency;
+	u8 inaccuracy;
+} __packed;
+
+/**
+ * struct i3c_ccc_cmd_payload - CCC payload
+ *
+ * @len: payload length
+ * @data: payload data
+ */
+struct i3c_ccc_cmd_payload {
+	u16 len;
+	void *data;
+};
+
+/**
+ * struct i3c_ccc_cmd_dest - CCC command destination
+ *
+ * @addr: can be an I3C device address or the broadcast address if this is a
+ *	  broadcast CCC
+ * @payload: payload to be sent to this device or broadcasted
+ */
+struct i3c_ccc_cmd_dest {
+	u8 addr;
+	struct i3c_ccc_cmd_payload payload;
+};
+
+/**
+ * struct i3c_ccc_cmd - CCC command
+ *
+ * @rnw: true if the CCC should retrieve data from the device. Only valid for
+ *	 unicast commands
+ * @id: CCC command id
+ * @dests: array of destinations and associated payload for this CCC. Most of
+ *	   the time, only one destination is provided
+ * @ndests: number of destinations. Should always be one for broadcast commands
+ */
+struct i3c_ccc_cmd {
+	bool rnw;
+	u8 id;
+	struct i3c_ccc_cmd_dest *dests;
+	int ndests;
+};
+
+#endif /* I3C_CCC_H */
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
new file mode 100644
index 000000000000..8d82a5516daa
--- /dev/null
+++ b/include/linux/i3c/device.h
@@ -0,0 +1,307 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_DEV_H
+#define I3C_DEV_H
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/kconfig.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+/**
+ * enum i3c_hdr_mode - HDR mode ids
+ * @I3C_HDR_DDR: DDR mode
+ * @I3C_HDR_TSP: TSP mode
+ * @I3C_HDR_TSL: TSL mode
+ */
+enum i3c_hdr_mode {
+	I3C_HDR_DDR,
+	I3C_HDR_TSP,
+	I3C_HDR_TSL,
+};
+
+/**
+ * struct i3c_priv_xfer - I3C SDR private transfer
+ * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @len: transfer length in bytes of the transfer
+ * @data: input/output buffer
+ * @data.in: input buffer. Must point to a DMA-able buffer
+ * @data.out: output buffer. Must point to a DMA-able buffer
+ */
+struct i3c_priv_xfer {
+	bool rnw;
+	u16 len;
+	union {
+		void *in;
+		const void *out;
+	} data;
+};
+
+/**
+ * enum i3c_dcr - I3C DCR values
+ * @I3C_DCR_GENERIC_DEVICE: generic I3C device
+ */
+enum i3c_dcr {
+	I3C_DCR_GENERIC_DEVICE = 0,
+};
+
+#define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
+#define I3C_PID_RND_LOWER_32BITS(pid)	(!!((pid) & BIT_ULL(32)))
+#define I3C_PID_RND_VAL(pid)		((pid) & GENMASK_ULL(31, 0))
+#define I3C_PID_PART_ID(pid)		(((pid) & GENMASK_ULL(31, 16)) >> 16)
+#define I3C_PID_INSTANCE_ID(pid)	(((pid) & GENMASK_ULL(15, 12)) >> 12)
+#define I3C_PID_EXTRA_INFO(pid)		((pid) & GENMASK_ULL(11, 0))
+
+#define I3C_BCR_DEVICE_ROLE(bcr)	((bcr) & GENMASK(7, 6))
+#define I3C_BCR_I3C_SLAVE		(0 << 6)
+#define I3C_BCR_I3C_MASTER		(1 << 6)
+#define I3C_BCR_HDR_CAP			BIT(5)
+#define I3C_BCR_BRIDGE			BIT(4)
+#define I3C_BCR_OFFLINE_CAP		BIT(3)
+#define I3C_BCR_IBI_PAYLOAD		BIT(2)
+#define I3C_BCR_IBI_REQ_CAP		BIT(1)
+#define I3C_BCR_MAX_DATA_SPEED_LIM	BIT(0)
+
+/**
+ * struct i3c_device_info - I3C device information
+ * @pid: Provisional ID
+ * @bcr: Bus Characteristic Register
+ * @dcr: Device Characteristic Register
+ * @static_addr: static/I2C address
+ * @dyn_addr: dynamic address
+ * @hdr_cap: supported HDR modes
+ * @max_read_ds: max read speed information
+ * @max_write_ds: max write speed information
+ * @max_ibi_len: max IBI payload length
+ * @max_read_turnaround: max read turn-around time in micro-seconds
+ * @max_read_len: max private SDR read length in bytes
+ * @max_write_len: max private SDR write length in bytes
+ *
+ * These are all basic information that should be advertised by an I3C device.
+ * Some of them are optional depending on the device type and device
+ * capabilities.
+ * For each I3C slave attached to a master with
+ * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
+ * to retrieve these data.
+ */
+struct i3c_device_info {
+	u64 pid;
+	u8 bcr;
+	u8 dcr;
+	u8 static_addr;
+	u8 dyn_addr;
+	u8 hdr_cap;
+	u8 max_read_ds;
+	u8 max_write_ds;
+	u8 max_ibi_len;
+	u32 max_read_turnaround;
+	u16 max_read_len;
+	u16 max_write_len;
+};
+
+/*
+ * I3C device internals are kept hidden from I3C device users. It's just
+ * simpler to refactor things when everything goes through getter/setters, and
+ * I3C device drivers should not have to worry about internal representation
+ * anyway.
+ */
+struct i3c_device;
+
+/* These macros should be used to i3c_device_id entries. */
+#define I3C_MATCH_MANUF_AND_PART (I3C_MATCH_MANUF | I3C_MATCH_PART)
+
+#define I3C_DEVICE(_manufid, _partid, _drvdata)				\
+	{								\
+		.match_flags = I3C_MATCH_MANUF_AND_PART,		\
+		.manuf_id = _manufid,					\
+		.part_id = _partid,					\
+		.data = _drvdata,					\
+	}
+
+#define I3C_DEVICE_EXTRA_INFO(_manufid, _partid, _info, _drvdata)	\
+	{								\
+		.match_flags = I3C_MATCH_MANUF_AND_PART |		\
+			       I3C_MATCH_EXTRA_INFO,			\
+		.manuf_id = _manufid,					\
+		.part_id = _partid,					\
+		.extra_info = _info,					\
+		.data = _drvdata,					\
+	}
+
+#define I3C_CLASS(_dcr, _drvdata)					\
+	{								\
+		.match_flags = I3C_MATCH_DCR,				\
+		.dcr = _dcr,						\
+	}
+
+/**
+ * struct i3c_driver - I3C device driver
+ * @driver: inherit from device_driver
+ * @probe: I3C device probe method
+ * @remove: I3C device remove method
+ * @id_table: I3C device match table. Will be used by the framework to decide
+ *	      which device to bind to this driver
+ */
+struct i3c_driver {
+	struct device_driver driver;
+	int (*probe)(struct i3c_device *dev);
+	int (*remove)(struct i3c_device *dev);
+	const struct i3c_device_id *id_table;
+};
+
+static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
+{
+	return container_of(drv, struct i3c_driver, driver);
+}
+
+struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
+struct i3c_device *dev_to_i3cdev(struct device *dev);
+
+static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
+				      void *data)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+
+	dev_set_drvdata(dev, data);
+}
+
+static inline void *i3cdev_get_drvdata(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+
+	return dev_get_drvdata(dev);
+}
+
+int i3c_driver_register_with_owner(struct i3c_driver *drv,
+				   struct module *owner);
+void i3c_driver_unregister(struct i3c_driver *drv);
+
+#define i3c_driver_register(__drv)		\
+	i3c_driver_register_with_owner(__drv, THIS_MODULE)
+
+/**
+ * module_i3c_driver() - Register a module providing an I3C driver
+ * @__drv: the I3C driver to register
+ *
+ * Provide generic init/exit functions that simply register/unregister an I3C
+ * driver.
+ * Should be used by any driver that does not require extra init/cleanup steps.
+ */
+#define module_i3c_driver(__drv)		\
+	module_driver(__drv, i3c_driver_register, i3c_driver_unregister)
+
+/**
+ * i3c_i2c_driver_register() - Register an i2c and an i3c driver
+ * @i3cdrv: the I3C driver to register
+ * @i2cdrv: the I2C driver to register
+ *
+ * This function registers both @i2cdev and @i3cdev, and fails if one of these
+ * registrations fails. This is mainly useful for devices that support both I2C
+ * and I3C modes.
+ * Note that when CONFIG_I3C is not enabled, this function only registers the
+ * I2C driver.
+ *
+ * Return: 0 if both registrations succeeds, a negative error code otherwise.
+ */
+static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
+					  struct i2c_driver *i2cdrv)
+{
+	int ret;
+
+	ret = i2c_add_driver(i2cdrv);
+	if (ret || !IS_ENABLED(CONFIG_I3C))
+		return ret;
+
+	ret = i3c_driver_register(i3cdrv);
+	if (ret)
+		i2c_del_driver(i2cdrv);
+
+	return ret;
+}
+
+/**
+ * i3c_i2c_driver_unregister() - Unregister an i2c and an i3c driver
+ * @i3cdrv: the I3C driver to register
+ * @i2cdrv: the I2C driver to register
+ *
+ * This function unregisters both @i3cdrv and @i2cdrv.
+ * Note that when CONFIG_I3C is not enabled, this function only unregisters the
+ * @i2cdrv.
+ */
+static inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
+					     struct i2c_driver *i2cdrv)
+{
+	if (IS_ENABLED(CONFIG_I3C))
+		i3c_driver_unregister(i3cdrv);
+
+	i2c_del_driver(i2cdrv);
+}
+
+/**
+ * module_i3c_i2c_driver() - Register a module providing an I3C and an I2C
+ *			     driver
+ * @__i3cdrv: the I3C driver to register
+ * @__i2cdrv: the I3C driver to register
+ *
+ * Provide generic init/exit functions that simply register/unregister an I3C
+ * and an I2C driver.
+ * This macro can be used even if CONFIG_I3C is disabled, in this case, only
+ * the I2C driver will be registered.
+ * Should be used by any driver that does not require extra init/cleanup steps.
+ */
+#define module_i3c_i2c_driver(__i3cdrv, __i2cdrv)	\
+	module_driver(__i3cdrv,				\
+		      i3c_i2c_driver_register,		\
+		      i3c_i2c_driver_unregister)
+
+int i3c_device_do_priv_xfers(struct i3c_device *dev,
+			     struct i3c_priv_xfer *xfers,
+			     int nxfers);
+
+void i3c_device_get_info(struct i3c_device *dev, struct i3c_device_info *info);
+
+struct i3c_ibi_payload {
+	unsigned int len;
+	const void *data;
+};
+
+/**
+ * struct i3c_ibi_setup - IBI setup object
+ * @max_payload_len: maximum length of the payload associated to an IBI. If one
+ *		     IBI appears to have a payload that is bigger than this
+ *		     number, the IBI will be rejected.
+ * @num_slots: number of pre-allocated IBI slots. This should be chosen so that
+ *	       the system never runs out of IBI slots, otherwise you'll lose
+ *	       IBIs.
+ * @handler: IBI handler, every time an IBI is received. This handler is called
+ *	     in a workqueue context. It is allowed to sleep and send new
+ *	     messages on the bus, though it's recommended to keep the
+ *	     processing done there as fast as possible to avoid delaying
+ *	     processing of other queued on the same workqueue.
+ *
+ * Temporary structure used to pass information to i3c_device_request_ibi().
+ * This object can be allocated on the stack since i3c_device_request_ibi()
+ * copies every bit of information and do not use it after
+ * i3c_device_request_ibi() has returned.
+ */
+struct i3c_ibi_setup {
+	unsigned int max_payload_len;
+	unsigned int num_slots;
+	void (*handler)(struct i3c_device *dev,
+			const struct i3c_ibi_payload *payload);
+};
+
+int i3c_device_request_ibi(struct i3c_device *dev,
+			   const struct i3c_ibi_setup *setup);
+void i3c_device_free_ibi(struct i3c_device *dev);
+int i3c_device_enable_ibi(struct i3c_device *dev);
+int i3c_device_disable_ibi(struct i3c_device *dev);
+
+#endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
new file mode 100644
index 000000000000..4c0595b2c2dc
--- /dev/null
+++ b/include/linux/i3c/master.h
@@ -0,0 +1,587 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_MASTER_H
+#define I3C_MASTER_H
+
+#include <asm/bitsperlong.h>
+
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/i3c/ccc.h>
+#include <linux/i3c/device.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#define I3C_HOT_JOIN_ADDR		0x2
+#define I3C_BROADCAST_ADDR		0x7e
+#define I3C_MAX_ADDR			GENMASK(6, 0)
+
+struct i3c_master_controller;
+struct i3c_bus;
+
+/**
+ * struct i3c_i2c_dev - I3C/I2C common information
+ * @node: node element used to insert the device into the I2C or I3C device
+ *	  list
+ * @bus: I3C bus this device is connected to
+ * @master: I3C master that instantiated this device. Will be used to send
+ *	    I2C/I3C frames on the bus
+ * @master_priv: master private data assigned to the device. Can be used to
+ *		 add master specific information
+ *
+ * This structure is describing common I3C/I2C dev information.
+ */
+struct i3c_i2c_dev {
+	struct list_head node;
+	struct i3c_bus *bus;
+	struct i3c_master_controller *master;
+	void *master_priv;
+};
+
+#define I3C_LVR_I2C_INDEX_MASK		GENMASK(7, 5)
+#define I3C_LVR_I2C_INDEX(x)		((x) << 5)
+#define I3C_LVR_I2C_FM_MODE		BIT(4)
+
+#define I2C_MAX_ADDR			GENMASK(9, 0)
+
+/**
+ * struct i2c_device - I2C device object
+ * @common: inherit common I3C/I2C description
+ * @info: I2C board info used to instantiate the I2C device. If you are
+ *	  using DT to describe your hardware, this will be filled for you
+ * @client: I2C client object created by the I2C framework. This will only
+ *	    be valid after i3c_master_register() returns
+ * @lvr: Legacy Virtual Register value as described in the I3C specification
+ *
+ * I2C device object. Note that the real I2C device is represented by
+ * i2c_device->client, but we need extra information to handle the device when
+ * it's connected to an I3C bus, hence the &struct i2c_device wrapper.
+ *
+ * The I2C framework is not impacted by this new representation.
+ */
+struct i2c_device {
+	struct i3c_i2c_dev common;
+	struct i2c_board_info info;
+	struct i2c_client *client;
+	u8 lvr;
+};
+
+/**
+ * struct i3c_ibi_slot - I3C IBI (In-Band Interrupt) slot
+ * @work: work associated to this slot. The IBI handler will be called from
+ *	  there
+ * @dev: the I3C device that has generated this IBI
+ * @len: length of the payload associated to this IBI
+ * @data: payload buffer
+ *
+ * An IBI slot is an object pre-allocated by the controller and used when an
+ * IBI comes in.
+ * Every time an IBI comes in, the I3C master driver should find a free IBI
+ * slot in its IBI slot pool, retrieve the IBI payload and queue the IBI using
+ * i3c_master_queue_ibi().
+ *
+ * How IBI slots are allocated is left to the I3C master driver, though, for
+ * simple kmalloc-based allocation, the generic IBI slot pool can be used.
+ */
+struct i3c_ibi_slot {
+	struct work_struct work;
+	struct i3c_device *dev;
+	unsigned int len;
+	void *data;
+};
+
+/**
+ * struct i3c_device_ibi_info - IBI information attached to a specific device
+ * @all_ibis_handled: used to be informed when no more IBIs are waiting to be
+ *		      processed. Used by i3c_device_disable_ibi() to wait for
+ *		      all IBIs to be dequeued
+ * @pending_ibis: count the number of pending IBIs. Each pending IBI has its
+ *		  work element queued to the controller workqueue
+ * @max_payload_len: maximum payload length for an IBI coming from this device.
+ *		     this value is specified when calling
+ *		     i3c_device_request_ibi() and should not change at run
+ *		     time. All messages IBIs exceeding this limit should be
+ *		     rejected by the master
+ * @enabled: reflect the IBI status
+ * @handler: IBI handler specified at i3c_device_request_ibi() call time. This
+ *	     handler will be called from the controller workqueue, and as such
+ *	     is allowed to sleep (though it is recommended to process the IBI
+ *	     as fast as possible to not stall processing of other IBIs queued
+ *	     on the same workqueue).
+ *	     New I3C messages can be sent from the IBI handler
+ *
+ * The &struct_i3c_device_ibi_info object is allocated when
+ * i3c_device_request_ibi() is called and attached to a specific device. This
+ * object is here to manage IBIs coming from a specific I3C device.
+ *
+ * Note that this structure is the generic view of the IBI management
+ * infrastructure. I3C master drivers may have their own internal
+ * representation which they can associate to the device using
+ * controller-private data.
+ */
+struct i3c_device_ibi_info {
+	struct completion all_ibis_handled;
+	atomic_t pending_ibis;
+	unsigned int max_payload_len;
+	bool enabled;
+	void (*handler)(struct i3c_device *dev,
+			const struct i3c_ibi_payload *payload);
+};
+
+/**
+ * struct i3c_device - I3C device object
+ * @common: inherit common I3C/I2C description
+ * @dev: device object to register the I3C dev to the device model
+ * @regfailed: true if the device has already been registered to the device
+ *	       model and this operation failed. The goal it to not try
+ *	       register the device everytime a new device is discovered on
+ *	       the bus
+ * @info: I3C device information. Will be automatically filled when you create
+ *	  your device with i3c_master_add_i3c_dev_locked()
+ * @init_dyn_addr: initial dynamic address requested by the FW
+ * @ibi_lock: lock used to protect the &struct_i3c_device->ibi
+ * @ibi: IBI info attached to a device. Should be NULL until
+ *	 i3c_device_request_ibi() is called
+ *
+ * I3C device object. Every I3C devs on the I3C bus are represented, including
+ * I3C masters. For each of them, we have an instance of &struct i3c_device.
+ */
+struct i3c_device {
+	struct i3c_i2c_dev common;
+	struct device dev;
+	bool regfailed;
+	struct i3c_device_info info;
+	u8 init_dyn_addr;
+	struct mutex ibi_lock;
+	struct i3c_device_ibi_info *ibi;
+};
+
+/*
+ * The I3C specification says the maximum number of devices connected on the
+ * bus is 11, but this number depends on external parameters like trace length,
+ * capacitive load per Device, and the types of Devices present on the Bus.
+ * I3C master can also have limitations, so this number is just here as a
+ * reference and should be adjusted on a per-controller/per-board basis.
+ */
+#define I3C_BUS_MAX_DEVS		11
+
+#define I3C_BUS_MAX_I3C_SCL_RATE	12900000
+#define I3C_BUS_TYP_I3C_SCL_RATE	12500000
+#define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
+#define I3C_BUS_I2C_FM_SCL_RATE		400000
+#define I3C_BUS_TLOW_OD_MIN_NS		200
+
+/**
+ * enum i3c_bus_mode - I3C bus mode
+ * @I3C_BUS_MODE_PURE: only I3C devices are connected to the bus. No limitation
+ *		       expected
+ * @I3C_BUS_MODE_MIXED_FAST: I2C devices with 50ns spike filter are present on
+ *			     the bus. The only impact in this mode is that the
+ *			     high SCL pulse has to stay below 50ns to trick I2C
+ *			     devices when transmitting I3C frames
+ * @I3C_BUS_MODE_MIXED_SLOW: I2C devices without 50ns spike filter are present
+ *			     on the bus
+ */
+enum i3c_bus_mode {
+	I3C_BUS_MODE_PURE,
+	I3C_BUS_MODE_MIXED_FAST,
+	I3C_BUS_MODE_MIXED_SLOW,
+};
+
+/**
+ * enum i3c_addr_slot_status - I3C address slot status
+ * @I3C_ADDR_SLOT_FREE: address is free
+ * @I3C_ADDR_SLOT_RSVD: address is reserved
+ * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
+ * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
+ * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ *
+ * On an I3C bus, addresses are assigned dynamically, and we need to know which
+ * addresses are free to use and which ones are already assigned.
+ *
+ * Addresses marked as reserved are those reserved by the I3C protocol
+ * (broadcast address, ...).
+ */
+enum i3c_addr_slot_status {
+	I3C_ADDR_SLOT_FREE,
+	I3C_ADDR_SLOT_RSVD,
+	I3C_ADDR_SLOT_I2C_DEV,
+	I3C_ADDR_SLOT_I3C_DEV,
+	I3C_ADDR_SLOT_STATUS_MASK = 3,
+};
+
+/**
+ * struct i3c_bus - I3C bus object
+ * @dev: device to be registered to the device-model
+ * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
+ *		this can change over the time. Will be used to let a master
+ *		know whether it needs to request bus ownership before sending
+ *		a frame or not
+ * @id: bus ID. Assigned by the framework when register the bus
+ * @addrslots: a bitmap with 2-bits per-slot to encode the address status and
+ *	       ease the DAA (Dynamic Address Assignment) procedure (see
+ *	       &enum i3c_addr_slot_status)
+ * @mode: bus mode (see &enum i3c_bus_mode)
+ * @scl_rate: SCL signal rate for I3C and I2C mode
+ * @devs: 2 lists containing all I3C/I2C devices connected to the bus
+ * @lock: read/write lock on the bus. This is needed to protect against
+ *	  operations that have an impact on the whole bus and the devices
+ *	  connected to it. For example, when asking slaves to drop their
+ *	  dynamic address (RSTDAA CCC), we need to make sure no one is trying
+ *	  to send I3C frames to these devices.
+ *	  Note that this lock does not protect against concurrency between
+ *	  devices: several drivers can send different I3C/I2C frames through
+ *	  the same master in parallel. This is the responsibility of the
+ *	  master to guarantee that frames are actually sent sequentially and
+ *	  not interlaced
+ *
+ * The I3C bus is represented with its own object and not implicitly described
+ * by the I3C master to cope with the multi-master functionality, where one bus
+ * can be shared amongst several masters, each of them requesting bus ownership
+ * when they need to.
+ */
+struct i3c_bus {
+	struct device dev;
+	struct i3c_device *cur_master;
+	int id;
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	enum i3c_bus_mode mode;
+	struct {
+		unsigned long i3c;
+		unsigned long i2c;
+	} scl_rate;
+	struct {
+		struct list_head i3c;
+		struct list_head i2c;
+	} devs;
+	struct rw_semaphore lock;
+};
+
+struct i3c_master_controller;
+
+/**
+ * struct i3c_master_controller_ops - I3C master methods
+ * @bus_init: hook responsible for the I3C bus initialization. You should at
+ *	      least call master_set_info() from there and set the bus mode.
+ *	      You can also put controller specific initialization in there.
+ *	      This method is mandatory.
+ * @bus_cleanup: cleanup everything done in
+ *		 &i3c_master_controller_ops->bus_init().
+ *		 This method is optional.
+ * @attach_i3c_dev: called every time an I3C device is attached to the bus. It
+ *		    can be after a DAA or when a device is statically declared
+ *		    by the FW, in which case it will only have a static address
+ *		    and the dynamic address will be 0.
+ *		    This is a good place to attach master controller specific
+ *		    data to I3C devices.
+ *		    This method is optional.
+ * @reattach_i3c_dev: called every time an I3C device has its addressed
+ *		      changed. It can be because the device has been powered
+ *		      down and has lost its address, or it can happen when a
+ *		      device had a static address and has been assigned a
+ *		      dynamic address with SETDASA.
+ *		      This method is optional.
+ * @detach_i3c_dev: called when an I3C device is detached from the bus. Usually
+ *		    happens when the master device is unregistered.
+ *		    This method is optional.
+ * @do_daa: do a DAA (Dynamic Address Assignment) procedure. This is procedure
+ *	    should send an ENTDAA CCC command and then add all devices
+ *	    discovered sure the DAA using i3c_master_add_i3c_dev_locked().
+ *	    Add devices added with i3c_master_add_i3c_dev_locked() will then be
+ *	    attached or re-attached to the controller.
+ *	    This method is mandatory.
+ * @supports_ccc_cmd: should return true if the CCC command is supported, false
+ *		      otherwise.
+ *		      This method is optional, if not provided the core assumes
+ *		      all CCC commands are supported.
+ * @send_ccc_cmd: send a CCC command
+ *		  This method is mandatory.
+ * @priv_xfers: do one or several private I3C SDR transfers
+ *		This method is mandatory.
+ * @attach_i2c_dev: called every time an I2C device is attached to the bus.
+ *		    This is a good place to attach master controller specific
+ *		    data to I2C devices.
+ *		    This method is optional.
+ * @detach_i2c_dev: called when an I2C device is detached from the bus. Usually
+ *		    happens when the master device is unregistered.
+ *		    This method is optional.
+ * @i2c_xfers: do one or several I2C transfers.
+ *	       This method is mandatory.
+ * @i2c_funcs: expose the supported I2C functionalities.
+ *	       This method is mandatory.
+ * @request_ibi: attach an IBI handler to an I3C device. This implies defining
+ *		 an IBI handler and the constraints of the IBI (maximum payload
+ *		 length and number of pre-allocated slots).
+ *		 Some controllers support less IBI-capable devices than regular
+ *		 devices, so this method might return -%EBUSY if there's no
+ *		 more space for an extra IBI registration
+ *		 This method is optional.
+ * @free_ibi: free an IBI previously requested with ->request_ibi(). The IBI
+ *	      should have been disabled with ->disable_irq() prior to that
+ *	      This method is mandatory only if ->request_ibi is not NULL.
+ * @enable_ibi: enable the IBI. Only valid if ->request_ibi() has been called
+ *		prior to ->enable_ibi(). The controller should first enable
+ *		the IBI on the controller end (for example, unmask the hardware
+ *		IRQ) and then send the ENEC CCC command (with the IBI flag set)
+ *		to the I3C device.
+ *		This method is mandatory only if ->request_ibi is not NULL.
+ * @disable_ibi: disable an IBI. First send the DISEC CCC command with the IBI
+ *		 flag set and then deactivate the hardware IRQ on the
+ *		 controller end.
+ *		 This method is mandatory only if ->request_ibi is not NULL.
+ * @recycle_ibi_slot: recycle an IBI slot. Called every time an IBI has been
+ *		      processed by its handler. The IBI slot should be put back
+ *		      in the IBI slot pool so that the controller can re-use it
+ *		      for a future IBI
+ *		      This method is mandatory only if ->request_ibi is not
+ *		      NULL.
+ */
+struct i3c_master_controller_ops {
+	int (*bus_init)(struct i3c_master_controller *master);
+	void (*bus_cleanup)(struct i3c_master_controller *master);
+	int (*attach_i3c_dev)(struct i3c_device *dev);
+	void (*reattach_i3c_dev)(struct i3c_device *dev, u8 old_dyn_addr);
+	void (*detach_i3c_dev)(struct i3c_device *dev);
+	int (*do_daa)(struct i3c_master_controller *master);
+	bool (*supports_ccc_cmd)(struct i3c_master_controller *master,
+				 const struct i3c_ccc_cmd *cmd);
+	int (*send_ccc_cmd)(struct i3c_master_controller *master,
+			    struct i3c_ccc_cmd *cmd);
+	int (*priv_xfers)(struct i3c_device *dev,
+			  const struct i3c_priv_xfer *xfers,
+			  int nxfers);
+	int (*attach_i2c_dev)(struct i2c_device *dev);
+	void (*detach_i2c_dev)(struct i2c_device *dev);
+	int (*i2c_xfers)(struct i2c_device *dev,
+			 const struct i2c_msg *xfers, int nxfers);
+	u32 (*i2c_funcs)(struct i3c_master_controller *master);
+	int (*request_ibi)(struct i3c_device *dev,
+			   const struct i3c_ibi_setup *req);
+	void (*free_ibi)(struct i3c_device *dev);
+	int (*enable_ibi)(struct i3c_device *dev);
+	int (*disable_ibi)(struct i3c_device *dev);
+	void (*recycle_ibi_slot)(struct i3c_device *dev,
+				 struct i3c_ibi_slot *slot);
+};
+
+/**
+ * struct i3c_master_controller - I3C master controller object
+ * @parent: parent device that instantiated this master
+ * @this: an I3C device object representing this master. This device will be
+ *	  added to the list of I3C devs available on the bus
+ * @i2c: I2C adapter used for backward compatibility. This adapter is
+ *	 registered to the I2C subsystem to be as transparent as possible to
+ *	 existing I2C drivers
+ * @ops: master operations. See &struct i3c_master_controller_ops
+ * @secondary: true if the master is a secondary master
+ * @init_done: true when the bus initialization is done
+ * @bus: I3C bus object created by this master
+ * @wq: workqueue used to execute IBI handlers. Can also be used by master
+ *	drivers if they need to postpone operations that need to take place
+ *	in a thread context. Typical examples are Hot Join processing which
+ *	requires taking the bus lock in maintenance, which in turn, can only
+ *	be done from a sleep-able context
+ *
+ * A &struct i3c_master_controller has to be registered to the I3C subsystem
+ * through i3c_master_register(). None of &struct i3c_master_controller fields
+ * should be set manually, just pass appropriate values to
+ * i3c_master_register().
+ */
+struct i3c_master_controller {
+	struct device *parent;
+	struct i3c_device *this;
+	struct i2c_adapter i2c;
+	const struct i3c_master_controller_ops *ops;
+	bool secondary;
+	bool init_done;
+	struct i3c_bus *bus;
+	struct workqueue_struct *wq;
+};
+
+/**
+ * i3c_bus_for_each_i2cdev() - iterate over all I2C devices present on the bus
+ * @bus: the I3C bus
+ * @i2cdev: an I2C device updated to point to the current device at each loop
+ *	    iteration
+ *
+ * Iterate over all I2C devs present on the bus.
+ */
+#define i3c_bus_for_each_i2cdev(bus, i2cdev)				\
+	list_for_each_entry(i2cdev, &(bus)->devs.i2c, common.node)
+
+/**
+ * i3c_bus_for_each_i3cdev() - iterate over all I3C devices present on the bus
+ * @bus: the I3C bus
+ * @i3cdev: an I3C device updated to point to the current device at each loop
+ *	    iteration
+ *
+ * Iterate over all I3C devs present on the bus.
+ */
+#define i3c_bus_for_each_i3cdev(bus, i3cdev)				\
+	list_for_each_entry(i3cdev, &(bus)->devs.i3c, common.node)
+
+void i3c_bus_maintenance_lock(struct i3c_bus *bus);
+void i3c_bus_maintenance_unlock(struct i3c_bus *bus);
+void i3c_bus_normaluse_lock(struct i3c_bus *bus);
+void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
+
+int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
+			    const struct i2c_msg *xfers,
+			    int nxfers);
+
+int i3c_master_disec_locked(struct i3c_master_controller *master, u8 addr,
+			    u8 evts);
+int i3c_master_enec_locked(struct i3c_master_controller *master, u8 addr,
+			   u8 evts);
+int i3c_master_entdaa_locked(struct i3c_master_controller *master);
+int i3c_master_defslvs_locked(struct i3c_master_controller *master);
+
+int i3c_master_get_free_addr(struct i3c_master_controller *master,
+			     u8 start_addr);
+
+int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
+				  u8 addr);
+int i3c_master_do_daa(struct i3c_master_controller *master);
+
+int i3c_master_set_info(struct i3c_master_controller *master,
+			const struct i3c_device_info *info);
+
+int i3c_master_register(struct i3c_master_controller *master,
+			struct device *parent,
+			const struct i3c_master_controller_ops *ops,
+			bool secondary);
+int i3c_master_unregister(struct i3c_master_controller *master);
+
+/**
+ * i3c_device_get_master_data() - get master private data attached to an I3C
+ *				  device
+ * @dev: the I3C dev to attach private data to
+ *
+ * Return: the private data previously attached with
+ *	   i3c_device_set_master_data() or NULL if no data has been attached
+ *	   to the device.
+ */
+static inline void *i3c_device_get_master_data(const struct i3c_device *dev)
+{
+	return dev->common.master_priv;
+}
+
+/**
+ * i3c_device_set_master_data() - attach master private data to an I3C device
+ * @dev: the I3C dev to attach private data to
+ * @data: private data
+ *
+ * This functions allows a master controller to attach per-device private data
+ * which can then be retrieved with i3c_device_get_master_data().
+ *
+ * Attaching private data to a device is usually done just after calling
+ * i3c_master_add_i3c_dev_locked().
+ */
+static inline void i3c_device_set_master_data(struct i3c_device *dev,
+					      void *data)
+{
+	dev->common.master_priv = data;
+}
+
+/**
+ * i2c_device_get_master_data() - get master private data attached to an I2C
+ *				  device
+ * @dev: the I2C dev to attach private data to
+ *
+ * Return: the private data previously attached with
+ *	   i2c_device_set_master_data() or NULL if no data has been attached
+ *	   to the device.
+ */
+static inline void *i2c_device_get_master_data(const struct i2c_device *dev)
+{
+	return dev->common.master_priv;
+}
+
+/**
+ * i2c_device_set_master_data() - attach master private data to an I2C device
+ * @dev: the I2C dev to attach private data to
+ * @data: private data
+ *
+ * This functions allows a master controller to attach per-device private data
+ * which can then be retrieved with i2c_device_get_master_data().
+ *
+ * Attaching private data to a device is usually done during
+ * &master_controller_ops->bus_init(), by iterating over all I2C devices
+ * instantiated by the core (using i3c_bus_for_each_i2cdev()).
+ */
+static inline void i2c_device_set_master_data(struct i2c_device *dev,
+					      void *data)
+{
+	dev->common.master_priv = data;
+}
+
+/**
+ * i3c_device_get_master() - get master used to communicate with a device
+ * @dev: I3C dev
+ *
+ * Return: the master controller driving @dev
+ */
+static inline struct i3c_master_controller *
+i3c_device_get_master(struct i3c_device *dev)
+{
+	return dev->common.master;
+}
+
+/**
+ * i2c_device_get_master() - get master used to communicate with a device
+ * @dev: I2C dev
+ *
+ * Return: the master controller driving @dev
+ */
+static inline struct i3c_master_controller *
+i2c_device_get_master(struct i2c_device *dev)
+{
+	return dev->common.master;
+}
+
+/**
+ * i3c_master_get_bus() - get the bus attached to a master
+ * @master: master object
+ *
+ * Return: the I3C bus @master is connected to
+ */
+static inline struct i3c_bus *
+i3c_master_get_bus(struct i3c_master_controller *master)
+{
+	return master->bus;
+}
+
+/**
+ * i3c_device_get_bus() - get the bus attached to a device
+ * @dev: an I3C device
+ *
+ * Return: the I3C bus @dev is connected to
+ */
+static inline struct i3c_bus *i3c_device_get_bus(struct i3c_device *dev)
+{
+	return dev->common.bus;
+}
+
+struct i3c_generic_ibi_pool;
+
+struct i3c_generic_ibi_pool *
+i3c_generic_ibi_alloc_pool(struct i3c_device *dev,
+			   const struct i3c_ibi_setup *req);
+void i3c_generic_ibi_free_pool(struct i3c_generic_ibi_pool *pool);
+
+struct i3c_ibi_slot *
+i3c_generic_ibi_get_free_slot(struct i3c_generic_ibi_pool *pool);
+void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
+				  struct i3c_ibi_slot *slot);
+
+void i3c_master_queue_ibi(struct i3c_device *dev, struct i3c_ibi_slot *slot);
+
+struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_device *dev);
+
+#endif /* I3C_MASTER_H */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 2014bd19f28e..b457703ed93a 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -448,6 +448,23 @@ struct pci_epf_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/* i3c */
+
+#define I3C_MATCH_DCR			0x1
+#define I3C_MATCH_MANUF			0x2
+#define I3C_MATCH_PART			0x4
+#define I3C_MATCH_EXTRA_INFO		0x8
+
+struct i3c_device_id {
+	__u8 match_flags;
+	__u8 dcr;
+	__u16 manuf_id;
+	__u16 part_id;
+	__u16 extra_info;
+
+	const void *data;
+};
+
 /* spi */
 
 #define SPI_NAME_SIZE	32
-- 
2.14.1

