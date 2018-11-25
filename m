Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42331C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0013420855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JQWzSE4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0013420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeKZKit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:38:49 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48770 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:38:49 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAPNkRfo091030;
        Sun, 25 Nov 2018 17:46:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543189587;
        bh=lf8LtwdUZED+A+ylnyyjZqjtl4ylg+CfCwWhN2BcRJg=;
        h=From:To:CC:Subject:Date;
        b=JQWzSE4+6TC5xJcikUjvWKs1oSkm2Cft2JTR08nSgriYOyagYK/hslNFE2jgdk+R8
         agWc9LWA41TuHQozVOOyINva/to7rDllmC5dUQzOsGF1HmRnkx1l2Ho/QPizfJqhBS
         la93ZcWq9UpU+8uonhIQw0qlYITrklXTB0EIYdZc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAPNkRbB126123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 17:46:27 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 17:46:27 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 17:46:27 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAPNkRJT017822;
        Sun, 25 Nov 2018 17:46:27 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAPNkRU03338;
        Sun, 25 Nov 2018 17:46:27 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0 configuration in dual_mac mode
Date:   Sun, 25 Nov 2018 17:46:26 -0600
Message-ID: <20181125234626.28474-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
dual mac mode wich are used to configure pvids for each external ports.
But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
ext. ports. As result, it's imposible to use priority tagged packets in
dual mac mode.

Hence, drop vid0 configuration in dual mac mode as it's not required for dual
mac mode functionality and, this way, make it possible to use priority
tagged packet in dual mac mode.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 15d563c..4f3a159 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2036,9 +2036,6 @@ static int cpsw_ndo_open(struct net_device *ndev)
 	/* Add default VLAN */
 	if (!cpsw->data.dual_emac)
 		cpsw_add_default_vlan(priv);
-	else
-		cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
-				  ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
 
 	/* initialize shared resources for every ndev */
 	if (!cpsw->usage_count) {
@@ -2490,7 +2487,7 @@ static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
 	struct cpsw_common *cpsw = priv->cpsw;
 	int ret;
 
-	if (vid == cpsw->data.default_vlan)
+	if (!cpsw->data.dual_emac && vid == cpsw->data.default_vlan)
 		return 0;
 
 	ret = pm_runtime_get_sync(cpsw->dev);
@@ -2528,7 +2525,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 	struct cpsw_common *cpsw = priv->cpsw;
 	int ret;
 
-	if (vid == cpsw->data.default_vlan)
+	if (!cpsw->data.dual_emac && vid == cpsw->data.default_vlan)
 		return 0;
 
 	ret = pm_runtime_get_sync(cpsw->dev);
-- 
2.10.5

