Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC380ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C612087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C612087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbeGLWi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:38:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:21713 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733209AbeGLWi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:38:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 15:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,345,1526367600"; 
   d="scan'208";a="64309665"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2018 15:27:14 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net,
        Srinivas <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v2 2/2] ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
Date:   Thu, 12 Jul 2018 15:27:12 -0700
Message-Id: <20180712222712.65310-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
References: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas <srinivas.pandruvada@linux.intel.com>

One of the requirement for modern x86 system to enter lowest power mode
(SLP_S0) is SATA IP block to be off. This is true even during when
platform is suspended to idle and not only in opportunistic (runtime)
suspend.

Several of these system don't have traditional ACPI S3, so it is
important that they enter SLP_S0 state, to avoid draining battery even
during suspend. So it is important that out of the box Linux installation
reach this state.

SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
user has to either use scsi-host sysfs or tools like powertop to set
the sata-host link_power_management_policy to min_power.

This change sets by default link power management policy to min_power
with partial (preferred) or slumber support on idle for some platforms.
To avoid regressions, the following conditions are used:
- The kernel config is already set to use med_power_with_dipm or deeper
- System is a SLP_S0 capable using ACPI low power idle flag
This combination will make sure that systems are fairly recent and
since getting shipped with SLP_S0 support, the DEVSLP function
is already validated.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/ahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b2b9eba1d214..e8d425823f9b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1604,6 +1604,19 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_update_mobile_policy(struct ahci_host_priv *hpriv)
+{
+#ifdef CONFIG_ACPI
+	if (mobile_lpm_policy > ATA_LPM_MED_POWER &&
+	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+		if (hpriv->cap & HOST_CAP_PART)
+			mobile_lpm_policy = ATA_LPM_MIN_POWER_WITH_ASP;
+		else if (hpriv->cap & HOST_CAP_SSC)
+			mobile_lpm_policy = ATA_LPM_MIN_POWER;
+	}
+#endif
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1796,6 +1809,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
+	ahci_update_mobile_policy(hpriv);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-- 
2.17.1

