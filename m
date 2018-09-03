Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F81C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92CB2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92CB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeICOme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:42:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727284AbeICOmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:42:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2B3B8EDB157E6;
        Mon,  3 Sep 2018 18:22:59 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 3 Sep 2018 18:22:54 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 02/11] net: hns3: Fix for multicast failure
Date:   Mon, 3 Sep 2018 11:21:47 +0100
Message-ID: <20180903102156.18676-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180903102156.18676-1-salil.mehta@huawei.com>
References: <20180903102156.18676-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

When the lower 24 bits of the IPV6 link-local addresses at both
ends are the same, the multicast MAC address for Neigbour Discovery
is the same. The multicast for Neigbour Discovery will fail.

This patch fixes it by including the bonding uplink port in the
multicast group.

Fixes: 46a3df9f9718("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1c2ab7e..8f1339a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4362,7 +4362,7 @@ int hclge_add_mc_addr_common(struct hclge_vport *vport,
 	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hclge_prepare_mac_addr(&req, addr);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
@@ -4429,7 +4429,7 @@ int hclge_rm_mc_addr_common(struct hclge_vport *vport,
 	hnae3_set_bit(req.flags, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
 	hnae3_set_bit(req.entry_type, HCLGE_MAC_VLAN_BIT1_EN_B, 1);
-	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 0);
+	hnae3_set_bit(req.mc_mac_en, HCLGE_MAC_VLAN_BIT0_EN_B, 1);
 	hclge_prepare_mac_addr(&req, addr);
 	status = hclge_lookup_mac_vlan_tbl(vport, &req, desc, true);
 	if (!status) {
-- 
2.7.4


