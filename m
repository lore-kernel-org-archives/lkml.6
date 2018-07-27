Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D742ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09346208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09346208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbeG0WKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:10:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:38326 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389459AbeG0WKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:10:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 13:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,411,1526367600"; 
   d="scan'208";a="76576900"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2018 13:47:05 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com, rjw@rjwysocki.net
Cc:     alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] ata: ahci: Support state with min power but Partial low power state
Date:   Fri, 27 Jul 2018 13:47:02 -0700
Message-Id: <20180727204703.6505-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
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
low power state. This policy is presented as "min_power_with_partial".

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
 drivers/ata/libahci.c     | 5 ++++-
 drivers/ata/libata-core.c | 1 +
 drivers/ata/libata-scsi.c | 1 +
 include/linux/libata.h    | 3 ++-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4c49c7c2a42c..94dcec2a8a5b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -800,6 +800,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			cmd |= PORT_CMD_ALPE;
 			if (policy == ATA_LPM_MIN_POWER)
 				cmd |= PORT_CMD_ASP;
+			else if (policy == ATA_LPM_MIN_POWER_WITH_PARTIAL)
+				cmd &= ~PORT_CMD_ASP;
 
 			/* write out new cmd value */
 			writel(cmd, port_mmio + PORT_CMD);
@@ -810,7 +812,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
 	    (hpriv->cap2 & HOST_CAP2_SADM) &&
 	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
-		if (policy == ATA_LPM_MIN_POWER)
+		if (policy == ATA_LPM_MIN_POWER ||
+		    policy == ATA_LPM_MIN_POWER_WITH_PARTIAL)
 			ahci_set_aggressive_devslp(ap, true);
 		else
 			ahci_set_aggressive_devslp(ap, false);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 27d15ed7fa3d..773b5f8eed1e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3967,6 +3967,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol |= (0x6 << 8);
 		break;
 	case ATA_LPM_MED_POWER_WITH_DIPM:
+	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
 	case ATA_LPM_MIN_POWER:
 		if (ata_link_nr_enabled(link) > 0)
 			/* no restrictions on LPM transitions */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6a91d04351d9..4648bd5cee15 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -110,6 +110,7 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_MAX_POWER]		= "max_performance",
 	[ATA_LPM_MED_POWER]		= "medium_power",
 	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
+	[ATA_LPM_MIN_POWER_WITH_PARTIAL] = "min_power_with_partial",
 	[ATA_LPM_MIN_POWER]		= "min_power",
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8b8946dd63b9..975543f8c1ff 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -522,7 +522,8 @@ enum ata_lpm_policy {
 	ATA_LPM_MAX_POWER,
 	ATA_LPM_MED_POWER,
 	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
-	ATA_LPM_MIN_POWER,
+	ATA_LPM_MIN_POWER_WITH_PARTIAL, /* Min Power + partial and slumber */
+	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
 };
 
 enum ata_lpm_hints {
-- 
2.17.1

