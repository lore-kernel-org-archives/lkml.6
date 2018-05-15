Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeEOXCU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:02:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37710 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbeEOXCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:02:04 -0400
X-Google-Smtp-Source: AB8JxZofdasey0/kGe/Gt0hxj4xiVa5OHX0+q+iWkKKbSK0n+XlOJFHIlDw9jw1j/KVxydJXqfO9kA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH net v2 3/3] net: dsa: bcm_sf2: Fix IPv6 rule half deletion
Date: Tue, 15 May 2018 16:01:25 -0700
Message-Id: <20180515230125.25886-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515230125.25886-1-f.fainelli@gmail.com>
References: <20180515230125.25886-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was possible to delete only one half of an IPv6, which would leave
the second half still programmed and possibly in use. Instead of
checking for the unused bitmap, we need to check the unique bitmap, and
refuse any deletion that does not match that criteria. We also need to
move that check from bcm_sf2_cfp_rule_del_one() into its caller:
bcm_sf2_cfp_rule_del() otherwise we would not be able to delete second
halves anymore that would not pass the first test.

Fixes: ba0696c22e7c ("net: dsa: bcm_sf2: Add support for IPv6 CFP rules")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2_cfp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index 6fd0f8a12cc2..b89acaee12d4 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -790,10 +790,6 @@ static int bcm_sf2_cfp_rule_del_one(struct bcm_sf2_priv *priv, int port,
 	int ret;
 	u32 reg;
 
-	/* Refuse deletion of unused rules, and the default reserved rule */
-	if (!test_bit(loc, priv->cfp.used) || loc == 0)
-		return -EINVAL;
-
 	/* Indicate which rule we want to read */
 	bcm_sf2_cfp_rule_addr_set(priv, loc);
 
@@ -831,6 +827,13 @@ static int bcm_sf2_cfp_rule_del(struct bcm_sf2_priv *priv, int port,
 	u32 next_loc = 0;
 	int ret;
 
+	/* Refuse deleting unused rules, and those that are not unique since
+	 * that could leave IPv6 rules with one of the chained rule in the
+	 * table.
+	 */
+	if (!test_bit(loc, priv->cfp.unique) || loc == 0)
+		return -EINVAL;
+
 	ret = bcm_sf2_cfp_rule_del_one(priv, port, loc, &next_loc);
 	if (ret)
 		return ret;
-- 
2.14.1
