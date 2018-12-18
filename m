Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F6DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DEE217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLRLCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16591 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbeLRLCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:12 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1A9A35D8A993F;
        Tue, 18 Dec 2018 19:02:08 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:59 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: fix a SSU buffer checking bug
Date:   Tue, 18 Dec 2018 19:37:59 +0800
Message-ID: <1545133079-79605-13-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
References: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When caculating the SSU buffer, it first allocate tx and
rx private buffer, then the remaining buffer is for rx
shared buffer. The remaining buffer size should be at
least bigger than or equal to the shared_std, which is the
minimum shared buffer size required by the driver, but
currently if the remaining buffer size is equal to the
shared_std, it returns failure, which causes SSU buffer
allocation failure problem.

This patch fixes this problem by rounding up shared_std before
checking the the remaining buffer size bigger than or equal to
the shared_std.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f847fde..d0e84de 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1403,10 +1403,11 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 	shared_buf_tc = pfc_enable_num * aligned_mps +
 			(tc_num - pfc_enable_num) * aligned_mps / 2 +
 			aligned_mps;
-	shared_std = max_t(u32, shared_buf_min, shared_buf_tc);
+	shared_std = roundup(max_t(u32, shared_buf_min, shared_buf_tc),
+			     HCLGE_BUF_SIZE_UNIT);
 
 	rx_priv = hclge_get_rx_priv_buff_alloced(buf_alloc);
-	if (rx_all <= rx_priv + shared_std)
+	if (rx_all < rx_priv + shared_std)
 		return false;
 
 	shared_buf = rounddown(rx_all - rx_priv, HCLGE_BUF_SIZE_UNIT);
-- 
1.9.1

