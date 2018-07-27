Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E52BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DFA20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DFA20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389675AbeG0WKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:10:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:38326 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389377AbeG0WKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:10:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 13:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,411,1526367600"; 
   d="scan'208";a="76576909"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2018 13:47:05 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com, rjw@rjwysocki.net
Cc:     alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
Date:   Fri, 27 Jul 2018 13:47:03 -0700
Message-Id: <20180727204703.6505-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
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
 drivers/ata/ahci.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 738fb22978dd..b14dccda0154 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -609,7 +609,7 @@ static int marvell_enable = 1;
 module_param(marvell_enable, int, 0644);
 MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
 
-static int mobile_lpm_policy = CONFIG_SATA_MOBILE_LPM_POLICY;
+static int mobile_lpm_policy = -1;
 module_param(mobile_lpm_policy, int, 0644);
 MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 
@@ -1550,6 +1550,37 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_update_initial_lpm_policy(struct ata_port *ap,
+					   struct ahci_host_priv *hpriv)
+{
+	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
+
+
+	/* Ignore processing for non mobile platforms */
+	if (!(hpriv->flags & AHCI_HFLAG_IS_MOBILE))
+		return;
+
+	/* user modified policy via module param */
+	if (mobile_lpm_policy != -1) {
+		policy = mobile_lpm_policy;
+		goto update_policy;
+	}
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
@@ -1747,10 +1778,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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

