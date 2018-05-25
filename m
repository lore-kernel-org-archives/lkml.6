Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935853AbeEYMxo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:53:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44646 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeEYMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:53:38 -0400
X-Google-Smtp-Source: ADUXVKJ+Pj80Eg25Gd/EYIwqMKtUQvp3+R53BcjkcbRwaHdkpL6P+YM/oYrybG0ebA2CH1gDRNSGsw==
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [RFC PATCH 1/3] USB: serial: add device-tree support
Date: Fri, 25 May 2018 14:52:55 +0200
Message-Id: <20180525125257.29124-2-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525125257.29124-1-johan@kernel.org>
References: <20180525125257.29124-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lookup and associate serial-port device-tree nodes given a parent
USB-interface node during probe.

Note that a serial-port node must be named "serial" and have a "reg"
property so that ports on multi-port interfaces can be distinguished.

	&usb_interface {
		#address-cells = <1>;
		#size-cells = <0>;

		serial@0 {
			reg = <0>;
		};
	};

FIXME: binding doc

Not-signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 44ecf0e2be9d..5a7ebe1e9fd6 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -35,6 +35,7 @@
 #include <linux/usb/serial.h>
 #include <linux/kfifo.h>
 #include <linux/idr.h>
+#include <linux/of.h>
 
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <gregkh@linuxfoundation.org>"
 #define DRIVER_DESC "USB Serial Driver core"
@@ -97,7 +98,6 @@ static int allocate_minors(struct usb_serial *serial, int num_ports)
 		if (minor < 0)
 			goto error;
 		port->minor = minor;
-		port->port_number = i;
 	}
 	serial->minors_reserved = 1;
 	mutex_unlock(&table_lock);
@@ -589,6 +589,7 @@ static void usb_serial_port_release(struct device *dev)
 	kfifo_free(&port->write_fifo);
 	kfree(port->interrupt_in_buffer);
 	kfree(port->interrupt_out_buffer);
+	of_node_put(dev->of_node);
 	tty_port_destroy(&port->port);
 	kfree(port);
 }
@@ -857,6 +858,29 @@ static int setup_port_interrupt_out(struct usb_serial_port *port,
 	return 0;
 }
 
+/* FIXME: move to separate compilation unit? */
+static struct device_node *find_port_node(struct usb_interface *intf, int port)
+{
+	struct device_node *node;
+	u32 reg;
+
+	for_each_child_of_node(intf->dev.of_node, node) {
+		if (!node->name || of_node_cmp(node->name, "serial") != 0)
+			continue;
+
+		if (of_property_read_u32(node, "reg", &reg))
+			continue;
+
+		if (reg == port)
+			break;
+	}
+
+	dev_dbg(&intf->dev, "node %pOF, port %d: %pOFP\n", intf->dev.of_node,
+			port, node);
+
+	return node;
+}
+
 static int usb_serial_probe(struct usb_interface *interface,
 			       const struct usb_device_id *id)
 {
@@ -963,6 +987,7 @@ static int usb_serial_probe(struct usb_interface *interface,
 			retval = -ENOMEM;
 			goto err_free_epds;
 		}
+		port->port_number = i;
 		tty_port_init(&port->port);
 		port->port.ops = &serial_port_ops;
 		port->serial = serial;
@@ -976,6 +1001,7 @@ static int usb_serial_probe(struct usb_interface *interface,
 		port->dev.bus = &usb_serial_bus_type;
 		port->dev.release = &usb_serial_port_release;
 		port->dev.groups = usb_serial_port_groups;
+		port->dev.of_node = find_port_node(interface, port->port_number);
 		device_initialize(&port->dev);
 	}
 
-- 
2.17.0
