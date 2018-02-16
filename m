Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934030AbeBPKrH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:47:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933685AbeBPKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:43:25 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 01/12] drivers: base: Unified device connection lookup
Date: Fri, 16 Feb 2018 11:43:10 +0100
Message-Id: <20180216104321.8259-2-hdegoede@redhat.com>
In-Reply-To: <20180216104321.8259-1-hdegoede@redhat.com>
References: <20180216104321.8259-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Several frameworks - clk, gpio, phy, pmw, etc. - maintain
lookup tables for describing connections and provide custom
API for handling them. This introduces a single generic
lookup table and API for the connections.

The motivation for this commit is centralizing the
connection lookup, but the goal is to ultimately extract the
connection descriptions also from firmware by using the
fwnode_graph_* functions and other mechanisms that are
available.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/driver-api/device_connection.rst |  43 ++++++++
 drivers/base/Makefile                          |   3 +-
 drivers/base/devcon.c                          | 139 +++++++++++++++++++++++++
 include/linux/connection.h                     |  33 ++++++
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/device_connection.rst
 create mode 100644 drivers/base/devcon.c
 create mode 100644 include/linux/connection.h

diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
new file mode 100644
index 000000000000..d52604448356
--- /dev/null
+++ b/Documentation/driver-api/device_connection.rst
@@ -0,0 +1,43 @@
+==================
+Device connections
+==================
+
+Introduction
+------------
+
+Devices have often connections to other devices that are out side of the direct
+child/parent relationship. A serial or network communication controller, which
+could be a PCI device, may need to be able to get a reference to its PHY
+component, which could be attached to for example the I2C bus. Some device
+drivers need to be able to control the clocks or the GPIOs for their devices,
+and so on.
+
+Device connections are generic descriptions of any type of connection between
+two separate devices.
+
+Device connections alone do not create a dependency between the two devices.
+They are only descriptions which are not tied to either of devices directly.
+A dependency between the two devices exists only if one of the two endpoint
+devices requests a reference to the other. The descriptions themselves can be
+defined in firmware (not yet supported) or they can be build-in.
+
+Usage
+-----
+
+Device connections should exist before device ``->probe`` callback is called for
+either endpoint devices in the description. If the connections are defined in
+firmware, this is not a problem. It should be considered if the connection
+descriptions are "build-in", and need to be added separately.
+
+The connection description consist of the names of the two devices with the
+connection, i.e. the endpoints, and unique identifier for the connection which
+is needed if there are multiple connections between the two devices.
+
+After a descriptions exist, the devices in it can request reference to the other
+endpoint device, or they can request the description itself.
+
+API
+---
+
+.. kernel-doc:: drivers/base/devcon.c
+   : functions: __device_find_connection device_find_connection add_device_connection remove_device_connection
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index e32a52490051..12a7f64d35a9 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -5,7 +5,8 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
-			   topology.o container.o property.o cacheinfo.o
+			   topology.o container.o property.o cacheinfo.o \
+			   devcon.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
new file mode 100644
index 000000000000..6f9e4f7280a5
--- /dev/null
+++ b/drivers/base/devcon.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Device connections
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/connection.h>
+#include <linux/device.h>
+
+static DEFINE_MUTEX(devcon_lock);
+static LIST_HEAD(devcon_list);
+
+/**
+ * __device_find_connection - Find physical connection to a device
+ * @dev: Device with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ *
+ * Find a connection with unique identifier @con_id between @dev and an other
+ * device. @match will be used to convert the connection description to data the
+ * caller is expecting to be returned.
+ */
+void *__device_find_connection(struct device *dev, const char *con_id,
+			       void *data,
+			       void *(*match)(struct devcon *con, int ep,
+					      void *data))
+{
+	const char *devname = dev_name(dev);
+	struct devcon *con;
+	void *ret = NULL;
+	int ep;
+
+	if (!match)
+		return NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(con, &devcon_list, list) {
+		ep = match_string(con->endpoint, 2, devname);
+		if (ep < 0)
+			continue;
+
+		if (con_id && strcmp(con->id, con_id))
+			continue;
+
+		ret = match(con, !ep, data);
+		if (ret)
+			break;
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__device_find_connection);
+
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c.h>
+#include <linux/pci.h>
+
+static struct bus_type *generic_match_buses[] = {
+	&platform_bus_type,
+#ifdef CONFIG_PCI
+	&pci_bus_type,
+#endif
+#ifdef CONFIG_I2C
+	&i2c_bus_type,
+#endif
+#ifdef CONFIG_SPI_MASTER
+	&spi_bus_type,
+#endif
+	NULL,
+};
+
+/* This tries to find the device from the most common bus types by name. */
+static void *generic_match(struct devcon *con, int ep, void *data)
+{
+	struct bus_type *bus;
+	struct device *dev;
+
+	for (bus = generic_match_buses[0]; bus; bus++) {
+		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
+		if (dev)
+			return dev;
+	}
+
+	/*
+	 * We only get called if a connection was found, tell the caller to
+	 * wait for the other device to show-up.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * device_find_connection - Find two devices connected together
+ * @dev: Device with the connection
+ * @con_id: Identifier for the connection
+ *
+ * Find a connection with unique identifier @con_id between @dev and an
+ * other device. On success returns handle to the device that is connected
+ * to @dev, with the reference count for the found device incremented. Returns
+ * NULL if no matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a
+ * connection was found but the other device has not been enumerated yet.
+ */
+struct device *device_find_connection(struct device *dev, const char *con_id)
+{
+	return __device_find_connection(dev, con_id, generic_match, NULL);
+}
+EXPORT_SYMBOL_GPL(device_find_connection);
+
+/**
+ * add_device_connection - Register a collection of connection descriptions
+ * @con: Collection of connection descriptions to be registered
+ */
+void add_device_connection(struct devcon *con)
+{
+	mutex_lock(&devcon_lock);
+	list_add_tail_rcu(&con->list, &devcon_list);
+	mutex_unlock(&devcon_lock);
+}
+EXPORT_SYMBOL_GPL(add_device_connection);
+
+/**
+ * remove_device_connections - Unregister collection of connection descriptions
+ * @con: Collection of connection descriptions to be unregistered
+ */
+void remove_device_connection(struct devcon *con)
+{
+	mutex_lock(&devcon_lock);
+	list_del_rcu(&con->list);
+	mutex_unlock(&devcon_lock);
+	/* The caller may free the devcon struct immediately afterwards. */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(remove_device_connection);
diff --git a/include/linux/connection.h b/include/linux/connection.h
new file mode 100644
index 000000000000..1aed6f3d3d6f
--- /dev/null
+++ b/include/linux/connection.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef _LINUX_CONNECTION_H_
+#define _LINUX_CONNECTION_H_
+
+#include <linux/list.h>
+
+struct device;
+
+/**
+ * struct devcon - Device Connection Descriptor
+ * @endpoint: The names of the two devices connected together
+ * @id: Unique identifier for the connection
+ */
+struct devcon {
+	const char		*endpoint[2];
+	const char		*id;
+	struct list_head	list;
+};
+
+void *__device_find_connection(struct device *dev, const char *con_id,
+			       void *data,
+			       void *(*match)(struct devcon *con, int ep,
+					      void *data));
+
+struct device *device_find_connection(struct device *dev, const char *con_id);
+
+#define DEVCON(_ep0, _ep1, _id)		{ { _ep0, _ep1 }, _id, }
+
+void add_device_connection(struct devcon *con);
+void remove_device_connection(struct devcon *con);
+
+#endif /* _LINUX_CONNECTION_H_ */
-- 
2.14.3
