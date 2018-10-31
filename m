Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41810C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087A620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBu8HlQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087A620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbeKAIcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbeKAIJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6A720821;
        Wed, 31 Oct 2018 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027362;
        bh=bCeSnhJ5sOCuPnDqpcQ3vgv41nyVpOUmBoy+SEGwNAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBu8HlQDs2fRJN+E8W47JdE5mpFjxmKUaGNuOmY4fQViv4FiO4woRJ5hwMV7DEJ6o
         S0ZRO5oQ+aQO3wNUNhuNVol32Inj5QrG0b84KuK5zlGh1I5fYgkeBwg9Jh+gkvhOXe
         OESIrjrBMUL7mHlcE7EWHqOjleWCYdFkixR+ruYw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 097/126] PCI / ACPI: Enable wake automatically for power managed bridges
Date:   Wed, 31 Oct 2018 19:07:25 -0400
Message-Id: <20181031230754.29029-97-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 6299cf9ec3985cac70bede8a855b5087b81a6640 ]

We enable power management automatically for bridges where
pci_bridge_d3_possible() returns true. However, these bridges may have
ACPI methods such as _DSW that need to be called before D3 entry. For
example in Lenovo Thinkpad X1 Carbon 6th _DSW method is used to prepare
D3cold for the PCIe root port hosting Thunderbolt chain. Because wake is
not enabled _DSW method is never called and the port does not enter
D3cold properly consuming more power than necessary.

Users can work this around by writing "enabled" to "wakeup" sysfs file
under the device in question but that is not something an ordinary user
is expected to do.

Since we already automatically enable power management for PCIe ports
with ->bridge_d3 set extend that to enable wake for them as well,
assuming the port has any ACPI wakeup related objects implemented in the
namespace (adev->wakeup.flags.valid is true). This ensures the necessary
ACPI methods get called at appropriate times and allows the root port in
Thinkpad X1 Carbon 6th to go into D3cold.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-acpi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 5d1698265da5..d2b04ab37308 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -779,19 +779,33 @@ static void pci_acpi_setup(struct device *dev)
 		return;
 
 	device_set_wakeup_capable(dev, true);
+	/*
+	 * For bridges that can do D3 we enable wake automatically (as
+	 * we do for the power management itself in that case). The
+	 * reason is that the bridge may have additional methods such as
+	 * _DSW that need to be called.
+	 */
+	if (pci_dev->bridge_d3)
+		device_wakeup_enable(dev);
+
 	acpi_pci_wakeup(pci_dev, false);
 }
 
 static void pci_acpi_cleanup(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	if (!adev)
 		return;
 
 	pci_acpi_remove_pm_notifier(adev);
-	if (adev->wakeup.flags.valid)
+	if (adev->wakeup.flags.valid) {
+		if (pci_dev->bridge_d3)
+			device_wakeup_disable(dev);
+
 		device_set_wakeup_capable(dev, false);
+	}
 }
 
 static bool pci_acpi_bus_match(struct device *dev)
-- 
2.17.1

