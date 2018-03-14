Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeCNIHe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:07:34 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:20949 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752592AbeCNIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:07:31 -0400
Date: Wed, 14 Mar 2018 03:07:27 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
        Wang Jian <jianjian.wang1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pktgen: Fix memory leak in pktgen_if_write
Message-ID: <20180314080727.GA17319@embeddedgus>
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
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1ew1Ra-004MAO-77
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:39748
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_buf_ is an array and the one that must be freed is _tp_ instead.

Fixes: a870a02cc963 ("pktgen: use dynamic allocation for debug print buffer")
Reported-by: Wang Jian <jianjian.wang1@gmail.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/core/pktgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index fd65761..545cf08 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -913,7 +913,7 @@ static ssize_t pktgen_if_write(struct file *file,
 			return PTR_ERR(tp);
 
 		pr_debug("%s,%zu  buffer -:%s:-\n", name, count, tp);
-		kfree(buf);
+		kfree(tp);
 	}
 
 	if (!strcmp(name, "min_pkt_size")) {
-- 
2.7.4
