Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1CCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEEB2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfA3U5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:57:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387879AbfA3U41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3AE1954F9B0FA9FDD33E;
        Thu, 31 Jan 2019 04:56:25 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:16 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: fix an issue for hclgevf_ae_get_hdev
Date:   Thu, 31 Jan 2019 04:55:50 +0800
Message-ID: <20190130205552.8512-11-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190130205552.8512-1-tanhuazhong@huawei.com>
References: <20190130205552.8512-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

HNS3 VF driver support NIC and Roce, hdev stores NIC
handle and Roce handle, should use correct parameter for
container_of.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 93f306f42cf4..95f926971e3b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -86,7 +86,12 @@ static const u32 tqp_intr_reg_addr_list[] = {HCLGEVF_TQP_INTR_CTRL_REG,
 static inline struct hclgevf_dev *hclgevf_ae_get_hdev(
 	struct hnae3_handle *handle)
 {
-	return container_of(handle, struct hclgevf_dev, nic);
+	if (!handle->client)
+		return container_of(handle, struct hclgevf_dev, nic);
+	else if (handle->client->type == HNAE3_CLIENT_ROCE)
+		return container_of(handle, struct hclgevf_dev, roce);
+	else
+		return container_of(handle, struct hclgevf_dev, nic);
 }
 
 static int hclgevf_tqps_update_stats(struct hnae3_handle *handle)
-- 
2.20.1


