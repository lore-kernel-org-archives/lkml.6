Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6B521850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeLSHnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:43:50 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:29740 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLSHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:43:49 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4C8D2335D42E3AAA5787;
        Wed, 19 Dec 2018 15:43:47 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBJ7hWwK050157;
        Wed, 19 Dec 2018 15:43:32 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018121915435413-17580349 ;
          Wed, 19 Dec 2018 15:43:54 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V5 2/3]  misc/pvpanic : add pci interface for pvpanic
Date:   Wed, 19 Dec 2018 16:04:51 +0800
Message-Id: <1545206692-32183-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1545206692-32183-1-git-send-email-peng.hao2@zte.com.cn>
References: <1545206692-32183-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-19 15:43:54,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-19 15:43:24,
        Serialize complete at 2018-12-19 15:43:24
X-MAIL: mse01.zte.com.cn wBJ7hWwK050157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support pvpanic as a pci device in guest kernel.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index f84ed30..c30bf62 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -13,9 +13,12 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
+#define PCI_VENDOR_ID_REDHAT             0x1b36
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0101
 static void __iomem *base;
 
 #define PVPANIC_PANICKED        (1 << 0)
@@ -172,12 +175,76 @@ static int pvpanic_mmio_remove(struct platform_device *pdev)
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
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret < 0)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
+	if (ret)
+		return ret;
+
+	base = pcim_iomap_table(pdev)[0];
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
+	return 0;
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pvpanic_panic_nb);
+}
+
+static struct pci_driver pvpanic_pci_driver = {
+	.name =         "pvpanic-pci",
+	.id_table =     pvpanic_pci_id_tbl,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+};
+
+static int pvpanic_register_pci_driver(void)
+{
+	return pci_register_driver(&pvpanic_pci_driver);
+}
+
+static void pvpanic_unregister_pci_driver(void)
+{
+	pci_unregister_driver(&pvpanic_pci_driver);
+}
+#else
+static int pvpanic_register_pci_driver(void)
+{
+	return 0;
+}
+
+static void pvpanic_unregister_pci_driver(void) {}
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
+		r1 = pvpanic_register_acpi_driver();
+	r2 = pvpanic_register_pci_driver();
+	if (r1 && r2) /* all drivers register failed */
+		return 1;
 	else
-		return pvpanic_register_acpi_driver();
+		return 0;
 }
 
 static void __exit pvpanic_mmio_exit(void)
@@ -186,6 +253,7 @@ static void __exit pvpanic_mmio_exit(void)
 		platform_driver_unregister(&pvpanic_mmio_driver);
 	else
 		pvpanic_unregister_acpi_driver();
+	pvpanic_unregister_pci_driver();
 }
 
 module_init(pvpanic_mmio_init);
-- 
1.8.3.1

