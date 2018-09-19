Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A3BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBA42150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBA42150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbeISXKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733057AbeISXKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4333D90B43368;
        Thu, 20 Sep 2018 01:31:34 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:31:26 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: Fix parameter type for q_id in hclge_tm_q_to_qs_map_cfg()
Date:   Wed, 19 Sep 2018 18:29:58 +0100
Message-ID: <20180919172958.12992-13-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180919172958.12992-1-salil.mehta@huawei.com>
References: <20180919172958.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

So far all the places calling hclge_tm_q_to_qs_map_cfg() are assigning
an u16 type value to "q_id", and in the processing of
hclge_tm_q_to_qs_map_cfg(), it also converts the "q_id" to le16.

The max tqp number for pf can be more than 256, we should use "u16" to
store the queue id, instead of "u8", which may cause data lost.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 5db70a1..0282067 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -297,7 +297,7 @@ static int hclge_tm_qs_to_pri_map_cfg(struct hclge_dev *hdev,
 }
 
 static int hclge_tm_q_to_qs_map_cfg(struct hclge_dev *hdev,
-				    u8 q_id, u16 qs_id)
+				    u16 q_id, u16 qs_id)
 {
 	struct hclge_nq_to_qs_link_cmd *map;
 	struct hclge_desc desc;
-- 
2.7.4


