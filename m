Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D15ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04610208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04610208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbeGPJ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:26:07 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:45074 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727182AbeGPJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:26:06 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 16 Jul 2018 17:59:41 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id BE60C77E56;
        Mon, 16 Jul 2018 17:59:41 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,360,1526310000"; 
   d="scan'208";a="286981870"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 16 Jul 2018 17:59:39 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date:   Mon, 16 Jul 2018 09:59:13 +0100
Message-Id: <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys I2C Controller has a bus clock, but typically SoCs hide this away.
However, on some SoCs you need to explicity enable the bus clock in order to
access the registers.
Therefore, enable an optional bus clock specified by DT.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/i2c/busses/i2c-designware-common.c  | 14 +++++++++++++-
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 48914df..4fa67d6 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -186,13 +186,25 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
 
 int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
 {
+	int ret;
+
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 
-	if (prepare)
+	if (prepare) {
+		/* Optional bus clock */
+		if (!IS_ERR(dev->busclk)) {
+			ret = clk_prepare_enable(dev->busclk);
+			if (ret)
+				return ret;
+		}
+
 		return clk_prepare_enable(dev->clk);
+	}
 
 	clk_disable_unprepare(dev->clk);
+	clk_disable_unprepare(dev->busclk);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index d690e64..10f905d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -239,6 +239,7 @@ struct dw_i2c_dev {
 	void __iomem		*base;
 	struct completion	cmd_complete;
 	struct clk		*clk;
+	struct clk		*busclk;
 	struct reset_control	*rst;
 	struct i2c_client		*slave;
 	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 5660daf..64389fe 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -332,6 +332,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	else
 		i2c_dw_configure_master(dev);
 
+	/* Optional bus clock */
+	dev->busclk = devm_clk_get(&pdev->dev, "bus");
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!i2c_dw_prepare_clk(dev, true)) {
 		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
-- 
2.7.4

