Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2068CC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63F621745
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63F621745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeHNEvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:51:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbeHNEvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:51:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DA3FE60D841B5;
        Tue, 14 Aug 2018 10:06:42 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Tue, 14 Aug 2018 10:06:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm/mach-at91/pm: Do not double put the device node
Date:   Tue, 14 Aug 2018 09:54:56 +0800
Message-ID: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device node iterators put the previous value of the index variable,
so an explicit put causes a double put.

I detect the issue with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/mach-at91/pm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 32fae4d..a5ec35f 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -143,15 +143,12 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 
 			/* Check if enabled on SHDWC. */
 			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
-				goto put_node;
+				continue;
 
 			mode |= wsi->pmc_fsmr_bit;
 			if (wsi->set_polarity)
 				polarity |= wsi->pmc_fsmr_bit;
 		}
-
-put_node:
-		of_node_put(np);
 	}
 
 	if (mode) {
-- 
1.7.12.4

