Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725DE206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725DE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeIDXFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:05:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:7110 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeIDXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:05:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 11:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="77938432"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2018 11:38:51 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Winner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI/portdrv: Enable error reporting on managed ports
Date:   Tue,  4 Sep 2018 12:33:09 -0600
Message-Id: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, the port driver will disable error reporting and assumes
it will be enabled later by the AER driver's pci_walk_bus() sequence.
This may not be the case for host-bridge enabled root ports, who will
enable first error reporting on the bus during the root port probe, and
then disable error reporting on downstream devices during subsequent
probing of the bus.

A hotplugged port device may also fail to enable error reporting as the
AER driver has already run on the root bus.

Check for these conditions and enable error reporting during portdrv
probing.

Example case:
[  343.790573] pcieport 10000:00:00.0: pci_disable_pcie_error_reporting
[  343.809812] pcieport 10000:00:00.0: pci_enable_pcie_error_reporting
[  343.819506] pci 10000:01:00.0: pci_enable_pcie_error_reporting
[  343.828814] pci 10000:02:00.0: pci_enable_pcie_error_reporting
[  343.838089] pci 10000:02:01.0: pci_enable_pcie_error_reporting
[  343.847478] pci 10000:02:02.0: pci_enable_pcie_error_reporting
[  343.856659] pci 10000:02:03.0: pci_enable_pcie_error_reporting
[  343.865794] pci 10000:02:04.0: pci_enable_pcie_error_reporting
[  343.874875] pci 10000:02:05.0: pci_enable_pcie_error_reporting
[  343.883918] pci 10000:02:06.0: pci_enable_pcie_error_reporting
[  343.892922] pci 10000:02:07.0: pci_enable_pcie_error_reporting
[  343.918900] pcieport 10000:01:00.0: pci_disable_pcie_error_reporting
[  343.968426] pcieport 10000:02:00.0: pci_disable_pcie_error_reporting
[  344.028179] pcieport 10000:02:01.0: pci_disable_pcie_error_reporting
[  344.091269] pcieport 10000:02:02.0: pci_disable_pcie_error_reporting
[  344.156473] pcieport 10000:02:03.0: pci_disable_pcie_error_reporting
[  344.238042] pcieport 10000:02:04.0: pci_disable_pcie_error_reporting
[  344.321864] pcieport 10000:02:05.0: pci_disable_pcie_error_reporting
[  344.411601] pcieport 10000:02:06.0: pci_disable_pcie_error_reporting
[  344.505332] pcieport 10000:02:07.0: pci_disable_pcie_error_reporting
[  344.621824] nvme 10000:06:00.0: pci_enable_pcie_error_reporting

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7c37d81..fdd953a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -343,6 +343,16 @@ int pcie_port_device_register(struct pci_dev *dev)
 	if (!nr_service)
 		goto error_cleanup_irqs;
 
+#ifdef CONFIG_PCIEAER
+	/*
+	 * Enable error reporting for this port in case AER probing has already
+	 * run on the root bus or this port device is hot-inserted
+	 */
+	if (dev->aer_cap && pci_aer_available() &&
+	    (pcie_ports_native || pci_find_host_bridge(dev->bus)->native_aer))
+		pci_enable_pcie_error_reporting(dev);
+#endif
+
 	return 0;
 
 error_cleanup_irqs:
-- 
1.8.3.1

