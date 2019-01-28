Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F0C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95092177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfA1WMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:12:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:37504 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfA1WMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:12:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 14:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="111810524"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2019 14:12:07 -0800
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        mchehab+samsung@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, olof@lixom.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3 5/6] net: stmmac: socfpga: Use shared System Manager driver
Date:   Mon, 28 Jan 2019 16:14:14 -0600
Message-Id: <1548713655-25940-6-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
References: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The ARM64 System Manager requires a different method of reading
the System Manager than ARM32. A new System Manager driver was
created to steer ARM32 System Manager calls to regmap_mmio and
ARM64 System Manager calls to the new access method.

Convert from syscon to the shared System Manager driver so that
both ARM64 and ARM32 are supported.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  No change to code. Update commit message.
v3  Remove the unused syscon.h header.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5b3b06a0a3bf..d466e33635b0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -15,7 +15,7 @@
  * Adopted from dwmac-sti.c
  */
 
-#include <linux/mfd/syscon.h>
+#include <linux/mfd/altera-sysmgr.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_net.h>
@@ -114,7 +114,8 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 
 	dwmac->interface = of_get_phy_mode(np);
 
-	sys_mgr_base_addr = syscon_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
+	sys_mgr_base_addr =
+		altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
 	if (IS_ERR(sys_mgr_base_addr)) {
 		dev_info(dev, "No sysmgr-syscon node found\n");
 		return PTR_ERR(sys_mgr_base_addr);
-- 
2.7.4

