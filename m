Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933890AbeBPKou (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:44:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933633AbeBPKnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:43:33 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] usb: typec: driver for Pericom PI3USB30532 Type-C cross switch
Date: Fri, 16 Feb 2018 11:43:19 +0100
Message-Id: <20180216104321.8259-11-hdegoede@redhat.com>
In-Reply-To: <20180216104321.8259-1-hdegoede@redhat.com>
References: <20180216104321.8259-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Pericom PI3USB30532 Type-C cross switch /
mux chip found on some devices with a Type-C port.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this is a rewrite of my previous driver which was using the
drivers/mux framework to use the new drivers/usb/typec/mux framework
---
 MAINTAINERS                         |   6 ++
 drivers/usb/typec/Kconfig           |   2 +
 drivers/usb/typec/Makefile          |   1 +
 drivers/usb/typec/mux/Kconfig       |  10 ++
 drivers/usb/typec/mux/Makefile      |   3 +
 drivers/usb/typec/mux/pi3usb30532.c | 177 ++++++++++++++++++++++++++++++++++++
 6 files changed, 199 insertions(+)
 create mode 100644 drivers/usb/typec/mux/Kconfig
 create mode 100644 drivers/usb/typec/mux/Makefile
 create mode 100644 drivers/usb/typec/mux/pi3usb30532.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 385ef9080287..ec047e7e3c43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14521,6 +14521,12 @@ F:	drivers/usb/
 F:	include/linux/usb.h
 F:	include/linux/usb/
 
+USB TYPEC PI3USB30532 MUX DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/typec/mux/pi3usb30532.c
+
 USB TYPEC SUBSYSTEM
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index a2a0684e7c82..030f88cb0c3f 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -85,4 +85,6 @@ config TYPEC_TPS6598X
 	  If you choose to build this driver as a dynamically linked module, the
 	  module will be called tps6598x.ko.
 
+source "drivers/usb/typec/mux/Kconfig"
+
 endif # TYPEC
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 56b2e9516ec1..1f599a6c30cc 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -6,3 +6,4 @@ obj-y				+= fusb302/
 obj-$(CONFIG_TYPEC_WCOVE)	+= typec_wcove.o
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
 obj-$(CONFIG_TYPEC_TPS6598X)	+= tps6598x.o
