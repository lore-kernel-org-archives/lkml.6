Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939204AbeE1NaC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:30:02 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50912 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939075AbeE1N36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:29:58 -0400
To: "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>,
        <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
Subject: [PATCH 3/5] scsi: ufs: Add Kconfig for UFS HC driver crypto support
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Message-ID: <9baaf314-e9de-a078-1085-9c81b3421d42@synopsys.com>
Date: Mon, 28 May 2018 14:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.144.133.104]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the Kconfig for enabling crypto support for
UFS Host Controller driver. It also adds Makefile changes
for building crypto support based on crypto Kconfig selection.

Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
---
 drivers/scsi/ufs/Kconfig  | 15 +++++++++++++++
 drivers/scsi/ufs/Makefile |  6 +++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index e27b4d4..0134672 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -50,6 +50,21 @@ config SCSI_UFSHCD
 	  However, do not compile this as a module if your root file system
 	  (the one containing the directory /) is located on a UFS device.
 
+config SCSI_UFSHCD_INLINE_ENCRYPTION
+	bool "Universal Flash Storage Controller Driver crypto support"
+	depends on SCSI_UFSHCD
+	default n
+	select BLK_DEV_INLINE_ENCRYPTION if SCSI_UFSHCD_INLINE_ENCRYPTION
+	help
+	This enables the Inline Encryption feature of the UFS Host
+	Controller driver. Once the capability is detected in hardware,
+	it will be made available for the user through Linux Kernel
+	Cryptography Framework(LKCF).
+
+	  If you have a controller with this capability, say Y.
+
+	  If unsure, say N.
+
 config SCSI_UFSHCD_PCI
 	tristate "PCI bus based UFS Controller support"
 	depends on SCSI_UFSHCD && PCI
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 918f579..ab84bec 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -4,6 +4,10 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-dwc-g210.o
 obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
-ufshcd-core-objs := ufshcd.o ufs-sysfs.o
+ifdef CONFIG_SCSI_UFSHCD_INLINE_ENCRYPTION
+        ufshcd-core-objs := ufshcd.o ufs-sysfs.o ufshcd-crypto.o
+else
+        ufshcd-core-objs := ufshcd.o ufs-sysfs.o
+endif
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
-- 
2.7.4
