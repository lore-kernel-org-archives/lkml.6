Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F0CC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2EF21872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfAZQuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbfAZQuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:03 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 269A46BAB9C61E7B6E52;
        Sun, 27 Jan 2019 00:49:59 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:49 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: fix broadcast promisc issue for revision 0x20
Date:   Sun, 27 Jan 2019 00:49:14 +0800
Message-ID: <20190126164921.3872-6-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190126164921.3872-1-tanhuazhong@huawei.com>
References: <20190126164921.3872-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

For revision 0x20, vlan filter is always bypassed when enable
broadcast promisc mode. In this case, broadcast packets with
any vlan id can be accpeted. We should disable broadcast promisc
mode until user want enable it.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        |  4 ++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index cec09235b1ef..322af28ab4b5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -506,7 +506,7 @@ static u8 hns3_get_netdev_flags(struct net_device *netdev)
 	u8 flags = 0;
 
 	if (netdev->flags & IFF_PROMISC) {
-		flags = HNAE3_USER_UPE | HNAE3_USER_MPE;
+		flags = HNAE3_USER_UPE | HNAE3_USER_MPE | HNAE3_BPE;
 	} else {
 		flags |= HNAE3_VLAN_FLTR;
 		if (netdev->flags & IFF_ALLMULTI)
@@ -541,13 +541,13 @@ static void hns3_nic_set_rx_mode(struct net_device *netdev)
 		}
 	}
 
-	hns3_update_promisc_mode(netdev, new_flags);
 	/* User mode Promisc mode enable and vlan filtering is disabled to
 	 * let all packets in. MAC-VLAN Table overflow Promisc enabled and
 	 * vlan fitering is enabled
 	 */
 	hns3_enable_vlan_filter(netdev, new_flags & HNAE3_VLAN_FLTR);
 	h->netdev_flags = new_flags;
+	hns3_update_promisc_mode(netdev, new_flags);
 }
 
 int hns3_update_promisc_mode(struct net_device *netdev, u8 promisc_flags)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d5482f9c422c..558389a18353 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3843,8 +3843,16 @@ static int hclge_set_promisc_mode(struct hnae3_handle *handle, bool en_uc_pmc,
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_promisc_param param;
+	bool en_bc_pmc = true;
 
-	hclge_promisc_param_init(&param, en_uc_pmc, en_mc_pmc, true,
+	/* For revision 0x20, if broadcast promisc enabled, vlan filter is
+	 * always bypassed. So broadcast promisc should be disabled until
+	 * user enable promisc mode
+	 */
+	if (handle->pdev->revision == 0x20)
+		en_bc_pmc = handle->netdev_flags & HNAE3_BPE ? true : false;
+
+	hclge_promisc_param_init(&param, en_uc_pmc, en_mc_pmc, en_bc_pmc,
 				 vport->vport_id);
 	return hclge_cmd_set_promisc_mode(hdev, &param);
 }
-- 
2.20.1


