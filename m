Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC4C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEE820671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBQXrGdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbeG1AVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:21:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37377 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388507AbeG1AVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:21:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so4539729lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sRtS++9tfqeRK26DArN/J83/p+Zu/+Nvsuwm+I5m8Sw=;
        b=NBQXrGdnsGRBqQhSTjxpB+QU/eVVifA9ZRvA1yH5KpVypQsRxV+SjRjKFg+ByVgYuP
         fljA6/+qlnCQQeMw+weumM34iEx5K32mieGWRkniC1K2OegrzddFL5rxVGoXrC/9ehAf
         U3/z3kIfx5q3pPwvw5DQMOHqP+Gt52k0S7joU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sRtS++9tfqeRK26DArN/J83/p+Zu/+Nvsuwm+I5m8Sw=;
        b=MS3DZqCJUeOdCal82z8NB3e5xnK9x0PS/6L2jLFSJ0v3v1RMo8d4BaILSz/qcjy+Ro
         xalb5LZodoJooN4T2OWiq6/Kuo+gPkn37HaeEtOkEGOZKo2i4uq87/Dyv/wzeOqVIHYB
         BRcPC7uuoMk0kgr2P3Ky8vD0PGPVF/g8Y3MI8jFhmSDYiA0RhsVnngBYi4PK8vbbRe2w
         tBWS3yxDZjWeV2L+4MesWiTNIIWt8Goc7K4MbAEyuuA1D5pCQVL9sskCyYWlWMmz/HNJ
         HvNAvwS2GqZNnFPpm1HzqRBZIbRWSk4wZul3TYfYLpvXSrO3Py4t4jPRulQD2N27eVix
         8y5g==
X-Gm-Message-State: AOUpUlGZyX2iWiWW9TP45ooSTxtxBYn+qIiUI2Porkp6DrdAKHuI3wFk
        dczMru3J79d6F+1DXHFB08Lp3Q==
X-Google-Smtp-Source: AAOMgpdOk1z3vTXVfijmx0rbIjWG40pGjID0PeaZ7Z3q4SDYBAT6DjkdWazDKpVfOmlnvINpt+mXZg==
X-Received: by 2002:a19:db44:: with SMTP id s65-v6mr4867328lfg.109.1532732249722;
        Fri, 27 Jul 2018 15:57:29 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h4-v6sm684949lfj.69.2018.07.27.15.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 15:57:28 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com, andrew@lunn.ch,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 net-next] net: ethernet: ti: cpsw: replace unnecessarily macroses on functions
Date:   Sat, 28 Jul 2018 01:57:25 +0300
Message-Id: <20180727225725.3843-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ugly macroses on functions.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

v2..v1:
 - removed inline for cpsw_src_port_detect()

 drivers/net/ethernet/ti/cpsw.c | 63 +++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1b54c26c2bec..9cacfe4ad065 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
 				(func)(slave++, ##arg);			\
 	} while (0)
 
-#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
-	do {								\
-		if (!cpsw->data.dual_emac)				\
-			break;						\
-		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
-			ndev = cpsw->slaves[0].ndev;			\
-			skb->dev = ndev;				\
-		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
-			ndev = cpsw->slaves[1].ndev;			\
-			skb->dev = ndev;				\
-		}							\
-	} while (0)
-#define cpsw_add_mcast(cpsw, priv, addr)				\
-	do {								\
-		if (cpsw->data.dual_emac) {				\
-			struct cpsw_slave *slave = cpsw->slaves +	\
-						priv->emac_port;	\
-			int slave_port = cpsw_get_slave_port(		\
-						slave->slave_num);	\
-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
-				1 << slave_port | ALE_PORT_HOST,	\
-				ALE_VLAN, slave->port_vlan, 0);		\
-		} else {						\
-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
-				ALE_ALL_PORTS,				\
-				0, 0, 0);				\
-		}							\
-	} while (0)
-
 static inline int cpsw_get_slave_port(u32 slave_num)
 {
 	return slave_num + 1;
 }
 
+static void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
+				 struct sk_buff *skb)
+{
+	if (!cpsw->data.dual_emac)
+		return;
+
+	if (CPDMA_RX_SOURCE_PORT(status) == 1)
+		skb->dev = cpsw->slaves[0].ndev;
+	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
+		skb->dev = cpsw->slaves[1].ndev;
+}
+
+static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	if (cpsw->data.dual_emac) {
+		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
+		int slave_port = cpsw_get_slave_port(slave->slave_num);
+
+		cpsw_ale_add_mcast(cpsw->ale, addr,
+				   1 << slave_port | ALE_PORT_HOST,
+				   ALE_VLAN, slave->port_vlan, 0);
+		return;
+	}
+
+	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
+}
+
 static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -706,7 +706,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 
 		/* program multicast address list into ALE register */
 		netdev_for_each_mc_addr(ha, ndev) {
-			cpsw_add_mcast(cpsw, priv, (u8 *)ha->addr);
+			cpsw_add_mcast(priv, (u8 *)ha->addr);
 		}
 	}
 }
@@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	int			ret = 0;
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
-	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
+	cpsw_src_port_detect(cpsw, status, skb);
+	ndev = skb->dev;
 
 	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
 		/* In dual emac mode check for all interfaces */
-- 
2.17.1

