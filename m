Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeCBXKh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:10:37 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44820 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbeCBXIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:08:55 -0500
X-Google-Smtp-Source: AG47ELvP5kWDHlILBaYiCaLf0lyNZ3MFWqID0ALlpvcKfgTrymJ3KNaHNnSr7WKoA2tMYI4vxb8DzQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: david.laight@aculab.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH v2 2/4] net: phy: marvell: Use strlcpy() for ethtool::get_strings
Date: Fri,  2 Mar 2018 15:08:37 -0800
Message-Id: <20180302230839.31468-3-f.fainelli@gmail.com>
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

Fixes: d2fa47d9dd5c ("phy: marvell: Add ethtool statistics counters")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/marvell.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 22d9bc9c33a4..0e0978d8a0eb 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1452,8 +1452,8 @@ static void marvell_get_strings(struct phy_device *phydev, u8 *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(marvell_hw_stats); i++) {
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       marvell_hw_stats[i].string, ETH_GSTRING_LEN);
+		strlcpy(data + i * ETH_GSTRING_LEN,
+			marvell_hw_stats[i].string, ETH_GSTRING_LEN);
 	}
 }
 
-- 
2.14.1
