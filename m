Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeFAIYB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:24:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38931 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeFAIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:23:30 -0400
X-Google-Smtp-Source: ADUXVKIRWLgz3JuDc8cobktlQPxtPyTKhG/3HlrQMkKjLhVokPViM6Ih0d2B4IaXVPxxIR2Kgzz3zA==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 8/8] gnss: add receiver type support
Date: Fri,  1 Jun 2018 10:22:59 +0200
Message-Id: <20180601082259.17563-9-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601082259.17563-1-johan@kernel.org>
References: <20180601082259.17563-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "type" device attribute and a "GNSS_TYPE" uevent variable which
can be used to determine the type of a GNSS receiver. The currently
identified types reflect the protocol(s) supported by a receiver:

	"NMEA"	NMEA 0183
	"SiRF"	SiRF Binary
	"UBX"	UBX

Note that both SiRF and UBX type receivers typically support a subset of
NMEA 0183 with vendor extensions (e.g. to allow switching to the vendor
protocol).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-gnss | 15 +++++++
 MAINTAINERS                                |  1 +
 drivers/gnss/core.c                        | 49 ++++++++++++++++++++++
 drivers/gnss/sirf.c                        |  1 +
 drivers/gnss/ubx.c                         |  2 +
 include/linux/gnss.h                       |  9 ++++
 6 files changed, 77 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-gnss

diff --git a/Documentation/ABI/testing/sysfs-class-gnss b/Documentation/ABI/testing/sysfs-class-gnss
new file mode 100644
index 000000000000..2467b6900eae
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-gnss
@@ -0,0 +1,15 @@
+What:		/sys/class/gnss/gnssN/type
+Date:		May 2018
+KernelVersion:	4.18
+Contact:	Johan Hovold <johan@kernel.org>
+Description:
+		The GNSS receiver type. The currently identified types reflect
+		the protocol(s) supported by the receiver:
+
+			"NMEA"		NMEA 0183
+			"SiRF"		SiRF Binary
+			"UBX"		UBX
+
+		Note that also non-"NMEA" type receivers typically support a
+		subset of NMEA 0183 with vendor extensions (e.g. to allow
+		switching to a vendor protocol).
diff --git a/MAINTAINERS b/MAINTAINERS
index fa219e80a1f8..e666bc28a102 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5965,6 +5965,7 @@ F:	include/uapi/linux/gigaset_dev.h
 GNSS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-gnss
 F:	Documentation/devicetree/bindings/gnss/
 F:	drivers/gnss/
 F:	include/linux/gnss.h
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 307894ca2725..f30ef8338b3a 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -330,6 +330,52 @@ int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
 }
 EXPORT_SYMBOL_GPL(gnss_insert_raw);
 
+static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
+	[GNSS_TYPE_NMEA]	= "NMEA",
+	[GNSS_TYPE_SIRF]	= "SiRF",
+	[GNSS_TYPE_UBX]		= "UBX",
+};
+
+static const char *gnss_type_name(struct gnss_device *gdev)
+{
+	const char *name = NULL;
+
+	if (gdev->type < GNSS_TYPE_COUNT)
+		name = gnss_type_names[gdev->type];
+
+	if (!name)
+		dev_WARN(&gdev->dev, "type name not defined\n");
+
+	return name;
+}
+
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct gnss_device *gdev = to_gnss_device(dev);
+
+	return sprintf(buf, "%s\n", gnss_type_name(gdev));
+}
+static DEVICE_ATTR_RO(type);
+
+static struct attribute *gnss_attrs[] = {
+	&dev_attr_type.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(gnss);
+
+static int gnss_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct gnss_device *gdev = to_gnss_device(dev);
+	int ret;
+
+	ret = add_uevent_var(env, "GNSS_TYPE=%s", gnss_type_name(gdev));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int __init gnss_module_init(void)
 {
 	int ret;
@@ -347,6 +393,9 @@ static int __init gnss_module_init(void)
 		goto err_unregister_chrdev;
 	}
 
+	gnss_class->dev_groups = gnss_groups;
+	gnss_class->dev_uevent = gnss_uevent;
+
 	pr_info("GNSS driver registered with major %d\n", MAJOR(gnss_first));
 
 	return 0;
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 5fb0f730db48..79cb98950013 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -267,6 +267,7 @@ static int sirf_probe(struct serdev_device *serdev)
 	if (!gdev)
 		return -ENOMEM;
 
+	gdev->type = GNSS_TYPE_SIRF;
 	gdev->ops = &sirf_gnss_ops;
 	gnss_set_drvdata(gdev, data);
 
diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index ecddfb362a6f..902b6854b7db 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -77,6 +77,8 @@ static int ubx_probe(struct serdev_device *serdev)
 
 	gserial->ops = &ubx_gserial_ops;
 
+	gserial->gdev->type = GNSS_TYPE_UBX;
+
 	data = gnss_serial_get_drvdata(gserial);
 
 	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index e26aeac1e0e2..43546977098c 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -18,6 +18,14 @@
 
 struct gnss_device;
 
+enum gnss_type {
+	GNSS_TYPE_NMEA = 0,
+	GNSS_TYPE_SIRF,
+	GNSS_TYPE_UBX,
+
+	GNSS_TYPE_COUNT
+};
+
 struct gnss_operations {
 	int (*open)(struct gnss_device *gdev);
 	void (*close)(struct gnss_device *gdev);
@@ -30,6 +38,7 @@ struct gnss_device {
 	struct cdev cdev;
 	int id;
 
+	enum gnss_type type;
 	unsigned long flags;
 
 	struct rw_semaphore rwsem;
-- 
2.17.1
