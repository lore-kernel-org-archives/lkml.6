Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623EBC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2383B21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2383B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeIYELZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:11:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:5955 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbeIYELZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:11:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 15:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,299,1534834800"; 
   d="scan'208";a="75595433"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2018 15:07:03 -0700
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, peppe.cavallaro@st.com, dinguyen@kernel.org,
        linux@armlinux.org.uk, alexandre.torgue@st.com,
        joabreu@synopsys.com
Cc:     thor.thayer@linux.intel.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, arnd@arndb.de, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] net: stmmac: socfpga: Use shared System Manager driver
Date:   Mon, 24 Sep 2018 17:09:06 -0500
Message-Id: <1537826946-18942-5-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
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

