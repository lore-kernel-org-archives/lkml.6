Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D81C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCB221907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBHDmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 22:42:45 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.5]:45715 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbfBHDmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 22:42:45 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 080BD265381
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 21:42:44 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rx3rgVvBu2PzOrx3sg200E; Thu, 07 Feb 2019 21:42:44 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=49408 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1grx3r-001met-8v; Thu, 07 Feb 2019 21:42:43 -0600
Date:   Thu, 7 Feb 2019 21:42:41 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] mlxsw: spectrum_router: Use struct_size() in
 kzalloc()
Message-ID: <20190208034241.GA11858@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1grx3r-001met-8v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:49408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 30
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)

Notice that, in this case, variable alloc_size is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c    | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 230e1f6e192b..e3a3535f9f23 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3813,13 +3813,11 @@ mlxsw_sp_nexthop4_group_create(struct mlxsw_sp *mlxsw_sp, struct fib_info *fi)
 	struct mlxsw_sp_nexthop_group *nh_grp;
 	struct mlxsw_sp_nexthop *nh;
 	struct fib_nh *fib_nh;
-	size_t alloc_size;
 	int i;
 	int err;
 
-	alloc_size = sizeof(*nh_grp) +
-		     fi->fib_nhs * sizeof(struct mlxsw_sp_nexthop);
-	nh_grp = kzalloc(alloc_size, GFP_KERNEL);
+	nh_grp = kzalloc(struct_size(nh_grp, nexthops, fi->fib_nhs),
+			 GFP_KERNEL);
 	if (!nh_grp)
 		return ERR_PTR(-ENOMEM);
 	nh_grp->priv = fi;
@@ -5045,13 +5043,11 @@ mlxsw_sp_nexthop6_group_create(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_nexthop_group *nh_grp;
 	struct mlxsw_sp_rt6 *mlxsw_sp_rt6;
 	struct mlxsw_sp_nexthop *nh;
-	size_t alloc_size;
 	int i = 0;
 	int err;
 
-	alloc_size = sizeof(*nh_grp) +
-		     fib6_entry->nrt6 * sizeof(struct mlxsw_sp_nexthop);
-	nh_grp = kzalloc(alloc_size, GFP_KERNEL);
+	nh_grp = kzalloc(struct_size(nh_grp, nexthops, fib6_entry->nrt6),
+			 GFP_KERNEL);
 	if (!nh_grp)
 		return ERR_PTR(-ENOMEM);
 	INIT_LIST_HEAD(&nh_grp->fib_list);
-- 
2.20.1

