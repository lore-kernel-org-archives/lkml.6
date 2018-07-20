Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D4BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1577A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1577A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389788AbeGTN2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388413AbeGTN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:42 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E70C4C77;
        Fri, 20 Jul 2018 12:37:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Eli Cohen <eli@melloanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 020/101] net/mlx5e: Dont attempt to dereference the ppriv struct if not being eswitch manager
Date:   Fri, 20 Jul 2018 14:13:26 +0200
Message-Id: <20180720121423.818243055@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit 8ffd569aaa818f2624ca821d9a246342fa8b8c50 ]

The check for cpu hit statistics was not returning immediate false for
any non vport rep netdev and hence we crashed (say on mlx5 probed VFs) if
user-space tool was calling into any possible netdev in the system.

Fix that by doing a proper check before dereferencing.

Fixes: 1d447a39142e ('net/mlx5e: Extendable vport representor netdev private data')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reported-by: Eli Cohen <eli@melloanox.com>
Reviewed-by: Eli Cohen <eli@melloanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -804,8 +804,12 @@ bool mlx5e_is_uplink_rep(struct mlx5e_pr
 static bool mlx5e_is_vf_vport_rep(struct mlx5e_priv *priv)
 {
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
-	struct mlx5_eswitch_rep *rep = rpriv->rep;
+	struct mlx5_eswitch_rep *rep;
 
+	if (!MLX5_CAP_GEN(priv->mdev, eswitch_flow_table))
+		return false;
+
+	rep = rpriv->rep;
 	if (rep && rep->vport != FDB_UPLINK_VPORT)
 		return true;
 


