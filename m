Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeEKX33 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 19:29:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38649 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbeEKX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 19:29:27 -0400
X-Google-Smtp-Source: AB8JxZpmiT1q9ypFyiSs4RtCl5cRRDnlbAcg63O7kf/KXiyxQSQJBEA+Bf2wAWic6Ap9cH9YaDGRYg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite for last rule
Date: Fri, 11 May 2018 16:24:58 -0700
Message-Id: <20180511232459.15980-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we let the kernel pick up a rule location with RX_CLS_LOC_ANY, we
would be able to overwrite the last rules because of a number of issues:

- the IPv4 code path would not be checking that rule_index is within
  bounds, the IPv6 code path would only be checking the second index and
  not the first one

- find_first_zero_bit() needs to operate on the full bitmap size
  (priv->num_cfp_rules) otherwise it would be off by one in the results
  it returns and the checks against bcm_sf2_cfp_rule_size() would be non
  functioning

Fixes: 3306145866b6 ("net: dsa: bcm_sf2: Move IPv4 CFP processing to specific functions")
Fixes: ba0696c22e7c ("net: dsa: bcm_sf2: Add support for IPv6 CFP rules")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2_cfp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index 23b45da784cb..ade5fa3d747d 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -354,10 +354,13 @@ static int bcm_sf2_cfp_ipv4_rule_set(struct bcm_sf2_priv *priv, int port,
 	/* Locate the first rule available */
 	if (fs->location == RX_CLS_LOC_ANY)
 		rule_index = find_first_zero_bit(priv->cfp.used,
-						 bcm_sf2_cfp_rule_size(priv));
+						 priv->num_cfp_rules);
 	else
 		rule_index = fs->location;
 
+	if (rule_index > bcm_sf2_cfp_rule_size(priv))
+		return -ENOSPC;
+
 	layout = &udf_tcpip4_layout;
 	/* We only use one UDF slice for now */
 	slice_num = bcm_sf2_get_slice_number(layout, 0);
@@ -563,9 +566,11 @@ static int bcm_sf2_cfp_ipv6_rule_set(struct bcm_sf2_priv *priv, int port,
 	 */
 	if (fs->location == RX_CLS_LOC_ANY)
 		rule_index[0] = find_first_zero_bit(priv->cfp.used,
-						    bcm_sf2_cfp_rule_size(priv));
+						    priv->num_cfp_rules);
 	else
 		rule_index[0] = fs->location;
+	if (rule_index[0] > bcm_sf2_cfp_rule_size(priv))
+		return -ENOSPC;
 
 	/* Flag it as used (cleared on error path) such that we can immediately
 	 * obtain a second one to chain from.
@@ -573,7 +578,7 @@ static int bcm_sf2_cfp_ipv6_rule_set(struct bcm_sf2_priv *priv, int port,
 	set_bit(rule_index[0], priv->cfp.used);
 
 	rule_index[1] = find_first_zero_bit(priv->cfp.used,
-					    bcm_sf2_cfp_rule_size(priv));
+					    priv->num_cfp_rules);
 	if (rule_index[1] > bcm_sf2_cfp_rule_size(priv)) {
 		ret = -ENOSPC;
 		goto out_err;
-- 
2.14.1
