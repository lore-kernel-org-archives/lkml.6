Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163150AbeBOVdb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:33:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756059AbeBOVd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:29 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 02/11] fw_cfg: add a public uapi header
Date: Thu, 15 Feb 2018 22:33:03 +0100
Message-Id: <20180215213312.29234-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common header file for well-known values and structures to be
shared by the Linux kernel with qemu or other projects.

It is based from qemu/docs/specs/fw_cfg.txt which references
qemu/include/hw/nvram/fw_cfg_keys.h "for the most up-to-date and
authoritative list" & vmcoreinfo.txt. Those files don't have an
explicit license, but qemu/hw/nvram/fw_cfg.c is BSD-license, so
Michael S. Tsirkin suggested to use the same license.

The patch intentionally left out DMA & vmcoreinfo structures &
defines, which are added in the commits making usage of it.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

---

The related qemu patch making use of it, to be submitted:
https://github.com/elmarco/qemu/commit/4884fc9e9c4c4467a371e5a40f3181239e1b70f5
---
 MAINTAINERS                    |  1 +
 drivers/firmware/qemu_fw_cfg.c | 22 ++------------
 include/uapi/linux/fw_cfg.h    | 66 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 20 deletions(-)
 create mode 100644 include/uapi/linux/fw_cfg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..a66b65f62811 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11352,6 +11352,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	qemu-devel@nongnu.org
 S:	Maintained
 F:	drivers/firmware/qemu_fw_cfg.c
+F:	include/uapi/linux/fw_cfg.h
 
 QIB DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index a41b572eeeb1..42601a3eaed5 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -32,30 +32,12 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <uapi/linux/fw_cfg.h>
 
 MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
 MODULE_LICENSE("GPL");
 
-/* selector key values for "well-known" fw_cfg entries */
-#define FW_CFG_SIGNATURE  0x00
-#define FW_CFG_ID         0x01
-#define FW_CFG_FILE_DIR   0x19
-
-/* size in bytes of fw_cfg signature */
-#define FW_CFG_SIG_SIZE 4
-
-/* fw_cfg "file name" is up to 56 characters (including terminating nul) */
-#define FW_CFG_MAX_FILE_PATH 56
-
-/* fw_cfg file directory entry type */
-struct fw_cfg_file {
-	u32 size;
-	u16 select;
-	u16 reserved;
-	char name[FW_CFG_MAX_FILE_PATH];
-};
-
 /* fw_cfg device i/o register addresses */
 static bool fw_cfg_is_mmio;
 static phys_addr_t fw_cfg_p_base;
@@ -597,7 +579,7 @@ MODULE_DEVICE_TABLE(of, fw_cfg_sysfs_mmio_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id fw_cfg_sysfs_acpi_match[] = {
-	{ "QEMU0002", },
+	{ FW_CFG_ACPI_DEVICE_ID, },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, fw_cfg_sysfs_acpi_match);
diff --git a/include/uapi/linux/fw_cfg.h b/include/uapi/linux/fw_cfg.h
new file mode 100644
index 000000000000..c698ac3812f6
--- /dev/null
+++ b/include/uapi/linux/fw_cfg.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+#ifndef _LINUX_FW_CFG_H
+#define _LINUX_FW_CFG_H
+
+#include <linux/types.h>
+
+#define FW_CFG_ACPI_DEVICE_ID	"QEMU0002"
+
+/* selector key values for "well-known" fw_cfg entries */
+#define FW_CFG_SIGNATURE	0x00
+#define FW_CFG_ID		0x01
+#define FW_CFG_UUID		0x02
+#define FW_CFG_RAM_SIZE		0x03
+#define FW_CFG_NOGRAPHIC	0x04
+#define FW_CFG_NB_CPUS		0x05
+#define FW_CFG_MACHINE_ID	0x06
+#define FW_CFG_KERNEL_ADDR	0x07
+#define FW_CFG_KERNEL_SIZE	0x08
+#define FW_CFG_KERNEL_CMDLINE	0x09
+#define FW_CFG_INITRD_ADDR	0x0a
+#define FW_CFG_INITRD_SIZE	0x0b
+#define FW_CFG_BOOT_DEVICE	0x0c
+#define FW_CFG_NUMA		0x0d
+#define FW_CFG_BOOT_MENU	0x0e
+#define FW_CFG_MAX_CPUS		0x0f
+#define FW_CFG_KERNEL_ENTRY	0x10
+#define FW_CFG_KERNEL_DATA	0x11
+#define FW_CFG_INITRD_DATA	0x12
+#define FW_CFG_CMDLINE_ADDR	0x13
+#define FW_CFG_CMDLINE_SIZE	0x14
+#define FW_CFG_CMDLINE_DATA	0x15
+#define FW_CFG_SETUP_ADDR	0x16
+#define FW_CFG_SETUP_SIZE	0x17
+#define FW_CFG_SETUP_DATA	0x18
+#define FW_CFG_FILE_DIR		0x19
+
+#define FW_CFG_FILE_FIRST	0x20
+#define FW_CFG_FILE_SLOTS_MIN	0x10
+
+#define FW_CFG_WRITE_CHANNEL	0x4000
+#define FW_CFG_ARCH_LOCAL	0x8000
+#define FW_CFG_ENTRY_MASK	(~(FW_CFG_WRITE_CHANNEL | FW_CFG_ARCH_LOCAL))
+
+#define FW_CFG_INVALID		0xffff
+
+/* width in bytes of fw_cfg control register */
+#define FW_CFG_CTL_SIZE		0x02
+
+/* fw_cfg "file name" is up to 56 characters (including terminating nul) */
+#define FW_CFG_MAX_FILE_PATH	56
+
+/* size in bytes of fw_cfg signature */
+#define FW_CFG_SIG_SIZE 4
+
+/* FW_CFG_ID bits */
+#define FW_CFG_VERSION		0x01
+
+/* fw_cfg file directory entry type */
+struct fw_cfg_file {
+	__be32 size;
+	__be16 select;
+	__u16 reserved;
+	char name[FW_CFG_MAX_FILE_PATH];
+};
+
+#endif
-- 
2.16.1.73.g5832b7e9f2
