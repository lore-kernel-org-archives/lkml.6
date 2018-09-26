Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E53C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A2B20779
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A2B20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeIZPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:52:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbeIZPww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:52:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC914B0A9D6DA;
        Wed, 26 Sep 2018 17:40:43 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 17:40:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-hams@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: hamradio: fix return type of ndo_start_xmit function
Date:   Wed, 26 Sep 2018 17:40:22 +0800
Message-ID: <20180926094022.22632-1-yuehaibing@huawei.com>
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
 drivers/net/hamradio/baycom_epp.c | 3 ++-
 drivers/net/hamradio/dmascc.c     | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 1e62d00..f4ceccf 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -772,7 +772,8 @@ static void epp_bh(struct work_struct *work)
  * ===================== network driver interface =========================
  */
 
-static int baycom_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+baycom_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct baycom_state *bc = netdev_priv(dev);
 
diff --git a/drivers/net/hamradio/dmascc.c b/drivers/net/hamradio/dmascc.c
index cde4120..2798870 100644
--- a/drivers/net/hamradio/dmascc.c
+++ b/drivers/net/hamradio/dmascc.c
@@ -239,7 +239,7 @@ struct scc_info {
 static int scc_open(struct net_device *dev);
 static int scc_close(struct net_device *dev);
 static int scc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
-static int scc_send_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t scc_send_packet(struct sk_buff *skb, struct net_device *dev);
 static int scc_set_mac_address(struct net_device *dev, void *sa);
 
 static inline void tx_on(struct scc_priv *priv);
@@ -921,7 +921,7 @@ static int scc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 
 
-static int scc_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t scc_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct scc_priv *priv = dev->ml_priv;
 	unsigned long flags;
-- 
1.8.3.1


