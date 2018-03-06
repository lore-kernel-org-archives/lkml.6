Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbeCFTMO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:12:14 -0500
Received: from gateway30.websitewelcome.com ([192.185.147.85]:25108 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753823AbeCFTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:12:10 -0500
Date: Tue, 6 Mar 2018 12:47:55 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [RFC] netfilter: cttimeout: remove VLA in ctnl_timeout_parse_policy
Message-ID: <20180306184755.GA7628@embeddedgus>
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
X-Exim-ID: 1etHd3-004NRO-8T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:37144
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/netfilter/nfnetlink_cttimeout.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 95b0470..a2f7d92 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -52,18 +52,26 @@ ctnl_timeout_parse_policy(void *timeouts,
 			  struct net *net, const struct nlattr *attr)
 {
 	int ret = 0;
+	struct nlattr **tb = NULL;
 
 	if (likely(l4proto->ctnl_timeout.nlattr_to_obj)) {
-		struct nlattr *tb[l4proto->ctnl_timeout.nlattr_max+1];
+		tb = kcalloc(l4proto->ctnl_timeout.nlattr_max + 1, sizeof(*tb),
+			     GFP_KERNEL);
+
+		if (!tb)
+			return -ENOMEM;
 
 		ret = nla_parse_nested(tb, l4proto->ctnl_timeout.nlattr_max,
 				       attr, l4proto->ctnl_timeout.nla_policy,
 				       NULL);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		ret = l4proto->ctnl_timeout.nlattr_to_obj(tb, net, timeouts);
 	}
+
+err:
+	kfree(tb);
 	return ret;
 }
 
-- 
2.7.4
