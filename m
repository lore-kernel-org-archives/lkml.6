Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386AEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2A321774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2A321774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeHUJnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:00 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6D16516;
        Tue, 21 Aug 2018 06:24:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 13/42] mlxsw: core_acl_flex_actions: Remove redundant mirror resource destruction
Date:   Tue, 21 Aug 2018 08:20:45 +0200
Message-Id: <20180821055018.278017577@linuxfoundation.org>
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

[ Upstream commit caebd1b389708bf3d0465be829480fc706a68720 ]

In previous patch mlxsw_afa_resource_del() was added to avoid a duplicate
resource detruction scenario.
For mirror actions, such duplicate destruction leads to a crash as in:

 # tc qdisc add dev swp49 ingress
 # tc filter add dev swp49 parent ffff: \
   protocol ip chain 100 pref 10 \
   flower skip_sw dst_ip 192.168.101.1 action drop
 # tc filter add dev swp49 parent ffff: \
   protocol ip pref 10 \
   flower skip_sw dst_ip 192.168.101.1 action goto chain 100 \
   action mirred egress mirror dev swp4

Therefore add a call to mlxsw_afa_resource_del() in
mlxsw_afa_mirror_destroy() in order to clear that resource
from rule's resources.

Fixes: d0d13c1858a1 ("mlxsw: spectrum_acl: Add support for mirror action")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -862,6 +862,7 @@ static void
 mlxsw_afa_mirror_destroy(struct mlxsw_afa_block *block,
 			 struct mlxsw_afa_mirror *mirror)
 {
+	mlxsw_afa_resource_del(&mirror->resource);
 	block->afa->ops->mirror_del(block->afa->ops_priv,
 				    mirror->local_in_port,
 				    mirror->span_id,


