Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4A020882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4A020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeINUcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:32:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeINUcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:32:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C4D986C6111FB;
        Fri, 14 Sep 2018 23:17:38 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 23:17:35 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <sebastian.hesselbarth@gmail.com>
CC:     <gregory.clement@bootlin.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm: common: use match_string() helper to simplify the code
Date:   Fri, 14 Sep 2018 23:05:19 +0800
Message-ID: <1536937519-31611-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/plat-orion/common.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index a2399fd..d705ffa 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -479,17 +479,14 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 
 void __init orion_ge00_switch_init(struct dsa_chip_data *d)
 {
-	unsigned int i;
+	int index;
 
 	if (!IS_BUILTIN(CONFIG_PHYLIB))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(d->port_names); i++) {
-		if (!strcmp(d->port_names[i], "cpu")) {
-			d->netdev[i] = &orion_ge00.dev;
-			break;
-		}
-	}
+	index = match_string(d->port_names, ARRAY_SIZE(d->port_names), "cpu");
+	if (index >= 0)
+		d->netdev[index] = &orion_ge00.dev;
 
 	orion_ge00_switch_board_info.mdio_addr = d->sw_addr;
 	orion_ge00_switch_board_info.platform_data = d;
-- 
1.7.12.4

