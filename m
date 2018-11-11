Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C592084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQHZ94mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C592084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbeKLJVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388599AbeKLIUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79043208A3;
        Sun, 11 Nov 2018 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975425;
        bh=J0+mYqmWEHl6nmnYDQcORRn35ONVlQErLpTt1qpZP9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQHZ94mWxluJsLY+KycXvUoYaKu2dVJDR8H0PnmphdqjCNyX/uMRDPwsJFjJNHwgJ
         9bLMQ47AclkFnj2XWlUthHmIgBBxgxqf56LyRDBhTcwsMNS2IKZx4Dy1ypxL3O5iUN
         TITvfcSloZWlQHtGtK+Lqo7eDiwPNV0eWIc8rjG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 157/350] PCI / ACPI: Enable wake automatically for power managed bridges
Date:   Sun, 11 Nov 2018 14:20:21 -0800
Message-Id: <20181111221714.628248145@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-acpi.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -779,19 +779,33 @@ static void pci_acpi_setup(struct device
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


