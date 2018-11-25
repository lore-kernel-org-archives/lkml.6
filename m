Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F92C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C2920855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C2920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeKZKfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:35:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47716 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:35:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAPNhMvr088702;
        Sun, 25 Nov 2018 17:43:22 -0600
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAPNhMcN098550
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 17:43:22 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 17:43:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 17:43:21 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAPNhLH9015074;
        Sun, 25 Nov 2018 17:43:21 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAPNhLU03226;
        Sun, 25 Nov 2018 17:43:21 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet size
Date:   Sun, 25 Nov 2018 17:43:15 -0600
Message-ID: <20181125234315.28313-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For proper VLAN packets forwarding CPSW driver uses min tx packet size of
64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").

Unfortunately, this breaks some industrial automation protocols, as
reported by TI customers [1], which can work only with min TX packet size
from 60 byte (ecluding FCS).

Hence, introduce module boot parameter "tx_packet_min" to allow configure
min TX packet size at boot time.

[1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669
Fixes: 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ceaec56..15d563c 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -188,6 +188,10 @@ static int rx_packet_max = CPSW_MAX_PACKET_SIZE;
 module_param(rx_packet_max, int, 0);
 MODULE_PARM_DESC(rx_packet_max, "maximum receive packet size (bytes)");
 
+static int tx_packet_min = CPSW_MIN_PACKET_SIZE;
+module_param(tx_packet_min, int, 0444);
+MODULE_PARM_DESC(tx_packet_min, "minimum tx packet size (bytes)");
+
 static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
 module_param(descs_pool_size, int, 0444);
 MODULE_PARM_DESC(descs_pool_size, "Number of CPDMA CPPI descriptors in pool");
@@ -2131,7 +2135,7 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 	struct cpdma_chan *txch;
 	int ret, q_idx;
 
-	if (skb_padto(skb, CPSW_MIN_PACKET_SIZE)) {
+	if (skb_padto(skb, tx_packet_min)) {
 		cpsw_err(priv, tx_err, "packet pad failed\n");
 		ndev->stats.tx_dropped++;
 		return NET_XMIT_DROP;
@@ -3636,7 +3640,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	dma_params.num_chan		= data->channels;
 	dma_params.has_soft_reset	= true;
-	dma_params.min_packet_size	= CPSW_MIN_PACKET_SIZE;
+	dma_params.min_packet_size	= tx_packet_min;
 	dma_params.desc_mem_size	= data->bd_ram_size;
 	dma_params.desc_align		= 16;
 	dma_params.has_ext_regs		= true;
-- 
2.10.5

