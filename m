Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871AEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbeGTN1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:27:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbeGTN1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:27:09 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6DB73C9A;
        Fri, 20 Jul 2018 12:38:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 055/101] IB/mlx5: Avoid dealing with vport representors if not being e-switch manager
Date:   Fri, 20 Jul 2018 14:14:01 +0200
Message-Id: <20180720121425.420082736@linuxfoundation.org>
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

[ Upstream commit aff2252a2ad3844ca47bf2f18af071101baace40 ]

In smartnic env, the host (PF) driver might not be an e-switch
manager, hence the switchdev mode representors are running on
the embedded cpu (EC) and not at the host.

As such, we should avoid dealing with vport representors if
not being esw manager.

Fixes: b5ca15ad7e61 ('IB/mlx5: Add proper representors support')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5736,7 +5736,7 @@ static void *mlx5_ib_add(struct mlx5_cor
 	dev->num_ports = max(MLX5_CAP_GEN(mdev, num_ports),
 			     MLX5_CAP_GEN(mdev, num_vhca_ports));
 
-	if (MLX5_VPORT_MANAGER(mdev) &&
+	if (MLX5_ESWITCH_MANAGER(mdev) &&
 	    mlx5_ib_eswitch_mode(mdev->priv.eswitch) == SRIOV_OFFLOADS) {
 		dev->rep = mlx5_ib_vport_rep(mdev->priv.eswitch, 0);
 


