Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91025C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8521738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8521738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeHMOSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:18:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729256AbeHMOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:18:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8DEE156DCAF18;
        Mon, 13 Aug 2018 19:36:37 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Mon, 13 Aug 2018 19:36:33 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <alcooperx@gmail.com>, <kishon@ti.com>, <robh@kernel.org>,
        <hauke@hauke-m.de>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] phy:phy-brcm-us: Use PTR_ERR_OR_ZERO to replace the open code
Date:   Mon, 13 Aug 2018 19:24:45 +0800
Message-ID: <1534159486-25008-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1534159486-25008-1-git-send-email-zhongjiang@huawei.com>
References: <1534159486-25008-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
just replace them rather than duplicating its implement.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index d1dab36..f59b1dc 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -372,10 +372,8 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	clk_disable(priv->usb_30_clk);
 
 	phy_provider = devm_of_phy_provider_register(dev, brcm_usb_phy_xlate);
-	if (IS_ERR(phy_provider))
-		return PTR_ERR(phy_provider);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.7.12.4

