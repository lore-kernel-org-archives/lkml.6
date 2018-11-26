Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C49FC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320E520868
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j+M+x6jC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320E520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeKZLI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:08:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52682 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeKZLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:08:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ0FYU6098855;
        Sun, 25 Nov 2018 18:15:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543191334;
        bh=GnXeS45PGTnjfeOQW4vPy7VEVfXofOgaQHxhQErqVQs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=j+M+x6jCg6dt21AK4YJbNSTZ2rVbzpFTzCSk0pv6TbMWn2m/XMoo1vqR2B5Uii2QX
         E1g8O5iSrFGXewqX0/arddkCHGb9MC3xi6Ffu71rU7fbhQO5uFhH0n8hDAwu1iuuA5
         yejcevBa5xnhCs9rl3M31GdIrWNuE7rj1L5WfTxs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ0FYYM126529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 18:15:34 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 18:15:33 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 18:15:33 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ0FXpn030827;
        Sun, 25 Nov 2018 18:15:33 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAQ0FXU04350;
        Sun, 25 Nov 2018 18:15:33 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 04/10] net: ethernet: ti: cpsw: add support for port interface mode selection phy
Date:   Sun, 25 Nov 2018 18:15:25 -0600
Message-ID: <20181126001531.12974-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
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
 drivers/net/ethernet/ti/cpsw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e4aa030..ceaec56 100644
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
@@ -1624,7 +1626,12 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	phy_start(slave->phy);
 
 	/* Configure GMII_SEL register */
-	cpsw_phy_sel(cpsw->dev, slave->phy->interface, slave->slave_num);
+	if (!IS_ERR(slave->data->ifphy))
+		phy_set_mode_ext(slave->data->ifphy, PHY_MODE_ETHERNET,
+				 slave->data->phy_if);
+	else
+		cpsw_phy_sel(cpsw->dev, slave->phy->interface,
+			     slave->slave_num);
 }
 
 static inline void cpsw_add_default_vlan(struct cpsw_priv *priv)
@@ -3274,6 +3281,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
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

