Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934332AbeCBXJC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:09:02 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45066 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934297AbeCBXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:08:58 -0500
X-Google-Smtp-Source: AG47ELtogDV1sdS2HSYUgpd23rxEnjPvUtflNclt46mmLhBMtsNkzfSoejf2h7FuFdQF/eBZR81KiA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: david.laight@aculab.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH v2 3/4] net: phy: micrel: Use strlcpy() for ethtool::get_strings
Date: Fri,  2 Mar 2018 15:08:38 -0800
Message-Id: <20180302230839.31468-4-f.fainelli@gmail.com>
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

Fixes: 2b2427d06426 ("phy: micrel: Add ethtool statistics counters")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/micrel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 0f45310300f6..49be85afbea9 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -664,8 +664,8 @@ static void kszphy_get_strings(struct phy_device *phydev, u8 *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(kszphy_hw_stats); i++) {
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       kszphy_hw_stats[i].string, ETH_GSTRING_LEN);
+		strlcpy(data + i * ETH_GSTRING_LEN,
+			kszphy_hw_stats[i].string, ETH_GSTRING_LEN);
 	}
 }
 
-- 
2.14.1
