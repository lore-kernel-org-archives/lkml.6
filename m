Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC49C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE0425407
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE0425407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeGBTCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:02:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:50141 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753328AbeGBTCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:02:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 12:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,299,1526367600"; 
   d="scan'208";a="54584843"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2018 12:02:05 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] ata: libahci: Correct setting of DEVSLP register
Date:   Mon,  2 Jul 2018 12:01:53 -0700
Message-Id: <20180702190154.6864-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have seen that on some platforms, SATA device never show any DEVSLP
residency. This prevent power gating of SATA IP, which prevent system
to transition to low power mode in systems with SLP_S0 aka modern
standby systems. The PHY logic is off only in DEVSLP not in slumber.
Reference:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets
/332995-skylake-i-o-platform-datasheet-volume-1.pdf
Section 28.7.6.1

Here driver is trying to do read-modify-write the devslp register. But
not resetting the bits for which this driver will modify values (DITO,
MDAT and DETO). So simply reset those bits before updating to new values.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/ata/libahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 965842a08743..f6795d261869 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2159,6 +2159,8 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 		deto = 20;
 	}
 
+	/* Make dito, mdat, deto bits to 0s */
+	devslp &= ~GENMASK_ULL(24, 2);
 	devslp |= ((dito << PORT_DEVSLP_DITO_OFFSET) |
 		   (mdat << PORT_DEVSLP_MDAT_OFFSET) |
 		   (deto << PORT_DEVSLP_DETO_OFFSET) |
-- 
2.17.1

