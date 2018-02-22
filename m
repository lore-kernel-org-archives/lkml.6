Return-Path: <idgar@virtualoco.com>
X-Google-Smtp-Source: AH8x224bYZjxaB/P3BXAU6Q/cGDOZT7+jWmRUjXCMp2HtZGx7faIH6+IARgYUgJzKagC+yEono77
ARC-Seal: i=1; a=rsa-sha256; t=1519316452; cv=none;
        d=google.com; s=arc-20160816;
        b=FHStTToYz1C5v1wtiNTt8K/VrP8Fy/F5ibcfR123/By6ytYB8oh26YKulwemAxBGIf
         DFoL0l6oIMhSILqucN2tJkJetqPAW3jvzqDq12BZhPX7GKk1quyyo0uvAd1Ps8drgVfh
         AhlUaJVrym/KF422mM7e7jeJmqsTbhFZAi7qPt0CGDdlxQpBMZiuIFVA7lcwZlPoCADK
         k4MJxiSF8xk75RkD3FqPwuzB7QqoiZutiJfIuC/yszjx/LxYpqjrZDaQZ7RtAIvbarnO
         +oQbuQL4tatT64P88D7W1uPtDUoUXwb6oc+iduOVg2vJ/jW77wMR6z575k8vMJ7B+Umx
         myIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=nvmv2Nx5wj/qUAYVTV8yKV8Enqo3mZPaPODsR991uMA=;
        b=yiVzHMYuFTQTbRYH4LdeCihdu+nu4DPikPyTiHrd7+JOYp+vGYBEDkD5djKrvcjWCm
         mjPrQw21AQtFw8/vu7REZc3ZD+xOU6CieG1JouU+L4WPdvq3SuW5UTA2m+KuwqeT568L
         mdu9jbs26lyVHQTtH462hoO846KO1x/qi2aLGbHBN6xtQ9z3KEWWA/XglOBPiFKH3m59
         mpfzpS9lGH8ipjIN0o2bfX+GWBACBTU0aVmG+YjiJtvVQ7BS8oMe1PXQSyLegKsCAq4G
         lddlhhhzzva4M94r4HmWq2d3A909pi7+dinv4zCZ5aj8tJSY9BODrKc659TA8v9ddbyq
         LTCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtualoco.com header.s=it header.b=Ls7h0KbK;
       spf=pass (google.com: domain of idgar@virtualoco.com designates 135.84.80.217 as permitted sender) smtp.mailfrom=idgar@virtualoco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtualoco.com header.s=it header.b=Ls7h0KbK;
       spf=pass (google.com: domain of idgar@virtualoco.com designates 135.84.80.217 as permitted sender) smtp.mailfrom=idgar@virtualoco.com
From: Or Idgar <idgar@virtualoco.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: [PATCH] drivers/virt: vm_gen_counter: initial driver implementation
Date: Thu, 22 Feb 2018 18:20:38 +0200
Message-Id: <20180222162038.28768-1-idgar@virtualoco.com>
X-Mailer: git-send-email 2.14.3
X-ZohoMailClient: External
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593118768319025256?=
X-GMAIL-MSGID: =?utf-8?q?1593118768319025256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Or Idgar <oridgar@gmail.com>

This patch is a driver which expose the Virtual Machine Generation ID
via sysfs. The ID is a UUID value used to differentiate between virtual
machines.

