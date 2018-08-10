Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94DEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8005A223E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2QYU4IqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8005A223E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeHJHA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 03:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeHJHAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 03:00:25 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.41.132.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00877223E6;
        Fri, 10 Aug 2018 04:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533875539;
        bh=ep03PYapCeVjr8SjK5mkrUXq5d9312OAgTtYKLqhMXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QYU4IqNfSyU6NTWh5WjNyAg1R/ZdotrFdCZ+nMKGu3g92st8NUKeCC/FLJ9XFGYI
         16/ihYLikB/e6ZzrEnz4ZsQitDnmXqLI9J5OObJWWHfrLCE4pOG/sOVEFljLlFqwrO
         Xr9SZK6oHOUSzpjIiGL0B8JvA9ZGNWV7wI4dKp3A=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] PCI/ACPI: allow _OSC presence to be optional for PCI
Date:   Fri, 10 Aug 2018 04:32:12 +0000
Message-Id: <1533875532-24954-2-git-send-email-okaya@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533875532-24954-1-git-send-email-okaya@kernel.org>
References: <1533875532-24954-1-git-send-email-okaya@kernel.org>
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
 drivers/acpi/pci_root.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e465e72..707aafc 100644
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
@@ -455,10 +456,15 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
+		*no_aspm = 1;
+
+		/* _OSC is optional for PCI host bridges */
+		if ((status == AE_NOT_FOUND) && !is_pcie)
+			return;
+
 		dev_info(&device->dev, "_OSC failed (%s)%s\n",
 			 acpi_format_exception(status),
 			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
-		*no_aspm = 1;
 		return;
 	}
 
@@ -534,6 +540,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
 	bool hotadd = system_state == SYSTEM_RUNNING;
+	bool is_pcie;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -591,7 +598,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
 
-	negotiate_os_control(root, &no_aspm);
+	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
+	negotiate_os_control(root, &no_aspm, is_pcie);
 
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
-- 
2.7.4

