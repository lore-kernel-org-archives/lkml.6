Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7A8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2AB214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2AB214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIZQlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:41:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeIZQlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:41:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C0231A78755B0;
        Wed, 26 Sep 2018 18:29:14 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 18:29:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <sthemmin@microsoft.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devel@linuxdriverproject.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] hv_netvsc: fix return type of ndo_start_xmit function
Date:   Wed, 26 Sep 2018 18:25:10 +0800
Message-ID: <20180926102510.15696-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

As suggestion from Haiyang Zhang <haiyangz@microsoft.com>, if netvsc_vf_xmit
fails, We are not sure if the error can go away after retrying, returning
NETDEV_TX_BUSY may cause infinite retry from the upper layer.
so just return NETDEV_TX_OK at there.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/hyperv/netvsc_drv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ec69974..a1d44b4 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -511,7 +511,8 @@ static int netvsc_vf_xmit(struct net_device *net, struct net_device *vf_netdev,
 	return rc;
 }
 
-static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
+static netdev_tx_t
+netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 {
 	struct net_device_context *net_device_ctx = netdev_priv(net);
 	struct hv_netvsc_packet *packet = NULL;
@@ -528,8 +529,10 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 	 */
 	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
 	if (vf_netdev && netif_running(vf_netdev) &&
-	    !netpoll_tx_running(net))
-		return netvsc_vf_xmit(net, vf_netdev, skb);
+	    !netpoll_tx_running(net)) {
+		netvsc_vf_xmit(net, vf_netdev, skb);
+		return NETDEV_TX_OK;
+	}
 
 	/* We will atmost need two pages to describe the rndis
 	 * header. We can only transmit MAX_PAGE_BUFFER_COUNT number
-- 
1.8.3.1


