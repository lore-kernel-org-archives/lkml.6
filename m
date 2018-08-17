Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AE8C04ABB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7D2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF7D2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeHQI0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 04:26:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:48469 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbeHQI0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 04:26:06 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7H4nAsJ017258;
        Thu, 16 Aug 2018 23:49:41 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 6/6] pci: Protect is_busmaster using the state lock
Date:   Fri, 17 Aug 2018 14:49:02 +1000
Message-Id: <20180817044902.31420-7-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180817044902.31420-1-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wraps pci_set_master() and pci_clear_master() with the pci_dev
state lock. The clearing of is_busmaster in pci_disable_device()
is already covered.

This also adds a comment explaining why is_busmaster must not be
checked in pci_set_master() due to how the power management code
uses it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/pci.c   | 9 +++++++++
 include/linux/pci.h | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 68152de2b5a0..13d988d5b2a3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4052,11 +4052,18 @@ void __weak pcibios_set_master(struct pci_dev *dev)
  *
  * Enables bus-mastering on the device and calls pcibios_set_master()
  * to do the needed arch specific settings.
+ *
+ * Note: This must not check dev->is_busmaster because the power management
+ *       code will call this in order to restore the config space to the
+ *       state of is_busmaster, thus is_busmaster might be set but the
+ *       config space bit cleared.
  */
 void pci_set_master(struct pci_dev *dev)
 {
+	pci_dev_state_lock(dev);
 	__pci_set_master(dev, true);
 	pcibios_set_master(dev);
+	pci_dev_state_unlock(dev);
 }
 EXPORT_SYMBOL(pci_set_master);
 
@@ -4066,7 +4073,9 @@ EXPORT_SYMBOL(pci_set_master);
  */
 void pci_clear_master(struct pci_dev *dev)
 {
+	pci_dev_state_lock(dev);
 	__pci_set_master(dev, false);
+	pci_dev_state_unlock(dev);
 }
 EXPORT_SYMBOL(pci_clear_master);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0d4fc22df190..a5bac5b21454 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,7 +375,6 @@ struct pci_dev {
 	unsigned int	multifunction:1;	/* Multi-function device */
 
 	unsigned int	is_added:1;
-	unsigned int	is_busmaster:1;		/* Is busmaster */
 	unsigned int	no_msi:1;		/* May not use MSI */
 	unsigned int	no_64bit_msi:1; 	/* May only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* Config space access blocked */
@@ -450,6 +449,7 @@ struct pci_dev {
 	struct mutex	state_lock;	/* Protect local state bits */
 
 	/* --- Fields below this line are protected by the state_lock mutex */
+	unsigned int	is_busmaster:1;		/* Is busmaster */
 };
 
 static inline void pci_dev_state_lock(struct pci_dev *dev)
-- 
2.17.1

