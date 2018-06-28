Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F6CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709A525FEB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709A525FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeF1Dna (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:43:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752993AbeF1DlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 462068A003719;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:52 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 04/11] net: hns3: add l4_type check for both ipv4 and ipv6
Date:   Thu, 28 Jun 2018 12:12:22 +0800
Message-ID: <1530159149-122284-5-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HW supports UDP, TCP and SCTP packets checksum for both ipv4 and
ipv6,  but do not support other type packets checksum for ipv4 or
ipv6.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 25a73bb..99bb6a8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2103,11 +2103,11 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 		skb->csum_level = 1;
 	case HNS3_OL4_TYPE_NO_TUN:
 		/* Can checksum ipv4 or ipv6 + UDP/TCP/SCTP packets */
-		if (l3_type == HNS3_L3_TYPE_IPV4 ||
-		    (l3_type == HNS3_L3_TYPE_IPV6 &&
-		     (l4_type == HNS3_L4_TYPE_UDP ||
-		      l4_type == HNS3_L4_TYPE_TCP ||
-		      l4_type == HNS3_L4_TYPE_SCTP)))
+		if ((l3_type == HNS3_L3_TYPE_IPV4 ||
+		     l3_type == HNS3_L3_TYPE_IPV6) &&
+		    (l4_type == HNS3_L4_TYPE_UDP ||
+		     l4_type == HNS3_L4_TYPE_TCP ||
+		     l4_type == HNS3_L4_TYPE_SCTP))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		break;
 	}
-- 
2.9.3

