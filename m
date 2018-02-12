Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412623; cv=none;
        d=google.com; s=arc-20160816;
        b=sMSlSI4oAHE5+FeKQcr6jdN8dh+9OCZbnwNAwZyWbF3mAmuuQ46W8mfK3HrKUXqABn
         8y1QC/7E9+wWrqdeLrqP+b1L+jM0Drge7K4Oubx1cnj7kZn5KfO6+dVCrb/0qFBbwUd0
         hce4MndTQq5X2L6GKAhrF48oWUyjNpDp0jQuEkVPlUo+Fhdj5Srzdy6x03Kzo9261aaI
         dLBrkqLxx8pX3DZzr0fu8hYDNA8S/RRTj2+nDghg0ic6U4reKbtaucUjw3SHEVnrhyMK
         xyukHL3VNOmU8R7G0Nb3C62HX4Sno/nCTjxbTtnFpXHFjSTpNiKDSwQR87eUS++3mroF
         YzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=of7diKi7tfMKvmwg2tF9YoG6ES7Rx3p5XxA+LNA5Ox4=;
        b=U3xny2lVu6S90GhO6Ce4S9xtNuah53wN0PjyeTVxTcmX6q7aXGqAlZTEHt6LgcYkpg
         i183DRvusO8f/Hya0qY1xvR27sYJ1PniGURHYpSYzygNbkBc+rHVVq+npsMmzznchbmc
         qhpCTfUE4U2fYXhYbFVRJ+o5K8jK6iUdb+YNq7oGBY+zA5Dj5eayVdg6+Vkj7FpmCi1P
         SyS5J3x/WXdD5sT/iBCA6ELkhmYTDKk/ZF6iB/CvJyBUDTIRZe0Fnp9b3qIGexck+oKE
         cCnCXYYpFZhOfWdoXlJbtMWXmQknqVkyh/nkalHSs45LjQS/D4jD0BY1PsyGWVxaWgKD
         wfhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VUFwgm43;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VUFwgm43;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225IdFWuvbDguhtkZd0oC0npG8UUmPqWp0F0F2jJwa/6pIjbgQGD+YQPLub08PnMEPzRsNrEaQ==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 06/10] fsi: Match fsi slaves and engines to available dt nodes
Date: Mon, 12 Feb 2018 15:45:45 +1030
Message-Id: <20180212051549.8575-7-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171035919627090?=
X-GMAIL-MSGID: =?utf-8?q?1592171035919627090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeremy Kerr <jk@ozlabs.org>

This change populates device tree nodes for scanned FSI slaves and
engines. If the master populates ->of_node of the FSI master device,
we'll look for matching slaves, and under those slaves we'll look for
matching engines.

This means that FSI drivers will have their ->of_node pointer populated
if there's a corresponding DT node, which they can use for further
device discover.

Presence of device tree nodes is optional, and only required for
fsi device drivers that need extra properties, or subordinate devices,
to be enumerated.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/Kconfig           |  1 +
 drivers/fsi/fsi-core.c        | 99 +++++++++++++++++++++++++++++++++++++++++++
 drivers/fsi/fsi-master-gpio.c |  4 ++
 drivers/fsi/fsi-master-hub.c  |  4 ++
 4 files changed, 108 insertions(+)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 513e35173aaa..a326ed663d3c 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig FSI
 	tristate "FSI support"
+	depends on OF
 	select CRC4
 	---help---
 	  FSI - the FRU Support Interface - is a simple bus for low-level
diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e5dfece248a5..1069cb402bd3 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -18,6 +18,7 @@
 #include <linux/fsi.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 
@@ -142,6 +143,7 @@ static void fsi_device_release(struct device *_device)
 {
 	struct fsi_device *device = to_fsi_dev(_device);
 
+	of_node_put(device->dev.of_node);
 	kfree(device);
 }
 
@@ -334,6 +336,57 @@ extern void fsi_slave_release_range(struct fsi_slave *slave,
 }
 EXPORT_SYMBOL_GPL(fsi_slave_release_range);
 
