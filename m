Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbeEHKbC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:31:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754460AbeEHKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:30:59 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <lee.jones@linaro.org>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/3] HISI LPC: Add ACPI UART support
Date: Tue, 8 May 2018 18:27:32 +0800
Message-ID: <1525775252-239214-4-git-send-email-john.garry@huawei.com>
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

On the Huawei D03 development board the system UART is
the UART connected on the LPC bus.

The profile for the device driver required for this HW
is as follows:
 - platform driver
 - 16550
 - ACPI support
 - polling mode support
 - IO space support

In principle we should use the PNP driver (8250_dw.c) for
8250-devices with ACPI FW. However since this driver does
not support PNP devices, and modifying the PNP core code
to support it is not worth the effort, use the generic
8250 isa driver.

For this, we setup the pdev platform data for the serial
8250 port.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index eb5b3fc..d5f8545 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/serial_8250.h>
 #include <linux/slab.h>
 
 #define DRV_NAME "hisi-lpc"
@@ -493,6 +494,22 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 				.hid = "IPI0001",
 				.name = "hisi-lpc-ipmi",
 			},
+			/* 8250-compatible uart */
+			{
+				.hid = "HISI1031",
+				.name = "serial8250",
+				.pdata = (struct plat_serial8250_port []) {
+					{
+						.iobase = res->start,
+						.uartclk = 1843200,
+						.iotype = UPIO_PORT,
+						.flags = UPF_BOOT_AUTOCONF,
+					},
+					{}
+				},
+				.pdata_size = 2 *
+					sizeof(struct plat_serial8250_port),
+			},
 			{}
 		};
 
-- 
1.9.1
