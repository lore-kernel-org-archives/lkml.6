Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2CBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A60B204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A60B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeGTOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:39:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:30690 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeGTOjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:39:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 06:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,379,1526367600"; 
   d="scan'208";a="68538646"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2018 06:50:58 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH 2/2] ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
Date:   Fri, 20 Jul 2018 06:50:41 -0700
Message-Id: <20180720135041.62265-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
- User didn't override the policy from module parameter
- The kernel config is already set to use med_power_with_dipm or deeper
- System is a SLP_S0 capable using ACPI low power idle flag
This combination will make sure that systems are fairly recent and
since getting shipped with SLP_S0 support, the DEVSLP function
is already validated.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Changes:
Fix issue reported by lkp robot: Missed static.

 drivers/ata/ahci.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 738fb22978dd..5258910a6383 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1550,6 +1550,34 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_update_initial_lpm_policy(struct ata_port *ap,
+					   struct ahci_host_priv *hpriv)
+{
+	int policy = mobile_lpm_policy;
+
+	/* Ignore processing for non mobile platforms */
+	if (!(hpriv->flags & AHCI_HFLAG_IS_MOBILE))
+		return;
+
+	/* user modified policy via module param */
+	if (policy != CONFIG_SATA_MOBILE_LPM_POLICY)
+		goto update_policy;
+
+#ifdef CONFIG_ACPI
+	if (policy > ATA_LPM_MED_POWER &&
+	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+		if (hpriv->cap & HOST_CAP_PART)
+			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
+		else if (hpriv->cap & HOST_CAP_SSC)
+			policy = ATA_LPM_MIN_POWER;
+	}
+#endif
+
+update_policy:
+	if (policy >= ATA_LPM_UNKNOWN && policy <= ATA_LPM_MIN_POWER)
+		ap->target_lpm_policy = policy;
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1747,10 +1775,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = hpriv->em_msg_type;
 
-		if ((hpriv->flags & AHCI_HFLAG_IS_MOBILE) &&
-		    mobile_lpm_policy >= ATA_LPM_UNKNOWN &&
-		    mobile_lpm_policy <= ATA_LPM_MIN_POWER)
-			ap->target_lpm_policy = mobile_lpm_policy;
+		ahci_update_initial_lpm_policy(ap, hpriv);
 
 		/* disabled/not-implemented port */
 		if (!(hpriv->port_map & (1 << i)))
-- 
2.17.1

