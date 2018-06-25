Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ACEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A6E26261
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRuzhHLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A6E26261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934074AbeFYXAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbeFYXAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:00:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3070126261;
        Mon, 25 Jun 2018 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529967601;
        bh=2vJ+z0DE/gcJgT6WfciHlw1f01CFH4wbbAYBy9kWZCA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KRuzhHLeCtrYTxo+THa/qTRZO4T9L58UMyOQVA4X/njtVVsm/WbRU7+qTemsHfGsf
         pZaoxwtKe9EJjGkTELyz9Up6WdWG81ZJTqX5ZoFk/VW5rjP/1h92xRui0jlQFqhmtV
         E018NKXsdZy61yqLN9yZIKyb2qyTpFx7YnoVPtQY=
Subject: [PATCH v1 4/4] PCI: hotplug: Implement hotplug_is_native() only
 when CONFIG_ACPI=y
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Jun 2018 18:00:00 -0500
Message-ID: <152996760010.260522.16627091342000868828.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

hotplug_is_native() is used only by the acpiphp driver, so we only need to
implement the interface when CONFIG_ACPI=y.

Move the implementation under #ifdef CONFIG_ACPI and drop the unnecessary
stubs for the non-ACPI case.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_hotplug.h |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index f08a44e1606f..09eb40299c37 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -9,7 +9,6 @@
  * All rights reserved.
  *
  * Send feedback to <kristen.c.accardi@intel.com>
- *
  */
 #ifndef _PCI_HOTPLUG_H
 #define _PCI_HOTPLUG_H
@@ -171,6 +170,11 @@ static inline bool shpchp_is_native(struct pci_dev *bridge)
 {
 	return bridge->shpc_managed;
 }
+
+static inline bool hotplug_is_native(struct pci_dev *bridge)
+{
+	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
+}
 #else
 static inline int pci_get_hp_params(struct pci_dev *dev,
 				    struct hotplug_params *hpp)
@@ -182,12 +186,6 @@ static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
 {
 	return 0;
 }
-static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
-static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
 #endif
 
-static inline bool hotplug_is_native(struct pci_dev *bridge)
-{
-	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
-}
 #endif

