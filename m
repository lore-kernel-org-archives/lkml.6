Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeBLRkI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:40:08 -0500
Received: from gateway20.websitewelcome.com ([192.185.69.18]:35923 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752294AbeBLRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:40:06 -0500
Date: Mon, 12 Feb 2018 11:14:55 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] nbd: fix return value in error handling path
Message-ID: <20180212171450.GA31668@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1elHh3-002LrG-4V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:38938
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the proper value to return in this particular case is the
one contained into variable new_index instead of ret.

Addresses-Coverity-ID: 1465148 ("Copy-paste error")
Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5f2a424..86258b0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1591,7 +1591,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			if (new_index < 0) {
 				mutex_unlock(&nbd_index_mutex);
 				printk(KERN_ERR "nbd: failed to add new device\n");
-				return ret;
+				return new_index;
 			}
 			nbd = idr_find(&nbd_index_idr, new_index);
 		}
-- 
2.7.4
