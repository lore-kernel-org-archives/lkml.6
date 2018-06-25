Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F258CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953FE2625F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX3VpwnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953FE2625F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeFYW76 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933509AbeFYW7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:59:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0B32625C;
        Mon, 25 Jun 2018 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529967594;
        bh=EGwcOQsRuKdeGlODshHJygOqIrCGZjzu/XTBz6hiSrY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OX3VpwnNrHHl4WIWaQkyR2rZ9rrVkOKHy2IZDwjFxxZ1CarVuZNrtfBCn0I0hEMlH
         tCBSVqnuMkuH7Rjv/Pk33VQENarTF1fc5YafkhzCjbmKev3+Ha1ZB/5koVUoP6km/g
         tTkm8+C4gmTq2LCnOkyiJ7nmM0LIR92u//GnHGaA=
Subject: [PATCH v1 3/4] PCI: shpchp: Inline shpchp_is_native()
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Jun 2018 17:59:53 -0500
Message-ID: <152996759356.260522.17897676139260762555.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

shpchp_is_native() is trivial and has nothing to do with ACPI, so make it
an inline in pci_hotplug.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-acpi.c      |   12 ------------
 include/linux/pci_hotplug.h |    8 ++++++--
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 5100fd2d5a75..52b8434d4d6e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -394,18 +394,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	return host->native_pcie_hotplug;
 }
 
-/**
- * shpchp_is_native - Check whether a hotplug port is handled by the OS
- * @bridge: Hotplug port to check
- *
- * Returns true if the given @bridge is handled by the native SHPC hotplug
- * driver.
- */
-bool shpchp_is_native(struct pci_dev *bridge)
-{
-	return bridge->shpc_managed;
-}
-
 /**
  * pci_acpi_wake_bus - Root bus wakeup notification fork function.
  * @context: Device wakeup context.
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index cf5e22103f68..f08a44e1606f 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -162,11 +162,15 @@ struct hotplug_params {
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
-bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
-bool shpchp_is_native(struct pci_dev *bridge);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
+
+bool pciehp_is_native(struct pci_dev *bridge);
+static inline bool shpchp_is_native(struct pci_dev *bridge)
+{
+	return bridge->shpc_managed;
+}
 #else
 static inline int pci_get_hp_params(struct pci_dev *dev,
 				    struct hotplug_params *hpp)

