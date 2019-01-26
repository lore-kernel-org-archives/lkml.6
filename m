Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5DC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A55214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfAZQuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbfAZQuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:03 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F28D9EC00AE81845FAE2;
        Sun, 27 Jan 2019 00:49:58 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:52 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: add 8 BD limit for tx flow
Date:   Sun, 27 Jan 2019 00:49:19 +0800
Message-ID: <20190126164921.3872-11-tanhuazhong@huawei.com>
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

From: Peng Li <lipeng321@huawei.com>

A single transmit packet can span up to 8 descriptors according
to the HW limit. If a skb has more than 8 frags, driver uses
skb_copy to get a new skb which has less frags.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 93e3e38ba852..216f3dd25cd6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1133,6 +1133,7 @@ static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 				   struct hns3_enet_ring *ring)
 {
 	struct sk_buff *skb = *out_skb;
+	struct sk_buff *new_skb = NULL;
 	struct skb_frag_struct *frag;
 	int bdnum_for_frag;
 	int frag_num;
@@ -1155,7 +1156,19 @@ static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 		buf_num += bdnum_for_frag;
 	}
 
-	if (buf_num > ring_space(ring))
+	if (unlikely(buf_num > HNS3_MAX_BD_PER_FRAG)) {
+		buf_num = (skb->len + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
+		if (ring_space(ring) < buf_num)
+			return -EBUSY;
+		/* manual split the send packet */
+		new_skb = skb_copy(skb, GFP_ATOMIC);
+		if (!new_skb)
+			return -ENOMEM;
+		dev_kfree_skb_any(skb);
+		*out_skb = new_skb;
+	}
+
+	if (unlikely(ring_space(ring) < buf_num))
 		return -EBUSY;
 
 	*bnum = buf_num;
@@ -1166,11 +1179,24 @@ static int hns3_nic_maybe_stop_tx(struct sk_buff **out_skb, int *bnum,
 				  struct hns3_enet_ring *ring)
 {
 	struct sk_buff *skb = *out_skb;
+	struct sk_buff *new_skb = NULL;
 	int buf_num;
 
 	/* No. of segments (plus a header) */
 	buf_num = skb_shinfo(skb)->nr_frags + 1;
 
+	if (unlikely(buf_num > HNS3_MAX_BD_PER_FRAG)) {
+		buf_num = (skb->len + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
+		if (ring_space(ring) < buf_num)
+			return -EBUSY;
+		/* manual split the send packet */
+		new_skb = skb_copy(skb, GFP_ATOMIC);
+		if (!new_skb)
+			return -ENOMEM;
+		dev_kfree_skb_any(skb);
+		*out_skb = new_skb;
+	}
+
 	if (unlikely(ring_space(ring) < buf_num))
 		return -EBUSY;
 
-- 
2.20.1


