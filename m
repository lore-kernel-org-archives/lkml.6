Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E263C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E58214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAZQuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2783 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfAZQuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 22161C2BBE7DAE21BDDA;
        Sun, 27 Jan 2019 00:49:59 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:50 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: remove dcb_ops->map_update in hclge_dcb
Date:   Sun, 27 Jan 2019 00:49:17 +0800
Message-ID: <20190126164921.3872-9-tanhuazhong@huawei.com>
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

After doing down/uninit/init/up in hclge_dcb, it is not necessary
to call dcb_ops->map_update in enet, so hclge_map_update can be
called directly in hclge_dcb.

This is for preparing to call hns3_nic_set_real_num_queue with
netdev down when user changes mqprio configuration.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h            |  1 -
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        | 10 +---------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  9 +++++----
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index dc3db45361d3..585800e634e6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -477,7 +477,6 @@ struct hnae3_dcb_ops {
 	u8   (*getdcbx)(struct hnae3_handle *);
 	u8   (*setdcbx)(struct hnae3_handle *, u8);
 
-	int (*map_update)(struct hnae3_handle *);
 	int (*setup_tc)(struct hnae3_handle *, u8, u8 *);
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 927a980fc211..0ecaeab2dad4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3737,7 +3737,6 @@ static int hns3_client_setup_tc(struct hnae3_handle *handle, u8 tc)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct net_device *ndev = kinfo->netdev;
-	int ret;
 
 	if (tc > HNAE3_MAX_TC)
 		return -EINVAL;
@@ -3745,14 +3744,7 @@ static int hns3_client_setup_tc(struct hnae3_handle *handle, u8 tc)
 	if (!ndev)
 		return -ENODEV;
 
-	ret = (kinfo->dcb_ops && kinfo->dcb_ops->map_update) ?
-		kinfo->dcb_ops->map_update(handle) : -EOPNOTSUPP;
-	if (ret)
-		return ret;
-
-	ret = hns3_nic_set_real_num_queue(ndev);
-
-	return ret;
+	return hns3_nic_set_real_num_queue(ndev);
 }
 
 static int hns3_recover_hw_addr(struct net_device *ndev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 6c387b21f882..de8e38cca507 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -156,10 +156,8 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 	return 0;
 }
 
-static int hclge_map_update(struct hnae3_handle *h)
+static int hclge_map_update(struct hclge_dev *hdev)
 {
-	struct hclge_vport *vport = hclge_get_vport(h);
-	struct hclge_dev *hdev = vport->back;
 	int ret;
 
 	ret = hclge_tm_schd_setup_hw(hdev);
@@ -235,6 +233,10 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 		goto err_out;
 
 	if (map_changed) {
+		ret = hclge_map_update(hdev);
+		if (ret)
+			goto err_out;
+
 		ret = hclge_client_setup_tc(hdev);
 		if (ret)
 			goto err_out;
@@ -411,7 +413,6 @@ static const struct hnae3_dcb_ops hns3_dcb_ops = {
 	.ieee_setpfc	= hclge_ieee_setpfc,
 	.getdcbx	= hclge_getdcbx,
 	.setdcbx	= hclge_setdcbx,
-	.map_update	= hclge_map_update,
 	.setup_tc	= hclge_setup_tc,
 };
 
-- 
2.20.1


