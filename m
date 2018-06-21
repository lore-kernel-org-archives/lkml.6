Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A72C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370AC216C1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370AC216C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbeFUQrm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:47:42 -0400
Received: from foss.arm.com ([217.140.101.70]:52430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933391AbeFUQrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:47:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C1571435;
        Thu, 21 Jun 2018 09:47:40 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA8F3F5BC;
        Thu, 21 Jun 2018 09:47:39 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: shpchp: Fix probing logic inversion
Date:   Thu, 21 Jun 2018 17:47:15 +0100
Message-Id: <20180621164715.28160-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until recently, shpc_probe() would bail out pretty early in the
absence of the SHPC capability. A logic change in the way the
driver now checks that capability makes it go and probe the
firmware anyway, with ugly consequences if the system is not
ACPI based (my arm64 ThunderX is DT driven, and explodes in
a spectacular way after getting a NULL root bridge from the
non-existent ACPI tables...).

Take this opportunity to move the call to shpchp_is_native()
back into shpc_probe(), making it clear that a non-ACPI system
is not expected to use this driver.

Fixes: 90cc0c3cc709 ("PCI: shpchp: Add shpchp_is_native()")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/hotplug/acpi_pcihp.c  | 3 ---
 drivers/pci/hotplug/shpchp_core.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 3979f89b250a..b57f29753a08 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -83,9 +83,6 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 	 * OSHP within the scope of the hotplug controller and its parents,
 	 * up to the host bridge under which this controller exists.
 	 */
-	if (shpchp_is_native(pdev))
-		return 0;
-
 	/* If _OSC exists, we should not evaluate OSHP */
 	host = pci_find_host_bridge(pdev->bus);
 	root = acpi_pci_find_root(ACPI_HANDLE(&host->dev));
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index e91be287f292..8902fe18a636 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -275,7 +275,8 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int rc;
 	struct controller *ctrl;
 
-	if (acpi_get_hp_hw_control_from_firmware(pdev))
+	if (!shpchp_is_native(pdev) ||
+	    acpi_get_hp_hw_control_from_firmware(pdev))
 		return -ENODEV;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
-- 
2.17.1

