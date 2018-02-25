Return-Path: <idgar@virtualoco.com>
X-Google-Smtp-Source: AG47ELvPcD50Xp1b2xkR0tEDo7UzGnd6SFeYxQWI89tYjBEQ5JS6BZo93DM2E8Haw7QD1EasJ/0z
ARC-Seal: i=1; a=rsa-sha256; t=1519561622; cv=none;
        d=google.com; s=arc-20160816;
        b=xnIvBlhpNJaQpVpbNbtt3UNu9gpn2MalY9aMIYYRI2ttww6hAWSzQ/g5GbZWCLXUwW
         6E5DxRAKGaf2GACHzPI4Pwp2+H6qYjlIH3PGmpsEp5KPcp2XhMGUVT8JeXp7IqviFbpG
         BXDt8YrxSNX+k0uoBfdBo6uAdqSa95Qjx2nY20sJEagKepWK+K2ny0C7PCVgN4MWiAVK
         bx3QNacA/6qJjTlD7eTtXn8UicYLqdv3Yx5+zC52k7sWpJeOvyjhbBtxZUJ5KApZdS4r
         jzQYtFXr7Js7+UZ/Do+LHv7mofe8xv3rsYdeVqgLeZieAYeQjsQLhojSB//ZbLRHEMGy
         QvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=0vOZpzNMRGogOi62SxqEpfE/VORpS9cBtGr4c5Kdg+o=;
        b=mc4XSZIr+n3w+DQbzIUJGRc3qcvvr3FIS+GC75AUySWJ3t5GE596U4lDuxrmhC/r86
         /ISuvezoqMxaoRd3QYGubARISaMUmNSCP8JW9QcAEMJNGG86cwaOqX4eml33hDv34fzW
         g9hq9PR/oZybI4XX7heONBmUaFoTwkOf0dqkny+IgsVqxAJ9ZJWHkUrF6tu8SUyljOcR
         P4WKXAOohSNvWjfE99ZklJ9W531xXBYfUmotPm6FRXZwDKpPLmFGLy5eRuai7dfG0Hux
         TCye0xVAuKAd+o6EH+//07eFjF3LMX5Km25iTo+joCUrOBYVnipmzC3uD1ipALTM2GN9
         TOcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtualoco.com header.s=it header.b=FcSRW2xG;
       spf=pass (google.com: domain of idgar@virtualoco.com designates 135.84.80.217 as permitted sender) smtp.mailfrom=idgar@virtualoco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtualoco.com header.s=it header.b=FcSRW2xG;
       spf=pass (google.com: domain of idgar@virtualoco.com designates 135.84.80.217 as permitted sender) smtp.mailfrom=idgar@virtualoco.com
From: Or Idgar <idgar@virtualoco.com>
To: linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: oidgar@redhat.com,
	idgar@virtualoco.com,
	ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: [PATCH v2] drivers/virt: vm_gen_counter: initial driver implementation
Date: Sun, 25 Feb 2018 14:26:31 +0200
Message-Id: <20180225122631.22834-1-idgar@virtualoco.com>
X-Mailer: git-send-email 2.14.3
X-ZohoMailClient: External
X-ZohoMail: Z_638866495 SPT_1 Z_638866494 SPT_1 SLF_D
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593375847957640337?=
X-GMAIL-MSGID: =?utf-8?q?1593375847957640337?=
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
 drivers/misc/vmgenid.c                     | 140 +++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+)
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
index 000000000000..6b7ec9bd45e8
--- /dev/null
+++ b/drivers/misc/vmgenid.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual Machine Generation ID driver
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All rights reserved.
+ *	Authors:
+ *	  Or Idgar <oridgar@gmail.com>
+ *	  Gal Hammer <ghammer@redhat.com>
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
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
+	uuidp = acpi_os_map_memory(phy_addr, sizeof(uuid_t));
+	if (!uuidp)
+		return -EFAULT;
+
+	result = sprintf(buf, "%pUl\n", uuidp);
+	acpi_os_unmap_memory(uuidp, sizeof(uuid_t));
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
+	uuidp = acpi_os_map_memory(phy_addr, sizeof(uuid_t));
+	if (!uuidp)
+		return -EFAULT;
+	memcpy(buf, uuidp, sizeof(uuid_t));
+	acpi_os_unmap_memory(uuidp, sizeof(uuid_t));
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
