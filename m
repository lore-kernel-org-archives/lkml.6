Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B8C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47410216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47410216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbeKNCCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:02:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:43530 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388159AbeKNCCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:02:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 08:03:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="280745444"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2018 08:03:57 -0800
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, dinguyen@kernel.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        mchehab+samsung@kernel.org, arnd@arndb.de,
        bjorn.andersson@linaro.org, olof@lixom.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
Subject: [RESEND 4/4] net: stmmac: socfpga: Convert to shared System Manager driver
Date:   Tue, 13 Nov 2018 10:06:14 -0600
Message-Id: <1542125174-8204-5-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
References: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The ARM64 System Manager requires a different method of reading
the System Manager than ARM32. A new System Manager driver was
created to steer ARM32 System Manager calls to syscon and ARM64
System Manager calls to the new access method.

Convert from syscon to the shared System Manager driver so that
both ARM64 and ARM32 are supported.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5b3b06a0a3bf..743c7f471edb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -15,6 +15,7 @@
  * Adopted from dwmac-sti.c
  */
 
+#include <linux/mfd/altera-sysmgr.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -114,7 +115,8 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 
 	dwmac->interface = of_get_phy_mode(np);
 
-	sys_mgr_base_addr = syscon_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
+	sys_mgr_base_addr =
+		altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
 	if (IS_ERR(sys_mgr_base_addr)) {
 		dev_info(dev, "No sysmgr-syscon node found\n");
 		return PTR_ERR(sys_mgr_base_addr);
-- 
2.7.4

