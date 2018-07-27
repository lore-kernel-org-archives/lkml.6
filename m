Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064BEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE48620894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE48620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbeG0LWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbeG0LWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:12 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 566B5CBA;
        Fri, 27 Jul 2018 10:01:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 15/48] net/mlx5e: Fix quota counting in aRFS expire flow
Date:   Fri, 27 Jul 2018 12:00:00 +0200
Message-Id: <20180727095920.113745084@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 2630bae8018823c3b88788b69fb9f16ea3b4a11e ]

Quota should follow the amount of rules which do expire, and not the
number of rules that were examined, fixed that.

Fixes: 18c908e477dc ("net/mlx5e: Add accelerated RFS support")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -381,14 +381,14 @@ static void arfs_may_expire_flow(struct
 	HLIST_HEAD(del_list);
 	spin_lock_bh(&priv->fs.arfs.arfs_lock);
 	mlx5e_for_each_arfs_rule(arfs_rule, htmp, priv->fs.arfs.arfs_tables, i, j) {
-		if (quota++ > MLX5E_ARFS_EXPIRY_QUOTA)
-			break;
 		if (!work_pending(&arfs_rule->arfs_work) &&
 		    rps_may_expire_flow(priv->netdev,
 					arfs_rule->rxq, arfs_rule->flow_id,
 					arfs_rule->filter_id)) {
 			hlist_del_init(&arfs_rule->hlist);
 			hlist_add_head(&arfs_rule->hlist, &del_list);
+			if (quota++ > MLX5E_ARFS_EXPIRY_QUOTA)
+				break;
 		}
 	}
 	spin_unlock_bh(&priv->fs.arfs.arfs_lock);


