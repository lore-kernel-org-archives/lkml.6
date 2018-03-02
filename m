Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934357AbeCBXJW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:09:22 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40535 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeCBXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:09:00 -0500
X-Google-Smtp-Source: AG47ELs9eGRopixhW3VF1r6EdY2InNLGHYjc6lfHRX8lI5iUBBkv3uyYjRdg5d44T0URohlh3ADwEg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: david.laight@aculab.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH v2 4/4] net: phy: broadcom: Use strlcpy() for ethtool::get_strings
Date: Fri,  2 Mar 2018 15:08:39 -0800
Message-Id: <20180302230839.31468-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302230839.31468-1-f.fainelli@gmail.com>
References: <20180302230839.31468-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our statistics strings are allocated at initialization without being
bound to a specific size, yet, we would copy ETH_GSTRING_LEN bytes using
memcpy() which would create out of bounds accesses, this was flagged by
KASAN. Replace this with strlcpy() to make sure we are bound the source
buffer size and we also always NUL-terminate strings.

Fixes: 820ee17b8d3b ("net: phy: broadcom: Add support code for reading PHY counters")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/bcm-phy-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 171010eb4d9c..5ad130c3da43 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -341,8 +341,8 @@ void bcm_phy_get_strings(struct phy_device *phydev, u8 *data)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(bcm_phy_hw_stats); i++)
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       bcm_phy_hw_stats[i].string, ETH_GSTRING_LEN);
+		strlcpy(data + i * ETH_GSTRING_LEN,
+			bcm_phy_hw_stats[i].string, ETH_GSTRING_LEN);
 }
 EXPORT_SYMBOL_GPL(bcm_phy_get_strings);
 
-- 
2.14.1
