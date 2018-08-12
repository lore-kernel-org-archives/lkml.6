Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C352CC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8081D2152F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8081D2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeHLM0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727990AbeHLM0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 784E0D2BD17F6;
        Sun, 12 Aug 2018 17:48:34 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:26 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 2/9] net: hns3: Fix for command format parsing error in hclge_is_all_function_id_zero
Date:   Sun, 12 Aug 2018 10:47:31 +0100
Message-ID: <20180812094738.14852-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180812094738.14852-1-salil.mehta@huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.119]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

According to the functional specification of hardward, the first
descriptor of response from command 'lookup vlan talbe' is not valid.
Currently, the first descriptor is parsed as normal value, which will
cause an expected error.

This patch fixes this problem by skipping the first descriptor.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 99dda5051f5f..18ae11d8de73 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3930,7 +3930,7 @@ static bool hclge_is_all_function_id_zero(struct hclge_desc *desc)
 #define HCLGE_FUNC_NUMBER_PER_DESC 6
 	int i, j;
 
-	for (i = 0; i < HCLGE_DESC_NUMBER; i++)
+	for (i = 1; i < HCLGE_DESC_NUMBER; i++)
 		for (j = 0; j < HCLGE_FUNC_NUMBER_PER_DESC; j++)
 			if (desc[i].data[j])
 				return false;
-- 
2.11.0


