Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C212C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EED32070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865319;
	bh=iBs1IwAJBG9j6wZ0S40T6jmm7tFX7mbpiRpdcI5jWyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q32E3j3yIwTNNVZMBmTuKCDnQVSODDax+7x0P9opcPlkgbW8DyUYLkWB9w19A8yb1
	 74KPUApyGGqxZmaztlA5prdVFNn1n9ucCFZRoY6ADIGiMG5sPo5w+ZpIBRoFDB0QTO
	 jPv9msm5UsYe+0OEHZGTKPa1mtr31m4y0SoLiMP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeLZWgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbeLZWgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01629218E2;
        Wed, 26 Dec 2018 22:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863773;
        bh=iBs1IwAJBG9j6wZ0S40T6jmm7tFX7mbpiRpdcI5jWyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GC+c5h4Eo+DIlPsysK4/anVhsorppo5UjKa696kCrvzk3DwjIBgfLQ30X9cCl8p+7
         Y1BkDye5D5kGiCFuyv/aqVH0P8guu/3D8nUsrZzaJAuWPIZcGNWTRVhCRVtg2g5Gke
         6gvGFiFphyPlv3+TgMEZnmSs0HIUVPE6aaSJVjsQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/97] IB/mlx5: Block DEVX umem from the non applicable cases
Date:   Wed, 26 Dec 2018 17:34:30 -0500
Message-Id: <20181226223557.149329-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

[ Upstream commit 47f07f03b5ee436fe074c4fb1fb28d013c36a0d8 ]

Blocks creating a DEVX UMEM with the non applicable access flags
as of ODP, MW_BIND, etc.

Specifically when an ODP flag is used below WARN call trace is issued.

[ 2510.404131] RIP: 0010:__mlx5_ib_populate_pas+0x207/0x220 [mlx5_ib]
...
[ 2510.404143] Call Trace:
[ 2510.404150]  ? __kmalloc_node+0x1b3/0x280
[ 2510.404156]  ? _uverbs_alloc+0x63/0x90 [ib_uverbs]
[ 2510.404158]  ? _uverbs_alloc+0x63/0x90 [ib_uverbs]
[ 2510.404162]  mlx5_ib_populate_pas+0x53/0x60 [mlx5_ib]
[ 2510.404167]  mlx5_ib_handler_MLX5_IB_METHOD_DEVX_UMEM_REG+0x273/0x3f0 [mlx5_ib]

Fixes: aeae94579caf ("IB/mlx5: Add DEVX support for memory registration")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index f2f11e652dcd..02f36ab72ad4 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -857,7 +857,9 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 
 	err = uverbs_get_flags32(&access, attrs,
 				 MLX5_IB_ATTR_DEVX_UMEM_REG_ACCESS,
-				 IB_ACCESS_SUPPORTED);
+				 IB_ACCESS_LOCAL_WRITE |
+				 IB_ACCESS_REMOTE_WRITE |
+				 IB_ACCESS_REMOTE_READ);
 	if (err)
 		return err;
 
-- 
2.19.1

