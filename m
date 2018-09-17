Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E832ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8F12088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8F12088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeIREVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:21:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIREVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:21:38 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01AF8CAD;
        Mon, 17 Sep 2018 22:52:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rivshin <drivshin@allworx.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Andrew Goodbody <andrew.goodbody@cambrionix.com>,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>
Subject: [PATCH 4.4 49/56] drivers: net: cpsw: fix parsing of phy-handle DT property in dual_emac config
Date:   Tue, 18 Sep 2018 00:42:22 +0200
Message-Id: <20180917213829.954751608@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rivshin <drivshin@allworx.com>

commit 552165bcf7060b998b4a9b5b86110b6a5e04dfd9 upstream.

Commit 9e42f715264ff158478fa30eaed847f6e131366b ("drivers: net: cpsw: add
phy-handle parsing") saved the "phy-handle" phandle into a new cpsw_priv
field. However, phy connections are per-slave, so the phy_node field should
be in cpsw_slave_data rather than cpsw_priv.

This would go unnoticed in a single emac configuration. But in dual_emac
mode, the last "phy-handle" property parsed for either slave would be used
by both of them, causing them both to refer to the same phy_device.

Fixes: 9e42f715264f ("drivers: net: cpsw: add phy-handle parsing")
Signed-off-by: David Rivshin <drivshin@allworx.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Andrew Goodbody <andrew.goodbody@cambrionix.com>
Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/ti/cpsw.c |   13 ++++++-------
 drivers/net/ethernet/ti/cpsw.h |    1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -371,7 +371,6 @@ struct cpsw_priv {
 	spinlock_t			lock;
 	struct platform_device		*pdev;
 	struct net_device		*ndev;
-	struct device_node		*phy_node;
 	struct napi_struct		napi_rx;
 	struct napi_struct		napi_tx;
 	struct device			*dev;
@@ -1165,8 +1164,8 @@ static void cpsw_slave_open(struct cpsw_
 		cpsw_ale_add_mcast(priv->ale, priv->ndev->broadcast,
 				   1 << slave_port, 0, 0, ALE_MCAST_FWD_2);
 
-	if (priv->phy_node)
-		slave->phy = of_phy_connect(priv->ndev, priv->phy_node,
+	if (slave->data->phy_node)
+		slave->phy = of_phy_connect(priv->ndev, slave->data->phy_node,
 				 &cpsw_adjust_link, 0, slave->data->phy_if);
 	else
 		slave->phy = phy_connect(priv->ndev, slave->data->phy_id,
@@ -1957,12 +1956,11 @@ static void cpsw_slave_init(struct cpsw_
 	slave->port_vlan = data->dual_emac_res_vlan;
 }
 
-static int cpsw_probe_dt(struct cpsw_priv *priv,
+static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			 struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *slave_node;
-	struct cpsw_platform_data *data = &priv->data;
 	int i = 0, ret;
 	u32 prop;
 
@@ -2050,7 +2048,8 @@ static int cpsw_probe_dt(struct cpsw_pri
 		if (strcmp(slave_node->name, "slave"))
 			continue;
 
-		priv->phy_node = of_parse_phandle(slave_node, "phy-handle", 0);
+		slave_data->phy_node = of_parse_phandle(slave_node,
+							"phy-handle", 0);
 		parp = of_get_property(slave_node, "phy_id", &lenp);
 		if (of_phy_is_fixed_link(slave_node)) {
 			struct device_node *phy_node;
@@ -2291,7 +2290,7 @@ static int cpsw_probe(struct platform_de
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(&pdev->dev);
 
-	if (cpsw_probe_dt(priv, pdev)) {
+	if (cpsw_probe_dt(&priv->data, pdev)) {
 		dev_err(&pdev->dev, "cpsw: platform data missing\n");
 		ret = -ENODEV;
 		goto clean_runtime_disable_ret;
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -18,6 +18,7 @@
 #include <linux/phy.h>
 
 struct cpsw_slave_data {
+	struct device_node *phy_node;
 	char		phy_id[MII_BUS_ID_SIZE];
 	int		phy_if;
 	u8		mac_addr[ETH_ALEN];


