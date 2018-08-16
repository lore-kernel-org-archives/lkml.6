Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84EA20936
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84EA20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbeHPNgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:36:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387500AbeHPNgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:36:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7FA81F8FA9308;
        Thu, 16 Aug 2018 18:38:18 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Thu, 16 Aug 2018 18:38:16 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: pm: call put_device instead of of_node_put in at91_pm_config_ws
Date:   Thu, 16 Aug 2018 18:26:22 +0800
Message-ID: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_device_by_node takes a reference to the struct device when it
finds a match via get_device. but it fails to put_device in
at91_pm_config_ws, for_each_matching_node_and_match will get and put
the node properly, there is no need to call the of_put_node. Therefore,
just call put_device instead of of_node_put in at91_pm_config_ws.

Fixes: d7484f5c6b3b ("ARM: at91: pm: configure wakeup sources for ULP1 mode")
Suggested-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/mach-at91/pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 32fae4d..6574f00 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -143,15 +143,15 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 
 			/* Check if enabled on SHDWC. */
 			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
-				goto put_node;
+				goto put_device;
 
 			mode |= wsi->pmc_fsmr_bit;
 			if (wsi->set_polarity)
 				polarity |= wsi->pmc_fsmr_bit;
 		}
 
-put_node:
-		of_node_put(np);
+put_device:
+		put_device(&pdev->dev);
 	}
 
 	if (mode) {
-- 
1.7.12.4

