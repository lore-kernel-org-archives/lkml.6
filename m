Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC468C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83A02176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeLTDQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:16:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16611 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729891AbeLTDQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:32 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 36D4625310DD;
        Thu, 20 Dec 2018 11:16:28 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 11:16:16 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: don't restore rules when flow director is disabled
Date:   Thu, 20 Dec 2018 11:52:04 +0800
Message-ID: <1545277926-66432-8-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
References: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

When user disables flow director, all the rules will be disabled. But
when reset happens, it will restore all the rules again. It's not
reasonable. This patch fixes it by add flow director status check before
restore fules.

Fixes: 6871af29b3ab ("net: hns3: Add reset handle for flow director")
Fixes: c17852a8932f ("net: hns3: Add support for enable/disable flow director")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9f89858..f7637c0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4808,6 +4808,10 @@ static int hclge_restore_fd_entries(struct hnae3_handle *handle)
 	if (!hnae3_dev_fd_supported(hdev))
 		return 0;
 
+	/* if fd is disabled, should not restore it when reset */
+	if (!hdev->fd_cfg.fd_en)
+		return 0;
+
 	hlist_for_each_entry_safe(rule, node, &hdev->fd_rule_list, rule_node) {
 		ret = hclge_config_action(hdev, HCLGE_FD_STAGE_1, rule);
 		if (!ret)
-- 
1.9.1

