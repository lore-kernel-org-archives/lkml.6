Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFDEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C5F25534
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C5F25534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeGBTCa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:02:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:50141 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753497AbeGBTCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:02:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 12:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,299,1526367600"; 
   d="scan'208";a="54584845"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2018 12:02:05 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] ata: libahci: Allow reconfigure of DEVSLP register
Date:   Mon,  2 Jul 2018 12:01:54 -0700
Message-Id: <20180702190154.6864-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two modes in which DEVSLP can be entered. The OS initiated or
hardware autonomous.

In hardware autonomous mode, BIOS configures the AHCI controller and the
device to enable DEVSLP. But they may not be ideal for all cases. So in
this case, OS should be able to reconfigure DEVSLP register.

Currently if the DEVSLP is already enabled, we can't set again as it will
simply return. There are some systems where the firmware is setting high
DITO by default, in this case we can't modify here to correct settings.
With the default in several seconds, we are not able to transition to
DEVSLP.

This change will allow reconfiguration of devslp register if DITO is
different.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/libahci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index f6795d261869..432ac2f5de34 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2104,7 +2104,7 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ata_device *dev = ap->link.device;
-	u32 devslp, dm, dito, mdat, deto;
+	u32 devslp, dm, dito, mdat, deto, dito_conf;
 	int rc;
 	unsigned int err_mask;
 
@@ -2128,8 +2128,15 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 		return;
 	}
 
-	/* device sleep was already enabled */
-	if (devslp & PORT_DEVSLP_ADSE)
+	dm = (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
+	dito = devslp_idle_timeout / (dm + 1);
+	if (dito > 0x3ff)
+		dito = 0x3ff;
+
+	dito_conf = (devslp >> PORT_DEVSLP_DITO_OFFSET) & 0x3FF;
+
+	/* device sleep was already enabled and same dito */
+	if ((devslp & PORT_DEVSLP_ADSE) && (dito_conf == dito))
 		return;
 
 	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
@@ -2137,11 +2144,6 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 	if (rc)
 		return;
 
-	dm = (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
-	dito = devslp_idle_timeout / (dm + 1);
-	if (dito > 0x3ff)
-		dito = 0x3ff;
-
 	/* Use the nominal value 10 ms if the read MDAT is zero,
 	 * the nominal value of DETO is 20 ms.
 	 */
-- 
2.17.1

