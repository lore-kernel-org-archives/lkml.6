Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886DC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4172133D
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfAZIoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:44:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfAZInt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:43:49 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 37B4DECD89FC648A6788;
        Sat, 26 Jan 2019 16:43:44 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sat, 26 Jan 2019 16:43:34 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net 3/3] net: hns: Fix wrong read accesses via Clause 45 MDIO protocol
Date:   Sat, 26 Jan 2019 17:18:27 +0800
Message-ID: <1548494307-63594-4-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548494307-63594-1-git-send-email-lipeng321@huawei.com>
References: <1548494307-63594-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

When reading phy registers via Clause 45 MDIO protocol, after write
address operation, the driver use another write address operation, so
can not read the right value of any phy registers. This patch fixes it.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 017e084..baf5cc2 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -321,7 +321,7 @@ static int hns_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 		}
 
 		hns_mdio_cmd_write(mdio_dev, is_c45,
-				   MDIO_C45_WRITE_ADDR, phy_id, devad);
+				   MDIO_C45_READ, phy_id, devad);
 	}
 
 	/* Step 5: waitting for MDIO_COMMAND_REG 's mdio_start==0,*/
-- 
1.9.1

