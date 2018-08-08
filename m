Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B299C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0334121737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0334121737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeHHNy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:54:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHNyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:54:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87C8240216E6;
        Wed,  8 Aug 2018 11:35:07 +0000 (UTC)
Received: from hive.brq.redhat.com (unknown [10.43.2.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1981C723;
        Wed,  8 Aug 2018 11:35:05 +0000 (UTC)
From:   Petr Oros <poros@redhat.com>
To:     netdev@vger.kernel.org
Cc:     ivecera@redhat.com, Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] be2net: Use Kconfig flag to support for enabling/disabling adapters
Date:   Wed,  8 Aug 2018 13:35:01 +0200
Message-Id: <20180808113505.550-1-poros@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 11:35:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 11:35:07 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'poros@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags to enable/disable supported chips in be2net.

With disable support are removed coresponding PCI IDs and
also codepaths with [BE2|BE3|BEx|lancer|skyhawk]_chip checks.

Disable chip will reduce module size by:
BE2 ~2kb
BE3 ~3kb
Lancer ~10kb
Skyhawk ~9kb

When enable skyhawk only it will reduce module size by ~20kb

New help style in Kconfig

Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/emulex/benet/Kconfig   | 41 +++++++++++++++++++++++++++--
 drivers/net/ethernet/emulex/benet/be.h      | 16 +++++++++++
 drivers/net/ethernet/emulex/benet/be_main.c | 10 ++++++-
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/Kconfig b/drivers/net/ethernet/emulex/benet/Kconfig
index b4853ec9de8d..2c2629771165 100644
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
 
@@ -10,6 +10,43 @@ config BE2NET_HWMON
 	depends on BE2NET && HWMON
 	depends on !(BE2NET=y && HWMON=m)
 	default y
-	---help---
+	help
 	  Say Y here if you want to expose thermal sensor data on
 	  be2net network adapter.
+
+config BE2NET_BE2
+	bool "Support for BE2 chipsets"
+	depends on BE2NET
+	default y
+	help
+	  Say Y here if you want to use devices based on BE2
+	  chipsets. (e.g. OneConnect OCe10xxx)
+
+config BE2NET_BE3
+	bool "Support for BE3 chipsets"
+	depends on BE2NET
+	default y
+	help
+	  Say Y here if you want to use devices based on BE3
+	  chipsets. (e.g. OneConnect OCe11xxx)
+
+config BE2NET_LANCER
+	bool "Support for Lancer chipsets"
+	depends on BE2NET
+	default y
+	help
+	  Say Y here if you want to use devices based on Lancer
+	  chipsets. (e.g LightPulse LPe12xxx)
+
+config BE2NET_SKYHAWK
+	bool "Support for Skyhawk chipsets"
+	depends on BE2NET
+	default y
+	help
+	  Say Y here if you want to use devices based on Skyhawk
+	  chipsets. (e.g. OneConnect OCe14xxx)
+
+comment "WARNING: be2net is useless without any enabled chip"
+        depends on BE2NET_BE2=n && BE2NET_BE3=n && BE2NET_LANCER=n && \
+	BE2NET_SKYHAWK=n && BE2NET
+
diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index 382891f81e09..405e9729d425 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -773,17 +773,33 @@ static inline u16 be_max_any_irqs(struct be_adapter *adapter)
 /* Is BE in QNQ multi-channel mode */
 #define be_is_qnq_mode(adapter)		(adapter->function_mode & QNQ_MODE)
 
+#ifdef CONFIG_BE2NET_LANCER
 #define lancer_chip(adapter)	(adapter->pdev->device == OC_DEVICE_ID3 || \
 				 adapter->pdev->device == OC_DEVICE_ID4)
+#else
+#define lancer_chip(adapter)	(0)
+#endif /* CONFIG_BE2NET_LANCER */
 
+#ifdef CONFIG_BE2NET_SKYHAWK
 #define skyhawk_chip(adapter)	(adapter->pdev->device == OC_DEVICE_ID5 || \
 				 adapter->pdev->device == OC_DEVICE_ID6)
+#else
+#define skyhawk_chip(adapter)	(0)
+#endif /* CONFIG_BE2NET_SKYHAWK */
 
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
index 8f755009ff38..d08eefce7c64 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -47,14 +47,22 @@ MODULE_PARM_DESC(rx_frag_size, "Size of a fragment that holds rcvd data.");
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
+#ifdef CONFIG_BE2NET_LANCER
 	{ PCI_DEVICE(EMULEX_VENDOR_ID, OC_DEVICE_ID3)},
 	{ PCI_DEVICE(EMULEX_VENDOR_ID, OC_DEVICE_ID4)},
+#endif /* CONFIG_BE2NET_LANCER */
+#ifdef CONFIG_BE2NET_SKYHAWK
 	{ PCI_DEVICE(EMULEX_VENDOR_ID, OC_DEVICE_ID5)},
 	{ PCI_DEVICE(EMULEX_VENDOR_ID, OC_DEVICE_ID6)},
+#endif /* CONFIG_BE2NET_SKYHAWK */
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, be_dev_ids);
-- 
2.16.4

