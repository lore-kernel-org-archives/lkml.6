Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6844FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF68206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbeLQBtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:49:15 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:19494 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbeLQBtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:49:13 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id F0CD4B6136703D829543;
        Mon, 17 Dec 2018 09:49:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBH1n2rn014059;
        Mon, 17 Dec 2018 09:49:02 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018121709490510-17068293 ;
          Mon, 17 Dec 2018 09:49:05 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V2 2/3]  misc/pvpanic : add pci interface for pvpanic
Date:   Mon, 17 Dec 2018 10:09:11 +0800
Message-Id: <1545012552-16951-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1545012552-16951-1-git-send-email-peng.hao2@zte.com.cn>
References: <1545012552-16951-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-17 09:49:05,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-17 09:49:01,
        Serialize complete at 2018-12-17 09:49:01
X-MAIL: mse01.zte.com.cn wBH1n2rn014059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support pvpanic as a pci device in guest kernel.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index f84ed30..b8d8dba 100644
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
@@ -172,12 +175,86 @@ static int pvpanic_mmio_remove(struct platform_device *pdev)
 	.remove = pvpanic_mmio_remove,
 };
 
+#ifdef CONFIG_PCI
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
+	{}
+};
+
+static int pvpanic_pci_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
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
+static int pvpanic_register_pci_drvier(void)
+{
+	return pci_register_driver(&pvpanic_pci_driver);
+}
+
+static void pvpanic_unregister_pci_drvier(void)
+{
+	pci_unregister_driver(&pvpanic_pci_driver);
+}
+#else /* CONFIG_PCI */
+static int pvpanic_register_pci_drvier(void)
+{
+	return 0;
+}
+
+static void pvpanic_unregister_pci_drvier(void) {}
+#endif
+
 static int __init pvpanic_mmio_init(void)
 {
+	int r1, r2;
+
 	if (acpi_disabled)
-		return platform_driver_register(&pvpanic_mmio_driver);
+		r1 = platform_driver_register(&pvpanic_mmio_driver);
+	else
+		r2 = pvpanic_register_acpi_driver();
+	r2 = pvpanic_register_pci_drvier();
+	if (r1 && r2) /* all drivers register failed */
+		return 1;
 	else
-		return pvpanic_register_acpi_driver();
+		return 0;
 }
 
 static void __exit pvpanic_mmio_exit(void)
@@ -186,6 +263,7 @@ static void __exit pvpanic_mmio_exit(void)
 		platform_driver_unregister(&pvpanic_mmio_driver);
 	else
 		pvpanic_unregister_acpi_driver();
+	pvpanic_unregister_pci_drvier();
 }
 
 module_init(pvpanic_mmio_init);
-- 
1.8.3.1

