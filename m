Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeECPOA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:14:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751140AbeECPNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:13:48 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <lee.jones@linaro.org>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] HISI LPC: Add ACPI UART support
Date: Thu, 3 May 2018 23:08:39 +0800
Message-ID: <1525360119-102166-3-git-send-email-john.garry@huawei.com>
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

On the Huawei D03 development board the system UART is
the UART connected on the LPC bus.

The profile for the device driver required for this HW
would be as follows:
- platform driver
- supports 16550
- supports ACPI
- supports polling mode
- supports IO space

In principle we should use the PNP driver (8250_dw.c) for
8250-devices with ACPI FW. However since this host driver
does not support PNP devices, and modifying the PNP core
code to support it is not worth the effort, use the generic
8250 isa driver.

For this, we need to setup the MFD cell platform data for
a serial 8250 Port.

In addition to this change, we also make the following
changes:
- set child ACPI device as enumerated. This fixes a conflict
  in serdev setup for the UART
- use platform device ID auto for creating the uart child
  platform device to avoid conflict with platform devices
  created for serial8250_isa_devs from 8250_core.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 71693d77..b0ee2fa 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/serial_8250.h>
 #include <linux/slab.h>
 
 #define DRV_NAME "hisi-lpc"
@@ -362,6 +363,35 @@ static int hisi_lpc_acpi_xlat_io_res(struct acpi_device *adev,
 	.pnpid = "IPI0001",
 };
 
+static const struct mfd_cell_acpi_match hisi_lpc_acpi_mfd_match_uart = {
+	.pnpid = "HISI1031",
+};
+
+static int hisi_lpc_acpi_uart_setup(struct device *hostdev,
+				    struct mfd_cell *mfd_cell)
+{
+	const struct resource * const resource = mfd_cell->resources;
+	struct plat_serial8250_port ref_port[] = {
+		{
+			.iobase = resource->start,
+			.uartclk = 1843200,
+			.iotype = UPIO_PORT,
+			.flags = UPF_BOOT_AUTOCONF,
+		},
+		{}
+	};
+
+	mfd_cell->platform_data = devm_kmemdup(hostdev, &ref_port,
+					       sizeof(ref_port), GFP_KERNEL);
+	if (!mfd_cell->platform_data)
+		return -ENOMEM;
+
+	mfd_cell->pdata_size = sizeof(ref_port);
+
+	return 0;
+}
+
+
 struct hisi_lpc_acpi_mfd_cell {
 	struct mfd_cell mfd_cell;
 	int (*setup)(struct device *hostdev, struct mfd_cell *mfd_cell);
@@ -373,6 +403,14 @@ struct hisi_lpc_acpi_mfd_cell {
 			.acpi_match = &hisi_lpc_acpi_mfd_match_ipmi,
 		},
 	},
+	/* 8250-compatible uart */
+	{
+		.mfd_cell = {
+			.name = "serial8250",
+			.acpi_match = &hisi_lpc_acpi_mfd_match_uart,
+		},
+		.setup = hisi_lpc_acpi_uart_setup,
+	},
 	{}
 };
 
@@ -530,10 +568,11 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 				return ret;
 		}
 
+		acpi_device_set_enumerated(child);
 		count++;
 	}
 
-	ret = mfd_add_devices(hostdev, PLATFORM_DEVID_NONE,
+	ret = mfd_add_devices(hostdev, PLATFORM_DEVID_AUTO,
 			      mfd_cells, cell_num, NULL, 0, NULL);
 	if (ret) {
 		dev_err(hostdev, "failed to add mfd cells (%d)\n", ret);
-- 
1.9.1
