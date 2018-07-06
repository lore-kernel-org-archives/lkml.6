Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECDFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B234023F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B234023F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbeGFK3c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:29:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932771AbeGFK3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:29:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5CA4F771F5B1A;
        Fri,  6 Jul 2018 18:29:15 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:29:09 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 08/10] net: hns3: Fix get_vector ops in hclgevf_main module
Date:   Fri, 6 Jul 2018 11:28:02 +0100
Message-ID: <20180706102804.196-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706102804.196-1-salil.mehta@huawei.com>
References: <20180706102804.196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The hclgevf_free_vector function expects the caller to pass
the vector_id to it, and hclgevf_put_vector pass vector to
it now, which will cause vector allocation problem.

This patch fixes it by converting vector into vector_id before
calling hclgevf_free_vector.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 5a86532..d1f16f0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -658,8 +658,17 @@ static int hclgevf_unmap_ring_from_vector(
 static int hclgevf_put_vector(struct hnae3_handle *handle, int vector)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int vector_id;
+
+	vector_id = hclgevf_get_vector_index(hdev, vector);
+	if (vector_id < 0) {
+		dev_err(&handle->pdev->dev,
+			"hclgevf_put_vector get vector index fail. ret =%d\n",
+			vector_id);
+		return vector_id;
+	}
 
-	hclgevf_free_vector(hdev, vector);
+	hclgevf_free_vector(hdev, vector_id);
 
 	return 0;
 }
-- 
2.7.4


