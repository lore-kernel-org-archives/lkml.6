Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeECPN4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:13:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750954AbeECPNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:13:48 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <lee.jones@linaro.org>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] HISI LPC: Reference static MFD cells for ACPI support
Date: Thu, 3 May 2018 23:08:38 +0800
Message-ID: <1525360119-102166-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
References: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for ACPI support the driver models the host as
an MFD. For a device connected to the LPC bus, we dynamically
create an MFD cell for that device, configuring the cell
name and ACPI match parameters manually. This makes supporting
named devices and also special setup handling for certain devices
awkward, as we would need to introduce some special ACPI device
handling according to device HID.

To avoid this, create reference static MFD cells for known
child devices, so when adding an MFD cell we can fix the cell
platform data as required. For this, a setup callback function
is added.

For now, only the IPMI cell is added.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 89 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 36 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 2d4611e..71693d77 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -341,15 +341,6 @@ static void hisi_lpc_comm_outs(void *hostdata, unsigned long pio,
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
@@ -367,6 +358,40 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
 	return 0;
 }
 
+static const struct mfd_cell_acpi_match hisi_lpc_acpi_mfd_match_ipmi = {
+	.pnpid = "IPI0001",
+};
+
+struct hisi_lpc_acpi_mfd_cell {
+	struct mfd_cell mfd_cell;
+	int (*setup)(struct device *hostdev, struct mfd_cell *mfd_cell);
+} static const hisi_lpc_acpi_mfd_cells[] = {
+	/* ipmi */
+	{
+		.mfd_cell = {
+			.name = "hisi-lpc-ipmi",
+			.acpi_match = &hisi_lpc_acpi_mfd_match_ipmi,
+		},
+	},
+	{}
+};
+
+static const struct mfd_cell *hisi_lpc_acpi_mfd_get_cell(const char *hid)
+{
+	const struct hisi_lpc_acpi_mfd_cell *cell = hisi_lpc_acpi_mfd_cells;
+
+	for (; cell && cell->mfd_cell.name; cell++) {
+		const struct mfd_cell *mfd_cell = &cell->mfd_cell;
+		const struct mfd_cell_acpi_match *acpi_match;
+
+		acpi_match = mfd_cell->acpi_match;
+		if (!strcmp(acpi_match->pnpid, hid))
+			return mfd_cell;
+	}
+
+	return NULL;
+}
+
 /*
  * hisi_lpc_acpi_set_io_res - set the resources for a child's MFD
  * @child: the device node to be updated the I/O resource
@@ -464,7 +489,6 @@ static int hisi_lpc_acpi_set_io_res(struct device *child,
 static int hisi_lpc_acpi_probe(struct device *hostdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(hostdev);
-	struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cells;
 	struct mfd_cell *mfd_cells;
 	struct acpi_device *child;
 	int size, ret, count = 0, cell_num = 0;
@@ -472,39 +496,24 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 	list_for_each_entry(child, &adev->children, node)
 		cell_num++;
 
-	/* allocate the mfd cell and companion ACPI info, one per child */
-	size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
+	/* allocate the mfd cells, one per child */
+	size = sizeof(*mfd_cells);
 	mfd_cells = devm_kcalloc(hostdev, cell_num, size, GFP_KERNEL);
 	if (!mfd_cells)
 		return -ENOMEM;
 
-	hisi_lpc_mfd_cells = (struct hisi_lpc_mfd_cell *)&mfd_cells[cell_num];
 	/* Only consider the children of the host */
 	list_for_each_entry(child, &adev->children, node) {
 		struct mfd_cell *mfd_cell = &mfd_cells[count];
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
+		const struct mfd_cell *mfd_cell_ref;
+		const char *hid = acpi_device_hid(child);
+		struct hisi_lpc_acpi_mfd_cell *cell;
+
+		mfd_cell_ref = hisi_lpc_acpi_mfd_get_cell(hid);
+		if (!mfd_cell_ref)
+			return -ENOENT;
+
+		memcpy(mfd_cell, mfd_cell_ref, sizeof(*mfd_cell));
 
 		ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev,
 					       &mfd_cell->resources,
@@ -513,6 +522,14 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 			dev_warn(&child->dev, "set resource fail (%d)\n", ret);
 			return ret;
 		}
+
+		cell = container_of(mfd_cell_ref, typeof(*cell), mfd_cell);
+		if (cell->setup) {
+			ret = cell->setup(hostdev, mfd_cell);
+			if (ret)
+				return ret;
+		}
+
 		count++;
 	}
 
-- 
1.9.1
