Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C87C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1CE21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1CE21A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeHFOVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:21:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731081AbeHFOVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:21:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AEB040201A0;
        Mon,  6 Aug 2018 12:12:32 +0000 (UTC)
Received: from hive.brq.redhat.com (unknown [10.43.2.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA7C62026D68;
        Mon,  6 Aug 2018 12:12:30 +0000 (UTC)
From:   Petr Oros <poros@redhat.com>
To:     netdev@vger.kernel.org
Cc:     ivecera@redhat.com, Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Use Kconfig flag to remove support of deprecated BE2/BE3 adapters
Date:   Mon,  6 Aug 2018 14:12:28 +0200
Message-Id: <20180806121230.23690-1-poros@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 12:12:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 12:12:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'poros@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Add flags to remove support of deprecated BE2/BE3 adapters.
  BE2 disable will reduce .ko size by 2kb and BE3 by 3kb.
  Disable both will reduce .ko size by 9kb.

  With dissabled support is also removed coresponding PCI IDs
  and codepath with [BE2|BE3|BEx]_chip checks.

  New help style in Kconfig

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/emulex/benet/Kconfig   | 20 ++++++++++++++++++--
 drivers/net/ethernet/emulex/benet/be.h      |  8 ++++++++
 drivers/net/ethernet/emulex/benet/be_main.c |  6 +++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/Kconfig b/drivers/net/ethernet/emulex/benet/Kconfig
index b4853ec9de8d..68a9c40adc2a 100644
--- a/drivers/net/ethernet/emulex/benet/Kconfig
+++ b/drivers/net/ethernet/emulex/benet/Kconfig
@@ -1,7 +1,7 @@
 config BE2NET
 	tristate "ServerEngines' 10Gbps NIC - BladeEngine"
 	depends on PCI
-	---help---
+	help
 	  This driver implements the NIC functionality for ServerEngines'
 	  10Gbps network adapter - BladeEngine.
 
@@ -10,6 +10,22 @@ config BE2NET_HWMON
 	depends on BE2NET && HWMON
 	depends on !(BE2NET=y && HWMON=m)
 	default y
-	---help---
+	help
 	  Say Y here if you want to expose thermal sensor data on
 	  be2net network adapter.
+
+config BE2NET_BE2
+	bool "Support for deprecated BE2 chipsets"
+	depends on BE2NET
+	default y
+	help
+	  Say Y here if you want to use deprecated Emulex devices based
+	  on BE2 chipsets.
+
+config BE2NET_BE3
+	bool "Support for deprecated BE3 chipsets"
+	depends on BE2NET
+	default y
+	help
+	  Say Y here if you want to use deprecated Emulex devices based
+	  on BE3 chipsets.
diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index 382891f81e09..3038578ec7a7 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -779,11 +779,19 @@ static inline u16 be_max_any_irqs(struct be_adapter *adapter)
 #define skyhawk_chip(adapter)	(adapter->pdev->device == OC_DEVICE_ID5 || \
 				 adapter->pdev->device == OC_DEVICE_ID6)
 
+#ifdef CONFIG_BE2NET_BE3
 #define BE3_chip(adapter)	(adapter->pdev->device == BE_DEVICE_ID2 || \
 				 adapter->pdev->device == OC_DEVICE_ID2)
+#else
+#define BE3_chip(adapter)	(0)
+#endif /* CONFIG_BE2NET_BE3 */
 
+#ifdef CONFIG_BE2NET_BE2
 #define BE2_chip(adapter)	(adapter->pdev->device == BE_DEVICE_ID1 || \
 				 adapter->pdev->device == OC_DEVICE_ID1)
+#else
+#define BE2_chip(adapter)	(0)
+#endif /* CONFIG_BE2NET_BE2 */
 
 #define BEx_chip(adapter)	(BE3_chip(adapter) || BE2_chip(adapter))
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 8f755009ff38..d5b3f0139832 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -47,10 +47,14 @@ MODULE_PARM_DESC(rx_frag_size, "Size of a fragment that holds rcvd data.");
 static struct workqueue_struct *be_err_recovery_workq;
 
 static const struct pci_device_id be_dev_ids[] = {
+#ifdef CONFIG_BE2NET_BE2
 	{ PCI_DEVICE(BE_VENDOR_ID, BE_DEVICE_ID1) },
-	{ PCI_DEVICE(BE_VENDOR_ID, BE_DEVICE_ID2) },
 	{ PCI_DEVICE(BE_VENDOR_ID, OC_DEVICE_ID1) },
+#endif /* CONFIG_BE2NET_BE2 */
+#ifdef CONFIG_BE2NET_BE3
+	{ PCI_DEVICE(BE_VENDOR_ID, BE_DEVICE_ID2) },
 	{ PCI_DEVICE(BE_VENDOR_ID, OC_DEVICE_ID2) },
+#endif /* CONFIG_BE2NET_BE3 */
 	{ PCI_DEVICE(EMULEX_VENDOR_ID, OC_DEVICE_ID3)},
 	{ PCI_DEVICE(EMULEX_VENDOR_ID, OC_DEVICE_ID4)},
 	{ PCI_DEVICE(EMULEX_VENDOR_ID, OC_DEVICE_ID5)},
-- 
2.16.4

