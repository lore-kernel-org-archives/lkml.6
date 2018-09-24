Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF95ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB7721486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB7721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeIXR7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:59:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbeIXR7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:59:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5E0BD64;
        Mon, 24 Sep 2018 11:57:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rivshin <drivshin@allworx.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>
Subject: [PATCH 4.4 68/70] drivers: net: cpsw: fix segfault in case of bad phy-handle
Date:   Mon, 24 Sep 2018 13:53:07 +0200
Message-Id: <20180924113107.847362997@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
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

commit d733f7542ad47cf73e033c90cf55158587e1d060 upstream.

If an emac node has a phy-handle property that points to something
which is not a phy, then a segmentation fault will occur when the
interface is brought up. This is because while phy_connect() will
return ERR_PTR() on failure, of_phy_connect() will return NULL.
The common error check uses IS_ERR(), and so missed when
of_phy_connect() fails. The NULL pointer is then dereferenced.

Also, the common error message referenced slave->data->phy_id,
which would be empty in the case of phy-handle. Instead, use the
name of the device_node as a useful identifier. And in the phy_id
case add the error code for completeness.

Fixes: 9e42f715264f ("drivers: net: cpsw: add phy-handle parsing")
Signed-off-by: David Rivshin <drivshin@allworx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[SZ Lin (林上智): Tweak the patch to use original print function of dev_info()]
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |   37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1164,25 +1164,34 @@ static void cpsw_slave_open(struct cpsw_
 		cpsw_ale_add_mcast(priv->ale, priv->ndev->broadcast,
 				   1 << slave_port, 0, 0, ALE_MCAST_FWD_2);
 
-	if (slave->data->phy_node)
+	if (slave->data->phy_node) {
 		slave->phy = of_phy_connect(priv->ndev, slave->data->phy_node,
 				 &cpsw_adjust_link, 0, slave->data->phy_if);
-	else
+		if (!slave->phy) {
+			dev_err(priv->dev, "phy \"%s\" not found on slave %d\n",
+				slave->data->phy_node->full_name,
+				slave->slave_num);
+			return;
+		}
+	} else {
 		slave->phy = phy_connect(priv->ndev, slave->data->phy_id,
 				 &cpsw_adjust_link, slave->data->phy_if);
-	if (IS_ERR(slave->phy)) {
-		dev_err(priv->dev, "phy %s not found on slave %d\n",
-			slave->data->phy_id, slave->slave_num);
-		slave->phy = NULL;
-	} else {
-		dev_info(priv->dev, "phy found : id is : 0x%x\n",
-			 slave->phy->phy_id);
-		phy_start(slave->phy);
-
-		/* Configure GMII_SEL register */
-		cpsw_phy_sel(&priv->pdev->dev, slave->phy->interface,
-			     slave->slave_num);
+		if (IS_ERR(slave->phy)) {
+			dev_err(priv->dev,
+				"phy \"%s\" not found on slave %d, err %ld\n",
+				slave->data->phy_id, slave->slave_num,
+				PTR_ERR(slave->phy));
+			slave->phy = NULL;
+			return;
+		}
 	}
+
+	dev_info(priv->dev, "phy found : id is : 0x%x\n", slave->phy->phy_id);
+
+	phy_start(slave->phy);
+
+	/* Configure GMII_SEL register */
+	cpsw_phy_sel(&priv->pdev->dev, slave->phy->interface, slave->slave_num);
 }
 
 static inline void cpsw_add_default_vlan(struct cpsw_priv *priv)


