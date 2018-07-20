Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8526CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EB920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EB920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbeGTN3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:29:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389097AbeGTN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:29:02 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2322DCA5;
        Fri, 20 Jul 2018 12:38:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Cohen <eli@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 024/101] net/mlx5: Fix required capability for manipulating MPFS
Date:   Fri, 20 Jul 2018 14:13:30 +0200
Message-Id: <20180720121423.985118722@linuxfoundation.org>
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

From: Eli Cohen <eli@mellanox.com>

[ Upstream commit f811980444ec59ad62f9e041adbb576a821132c7 ]

Manipulating of the MPFS requires eswitch manager capabilities.

Fixes: eeb66cdb6826 ('net/mlx5: Separate between E-Switch and MPFS')
Signed-off-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
@@ -33,6 +33,7 @@
 #include <linux/etherdevice.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/mlx5_ifc.h>
+#include <linux/mlx5/eswitch.h>
 #include "mlx5_core.h"
 #include "lib/mpfs.h"
 
@@ -98,7 +99,7 @@ int mlx5_mpfs_init(struct mlx5_core_dev
 	int l2table_size = 1 << MLX5_CAP_GEN(dev, log_max_l2_table);
 	struct mlx5_mpfs *mpfs;
 
-	if (!MLX5_VPORT_MANAGER(dev))
+	if (!MLX5_ESWITCH_MANAGER(dev))
 		return 0;
 
 	mpfs = kzalloc(sizeof(*mpfs), GFP_KERNEL);
@@ -122,7 +123,7 @@ void mlx5_mpfs_cleanup(struct mlx5_core_
 {
 	struct mlx5_mpfs *mpfs = dev->priv.mpfs;
 
-	if (!MLX5_VPORT_MANAGER(dev))
+	if (!MLX5_ESWITCH_MANAGER(dev))
 		return;
 
 	WARN_ON(!hlist_empty(mpfs->hash));
@@ -137,7 +138,7 @@ int mlx5_mpfs_add_mac(struct mlx5_core_d
 	u32 index;
 	int err;
 
-	if (!MLX5_VPORT_MANAGER(dev))
+	if (!MLX5_ESWITCH_MANAGER(dev))
 		return 0;
 
 	mutex_lock(&mpfs->lock);
@@ -179,7 +180,7 @@ int mlx5_mpfs_del_mac(struct mlx5_core_d
 	int err = 0;
 	u32 index;
 
-	if (!MLX5_VPORT_MANAGER(dev))
+	if (!MLX5_ESWITCH_MANAGER(dev))
 		return 0;
 
 	mutex_lock(&mpfs->lock);


