Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696AAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2682C20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi7IU3bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2682C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeLEJpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbeLEJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:45:39 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E487213A2;
        Wed,  5 Dec 2018 09:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003138;
        bh=PTFLRBX/OkXfYiJARuFzC4QNZrpP5BCOVwzpy2QzOCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fi7IU3bF2AamKlPCIYP5yp+jbNA6HOzO2HMBQzS27g9FoCPsvO2Z655cSvEqM2Bto
         ulwmZl65R+6nh2TOavOZI97PLbqg84pSJ5ga55IjIwL8mmgKkAk7u3PI3FtWBgwDD2
         9roTneNfoU2Fk9lEA8COBr38sD+3pfOG4B9G4IG0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 41/69] IB/mlx5: Fix page fault handling for MW
Date:   Wed,  5 Dec 2018 04:42:19 -0500
Message-Id: <20181205094247.6556-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

[ Upstream commit 75b7b86bdb0df37e08e44b6c1f99010967f81944 ]

Memory windows are implemented with an indirect MKey, when a page fault
event comes for a MW Mkey we need to find the MR at the end of the list of
the indirect MKeys by iterating on all items from the first to the last.

The offset calculated during this process has to be zeroed after the first
iteration or the next iteration will start from a wrong address, resulting
incorrect ODP faulting behavior.

Fixes: db570d7deafb ("IB/mlx5: Add ODP support to MW")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/odp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3d701c7a4c91..1ed94b6c0b0a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -723,6 +723,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 			head = frame;
 
 			bcnt -= frame->bcnt;
+			offset = 0;
 		}
 		break;
 
-- 
2.17.1

