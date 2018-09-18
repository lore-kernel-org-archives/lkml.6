Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616ADECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B8820685
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B8820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeIRLzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:55:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727202AbeIRLzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:55:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 131CD998404DD;
        Tue, 18 Sep 2018 14:24:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 14:24:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <derek.chickles@caviumnetworks.com>,
        <satananda.burla@caviumnetworks.com>,
        <felix.manlunas@caviumnetworks.com>,
        <raghu.vatsavayi@caviumnetworks.com>, <alexander.sverdlin@nsn.com>,
        <david.daney@cavium.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: cavium: fix return type of ndo_start_xmit function
Date:   Tue, 18 Sep 2018 14:19:05 +0800
Message-ID: <20180918061905.25000-1-yuehaibing@huawei.com>
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

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c    | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c  | 5 +++--
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   | 5 +++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index f42c1b0..9d70e5c6 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -2313,7 +2313,7 @@ static inline int send_nic_timestamp_pkt(struct octeon_device *oct,
  * @returns whether the packet was transmitted to the device okay or not
  *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
  */
-static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct lio *lio;
 	struct octnet_buf_free_info *finfo;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 0ec4bfe..54b2457 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -1401,7 +1401,7 @@ static int send_nic_timestamp_pkt(struct octeon_device *oct,
  * @returns whether the packet was transmitted to the device okay or not
  *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
  */
-static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct octnet_buf_free_info *finfo;
 	union octnic_cmd_setup cmdsetup;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index 96cf4a4..ea9859e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -30,7 +30,8 @@
 
 static int lio_vf_rep_open(struct net_device *ndev);
 static int lio_vf_rep_stop(struct net_device *ndev);
-static int lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev);
+static netdev_tx_t lio_vf_rep_pkt_xmit(struct sk_buff *skb,
+				       struct net_device *ndev);
 static void lio_vf_rep_tx_timeout(struct net_device *netdev);
 static int lio_vf_rep_phys_port_name(struct net_device *dev,
 				     char *buf, size_t len);
@@ -361,7 +362,7 @@ static void lio_vf_rep_get_stats64(struct net_device *dev,
 		netif_wake_queue(ndev);
 }
 
-static int
+static netdev_tx_t
 lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct lio_vf_rep_desc *vf_rep = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index bb43ddb..4b3aecf 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1268,12 +1268,13 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 	return 0;
 }
 
-static int octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+octeon_mgmt_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct octeon_mgmt *p = netdev_priv(netdev);
 	union mgmt_port_ring_entry re;
 	unsigned long flags;
-	int rv = NETDEV_TX_BUSY;
+	netdev_tx_t rv = NETDEV_TX_BUSY;
 
 	re.d64 = 0;
 	re.s.tstamp = ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) != 0);
-- 
1.8.3.1


