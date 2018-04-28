Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbeD1AeG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:34:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35988 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933277AbeD1Acz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:55 -0400
X-Google-Smtp-Source: AB8JxZoTVLAQLufKlwUQ8+BfVaffkZh1l/MxkTZg1H9qVkJ9U6ZRzw1Zk+iun/WPg/mLNqCAYMNNnQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [RFC net-next 5/5] net: phy: broadcom: Add support for PHY test modes
Date: Fri, 27 Apr 2018 17:32:35 -0700
Message-Id: <20180428003237.1536-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-use the generic PHY library test modes for 100BaseT2 and 1000BaseT
and advertise support for those through the newly added ethtool knobs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/bcm-phy-lib.c | 15 +++++++++------
 drivers/net/phy/bcm7xxx.c     |  3 +++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index e797e0863895..cb3081e523a5 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -334,6 +334,8 @@ int bcm_phy_get_sset_count(struct phy_device *phydev, int sset)
 {
 	if (sset == ETH_SS_PHY_STATS)
 		return ARRAY_SIZE(bcm_phy_hw_stats);
+	else if (sset == ETH_SS_PHY_TESTS)
+		return genphy_get_test_count(phydev);
 
 	return -EOPNOTSUPP;
 }
@@ -343,12 +345,13 @@ void bcm_phy_get_strings(struct phy_device *phydev, u32 stringset, u8 *data)
 {
 	unsigned int i;
 
-	if (stringset != ETH_SS_PHY_STATS)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(bcm_phy_hw_stats); i++)
-		strlcpy(data + i * ETH_GSTRING_LEN,
-			bcm_phy_hw_stats[i].string, ETH_GSTRING_LEN);
+	if (stringset == ETH_SS_PHY_STATS) {
+		for (i = 0; i < ARRAY_SIZE(bcm_phy_hw_stats); i++)
+			strlcpy(data + i * ETH_GSTRING_LEN,
+				bcm_phy_hw_stats[i].string, ETH_GSTRING_LEN);
+	} else if (stringset == ETH_SS_PHY_TESTS) {
+		genphy_get_test_strings(phydev, data);
+	}
 }
 EXPORT_SYMBOL_GPL(bcm_phy_get_strings);
 
diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 1835af147eea..1efd287ed320 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -619,6 +619,9 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 	.get_sset_count	= bcm_phy_get_sset_count,			\
 	.get_strings	= bcm_phy_get_strings,				\
 	.get_stats	= bcm7xxx_28nm_get_phy_stats,			\
+	.set_test	= genphy_set_test,				\
+	.get_test	= genphy_get_test,				\
+	.get_test_len	= genphy_get_test_len,				\
 	.probe		= bcm7xxx_28nm_probe,				\
 }
 
-- 
2.14.1
