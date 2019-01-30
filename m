Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24941C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73A32184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbfA3U4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:56:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387876AbfA3U41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 35B369F352B2750815CF;
        Thu, 31 Jan 2019 04:56:25 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:17 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: keep flow director state unchanged when reset
Date:   Thu, 31 Jan 2019 04:55:52 +0800
Message-ID: <20190130205552.8512-13-tanhuazhong@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

In orginal codes, driver always enables flow director when
intializing. When user disable flow director with command
ethtool -K, the flow director will be enabled again after
resetting.

This patch fixes it by only enabling it when first initialzing.

Fixes: 6871af29b3ab ("net: hns3: Add reset handle for flow director")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 10 ++++++----
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b531eac12fea..2ffbf07ff829 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1007,6 +1007,9 @@ static int hclge_configure(struct hclge_dev *hdev)
 	hdev->tm_info.hw_pfc_map = 0;
 	hdev->wanted_umv_size = cfg.umv_space;
 
+	if (hnae3_dev_fd_supported(hdev))
+		hdev->fd_en = true;
+
 	ret = hclge_parse_speed(cfg.default_speed, &hdev->hw.mac.speed);
 	if (ret) {
 		dev_err(&hdev->pdev->dev, "Get wrong speed ret=%d.\n", ret);
@@ -3973,7 +3976,6 @@ static int hclge_init_fd_config(struct hclge_dev *hdev)
 		return -EOPNOTSUPP;
 	}
 
-	hdev->fd_cfg.fd_en = true;
 	hdev->fd_cfg.proto_support =
 		TCP_V4_FLOW | UDP_V4_FLOW | SCTP_V4_FLOW | TCP_V6_FLOW |
 		UDP_V6_FLOW | SCTP_V6_FLOW | IPV4_USER_FLOW | IPV6_USER_FLOW;
@@ -4731,7 +4733,7 @@ static int hclge_add_fd_entry(struct hnae3_handle *handle,
 	if (!hnae3_dev_fd_supported(hdev))
 		return -EOPNOTSUPP;
 
-	if (!hdev->fd_cfg.fd_en) {
+	if (!hdev->fd_en) {
 		dev_warn(&hdev->pdev->dev,
 			 "Please enable flow director first\n");
 		return -EOPNOTSUPP;
@@ -4884,7 +4886,7 @@ static int hclge_restore_fd_entries(struct hnae3_handle *handle)
 		return 0;
 
 	/* if fd is disabled, should not restore it when reset */
-	if (!hdev->fd_cfg.fd_en)
+	if (!hdev->fd_en)
 		return 0;
 
 	hlist_for_each_entry_safe(rule, node, &hdev->fd_rule_list, rule_node) {
@@ -5170,7 +5172,7 @@ static void hclge_enable_fd(struct hnae3_handle *handle, bool enable)
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	hdev->fd_cfg.fd_en = enable;
+	hdev->fd_en = enable;
 	if (!enable)
 		hclge_del_all_fd_entries(handle, false);
 	else
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 2c413c63c6c9..c939f4a7f5f0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -583,7 +583,6 @@ struct hclge_fd_key_cfg {
 
 struct hclge_fd_cfg {
 	u8 fd_mode;
-	u8 fd_en;
 	u16 max_key_length;
 	u32 proto_support;
 	u32 rule_num[2]; /* rule entry number */
@@ -758,6 +757,7 @@ struct hclge_dev {
 	struct hclge_fd_cfg fd_cfg;
 	struct hlist_head fd_rule_list;
 	u16 hclge_fd_rule_num;
+	u8 fd_en;
 
 	u16 wanted_umv_size;
 	/* max available unicast mac vlan space */
-- 
2.20.1


