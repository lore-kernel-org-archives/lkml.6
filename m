Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeCMDQU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 23:16:20 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.250]:13192 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932294AbeCMDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 23:16:19 -0400
Date: Mon, 12 Mar 2018 22:16:17 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] netfilter: nf_tables: remove VLA usage
Message-ID: <20180313031617.GA2204@embeddedgus>
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
X-Exim-ID: 1evaQE-0031A3-Br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:49622
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation.

>From a security viewpoint, the use of Variable Length Arrays can be
a vector for stack overflow attacks. Also, in general, as the code
evolves it is easy to lose track of how big a VLA can get. Thus, we
can end up having segfaults that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Use kmalloc_array instead of kcalloc.

 net/netfilter/nf_tables_api.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3f815b6..5a42e97 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4357,16 +4357,20 @@ static struct nft_object *nft_obj_init(const struct nft_ctx *ctx,
 				       const struct nft_object_type *type,
 				       const struct nlattr *attr)
 {
-	struct nlattr *tb[type->maxattr + 1];
+	struct nlattr **tb;
 	const struct nft_object_ops *ops;
 	struct nft_object *obj;
-	int err;
+	int err = -ENOMEM;
+
+	tb = kmalloc_array(type->maxattr + 1, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		goto err1;
 
 	if (attr) {
 		err = nla_parse_nested(tb, type->maxattr, attr, type->policy,
 				       NULL);
 		if (err < 0)
-			goto err1;
+			goto err2;
 	} else {
 		memset(tb, 0, sizeof(tb[0]) * (type->maxattr + 1));
 	}
@@ -4375,7 +4379,7 @@ static struct nft_object *nft_obj_init(const struct nft_ctx *ctx,
 		ops = type->select_ops(ctx, (const struct nlattr * const *)tb);
 		if (IS_ERR(ops)) {
 			err = PTR_ERR(ops);
-			goto err1;
+			goto err2;
 		}
 	} else {
 		ops = type->ops;
@@ -4383,18 +4387,21 @@ static struct nft_object *nft_obj_init(const struct nft_ctx *ctx,
 
 	err = -ENOMEM;
 	obj = kzalloc(sizeof(*obj) + ops->size, GFP_KERNEL);
-	if (obj == NULL)
-		goto err1;
+	if (!obj)
+		goto err2;
 
 	err = ops->init(ctx, (const struct nlattr * const *)tb, obj);
 	if (err < 0)
-		goto err2;
+		goto err3;
 
 	obj->ops = ops;
 
+	kfree(tb);
 	return obj;
-err2:
+err3:
 	kfree(obj);
+err2:
+	kfree(tb);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.7.4
