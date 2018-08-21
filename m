Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFFEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C687721774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C687721774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeHUJmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:42:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54954 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:42:53 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16BED516;
        Tue, 21 Aug 2018 06:24:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 11/42] mlxsw: core_acl_flex_actions: Remove redundant resource destruction
Date:   Tue, 21 Aug 2018 08:20:43 +0200
Message-Id: <20180821055018.164841756@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit dda0a3a3fb92451d4a922e56365ee1f73c8a9586 ]

Some ACL actions require the allocation of a separate resource
prior to applying the action itself. When facing an error condition
during the setup phase of the action, resource should be destroyed.
For such actions the destruction was done twice which is dangerous
and lead to a potential crash.
The destruction took place first upon error on action setup phase
and then as the rule was destroyed.

The following sequence generated a crash:

 # tc qdisc add dev swp49 ingress
 # tc filter add dev swp49 parent ffff: \
   protocol ip chain 100 pref 10 \
   flower skip_sw dst_ip 192.168.101.1 action drop
 # tc filter add dev swp49 parent ffff: \
   protocol ip pref 10 \
   flower skip_sw dst_ip 192.168.101.1 action goto chain 100 \
   action mirred egress mirror dev swp4

Therefore add mlxsw_afa_resource_del() as a complement of
mlxsw_afa_resource_add() to add symmetry to resource_list membership
handling. Call this from mlxsw_afa_fwd_entry_ref_destroy() to make the
_fwd_entry_ref_create() and _fwd_entry_ref_destroy() pair of calls a
NOP.

Fixes: 140ce421217e ("mlxsw: core: Convert fwd_entry_ref list to be generic per-block resource list")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -327,12 +327,16 @@ static void mlxsw_afa_resource_add(struc
 	list_add(&resource->list, &block->resource_list);
 }
 
+static void mlxsw_afa_resource_del(struct mlxsw_afa_resource *resource)
+{
+	list_del(&resource->list);
+}
+
 static void mlxsw_afa_resources_destroy(struct mlxsw_afa_block *block)
 {
 	struct mlxsw_afa_resource *resource, *tmp;
 
 	list_for_each_entry_safe(resource, tmp, &block->resource_list, list) {
-		list_del(&resource->list);
 		resource->destructor(block, resource);
 	}
 }
@@ -530,6 +534,7 @@ static void
 mlxsw_afa_fwd_entry_ref_destroy(struct mlxsw_afa_block *block,
 				struct mlxsw_afa_fwd_entry_ref *fwd_entry_ref)
 {
+	mlxsw_afa_resource_del(&fwd_entry_ref->resource);
 	mlxsw_afa_fwd_entry_put(block->afa, fwd_entry_ref->fwd_entry);
 	kfree(fwd_entry_ref);
 }


