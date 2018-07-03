Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23BDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626A2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UoclP9sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7626A2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeGCJA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:00:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44650 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeGCJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:00:25 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6390Kus069651;
        Tue, 3 Jul 2018 04:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530608420;
        bh=6qQXzq5sVskOjFDXqNbUSzMHq1iuyxh6NRYBZDUzlwU=;
        h=From:To:CC:Subject:Date;
        b=UoclP9sgwIGQSVeZWg+x7bSO1PkO4XOSXY4P9vFS0ne965aZdNTtmItdRKcLZc2yI
         yqugvTkVh+kTl6bEUioGRqaonBjCJBbMYlsNrr79cUIKdjyfaqEk30KEFJsSSkdBV9
         W81RSSUGqJVpqkbkH95EAXHYebQWRV8Fcd8mx3Dc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6390KaU032031;
        Tue, 3 Jul 2018 04:00:20 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 3 Jul
 2018 04:00:20 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 3 Jul 2018 04:00:20 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6390I41027625;
        Tue, 3 Jul 2018 04:00:19 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: endpoint: Fix NULL pointer dereference error when CONFIGFS is disabled
Date:   Tue, 3 Jul 2018 14:30:17 +0530
Message-ID: <20180703090017.22734-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ef1433f717a2c63747a519d86965d73 ("PCI: endpoint: Create configfs
entry for each pci_epf_device_id table entry") while adding configfs
entry for each pci_epf_device_id table entry introduced a NULL pointer
dereference error when CONFIG_PCI_ENDPOINT_CONFIGFS is not enabled.
Fix it here.

Fixes: ef1433f717a2c63747a519d86965d73 ("PCI: endpoint: Create configfs
entry for each pci_epf_device_id table entry")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 62 ++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 523a8cab3bfb..7fe1930d6589 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -137,25 +137,60 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
-/**
- * pci_epf_unregister_driver() - unregister the PCI EPF driver
- * @driver: the PCI EPF driver that has to be unregistered
- *
- * Invoke to unregister the PCI EPF driver.
- */
-void pci_epf_unregister_driver(struct pci_epf_driver *driver)
+static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group;
 
+	if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
+		return;
+
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry(group, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
 	list_del(&driver->epf_group);
 	mutex_unlock(&pci_epf_mutex);
+}
+
+/**
+ * pci_epf_unregister_driver() - unregister the PCI EPF driver
+ * @driver: the PCI EPF driver that has to be unregistered
+ *
+ * Invoke to unregister the PCI EPF driver.
+ */
+void pci_epf_unregister_driver(struct pci_epf_driver *driver)
+{
+	pci_epf_remove_cfs(driver);
 	driver_unregister(&driver->driver);
 }
 EXPORT_SYMBOL_GPL(pci_epf_unregister_driver);
 
+static int pci_epf_add_cfs(struct pci_epf_driver *driver)
+{
+	struct config_group *group;
+	const struct pci_epf_device_id *id;
+
+	if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
+		return 0;
+
+	INIT_LIST_HEAD(&driver->epf_group);
+
+	id = driver->id_table;
+	while (id->name[0]) {
+		group = pci_ep_cfs_add_epf_group(id->name);
+		if (IS_ERR(group)) {
+			pci_epf_remove_cfs(driver);
+			return PTR_ERR(group);
+		}
+
+		mutex_lock(&pci_epf_mutex);
+		list_add_tail(&group->group_entry, &driver->epf_group);
+		mutex_unlock(&pci_epf_mutex);
+		id++;
+	}
+
+	return 0;
+}
+
 /**
  * __pci_epf_register_driver() - register a new PCI EPF driver
  * @driver: structure representing PCI EPF driver
@@ -167,8 +202,6 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner)
 {
 	int ret;
-	struct config_group *group;
-	const struct pci_epf_device_id *id;
 
 	if (!driver->ops)
 		return -EINVAL;
@@ -183,16 +216,7 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 	if (ret)
 		return ret;
 
-	INIT_LIST_HEAD(&driver->epf_group);
-
-	id = driver->id_table;
-	while (id->name[0]) {
-		group = pci_ep_cfs_add_epf_group(id->name);
-		mutex_lock(&pci_epf_mutex);
-		list_add_tail(&group->group_entry, &driver->epf_group);
-		mutex_unlock(&pci_epf_mutex);
-		id++;
-	}
+	pci_epf_add_cfs(driver);
 
 	return 0;
 }
-- 
2.17.1

