Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC148C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B732920892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B732920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeLGVJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:09:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59891 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeLGVJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:38 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 44F367B14CDFF;
        Sat,  8 Dec 2018 05:09:35 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:27 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 06/14] net: hns3: add optimization in the hclge_hw_error_set_state
Date:   Fri, 7 Dec 2018 21:08:03 +0000
Message-ID: <20181207210811.23844-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181207210811.23844-1-salil.mehta@huawei.com>
References: <20181207210811.23844-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

1. This patch adds minor loop optimization in the
   hclge_hw_error_set_state function.
2. Adds logging module's name if it fails to configure the
   error interrupts.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 2d07be8..d1c9f7a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -586,18 +586,16 @@ static const struct hclge_hw_blk hw_blk[] = {
 
 int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state)
 {
+	const struct hclge_hw_blk *module = hw_blk;
 	int ret = 0;
-	int i = 0;
 
-	while (hw_blk[i].name) {
-		if (!hw_blk[i].config_err_int) {
-			i++;
-			continue;
+	while (module->name) {
+		if (module->config_err_int) {
+			ret = module->config_err_int(hdev, state);
+			if (ret)
+				return ret;
 		}
-		ret = hw_blk[i].config_err_int(hdev, state);
-		if (ret)
-			return ret;
-		i++;
+		module++;
 	}
 
 	return ret;
-- 
2.7.4


