Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAE320866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbfAOXOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:14:34 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.218]:30030 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728858AbfAOXOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:14:33 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id EB90D13BE0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 17:14:32 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jXuigklkq90onjXuigDaUl; Tue, 15 Jan 2019 17:14:32 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=56030 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gjXui-002jld-3n; Tue, 15 Jan 2019 17:14:32 -0600
Date:   Tue, 15 Jan 2019 17:14:29 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] mlxsw: spectrum_nve: Use struct_size() in kzalloc()
Message-ID: <20190115231429.GA25525@embeddedor>
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
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gjXui-002jld-3n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:56030
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
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

instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
index fb1c48c698f2..9019548d731b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -267,8 +267,8 @@ mlxsw_sp_nve_mc_record_create(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_nve_mc_record *mc_record;
 	int err;
 
-	mc_record = kzalloc(sizeof(*mc_record) + num_max_entries *
-			    sizeof(struct mlxsw_sp_nve_mc_entry), GFP_KERNEL);
+	mc_record = kzalloc(struct_size(mc_record, entries, num_max_entries),
+			    GFP_KERNEL);
 	if (!mc_record)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.20.1

