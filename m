Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F93B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F93B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeIMSmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:42:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeIMSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:42:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1E6ACF3;
        Thu, 13 Sep 2018 13:32:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 03/60] net: bcmgenet: use MAC link status for fixed phy
Date:   Thu, 13 Sep 2018 15:30:10 +0200
Message-Id: <20180913131745.439674818@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
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

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit c3c397c1f16c51601a3fac4fe0c63ad8aa85a904 ]

When using the fixed PHY with GENET (e.g. MOCA) the PHY link
status can be determined from the internal link status captured
by the MAC. This allows the PHY state machine to use the correct
link state with the fixed PHY even if MAC link event interrupts
are missed when the net device is opened.

Fixes: 8d88c6ebb34c ("net: bcmgenet: enable MoCA link state change detection")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |    3 +++
 drivers/net/ethernet/broadcom/genet/bcmmii.c   |   10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -185,6 +185,9 @@ struct bcmgenet_mib_counters {
 #define UMAC_MAC1			0x010
 #define UMAC_MAX_FRAME_LEN		0x014
 
+#define UMAC_MODE			0x44
+#define  MODE_LINK_STATUS		(1 << 5)
+
 #define UMAC_EEE_CTRL			0x064
 #define  EN_LPI_RX_PAUSE		(1 << 0)
 #define  EN_LPI_TX_PFC			(1 << 1)
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -167,8 +167,14 @@ void bcmgenet_mii_setup(struct net_devic
 static int bcmgenet_fixed_phy_link_update(struct net_device *dev,
 					  struct fixed_phy_status *status)
 {
-	if (dev && dev->phydev && status)
-		status->link = dev->phydev->link;
+	struct bcmgenet_priv *priv;
+	u32 reg;
+
+	if (dev && dev->phydev && status) {
+		priv = netdev_priv(dev);
+		reg = bcmgenet_umac_readl(priv, UMAC_MODE);
+		status->link = !!(reg & MODE_LINK_STATUS);
+	}
 
 	return 0;
 }


