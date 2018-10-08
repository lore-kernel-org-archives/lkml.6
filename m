Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BFBC71150
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE5B2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zp7j6VQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE5B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJIHEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:04:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59158 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeJIHEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:04:08 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98NnrUT074795;
        Mon, 8 Oct 2018 18:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539042593;
        bh=qAdOAVFcrQW2ns+nKEeBvF6x4Nb/j951S7LnOMCiuZo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zp7j6VQtxVjdktFAyagSMthb8IzojJEL6a/45lvS1VnwScbIPB7h9mKw1wPqaFiUA
         Dy63/KhCcBEbaBUMfudIm2Ajr7HsK9QgHNq/Fx/bXKI8ci4NiUW+cr5YSQo11fVn5Q
         yPeaFFNCHxiAwvhGyinRzBKAWGt+PEBSxO1sfkCs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnrPX023961;
        Mon, 8 Oct 2018 18:49:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 18:49:52 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 18:49:52 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98Nnqm2031121;
        Mon, 8 Oct 2018 18:49:52 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w98Nnqx25228;
        Mon, 8 Oct 2018 18:49:52 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 05/11] net: ethernet: ti: cpsw: add support for port interface mode selection phy
Date:   Mon, 8 Oct 2018 18:49:43 -0500
Message-ID: <20181008234949.15416-6-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181008234949.15416-1-grygorii.strashko@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for port interface mode selection phy (phy-gmii-sel):
- try to request interface mode selection phy from Port DT node and fail
silently if not defined and old CONFIG_TI_CPSW_PHY_SEL driver enabled.
- use new phy if requested successfully.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 832bce0..4607de2 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -26,6 +26,7 @@
 #include <linux/netdevice.h>
 #include <linux/net_tstamp.h>
 #include <linux/phy.h>
+#include <linux/phy/phy.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
@@ -387,6 +388,7 @@ struct cpsw_slave_data {
 	int		phy_if;
 	u8		mac_addr[ETH_ALEN];
 	u16		dual_emac_res_vlan;	/* Reserved VLAN for DualEMAC */
+	struct phy	*ifphy;
 };
 
 struct cpsw_platform_data {
@@ -1502,7 +1504,11 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	phy_start(slave->phy);
 
 	/* Configure GMII_SEL register */
-	cpsw_phy_sel(cpsw->dev, slave->phy->interface, slave->slave_num);
+	if (!IS_ERR(slave->data->ifphy))
+		phy_set_netif_mode(slave->data->ifphy, slave->data->phy_if);
+	else
+		cpsw_phy_sel(cpsw->dev, slave->phy->interface,
+			     slave->slave_num);
 }
 
 static inline void cpsw_add_default_vlan(struct cpsw_priv *priv)
@@ -3135,6 +3141,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		if (strcmp(slave_node->name, "slave"))
 			continue;
 
+		slave_data->ifphy = devm_of_phy_get(&pdev->dev, slave_node,
+						    NULL);
+		if (!IS_ENABLED(CONFIG_TI_CPSW_PHY_SEL) &&
+		    IS_ERR(slave_data->ifphy)) {
+			ret = PTR_ERR(slave_data->ifphy);
+			dev_err(&pdev->dev,
+				"%d: Error retrieving port phy: %d\n", i, ret);
+			return ret;
+		}
+
 		slave_data->phy_node = of_parse_phandle(slave_node,
 							"phy-handle", 0);
 		parp = of_get_property(slave_node, "phy_id", &lenp);
-- 
2.10.5

