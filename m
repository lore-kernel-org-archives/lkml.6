Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeD3BcX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 21:32:23 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:35236 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753514AbeD3BcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 21:32:22 -0400
X-Google-Smtp-Source: AB8JxZpODi7zOIXt0hsa/QtJPT+edvhtjZSytOwvBQCzhTCUQi99dhVJ7j0rGVRcw9sW+/cilPD88g==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Edward Cree <ecree@solarflare.com>, Inbar Karmy <inbark@mellanox.com>,
        Eugenia Emantayev <eugenia@mellanox.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Vidya Sagar Ravipati <vidya.chowdary@gmail.com>,
        Alan Brady <alan.brady@intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ethtool: fix a potential missing-check bug
Date: Sun, 29 Apr 2018 20:31:54 -0500
Message-Id: <1525051915-31944-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ethtool_get_rxnfc(), the object "info" is firstly copied from
user-space. If the FLOW_RSS flag is set in the member field flow_type of
"info" (and cmd is ETHTOOL_GRXFH), info needs to be copied again from
user-space because FLOW_RSS is newer and has new definition, as mentioned
in the comment. However, given that the user data resides in user-space, a
malicious user can race to change the data after the first copy. By doing
so, the user can inject inconsistent data. For example, in the second
copy, the FLOW_RSS flag could be cleared in the field flow_type of "info".
In the following execution, "info" will be used in the function
ops->get_rxnfc(). Such inconsistent data can potentially lead to unexpected
information leakage since ops->get_rxnfc() will prepare various types of
data according to flow_type, and the prepared data will be eventually
copied to user-space. This inconsistent data may also cause undefined
behaviors based on how ops->get_rxnfc() is implemented.

This patch re-verifies the flow_type field of "info" after the second copy.
If the value is not as expected, an error code will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/core/ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 03416e6..a121034 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1032,6 +1032,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 		info_size = sizeof(info);
 		if (copy_from_user(&info, useraddr, info_size))
 			return -EFAULT;
+		if (!(info.flow_type & FLOW_RSS))
+			return -EINVAL;
 	}
 
 	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
-- 
2.7.4
