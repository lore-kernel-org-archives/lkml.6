Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbeEHKbF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:31:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754631AbeEHKbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:31:00 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <lee.jones@linaro.org>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/3] HISI LPC: Stop using MFD APIs
Date: Tue, 8 May 2018 18:27:30 +0800
Message-ID: <1525775252-239214-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525775252-239214-1-git-send-email-john.garry@huawei.com>
References: <1525775252-239214-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD APIs should only be used by drivers in
drivers/mfd. It is not worth splitting the driver to have
separate parts in drivers/bus and drivers/mfd, so just
drop MFD API usage.

As a solution, we will use the platform device APIs directly
to achieve the same as we had when using MFD APIs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/Kconfig    |  1 -
 drivers/bus/hisi_lpc.c | 72 ++++++--------------------------------------------
 2 files changed, 8 insertions(+), 65 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6dc177b..d1c0b60 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -33,7 +33,6 @@ config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
 	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
 	select INDIRECT_PIO
-	select MFD_CORE if ACPI
 	help
 	  Driver to enable I/O access to devices attached to the Low Pin
 	  Count bus on the HiSilicon Hip06/7 SoC.
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 2d4611e..252a6a4 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -11,7 +11,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/logic_pio.h>
-#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -341,15 +340,6 @@ static void hisi_lpc_comm_outs(void *hostdata, unsigned long pio,
 };
 
 #ifdef CONFIG_ACPI
-#define MFD_CHILD_NAME_PREFIX DRV_NAME"-"
-#define MFD_CHILD_NAME_LEN (ACPI_ID_LEN + sizeof(MFD_CHILD_NAME_PREFIX) - 1)
-
-struct hisi_lpc_mfd_cell {
-	struct mfd_cell_acpi_match acpi_match;
-	char name[MFD_CHILD_NAME_LEN];
-	char pnpid[ACPI_ID_LEN];
-};
-
 static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
 				     struct acpi_device *host,
 				     struct resource *res)
@@ -368,7 +358,7 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
 }
 
 /*
- * hisi_lpc_acpi_set_io_res - set the resources for a child's MFD
+ * hisi_lpc_acpi_set_io_res - set the resources for a child
  * @child: the device node to be updated the I/O resource
  * @hostdev: the device node associated with host controller
  * @res: double pointer to be set to the address of translated resources
@@ -458,69 +448,23 @@ static int hisi_lpc_acpi_set_io_res(struct device *child,
  *
  * Returns 0 when successful, and a negative value for failure.
  *
- * Scan all child devices and create a per-device MFD with
- * logical PIO translated IO resources.
  */
 static int hisi_lpc_acpi_probe(struct device *hostdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(hostdev);
-	struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cells;
-	struct mfd_cell *mfd_cells;
 	struct acpi_device *child;
-	int size, ret, count = 0, cell_num = 0;
-
-	list_for_each_entry(child, &adev->children, node)
-		cell_num++;
-
-	/* allocate the mfd cell and companion ACPI info, one per child */
-	size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
-	mfd_cells = devm_kcalloc(hostdev, cell_num, size, GFP_KERNEL);
-	if (!mfd_cells)
-		return -ENOMEM;
+	int ret;
 
-	hisi_lpc_mfd_cells = (struct hisi_lpc_mfd_cell *)&mfd_cells[cell_num];
 	/* Only consider the children of the host */
 	list_for_each_entry(child, &adev->children, node) {
-		struct mfd_cell *mfd_cell = &mfd_cells[count];
-		struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cell =
-					&hisi_lpc_mfd_cells[count];
-		struct mfd_cell_acpi_match *acpi_match =
-					&hisi_lpc_mfd_cell->acpi_match;
-		char *name = hisi_lpc_mfd_cell[count].name;
-		char *pnpid = hisi_lpc_mfd_cell[count].pnpid;
-		struct mfd_cell_acpi_match match = {
-			.pnpid = pnpid,
-		};
-
-		/*
-		 * For any instances of this host controller (Hip06 and Hip07
-		 * are the only chipsets), we would not have multiple slaves
-		 * with the same HID. And in any system we would have just one
-		 * controller active. So don't worrry about MFD name clashes.
-		 */
-		snprintf(name, MFD_CHILD_NAME_LEN, MFD_CHILD_NAME_PREFIX"%s",
-			 acpi_device_hid(child));
-		snprintf(pnpid, ACPI_ID_LEN, "%s", acpi_device_hid(child));
-
-		memcpy(acpi_match, &match, sizeof(*acpi_match));
-		mfd_cell->name = name;
-		mfd_cell->acpi_match = acpi_match;
-
-		ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev,
-					       &mfd_cell->resources,
-					       &mfd_cell->num_resources);
+		const struct resource *res;
+		int num_res;
+
+		ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev, &res,
+					       &num_res);
 		if (ret) {
-			dev_warn(&child->dev, "set resource fail (%d)\n", ret);
-			return ret;
+			dev_warn(hostdev, "set resource fail (%d)\n", ret);
 		}
-		count++;
-	}
-
-	ret = mfd_add_devices(hostdev, PLATFORM_DEVID_NONE,
-			      mfd_cells, cell_num, NULL, 0, NULL);
-	if (ret) {
-		dev_err(hostdev, "failed to add mfd cells (%d)\n", ret);
-		return ret;
 	}
 
 	return 0;
-- 
1.9.1
