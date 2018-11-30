Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D618C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5C4214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5C4214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeK3UeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:34:14 -0500
Received: from mx.socionext.com ([202.248.49.38]:19593 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeK3UeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:34:14 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Nov 2018 18:25:32 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8C281180B47;
        Fri, 30 Nov 2018 18:25:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 30 Nov 2018 18:25:32 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CFCFB1A1210;
        Fri, 30 Nov 2018 18:25:31 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [RFC PATCH net v2] net: phy: Fix the issue that netif always links up after resuming
Date:   Fri, 30 Nov 2018 18:25:16 +0900
Message-Id: <1543569916-8714-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the link is down before entering hibernation,
there is an issue that the network interface always links up after resuming
from hibernation.

The phydev->state is PHY_READY before enabling the network interface, so
the link is down. After resuming from hibernation, the phydev->state is
forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.

This patch adds a new convenient function to check whether the PHY is in
a started state, and expects to solve the issue by changing phydev->state
to PHY_UP and calling phy_start_machine() only when the PHY is started.

Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/phy/phy.c        |  2 +-
 drivers/net/phy/phy_device.c |  9 +++++----
 include/linux/phy.h          | 10 ++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 1d73ac3..f484d03 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
 	cancel_delayed_work_sync(&phydev->state_queue);
 
 	mutex_lock(&phydev->lock);
-	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
+	if (phy_is_started(phydev))
 		phydev->state = PHY_UP;
 	mutex_unlock(&phydev->lock);
 }
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ab33d17..2c39717 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -309,10 +309,11 @@ static int mdio_bus_phy_restore(struct device *dev)
 		return ret;
 
 	/* The PHY needs to renegotiate. */
-	phydev->link = 0;
-	phydev->state = PHY_UP;
-
-	phy_start_machine(phydev);
+	if (phy_is_started(phydev)) {
+		phydev->link = 0;
+		phydev->state = PHY_UP;
+		phy_start_machine(phydev);
+	}
 
 	return 0;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3ea87f7..c194b45 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -898,6 +898,16 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
 }
 
 /**
+ * phy_is_started - Convenience function for testing whether a PHY is in
+ * a started state
+ * @phydev: the phy_device struct
+ */
+static inline bool phy_is_started(struct phy_device *phydev)
+{
+	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
+}
+
+/**
  * phy_write_mmd - Convenience function for writing a register
  * on an MMD on a given PHY.
  * @phydev: The phy_device struct
-- 
2.7.4

