Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D679ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40D421486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40D421486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeJRCiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:38:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:41469 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbeJRCiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:38:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="100082998"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2018 11:41:14 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, stable@vger.kernel.org
Subject: [PATCH v1 1/1] usb: dwc3: Fix NULL pointer exception in dwc3_pci_remove()
Date:   Wed, 17 Oct 2018 11:40:26 -0700
Message-Id: <2972befa36441a5dea1de9efb1e1355f8406d7b6.1539801494.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dwc3_pci_quirks() function, gpiod lookup table is only registered for
baytrail SOC. But in dwc3_pci_remove(), we try to unregistered it
without any checks. This leads to NULL pointer de-reference exception in
gpiod_remove_lookup_table() when unloading the module for non baytrail
SOCs. This patch fixes this issue.

Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms
without ACPI GPIO resources")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 1286076a8890..842795856bf4 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -283,8 +283,10 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 static void dwc3_pci_remove(struct pci_dev *pci)
 {
 	struct dwc3_pci		*dwc = pci_get_drvdata(pci);
+	struct pci_dev		*pdev = dwc->pci;
 
-	gpiod_remove_lookup_table(&platform_bytcr_gpios);
+	if (pdev->device == PCI_DEVICE_ID_INTEL_BYT)
+		gpiod_remove_lookup_table(&platform_bytcr_gpios);
 #ifdef CONFIG_PM
 	cancel_work_sync(&dwc->wakeup_work);
 #endif
-- 
2.7.4

