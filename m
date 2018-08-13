Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984EC2177D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984EC2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeHMJaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:30:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbeHMJaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:30:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E9E4E28EFE2A;
        Mon, 13 Aug 2018 14:49:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 14:48:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ganeshgr@chelsio.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] cxgb4: remove set but not used variable 'spd'
Date:   Mon, 13 Aug 2018 14:48:51 +0800
Message-ID: <20180813064851.912-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:
drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c: In function 'print_port_info':
drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:5147:14: warning:
 variable 'spd' set but not used [-Wunused-but-set-variable]

variable 'spd' is set but not used since
commit 547fd27241a8 ("cxgb4: Warn if device doesn't have enough PCI bandwidth")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 69590cf..961e3087 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5144,17 +5144,9 @@ static void print_port_info(const struct net_device *dev)
 {
 	char buf[80];
 	char *bufp = buf;
-	const char *spd = "";
 	const struct port_info *pi = netdev_priv(dev);
 	const struct adapter *adap = pi->adapter;
 
-	if (adap->params.pci.speed == PCI_EXP_LNKSTA_CLS_2_5GB)
-		spd = " 2.5 GT/s";
-	else if (adap->params.pci.speed == PCI_EXP_LNKSTA_CLS_5_0GB)
-		spd = " 5 GT/s";
-	else if (adap->params.pci.speed == PCI_EXP_LNKSTA_CLS_8_0GB)
-		spd = " 8 GT/s";
-
 	if (pi->link_cfg.pcaps & FW_PORT_CAP32_SPEED_100M)
 		bufp += sprintf(bufp, "100M/");
 	if (pi->link_cfg.pcaps & FW_PORT_CAP32_SPEED_1G)
-- 
2.7.0


