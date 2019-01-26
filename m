Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DFBC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09883214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfAZQvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:51:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfAZQt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:49:57 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D80A19CE6CB67979CD70;
        Sun, 27 Jan 2019 00:49:53 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:47 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: add error handling in hclge_ieee_setets
Date:   Sun, 27 Jan 2019 00:49:12 +0800
Message-ID: <20190126164921.3872-4-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190126164921.3872-1-tanhuazhong@huawei.com>
References: <20190126164921.3872-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently hclge_ieee_setets returns error directly when there is
error, which may cause netdev not up problem.

This patch adds some error handling when setting ETS configuration
fails.

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 3a4a54ee5204..90b566e8e454 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -232,12 +232,13 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 
 	ret = hclge_ieee_ets_to_tm_info(hdev, ets);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	if (map_changed) {
 		ret = hclge_client_setup_tc(hdev);
 		if (ret)
-			return ret;
+			goto err_out;
+
 		ret = hclge_notify_client(hdev, HNAE3_INIT_CLIENT);
 		if (ret)
 			return ret;
@@ -248,6 +249,16 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	}
 
 	return hclge_tm_dwrr_cfg(hdev);
+
+err_out:
+	if (!map_changed)
+		return ret;
+
+	if (hclge_notify_client(hdev, HNAE3_INIT_CLIENT))
+		return ret;
+
+	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	return ret;
 }
 
 static int hclge_ieee_getpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
-- 
2.20.1


