Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AH8x225P02RlXTjV7wF6CJTAvh9ryGJTleKkQmLEv0NzK2Mf1xQTpr5gfAaBSldhgNA2KaRBn8tg
ARC-Seal: i=1; a=rsa-sha256; t=1519830475; cv=none;
        d=google.com; s=arc-20160816;
        b=meM+9NqSRuehXipb1e3FYEPLWDHP3zPU5Y5plrbTWIezdF0fw3vgkZit6YHFTHKoUm
         nfHMzy+Bqyaf1tlcRqt9Mt+Gi8c28HRVEHhUXpeuHbL6qPmuDpFDokL0yogFwOmtX+JP
         U3VfJhuQ+SqprHmUJD/blAkPBWyDaaZEU5TwKM+ByPhWErOYfcIznjoVS4cAj7Y6TxZR
         SB/St5xjZ6HmMXzyhG2/Kodq12TK446y1PRomejf7W+UFxgrCQD9XInHfbJyCML8Mug7
         81RWrxFkJZgRentxhVWPzdXA3AA+wZcalxPcPI5PFAaof/AoGIgH949GiWC/i1s1fEWy
         jK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5TGzL2MjsEURwb52t8IwsiSf48xSFZ9gbd+K7I4lm04=;
        b=FhGi1RnwlMheE8//eTk6bLP3G3rulaLkFaucSQCw4bo36Oej0a6uyeoTEhwD8TcHxw
         lpnQJGhDKihv5Y6Htg/VRyMtO0ymzKZK4wdwzi+0pxQRzPikeK1fujAU1dkppKyghfus
         Oz6lOVdDN+Dmy/kNsjQTfKJxUgXUBLZnhloCJadei4xjBpRujkGKVTYHQ2wSckjLiF/v
         r+BNMtZKtccKK/QvGCCqCRgu0rCjUMJ3UpxmhAp1a66m84z9W7R94X8iTNDe1tEhDaFl
         xcXQgDZc1nrY8PgMIGNX8AV9i1jJzymYApmZmrx9Rq1C3mXmxHDqHRREfYhdxEvI5mD3
         3Vww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v5 01/12] drivers: base: Unified device connection lookup
Date: Wed, 28 Feb 2018 16:07:38 +0100
Message-Id: <20180228150749.26831-2-hdegoede@redhat.com>
In-Reply-To: <20180228150749.26831-1-hdegoede@redhat.com>
References: <20180228150749.26831-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454017476208824?=
X-GMAIL-MSGID: =?utf-8?q?1593657760523901085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
-Add missing documentation for @list struct devcon member

Changes in v4:
-Add Andy's Reviewed-by

Changes in v3:
-Various spelling and gramar fixes in the docs pointed out by Randy Dunlap

Changes in v2:
-Add a (struct devcon) cast to the DEVCON() macro
---
 Documentation/driver-api/device_connection.rst |  43 ++++++++
 drivers/base/Makefile                          |   3 +-
 drivers/base/devcon.c                          | 139 +++++++++++++++++++++++++
 include/linux/connection.h                     |  34 ++++++
 4 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/device_connection.rst
 create mode 100644 drivers/base/devcon.c
 create mode 100644 include/linux/connection.h

diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
new file mode 100644
index 000000000000..64a3e5e9bb7c
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
+Devices often have connections to other devices that are outside of the direct
+child/parent relationship. A serial or network communication controller, which
+could be a PCI device, may need to be able to get a reference to its PHY
+component, which could be attached for example to the I2C bus. Some device
+drivers need to be able to control the clocks or the GPIOs for their devices,
+and so on.
+
+Device connections are generic descriptions of any type of connection between
+two separate devices.
+
+Device connections alone do not create a dependency between the two devices.
+They are only descriptions which are not tied to either of the devices directly.
+A dependency between the two devices exists only if one of the two endpoint
+devices requests a reference to the other. The descriptions themselves can be
+defined in firmware (not yet supported) or they can be built-in.
+
+Usage
+-----
+
+Device connections should exist before device ``->probe`` callback is called for
+either endpoint device in the description. If the connections are defined in
+firmware, this is not a problem. It should be considered if the connection
+descriptions are "built-in", and need to be added separately.
+
+The connection description consists of the names of the two devices with the
+connection, i.e. the endpoints, and unique identifier for the connection which
+is needed if there are multiple connections between the two devices.
+
+After a description exists, the devices in it can request reference to the other
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
index 000000000000..1628dcb34709
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
+ * Find a connection with unique identifier @con_id between @dev and another
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
+	 * wait for the other device to show up.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * device_find_connection - Find two devices connected together
+ * @dev: Device with the connection
+ * @con_id: Identifier for the connection
+ *
+ * Find a connection with unique identifier @con_id between @dev and
+ * another device. On success returns handle to the device that is connected
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
index 000000000000..b2af70df5a97
--- /dev/null
+++ b/include/linux/connection.h
@@ -0,0 +1,34 @@
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
+ * @list: List head, private for devcon internal use only
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
+#define DEVCON(_ep0, _ep1, _id)    (struct devcon) { { _ep0, _ep1 }, _id, }
+
+void add_device_connection(struct devcon *con);
+void remove_device_connection(struct devcon *con);
+
+#endif /* _LINUX_CONNECTION_H_ */
-- 
2.14.3
