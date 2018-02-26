Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELuv5pw/YRvgvoCkBeeG5nenZj9FEzoe14ffoGUEdLdqaIj8o2d/mzlS2fyB1sCquXbsu/Lu
ARC-Seal: i=1; a=rsa-sha256; t=1519660215; cv=none;
        d=google.com; s=arc-20160816;
        b=G9oku/42598uJpi4djZcHin7/x6KMZKMkzRf7j+MDfr2pAYpmn0U9eUaCBdRiPTsfL
         mdP/ezX4A0bW9krSLeu1tIk2qLyNb/TVtCLwlbY5x90pbFj7wrJ0L/iNYg/gSo0Z5Nzw
         D4vU5HdVtjArZPdrqOAu9JZp1ZerErXh3u/5a8Wr98Oo1wTn6zEBcr4x3Yv8n20QfIfq
         1+Sgsn1NT4uyHbDrCEZyz88Op8vyp8NqzVPZa8/qfgEtcKBdPRlBynjEMfWaZvK4IiMs
         ROtwMOA3xzYk8P9ri/sH+2lAYK9g6LPfSSgIhrS4otpQyMs/ul84bTe1Q5ogVbadVJhK
         VPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=6PfO9WsrOzEx3rrYYECgVGyouxdFOLMokja/o1WS3io=;
        b=UQZuualEIeOYin08U084WquGHjkxWb6PKCo0DxQH7hYgpMBgMfecqWgdHAs7CrMKUZ
         TYLJTJKm+cEl6ZbIOik/UBuaG+wMSIbzdUwfqzV0//u9c9rzcMcxRTCFEWQ1AicYbJf2
         42HEHfl1yLbjzql4GkqmWYkPJxrhUsUJsHBPKR6yOP7ecy8gt4JSqXDLcTEkPeOOXkey
         VOMJFiQ4MpfXO9f1BIIP1C3mA+65Oivqth91pDEy+un3wLhypkUeQfUH0/GO9S0tYchy
         7dfzi1gEdjl9HmSvi/fWSk0Pwz+7QqcF6KjYeROwAYbPHSJkPBV/wzfk6WEaMJBn3Lit
         PjLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>,
	<andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <minyard@acm.org>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v15 8/9] HISI LPC: Add ACPI support
Date: Tue, 27 Feb 2018 00:40:48 +0800
Message-ID: <1519663249-9850-9-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479230024368492?=
X-GMAIL-MSGID: =?utf-8?q?1593479230024368492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Based on the previous patches, this patch supports the
LPC host on hip06/hip07 for ACPI FW.

It is the responsibility of the LPC host driver to
enumerate the child devices, as the ACPI scan code will
not enumerate children of "indirect IO" hosts.

