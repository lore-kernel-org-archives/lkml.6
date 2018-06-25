Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DD5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231432625F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv95CvE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231432625F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeFYW7p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932253AbeFYW7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:59:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6879A2625C;
        Mon, 25 Jun 2018 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529967581;
        bh=nrz5k30vg9eh38KGXVYVkvttqviUj+ZI1Y05HqJZfus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cv95CvE2pO5l3AnC4GQjuStJsvHckWnYbcG0ccpb/dK9PjFrnX1N8gGi7uZNxQQl3
         lZDgtvFdplaZS0WPG2EjLS1zSAQeTBUWJmITmuv1fEhZTcake5coQBrdjGpWkmWj69
         29jkhJv0XhrNsIKPQlpYHZNs1TJekWb8s7msaFF8=
Subject: [PATCH v1 1/4] PCI: shpchp: Manage SHPC unconditionally on non-ACPI
 systems
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Jun 2018 17:59:40 -0500
Message-ID: <152996758037.260522.6880919949506497973.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

If acpi_pci_find_root() returns NULL, it means there's no ACPI host bridge
device (PNP0A03 or PNP0A08), and the OS is always allowed to manage the
SHPC, so return success in that case.

This fixes a NULL pointer dereference when CONFIG_ACPI=y but the current
hardware/firmware platform doesn't support ACPI.  In that case,
acpi_get_hp_hw_control_from_firmware() is implemented but
acpi_pci_find_root() returns NULL.

Fixes: 90cc0c3cc709 ("PCI: shpchp: Add shpchp_is_native()")
Link: https://lkml.kernel.org/r/20180621164715.28160-1-marc.zyngier@arm.com
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpi_pcihp.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 3979f89b250a..5bd6c1573295 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -7,7 +7,6 @@
  * All rights reserved.
  *
  * Send feedback to <kristen.c.accardi@intel.com>
- *
  */
 
 #include <linux/module.h>
@@ -87,8 +86,17 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 		return 0;
 
 	/* If _OSC exists, we should not evaluate OSHP */
+
+	/*
+	 * If there's no ACPI host bridge (i.e., ACPI support is compiled
+	 * into the kernel but the hardware platform doesn't support ACPI),
+	 * there's nothing to do here.
+	 */
 	host = pci_find_host_bridge(pdev->bus);
 	root = acpi_pci_find_root(ACPI_HANDLE(&host->dev));
+	if (!root)
+		return 0;
+
 	if (root->osc_support_set)
 		goto no_control;
 

