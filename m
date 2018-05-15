Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeEOXCk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:02:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45274 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752386AbeEOXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:02:03 -0400
X-Google-Smtp-Source: AB8JxZrgCYoybayAtMRhrJNPlGYFd0Z10cN7dU02dtoxh1vPEplyrMLDswOde6RamBsPVtrAvj4KXA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH net v2 2/3] net: dsa: bcm_sf2: Fix IPv6 rules and chain ID
Date: Tue, 15 May 2018 16:01:24 -0700
Message-Id: <20180515230125.25886-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515230125.25886-1-f.fainelli@gmail.com>
References: <20180515230125.25886-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had several issues that would make the programming of IPv6 rules both
inconsistent and error prone:

- the chain ID that we would be asking the hardware to put in the
  packet's Broadcom tag would be off by one, it would return one of the
  two indexes, but not the one user-space specified

- when an user specified a particular location to insert a CFP rule at,
  we would not be returning the same index, which would be confusing if
  nothing else

- finally, like IPv4, it would be possible to overflow the last entry by
  re-programming it

Fix this by swapping the usage of rule_index[0] and rule_index[1] where
relevant in order to return a consistent and correct user-space
experience.

Fixes: ba0696c22e7c ("net: dsa: bcm_sf2: Add support for IPv6 CFP rules")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2_cfp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index 9e04786e3139..6fd0f8a12cc2 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -565,19 +565,21 @@ static int bcm_sf2_cfp_ipv6_rule_set(struct bcm_sf2_priv *priv, int port,
 	 * first half because the HW search is by incrementing addresses.
 	 */
 	if (fs->location == RX_CLS_LOC_ANY)
-		rule_index[0] = find_first_zero_bit(priv->cfp.used,
-						    bcm_sf2_cfp_rule_size(priv));
+		rule_index[1] = find_first_zero_bit(priv->cfp.used,
+						    priv->num_cfp_rules);
 	else
-		rule_index[0] = fs->location;
+		rule_index[1] = fs->location;
+	if (rule_index[1] > bcm_sf2_cfp_rule_size(priv))
+		return -ENOSPC;
 
 	/* Flag it as used (cleared on error path) such that we can immediately
 	 * obtain a second one to chain from.
 	 */
-	set_bit(rule_index[0], priv->cfp.used);
+	set_bit(rule_index[1], priv->cfp.used);
 
-	rule_index[1] = find_first_zero_bit(priv->cfp.used,
-					    bcm_sf2_cfp_rule_size(priv));
-	if (rule_index[1] > bcm_sf2_cfp_rule_size(priv)) {
+	rule_index[0] = find_first_zero_bit(priv->cfp.used,
+					    priv->num_cfp_rules);
+	if (rule_index[0] > bcm_sf2_cfp_rule_size(priv)) {
 		ret = -ENOSPC;
 		goto out_err;
 	}
@@ -715,14 +717,14 @@ static int bcm_sf2_cfp_ipv6_rule_set(struct bcm_sf2_priv *priv, int port,
 	/* Flag the second half rule as being used now, return it as the
 	 * location, and flag it as unique while dumping rules
 	 */
-	set_bit(rule_index[1], priv->cfp.used);
+	set_bit(rule_index[0], priv->cfp.used);
 	set_bit(rule_index[1], priv->cfp.unique);
 	fs->location = rule_index[1];
 
 	return ret;
 
 out_err:
-	clear_bit(rule_index[0], priv->cfp.used);
+	clear_bit(rule_index[1], priv->cfp.used);
 	return ret;
 }
 
-- 
2.14.1
