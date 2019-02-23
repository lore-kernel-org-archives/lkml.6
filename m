Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9ACC10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7839206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfBWJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfBWJXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7B659838A6AE6B56C036;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:23:01 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [Patch net-next 12/12] net: hns3: fix improper error handling for hns3_client_start
Date:   Sat, 23 Feb 2019 17:22:19 +0800
Message-ID: <1550913739-13232-13-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
References: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hns3_client_start() failed in the hns3_client_init(),
register_dev() should be undo in its error handling.

Fixes: a6d818e31d08 ("net: hns3: Add vport alive state checking support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9f9a52d..3cb43b1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3656,7 +3656,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	ret = hns3_client_start(handle);
 	if (ret) {
 		dev_err(priv->dev, "hns3_client_start fail! ret=%d\n", ret);
-			goto out_reg_netdev_fail;
+			goto out_client_start;
 	}
 
 	hns3_dcbnl_setup(handle);
@@ -3670,6 +3670,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 
 	return ret;
 
+out_client_start:
+	unregister_netdev(netdev);
 out_reg_netdev_fail:
 	hns3_uninit_phy(netdev);
 out_init_phy:
-- 
2.7.4

