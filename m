Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F8C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFF32080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFF32080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeLNIpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:45:35 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:53916 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeLNIpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:45:35 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2D16EE1F593223E19252;
        Fri, 14 Dec 2018 16:45:33 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBE8jCRb022915;
        Fri, 14 Dec 2018 16:45:12 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018121416455105-16718675 ;
          Fri, 14 Dec 2018 16:45:51 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH 2/3]  misc/pvpanic : add pci interface for pvpanic
Date:   Fri, 14 Dec 2018 17:06:50 +0800
Message-Id: <1544778411-121925-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544778411-121925-1-git-send-email-peng.hao2@zte.com.cn>
References: <1544778411-121925-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-14 16:45:51,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-14 16:44:57,
        Serialize complete at 2018-12-14 16:44:57
X-MAIL: mse01.zte.com.cn wBE8jCRb022915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support pvpanic as a pci device in guest kernel.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index f84ed30..1fae67e 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -13,11 +13,14 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
 static void __iomem *base;
 
+#define PCI_VENDOR_ID_REDHAT             0x1b36
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0101
 #define PVPANIC_PANICKED        (1 << 0)
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
@@ -172,12 +175,71 @@ static int pvpanic_mmio_remove(struct platform_device *pdev)
 	.remove = pvpanic_mmio_remove,
 };
 
+#ifdef CONFIG_PCI
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
+	{}
+};
+
+static int pvpanic_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	int err;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+	if (pci_request_region(pdev, 0, "pvpanic-pci"))
+		goto disable;
+
+	base = pci_ioremap_bar(pdev, 0);
+	if (!base)
+		goto release;
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
+	return 0;
+
+release:
+	pci_release_region(pdev, 0);
+disable:
+	pci_disable_device(pdev);
+
+	return -ENODEV;
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pvpanic_panic_nb);
+	iounmap(base);
+	pci_release_region(pdev, 0);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver pvpanic_pci_driver = {
+	.name =         "pvpanic-pci",
+	.id_table =     pvpanic_pci_id_tbl,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+};
+
+#endif /* CONFIG_PCI */
+
 static int __init pvpanic_mmio_init(void)
 {
+	int r1, r2;
+
 	if (acpi_disabled)
-		return platform_driver_register(&pvpanic_mmio_driver);
+		r1 = platform_driver_register(&pvpanic_mmio_driver);
+	else
+		r1 = pvpanic_register_acpi_driver();
+	r2 = pci_register_driver(&pvpanic_pci_driver);
+
+	if (r1 && r2) /* all drivers register failed */
+		return 1;
 	else
-		return pvpanic_register_acpi_driver();
+		return 0;
 }
 
 static void __exit pvpanic_mmio_exit(void)
@@ -186,6 +248,7 @@ static void __exit pvpanic_mmio_exit(void)
 		platform_driver_unregister(&pvpanic_mmio_driver);
 	else
 		pvpanic_unregister_acpi_driver();
+	pci_unregister_driver(&pvpanic_pci_driver);
 }
 
 module_init(pvpanic_mmio_init);
-- 
1.8.3.1

