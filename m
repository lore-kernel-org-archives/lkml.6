Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3318FECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA10F2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA10F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbeGLWi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:38:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:21713 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733177AbeGLWi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:38:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 15:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,345,1526367600"; 
   d="scan'208";a="64309662"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2018 15:27:14 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v2 1/2] ata: ahci: Support state with min power and  Partial low power state
Date:   Thu, 12 Jul 2018 15:27:11 -0700
Message-Id: <20180712222712.65310-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
References: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when min_power policy is selected, the partial low power state
is not entered and link will try aggressively enter to only slumber state.
Add a new policy which still enable DEVSLP but also try to enter partial
low power state.

For information the difference between partial and slumber
Partial – PHY logic is powered up, and in a reduced power state. The link
PM exit latency to active state maximum is 10 ns.
Slumber – PHY logic is powered up, and in a reduced power state. The link
PM exit latency to active state maximum is 10 ms.
Devslp – PHY logic is powered down. The link PM exit latency from this
state to active state maximum is 20 ms, unless otherwise specified by
DETO.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/libahci.c     | 6 +++++-
 drivers/ata/libata-core.c | 1 +
 drivers/ata/libata-scsi.c | 1 +
 include/linux/libata.h    | 3 ++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 511fb67f363d..8cf2cf49537d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -799,8 +799,11 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 				return 0;
 		} else {
 			cmd |= PORT_CMD_ALPE;
+
 			if (policy == ATA_LPM_MIN_POWER)
 				cmd |= PORT_CMD_ASP;
+			else if (policy == ATA_LPM_MIN_POWER_WITH_ASP)
+				cmd &= ~PORT_CMD_ASP;
 
 			/* write out new cmd value */
 			writel(cmd, port_mmio + PORT_CMD);
@@ -811,7 +814,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
 	    (hpriv->cap2 & HOST_CAP2_SADM) &&
 	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
-		if (policy == ATA_LPM_MIN_POWER)
+		if (policy == ATA_LPM_MIN_POWER ||
+		    policy == ATA_LPM_MIN_POWER_WITH_ASP)
 			ahci_set_aggressive_devslp(ap, true);
 		else
 			ahci_set_aggressive_devslp(ap, false);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cc71c63df381..245a59e6cb18 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3970,6 +3970,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol |= (0x6 << 8);
 		break;
 	case ATA_LPM_MED_POWER_WITH_DIPM:
+	case ATA_LPM_MIN_POWER_WITH_ASP:
 	case ATA_LPM_MIN_POWER:
 		if (ata_link_nr_enabled(link) > 0)
 			/* no restrictions on LPM transitions */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index aad1b01447de..2d683db50ceb 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -110,6 +110,7 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_MAX_POWER]		= "max_performance",
 	[ATA_LPM_MED_POWER]		= "medium_power",
 	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
+	[ATA_LPM_MIN_POWER_WITH_ASP]	= "min_power_with_asp",
 	[ATA_LPM_MIN_POWER]		= "min_power",
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 32f247cb5e9e..1e154f1f7e8f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -523,7 +523,8 @@ enum ata_lpm_policy {
 	ATA_LPM_MAX_POWER,
 	ATA_LPM_MED_POWER,
 	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
-	ATA_LPM_MIN_POWER,
+	ATA_LPM_MIN_POWER_WITH_ASP, /* Min Power + partial and slumber */
+	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
 };
 
 enum ata_lpm_hints {
-- 
2.17.1

