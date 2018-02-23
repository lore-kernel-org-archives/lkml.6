Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeBWPZv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:25:51 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42570 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeBWPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:25:49 -0500
X-Google-Smtp-Source: AH8x227pFIYNBUVDOJo3KzrgOAcwqrPYTRigyMkr8NknHniuDqMfqL4t4aMfWtGnYW/fYUOb/bbv5g==
From: Richard Cochran <richardcochran@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH net-next] net: phylink: Remove redundant netdev.phydev assignment
Date: Fri, 23 Feb 2018 07:25:46 -0800
Message-Id: <20180223152546.13354-1-richardcochran@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of working on MII time stamping infrastructure, I was trying
to figure out how netdev->phydev gets assigned, and I stumbled across
this.  Ever since the new phylink code came in, the field is assigned
twice.

The function, phylink_connect_phy(), calls

	phy_attach_direct()
	phylink_bringup_phy()

and phy_attach_direct() sets

	dev->phydev = phydev;

but phylink_bringup_phy() then sets the same field again:

	pl->netdev->phydev = phy;

Similarly, the function, phylink_of_phy_connect(), calls

	of_phy_attach()
		phy_attach_direct()
	phylink_bringup_phy()

The removal code is also duplicated:

phylink_disconnect_phy()
	pl->netdev->phydev = NULL;
	phy_disconnect()
		phy_detach()
			phydev->attached_dev->phydev = NULL;

This patch removes the redundant assignments, restricting manipulation
of the netdev.phydev field to phy_attach_direct() and phy_detach().

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/phy/phylink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6ac8b29b2dc3..867ffd654daf 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -679,7 +679,6 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy)
 
 	mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
-	pl->netdev->phydev = phy;
 	pl->phydev = phy;
 	linkmode_copy(pl->supported, supported);
 	linkmode_copy(pl->link_config.advertising, config.advertising);
@@ -817,7 +816,6 @@ void phylink_disconnect_phy(struct phylink *pl)
 	if (phy) {
 		mutex_lock(&phy->lock);
 		mutex_lock(&pl->state_mutex);
-		pl->netdev->phydev = NULL;
 		pl->phydev = NULL;
 		mutex_unlock(&pl->state_mutex);
 		mutex_unlock(&phy->lock);
-- 
2.11.0
