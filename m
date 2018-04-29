Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeD2Byr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 21:54:47 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:44692 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeD2Byn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 21:54:43 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>
Cc: x86@kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] hwmon: (k10temp) Use API function to access System Management Network
Date: Sat, 28 Apr 2018 18:54:39 -0700
Message-Id: <1524966879-9424-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMN (System Management Network) on Family 17h AMD CPUs is also accessed
from other drivers, specifically EDAC. Accessing it directly is racy.
On top of that, accessing the SMN through root bridge 00:00 is wrong on
multi-die CPUs and may result in reading the temperature from the wrong
die. Use available API functions to fix the problem.

For this to work, also change the Raven Ridge PCI device ID to point to
Data Fabric Function 3, since this ID is used by the API functions to
find the CPU node.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index b06bb1f90853..00e785afae0d 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <asm/amd_nb.h>
 #include <asm/processor.h>
 
 MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
@@ -40,8 +41,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #endif
 
-#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
-#define PCI_DEVICE_ID_AMD_17H_RR_NB	0x15d0
+#ifndef PCI_DEVICE_ID_AMD_17H_RR_DF_F3
+#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3	0x14eb
 #endif
 
 /* CPUID function 0x80000001, ebx */
@@ -136,8 +137,8 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 
 static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
 {
-	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0x60,
-			  F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
+	amd_smn_read(amd_pci_dev_to_node_id(pdev),
+		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
 static ssize_t temp1_input_show(struct device *dev,
@@ -323,7 +324,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
-- 
2.7.4
