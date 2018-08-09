Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B09C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8905221F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCqDJTcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8905221F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeHIVMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbeHIVMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:12:41 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.41.132.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0D22238B;
        Thu,  9 Aug 2018 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533840393;
        bh=ldCH/WDUXtX8U8JXgdkh9fGjiq5pWBE8UgJPrzCislc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCqDJTcmChbNgh2oHQrv7lqe9j24b4By7GxpFDg8Y6UGSUhFd0fYfoHiGduMQK9mk
         SLFkMAQs407k9vBx5hCWW3BiMiIU97lF7bIVCQHFB7MDCF3MU4SngbDH5bMU5HGODK
         Oj5nV82kCbBFN67fTgVfKHQTNWB0rNmOFlmvLHHI=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] PCI/ACPI: allow _OSC presence to be optional for PCI
Date:   Thu,  9 Aug 2018 18:46:23 +0000
Message-Id: <1533840383-7841-2-git-send-email-okaya@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533840383-7841-1-git-send-email-okaya@kernel.org>
References: <1533840383-7841-1-git-send-email-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI Spec 6.0 Section 6.2.11.3 OSC Implementation Example for PCI
Host Bridge Devices:

For a host bridge device that originates a PCI Express hierarchy,
the _OSC interface defined in this section is required.

For a host bridge device that originates a PCI/PCI-X bus hierarchy,
inclusion of an _OSC object is optional.

Allow PCI host bridges to bail out silently if _OSC is not found.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reported-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/acpi/pci_root.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9d738e2..c94ed01 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -421,7 +421,8 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
-static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
+static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
+				 bool is_pcie)
 {
 	u32 support, control, requested;
 	acpi_status status;
@@ -460,9 +461,14 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 		if (pcie_aspm_support_enabled())
 			aspm_msg = "; disabling ASPM";
 
-		dev_info(&device->dev, "_OSC failed (%s) %s\n",
-				 acpi_format_exception(status), aspm_msg);
 		*no_aspm = 1;
+
+		/* _OSC is optional for PCI host bridges */
+		if ((status == AE_NOT_FOUND) && !is_pcie)
+			return;
+
+		dev_info(&device->dev, "_OSC failed (%s) %s\n",
+			 acpi_format_exception(status), aspm_msg);
 		return;
 	}
 
@@ -538,6 +544,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
 	bool hotadd = system_state == SYSTEM_RUNNING;
+	bool is_pcie;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -595,7 +602,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
 
-	negotiate_os_control(root, &no_aspm);
+	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
+	negotiate_os_control(root, &no_aspm, is_pcie);
 
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
-- 
2.7.4

