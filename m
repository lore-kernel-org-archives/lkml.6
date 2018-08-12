Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B2C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBE221919
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBE221919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeHLM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728049AbeHLM0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:15 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0A1A8146207B7;
        Sun, 12 Aug 2018 17:48:45 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:36 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: Fix for vf vlan delete failed problem
Date:   Sun, 12 Aug 2018 10:47:34 +0100
Message-ID: <20180812094738.14852-6-salil.mehta@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

There are only 128 entries in vf vlan table, if user has added
more than 128 vlan, fw will ignore it and disable the vf vlan
table. So when user deletes the vlan entry that has not been
set to vf vlan table, fw will return not found result and driver
treat that as error, which will cause vlan delete failed problem.

This patch fixes it by returning ok when fw returns not found
result.

Fixes: 9dba194574e3 ("{topost} net: hns3: fix for vlan table problem")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3b7cd6744280..c88f5e6a9b77 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4684,9 +4684,17 @@ static int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
 			"Add vf vlan filter fail, ret =%d.\n",
 			req0->resp_code);
 	} else {
+#define HCLGE_VF_VLAN_DEL_NO_FOUND	1
 		if (!req0->resp_code)
 			return 0;
 
+		if (req0->resp_code == HCLGE_VF_VLAN_DEL_NO_FOUND) {
+			dev_warn(&hdev->pdev->dev,
+				 "vlan %d filter is not in vf vlan table\n",
+				 vlan);
+			return 0;
+		}
+
 		dev_err(&hdev->pdev->dev,
 			"Kill vf vlan filter fail, ret =%d.\n",
 			req0->resp_code);
-- 
2.11.0


