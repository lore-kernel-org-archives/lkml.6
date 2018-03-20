Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbeCTNOK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:14:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55044 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753019AbeCTNOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:14:07 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] phy: phy-mtk-tphy: fix missing clk_disable_unprepare() on error in mtk_phy_init()
Date: Tue, 20 Mar 2018 13:19:59 +0000
Message-ID: <1521551999-154546-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from mtk_phy_init() in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 38c281b..3ff9020 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -841,7 +841,7 @@ static int mtk_phy_init(struct phy *phy)
 	ret = clk_prepare_enable(instance->ref_clk);
 	if (ret) {
 		dev_err(tphy->dev, "failed to enable ref_clk\n");
-		return ret;
+		goto disable_u3phya_ref;
 	}
 
 	switch (instance->type) {
@@ -859,10 +859,17 @@ static int mtk_phy_init(struct phy *phy)
 		break;
 	default:
 		dev_err(tphy->dev, "incompatible PHY type\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto disable_ref_clk;
 	}
 
 	return 0;
+
+disable_ref_clk:
+	clk_disable_unprepare(instance->ref_clk);
+disable_u3phya_ref:
+	clk_disable_unprepare(tphy->u3phya_ref);
+	return ret;
 }
 
 static int mtk_phy_power_on(struct phy *phy)