The ACPI table for the LPC host controller and the child
devices is in the following format:
  Device (LPC0) {
    Name (_HID, "HISI0191")  // HiSi LPC
    Name (_CRS, ResourceTemplate () {
      Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
    })
  }

  Device (LPC0.IPMI) {
    Name (_HID, "IPI0001")
    Name (LORS, ResourceTemplate() {
      QWordIO (
        ResourceConsumer,
	MinNotFixed,     // _MIF
	MaxNotFixed,     // _MAF
	PosDecode,
	EntireRange,
	0x0,             // _GRA
	0xe4,            // _MIN
	0x3fff,          // _MAX
	0x0,             // _TRA
	0x04,            // _LEN
	, ,
	BTIO
      )
    })

Since the IO resources of the child devices need to be
translated from LPC bus addresses to logical PIO addresses,
and we shouldn't modify the resources of the devices
generated in the FW scan, a per-child MFD is created as
a substitute. The MFD IO resources will be the translated
bus addresses of the ACPI child.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/bus/hisi_lpc.c | 197 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index c2f3c14..0c7c1ec 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/logic_pio.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -353,6 +354,199 @@ static void hisi_lpc_comm_out(void *hostdata, unsigned long pio,
 	.outs = hisi_lpc_comm_outs,
 };
 
+#ifdef CONFIG_ACPI
+#define MFD_CHILD_NAME_PREFIX DRV_NAME"-"
+#define MFD_CHILD_NAME_LEN (ACPI_ID_LEN + sizeof(MFD_CHILD_NAME_PREFIX))
+
+struct hisi_lpc_mfd_cell {
+	struct mfd_cell_acpi_match acpi_match;
+	char name[MFD_CHILD_NAME_LEN];
+	char pnpid[ACPI_ID_LEN];
+};
+
+static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
+				     struct acpi_device *host,
+				     struct resource *res)
+{
+	unsigned long sys_port;
+	resource_size_t len = res->end - res->start;
+
+	sys_port = logic_pio_trans_hwaddr(&host->fwnode, res->start, len);
+	if (sys_port == ~0UL)
+		return -EFAULT;
+
+	res->start = sys_port;
+	res->end = sys_port + len;
+
+	return 0;
+}
+
+/*
+ * hisi_lpc_acpi_set_io_res - set the resources for a child's MFD
+ * @child: the device node to be updated the I/O resource
+ * @hostdev: the device node associated with host controller
+ * @res: double pointer to be set to the address of translated resources
+ * @num_res: pointer to variable to hold the number of translated resources
+ *
+ * Returns 0 when successful, and a negative value for failure.
+ *
+ * For a given host controller, each child device will have an associated
+ * host-relative address resource. This function will return the translated
+ * logical PIO addresses for each child devices resources.
+ */
+static int hisi_lpc_acpi_set_io_res(struct device *child,
+				    struct device *hostdev,
+				    const struct resource **res,
+				    int *num_res)
+{
+	struct acpi_device *adev;
+	struct acpi_device *host;
+	struct resource_entry *rentry;
+	LIST_HEAD(resource_list);
+	struct resource *resources;
+	int count;
+	int i;
+
+	if (!child || !hostdev)
+		return -EINVAL;
+
+	host = to_acpi_device(hostdev);
+	adev = to_acpi_device(child);
+
+	/* check the device state */
+	if (!adev->status.present) {
+		dev_dbg(child, "device is not present\n");
+		return -EIO;
+	}
+	/* whether the child had been enumerated? */
+	if (acpi_device_enumerated(adev)) {
+		dev_dbg(child, "has been enumerated\n");
+		return -EIO;
+	}
+
+	/*
+	 * The following code segment to retrieve the resources is common to
+	 * acpi_create_platform_device(), so consider a common helper function
+	 * in future.
+	 */
+	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (count <= 0) {
+		dev_dbg(child, "failed to get resources\n");
+		return count ? count : -EIO;
+	}
+
+	resources = devm_kcalloc(hostdev, count, sizeof(*resources),
+				 GFP_KERNEL);
+	if (!resources) {
+		dev_warn(hostdev, "could not allocate memory for %d resources\n",
+			 count);
+		acpi_dev_free_resource_list(&resource_list);
+		return -ENOMEM;
+	}
+	count = 0;
+	list_for_each_entry(rentry, &resource_list, node)
+		resources[count++] = *rentry->res;
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	/* translate the I/O resources */
+	for (i = 0; i < count; i++) {
+		int ret;
+
+		if (!(resources[i].flags & IORESOURCE_IO))
+			continue;
+		ret = hisi_lpc_acpi_xlat_io_res(adev, host, &resources[i]);
+		if (ret) {
+			dev_err(child, "translate IO range failed(%d)\n", ret);
+			return ret;
+		}
+	}
+	*res = resources;
+	*num_res = count;
+
+	return 0;
+}
+
+/*
+ * hisi_lpc_acpi_probe - probe children for ACPI FW
+ * @hostdev: LPC host device pointer
+ *
+ * Returns 0 when successful, and a negative value for failure.
+ *
+ * Scan all child devices and create a per-device MFD with
+ * logical PIO translated IO resources.
+ */
+static int hisi_lpc_acpi_probe(struct device *hostdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(hostdev);
+	struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cells;
+	struct mfd_cell *mfd_cells;
+	struct acpi_device *child;
+	int size, ret, count = 0, cell_num = 0;
+
+	list_for_each_entry(child, &adev->children, node)
+		cell_num++;
+
+	/* allocate the mfd cell and companion acpi info, one per child */
+	size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
+	mfd_cells = devm_kcalloc(hostdev, cell_num, size, GFP_KERNEL);
+	if (!mfd_cells)
+		return -ENOMEM;
+
+	hisi_lpc_mfd_cells = (struct hisi_lpc_mfd_cell *)
+					&mfd_cells[cell_num];
+	/* Only consider the children of the host */
+	list_for_each_entry(child, &adev->children, node) {
+		struct mfd_cell *mfd_cell = &mfd_cells[count];
+		struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cell =
+					&hisi_lpc_mfd_cells[count];
+		struct mfd_cell_acpi_match *acpi_match =
+					&hisi_lpc_mfd_cell->acpi_match;
+		char *name = hisi_lpc_mfd_cell[count].name;
+		char *pnpid = hisi_lpc_mfd_cell[count].pnpid;
+		struct mfd_cell_acpi_match match = {
+			.pnpid = pnpid,
+		};
+
+		snprintf(name, MFD_CHILD_NAME_LEN, MFD_CHILD_NAME_PREFIX"%s",
+			 acpi_device_hid(child));
+		snprintf(pnpid, ACPI_ID_LEN, "%s", acpi_device_hid(child));
+
+		memcpy(acpi_match, &match, sizeof(*acpi_match));
+		mfd_cell->name = name;
+		mfd_cell->acpi_match = acpi_match;
+
+		ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev,
+					       &mfd_cell->resources,
+					       &mfd_cell->num_resources);
+		if (ret) {
+			dev_warn(&child->dev, "set resource fail(%d)\n", ret);
+			return ret;
+		}
+		count++;
+	}
+
+	ret = mfd_add_devices(hostdev, PLATFORM_DEVID_NONE,
+			      mfd_cells, cell_num, NULL, 0, NULL);
+	if (ret) {
+		dev_err(hostdev, "failed to add mfd cells (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id hisi_lpc_acpi_match[] = {
+	{"HISI0191"},
+	{}
+};
+#else
+static int hisi_lpc_acpi_probe(struct device *dev)
+{
+	return -ENODEV;
+}
+#endif // CONFIG_ACPI
+
 /*
  * hisi_lpc_probe - the probe callback function for hisi lpc host,
  *		   will finish all the initialization.
@@ -397,6 +591,8 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	/* register the LPC host PIO resources */
 	if (!acpi_device)
 		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	else
+		ret = hisi_lpc_acpi_probe(dev);
 	if (ret)
 		return ret;
 
@@ -420,6 +616,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	.driver = {
 		.name           = DRV_NAME,
 		.of_match_table = hisi_lpc_of_match,
+		.acpi_match_table = ACPI_PTR(hisi_lpc_acpi_match),
 	},
 	.probe = hisi_lpc_probe,
 };
-- 
1.9.1