+obj-$(CONFIG_TYPEC)		+= mux/
diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
new file mode 100644
index 000000000000..9a954d2b8d8f
--- /dev/null
+++ b/drivers/usb/typec/mux/Kconfig
@@ -0,0 +1,10 @@
+menu "USB Type-C Multiplexer/DeMultiplexer Switch support"
+
+config TYPEC_MUX_PI3USB30532
+	tristate "Pericom PI3USB30532 Type-C cross switch driver"
+	depends on I2C
+	help
+	  Say Y or M if your system has a Pericom PI3USB30532 Type-C cross
+	  switch / mux chip found on some devices with a Type-C port.
+
+endmenu
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
new file mode 100644
index 000000000000..1332e469b8a0
--- /dev/null
+++ b/drivers/usb/typec/mux/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
new file mode 100644
index 000000000000..13ea3e3a783c
--- /dev/null
+++ b/drivers/usb/typec/mux/pi3usb30532.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Pericom PI3USB30532 Type-C cross switch / mux driver
+ *
+ * Copyright (c) 2017-2018 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/usb/tcpm.h>
+#include <linux/usb/typec_mux.h>
+
+#define PI3USB30532_CONF			0x00
+
+#define PI3USB30532_CONF_OPEN			0x00
+#define PI3USB30532_CONF_SWAP			0x01
+#define PI3USB30532_CONF_4LANE_DP		0x02
+#define PI3USB30532_CONF_USB3			0x04
+#define PI3USB30532_CONF_USB3_AND_2LANE_DP	0x06
+
+struct pi3usb30532 {
+	struct i2c_client *client;
+	struct mutex lock; /* protects the cached conf register */
+	struct typec_switch sw;
+	struct typec_mux mux;
+	u8 conf;
+};
+
+static int pi3usb30532_set_conf(struct pi3usb30532 *pi, u8 new_conf)
+{
+	int ret = 0;
+
+	if (pi->conf == new_conf)
+		return 0;
+
+	ret = i2c_smbus_write_byte_data(pi->client, PI3USB30532_CONF, new_conf);
+	if (ret == 0)
+		pi->conf = new_conf;
+	else
+		dev_err(&pi->client->dev, "Error writing conf: %d\n", ret);
+
+	return ret;
+}
+
+static int pi3usb30532_sw_set(struct typec_switch *sw,
+			      enum typec_orientation orientation)
+{
+	struct pi3usb30532 *pi = container_of(sw, struct pi3usb30532, sw);
+	u8 new_conf;
+	int ret;
+
+	mutex_lock(&pi->lock);
+	new_conf = pi->conf;
+
+	switch (orientation) {
+	case TYPEC_ORIENTATION_NONE:
+		new_conf = PI3USB30532_CONF_OPEN;
+		break;
+	case TYPEC_ORIENTATION_NORMAL:
+		new_conf &= ~PI3USB30532_CONF_SWAP;
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		new_conf |= PI3USB30532_CONF_SWAP;
+		break;
+	};
+
+	ret = pi3usb30532_set_conf(pi, new_conf);
+	mutex_unlock(&pi->lock);
+
+	return ret;
+}
+
+static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
+{
+	struct pi3usb30532 *pi = container_of(mux, struct pi3usb30532, mux);
+	u8 new_conf;
+	int ret;
+
+	mutex_lock(&pi->lock);
+	new_conf = pi->conf;
+
+	switch (state) {
+	case TYPEC_MUX_NONE:
+		new_conf = PI3USB30532_CONF_OPEN;
+		break;
+	case TYPEC_MUX_USB:
+		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
+			   PI3USB30532_CONF_USB3;
+		break;
+	case TYPEC_MUX_DP:
+		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
+			   PI3USB30532_CONF_4LANE_DP;
+		break;
+	case TYPEC_MUX_DOCK:
+		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
+			   PI3USB30532_CONF_USB3_AND_2LANE_DP;
+		break;
+	};
+
+	ret = pi3usb30532_set_conf(pi, new_conf);
+	mutex_unlock(&pi->lock);
+
+	return ret;
+}
+
+static int pi3usb30532_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct pi3usb30532 *pi;
+	int ret;
+
+	pi = devm_kzalloc(dev, sizeof(*pi), GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->client = client;
+	pi->sw.dev = dev;
+	pi->sw.set = pi3usb30532_sw_set;
+	pi->mux.dev = dev;
+	pi->mux.set = pi3usb30532_mux_set;
+	mutex_init(&pi->lock);
+
+	ret = i2c_smbus_read_byte_data(client, PI3USB30532_CONF);
+	if (ret < 0) {
+		dev_err(dev, "Error reading config register %d\n", ret);
+		return ret;
+	}
+	pi->conf = ret;
+
+	ret = typec_switch_register(&pi->sw);
+	if (ret) {
+		dev_err(dev, "Error registering typec switch: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_mux_register(&pi->mux);
+	if (ret) {
+		typec_switch_unregister(&pi->sw);
+		dev_err(dev, "Error registering typec mux: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, pi);
+	return 0;
+}
+
+static int pi3usb30532_remove(struct i2c_client *client)
+{
+	struct pi3usb30532 *pi = i2c_get_clientdata(client);
+
+	typec_mux_unregister(&pi->mux);
+	typec_switch_unregister(&pi->sw);
+	return 0;
+}
+
+static const struct i2c_device_id pi3usb30532_table[] = {
+	{ "pi3usb30532" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pi3usb30532_table);
+
+static struct i2c_driver pi3usb30532_driver = {
+	.driver = {
+		.name = "pi3usb30532",
+	},
+	.probe_new	= pi3usb30532_probe,
+	.remove		= pi3usb30532_remove,
+	.id_table	= pi3usb30532_table,
+};
+
+module_i2c_driver(pi3usb30532_driver);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_DESCRIPTION("Pericom PI3USB30532 Type-C mux driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3
