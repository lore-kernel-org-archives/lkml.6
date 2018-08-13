Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D2C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB73121763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB73121763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeHMMLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:11:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728192AbeHMMLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:11:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A7839FCB56BE7;
        Mon, 13 Aug 2018 17:30:04 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 17:29:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <derek.chickles@caviumnetworks.com>,
        <satananda.burla@caviumnetworks.com>,
        <felix.manlunas@caviumnetworks.com>,
        <raghu.vatsavayi@caviumnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] liquidio: remove set but not used variable 'is25G'
Date:   Mon, 13 Aug 2018 17:29:36 +0800
Message-ID: <20180813092936.5200-1-yuehaibing@huawei.com>
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

drivers/net/ethernet/cavium/liquidio/lio_ethtool.c: In function 'lio_set_link_ksettings':
drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:392:6: warning:
 variable 'is25G' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unnecessary braces as Shahed suggested
---
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index 807ea2c..8e05afd 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -389,18 +389,14 @@ static int lio_set_link_ksettings(struct net_device *netdev,
 	struct lio *lio = GET_LIO(netdev);
 	struct oct_link_info *linfo;
 	struct octeon_device *oct;
-	u32 is25G = 0;
 
 	oct = lio->oct_dev;
 
 	linfo = &lio->linfo;
 
-	if (oct->subsystem_id == OCTEON_CN2350_25GB_SUBSYS_ID ||
-	    oct->subsystem_id == OCTEON_CN2360_25GB_SUBSYS_ID) {
-		is25G = 1;
-	} else {
+	if (!(oct->subsystem_id == OCTEON_CN2350_25GB_SUBSYS_ID ||
+	      oct->subsystem_id == OCTEON_CN2360_25GB_SUBSYS_ID))
 		return -EOPNOTSUPP;
-	}
 
 	if (oct->no_speed_setting) {
 		dev_err(&oct->pci_dev->dev, "%s: Changing speed is not supported\n",
-- 
2.7.0