The VM-Generation ID is a feature defined by Microsoft (paper:
http://go.microsoft.com/fwlink/?LinkId=260709) and supported by multiple
hypervisor vendors.

Signed-off-by: Or Idgar <oridgar@gmail.com>
---
 Documentation/ABI/testing/sysfs-hypervisor |  13 +++
 drivers/misc/Kconfig                       |   6 ++
 drivers/misc/Makefile                      |   1 +
 drivers/misc/vmgenid.c                     | 141 +++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor
 create mode 100644 drivers/misc/vmgenid.c

diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
new file mode 100644
index 000000000000..2f9a7b8eab70
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-hypervisor
@@ -0,0 +1,13 @@
+What:		/sys/hypervisor/vm_gen_counter
+Date:		February 2018
+Contact:	Or Idgar <idgar@virtualoco.com>
+		Gal Hammer <ghammer@redhat.com>
+Description:	Expose the virtual machine generation ID. The directory
+		contains two files: "generation_id" and "raw". Both files
+		represent the same information.
+
+		"generation_id" file is a UUID string
+		representation.
+
+		"raw" file is a 128-bit integer
+		representation (binary).
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 03605f8fc0dc..5a74802bdfb4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -500,6 +500,12 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
+config VMGENID
+	tristate "Virtual Machine Generation ID driver"
+	help
+	  This is a Virtual Machine Generation ID driver which provides
+	  a virtual machine unique identifier.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c3c8624f4d95..067aa666bb6a 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-$(CONFIG_VMGENID)		+= vmgenid.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/vmgenid.c b/drivers/misc/vmgenid.c
new file mode 100644
index 000000000000..9d7f09f9e7bd
--- /dev/null
+++ b/drivers/misc/vmgenid.c
@@ -0,0 +1,141 @@
+/*
+ * Virtual Machine Generation ID driver
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All rights reserved.
+ *	Authors:
+ *	  Or Idgar <oridgar@gmail.com>
+ *	  Gal Hammer <ghammer@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/uuid.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Or Idgar <oridgar@gmail.com>");
+MODULE_AUTHOR("Gal Hammer <ghammer@redhat.com>");
+MODULE_DESCRIPTION("Virtual Machine Generation ID");
+MODULE_VERSION("0.1");
+
+ACPI_MODULE_NAME("vmgenid");
+
+static u64 phy_addr;
+
+static ssize_t generation_id_show(struct device *_d,
+			      struct device_attribute *attr, char *buf)
+{
+	uuid_t *uuidp;
+	ssize_t result;
+
+	uuidp = acpi_os_map_iomem(phy_addr, sizeof(uuid_t));
+	if (!uuidp)
+		return -EFAULT;
+
+	result = sprintf(buf, "%pUl\n", uuidp);
+	acpi_os_unmap_iomem(uuidp, sizeof(uuid_t));
+	return result;
+}
+static DEVICE_ATTR_RO(generation_id);
+
+static ssize_t raw_show(struct device *_d,
+			struct device_attribute *attr,
+			      char *buf)
+{
+	uuid_t *uuidp;
+
+	uuidp = acpi_os_map_iomem(phy_addr, sizeof(uuid_t));
+	if (!uuidp)
+		return -EFAULT;
+	memcpy(buf, uuidp, sizeof(uuid_t));
+	acpi_os_unmap_iomem(uuidp, sizeof(uuid_t));
+	return sizeof(uuid_t);
+}
+static DEVICE_ATTR_RO(raw);
+
+static struct attribute *vmgenid_attrs[] = {
+	&dev_attr_generation_id.attr,
+	&dev_attr_raw.attr,
+	NULL,
+};
+static const struct attribute_group vmgenid_group = {
+	.name = "vm_gen_counter",
+	.attrs = vmgenid_attrs,
+};
+
+static int get_vmgenid(acpi_handle handle)
+{
+	int i;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	union acpi_object *pss;
+	union acpi_object *element;
+
+	status = acpi_evaluate_object(handle, "ADDR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _ADDR"));
+		return -ENODEV;
+	}
+	pss = buffer.pointer;
+	if (!pss || pss->type != ACPI_TYPE_PACKAGE || pss->package.count != 2)
+		return -EFAULT;
+
+	phy_addr = 0;
+	for (i = 0; i < pss->package.count; i++) {
+		element = &(pss->package.elements[i]);
+		if (element->type != ACPI_TYPE_INTEGER)
+			return -EFAULT;
+		phy_addr |= element->integer.value << i*32;
+	}
+	return 0;
+}
+
+static int acpi_vmgenid_add(struct acpi_device *device)
+{
+	int retval;
+
+	if (!device)
+		return -EINVAL;
+	retval = get_vmgenid(device->handle);
+	if (retval < 0)
+		return retval;
+	return sysfs_create_group(hypervisor_kobj, &vmgenid_group);
+}
+
+static int acpi_vmgenid_remove(struct acpi_device *device)
+{
+	sysfs_remove_group(hypervisor_kobj, &vmgenid_group);
+	return 0;
+}
+
+static const struct acpi_device_id vmgenid_ids[] = {
+	{"QEMUVGID", 0},
+	{"", 0},
+};
+
+static struct acpi_driver acpi_vmgenid_driver = {
+	.name = "vm_gen_counter",
+	.ids = vmgenid_ids,
+	.owner = THIS_MODULE,
+	.ops = {
+		.add = acpi_vmgenid_add,
+		.remove = acpi_vmgenid_remove,
+	}
+};
+
+static int __init vmgenid_init(void)
+{
+	return acpi_bus_register_driver(&acpi_vmgenid_driver);
+}
+
+static void __exit vmgenid_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_vmgenid_driver);
+}
+
+module_init(vmgenid_init);
+module_exit(vmgenid_exit);
-- 
2.14.3