+static bool fsi_device_node_matches(struct device *dev, struct device_node *np,
+		uint32_t addr, uint32_t size)
+{
+	unsigned int len, na, ns;
+	const __be32 *prop;
+	uint32_t psize;
+
+	na = of_n_addr_cells(np);
+	ns = of_n_size_cells(np);
+
+	if (na != 1 || ns != 1)
+		return false;
+
+	prop = of_get_property(np, "reg", &len);
+	if (!prop || len != 8)
+		return false;
+
+	if (of_read_number(prop, 1) != addr)
+		return false;
+
+	psize = of_read_number(prop + 1, 1);
+	if (psize != size) {
+		dev_warn(dev,
+			"node %s matches probed address, but not size (got 0x%x, expected 0x%x)",
+			of_node_full_name(np), psize, size);
+	}
+
+	return true;
+}
+
+/* Find a matching node for the slave engine at @address, using @size bytes
+ * of space. Returns NULL if not found, or a matching node with refcount
+ * already incremented.
+ */
+static struct device_node *fsi_device_find_of_node(struct fsi_device *dev)
+{
+	struct device_node *parent, *np;
+
+	parent = dev_of_node(&dev->slave->dev);
+	if (!parent)
+		return NULL;
+
+	for_each_child_of_node(parent, np) {
+		if (fsi_device_node_matches(&dev->dev, np,
+					dev->addr, dev->size))
+			return np;
+	}
+
+	return NULL;
+}
+
 static int fsi_slave_scan(struct fsi_slave *slave)
 {
 	uint32_t engine_addr;
@@ -402,6 +455,7 @@ static int fsi_slave_scan(struct fsi_slave *slave)
 			dev_set_name(&dev->dev, "%02x:%02x:%02x:%02x",
 					slave->master->idx, slave->link,
 					slave->id, i - 2);
+			dev->dev.of_node = fsi_device_find_of_node(dev);
 
 			rc = device_register(&dev->dev);
 			if (rc) {
@@ -558,9 +612,53 @@ static void fsi_slave_release(struct device *dev)
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
 
+	of_node_put(dev->of_node);
 	kfree(slave);
 }
 
+static bool fsi_slave_node_matches(struct device_node *np,
+		int link, uint8_t id)
+{
+	unsigned int len, na, ns;
+	const __be32 *prop;
+
+	na = of_n_addr_cells(np);
+	ns = of_n_size_cells(np);
+
+	/* Ensure we have the correct format for addresses and sizes in
+	 * reg properties
+	 */
+	if (na != 2 || ns != 0)
+		return false;
+
+	prop = of_get_property(np, "reg", &len);
+	if (!prop || len != 8)
+		return false;
+
+	return (of_read_number(prop, 1) == link) &&
+		(of_read_number(prop + 1, 1) == id);
+}
+
+/* Find a matching node for the slave at (link, id). Returns NULL if none
+ * found, or a matching node with refcount already incremented.
+ */
+static struct device_node *fsi_slave_find_of_node(struct fsi_master *master,
+		int link, uint8_t id)
+{
+	struct device_node *parent, *np;
+
+	parent = dev_of_node(&master->dev);
+	if (!parent)
+		return NULL;
+
+	for_each_child_of_node(parent, np) {
+		if (fsi_slave_node_matches(np, link, id))
+			return np;
+	}
+
+	return NULL;
+}
+
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
 	uint32_t chip_id, llmode;
@@ -623,6 +721,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	slave->master = master;
 	slave->dev.parent = &master->dev;
+	slave->dev.of_node = fsi_slave_find_of_node(master, link, id);
 	slave->dev.release = fsi_slave_release;
 	slave->link = link;
 	slave->id = id;
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index b54c213f3dcb..3f487449a277 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -593,6 +594,7 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 
 	master->dev = &pdev->dev;
 	master->master.dev.parent = master->dev;
+	master->master.dev.of_node = of_node_get(dev_of_node(master->dev));
 
 	gpio = devm_gpiod_get(&pdev->dev, "clock", 0);
 	if (IS_ERR(gpio)) {
@@ -664,6 +666,8 @@ static int fsi_master_gpio_remove(struct platform_device *pdev)
 		devm_gpiod_put(&pdev->dev, master->gpio_mux);
 	fsi_master_unregister(&master->master);
 
+	of_node_put(master->master.dev.of_node);
+
 	return 0;
 }
 
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 133b9bff1d65..3223a671a0ef 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/fsi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 
 #include "fsi-master.h"
@@ -274,6 +275,7 @@ static int hub_master_probe(struct device *dev)
 
 	hub->master.dev.parent = dev;
 	hub->master.dev.release = hub_master_release;
+	hub->master.dev.of_node = of_node_get(dev_of_node(dev));
 
 	hub->master.n_links = links;
 	hub->master.read = hub_master_read;
@@ -302,6 +304,8 @@ static int hub_master_remove(struct device *dev)
 
 	fsi_master_unregister(&hub->master);
 	fsi_slave_release_range(hub->upstream->slave, hub->addr, hub->size);
+	of_node_put(hub->master.dev.of_node);
+
 	return 0;
 }
 
-- 
2.15.1
