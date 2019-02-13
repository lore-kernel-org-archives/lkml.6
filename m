Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926B2C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E492190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391449AbfBMPH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:07:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:11815 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBMPH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:07:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 07:07:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="299437263"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2019 07:07:53 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 01/10] platform/x86: intel_pmc_core: Handle CFL regmap properly
Date:   Wed, 13 Feb 2019 20:38:01 +0530
Message-Id: <20190213150810.32750-2-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only Coffeelake should use Cannonlake regmap other than Cannonlake
platform. This allows Coffeelake special handling only when there is no
matching PCI device and default reg map selected as per CPUID is for
Sunrisepoint PCH. This change is needed to enable support for newer SoCs
such as Icelake.

Cc: "David E. Box" <david.e.box@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 661405bd817b ("platform/x86: intel_pmc_core: Special case for Coffeelake")
Acked-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 22dbf115782e..37f605da9333 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -768,7 +768,7 @@ static int __init pmc_core_probe(void)
 	 * Sunrisepoint PCH regmap can't be used. Use Cannonlake PCH regmap
 	 * in this case.
 	 */
-	if (!pci_dev_present(pmc_pci_ids))
+	if (pmcdev->map == &spt_reg_map && !pci_dev_present(pmc_pci_ids))
 		pmcdev->map = &cnp_reg_map;
 
 	if (lpit_read_residency_count_address(&slp_s0_addr))
-- 
2.17.1

