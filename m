Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB78C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4312238C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD3GTMIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4312238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeHIVMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbeHIVMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:12:40 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.41.132.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0739521F45;
        Thu,  9 Aug 2018 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533840392;
        bh=WKFoIviVEhWMRP3J/Sp4WkN7Jf89ifXwS7ZdRx4OmrE=;
        h=From:To:Cc:Subject:Date:From;
        b=iD3GTMIznWYJLGutmOz0UubWXbx/X+7y+IBmZjeRCepYQ4fRTICY3AiMXp1ehDXTV
         didDRk39wdro82mOCfv1HHOtulDnL4vh2lKNdN0Xx5KdUxfPODBy87duXjPlmpvJAL
         fWaD6zC0K7Z5jTXnUoHNXvGafHiXAofzBk2voN5Q=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] PCI/ACPI: correct error message for ASPM disabling
Date:   Thu,  9 Aug 2018 18:46:22 +0000
Message-Id: <1533840383-7841-1-git-send-email-okaya@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If _OSC execution fails today for platforms without an _OSC
entry, code is printing a misleading message saying disabling
ASPM as follows:

acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

We need to ensure that platform supports ASPM to begin with.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reported-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/acpi/pci_root.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035..9d738e2 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -455,8 +455,13 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			 acpi_format_exception(status));
+		char *aspm_msg = "";
+
+		if (pcie_aspm_support_enabled())
+			aspm_msg = "; disabling ASPM";
+
+		dev_info(&device->dev, "_OSC failed (%s) %s\n",
+				 acpi_format_exception(status), aspm_msg);
 		*no_aspm = 1;
 		return;
 	}
-- 
2.7.4

