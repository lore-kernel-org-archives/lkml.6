Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932281AbeEHKbD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:31:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754628AbeEHKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:30:59 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <lee.jones@linaro.org>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/3] HISI LPC: Re-Add ACPI child enumeration support
Date: Tue, 8 May 2018 18:27:31 +0800
Message-ID: <1525775252-239214-3-git-send-email-john.garry@huawei.com>
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

Since we no longer use the MFD APIs to enumerate the
child devices on the bus, use the platform driver APIs
directly.

In this patch we iterate of the children devices for the
host, and create a platform device directly per child.

For the iterating, we match the child ACPI HID against a
known list of supported child devices and their respective
ACPIs HID, to find the device name and any other
supplementary data.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 252a6a4..eb5b3fc 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -442,12 +442,28 @@ static int hisi_lpc_acpi_set_io_res(struct device *child,
 	return 0;
 }
 
+static int hisi_lpc_acpi_remove_subdev(struct device *dev, void *unused)
+{
+	platform_device_unregister(to_platform_device(dev));
+	return 0;
+}
+
+struct hisi_lpc_acpi_cell {
+	const char *hid;
+	const char *name;
+	void *pdata;
+	size_t pdata_size;
+};
+
 /*
  * hisi_lpc_acpi_probe - probe children for ACPI FW
  * @hostdev: LPC host device pointer
  *
  * Returns 0 when successful, and a negative value for failure.
  *
+ * Create a platform device per child, fixing up the resources
+ * from bus addresses to Logical PIO addresses.
+ *
  */
 static int hisi_lpc_acpi_probe(struct device *hostdev)
 {
@@ -457,17 +473,75 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 
 	/* Only consider the children of the host */
 	list_for_each_entry(child, &adev->children, node) {
+		const char *hid = acpi_device_hid(child);
+		const struct hisi_lpc_acpi_cell *cell;
+		struct platform_device *pdev;
 		const struct resource *res;
+		bool found = false;
 		int num_res;
 
 		ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev, &res,
 					       &num_res);
 		if (ret) {
 			dev_warn(hostdev, "set resource fail (%d)\n", ret);
+			goto fail;
+		}
+
+		cell = (struct hisi_lpc_acpi_cell []){
+			/* ipmi */
+			{
+				.hid = "IPI0001",
+				.name = "hisi-lpc-ipmi",
+			},
+			{}
+		};
+
+		for (; cell && cell->name; cell++) {
+			if (!strcmp(cell->hid, hid)) {
+				found = true;
+				break;
+			}
 		}
+
+		if (!found) {
+			dev_warn(hostdev,
+				 "could not find cell for child device (%s)\n",
+				 hid);
+			ret = -ENODEV;
+			goto fail;
+		}
+
+		pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
+		if (!pdev) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		pdev->dev.parent = hostdev;
+		ACPI_COMPANION_SET(&pdev->dev, child);
+
+		ret = platform_device_add_resources(pdev, res, num_res);
+		if (ret)
+			goto fail;
+
+		ret = platform_device_add_data(pdev, cell->pdata,
+					       cell->pdata_size);
+		if (ret)
+			goto fail;
+
+		ret = platform_device_add(pdev);
+		if (ret)
+			goto fail;
+
+		acpi_device_set_enumerated(child);
 	}
 
 	return 0;
+
+fail:
+	device_for_each_child(hostdev, NULL,
+			      hisi_lpc_acpi_remove_subdev);
+	return ret;
 }
 
 static const struct acpi_device_id hisi_lpc_acpi_match[] = {
-- 
1.9.1
