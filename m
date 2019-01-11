Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D76C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB912133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217300;
	bh=H7uAdKN/S0Mg0So+OAyKBDKGFh8Gzj3pT2IyDT/lAwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1c6L22Q/RYYMPmJ+w8Tre7iqcX/WaC0TOceLK7X9RvAcKOGGlilHlzBPn+5/B5ks
	 qCFrP+quhc0MfuVykpS0uATYId22sGROB6WpBBnz1Z87Hmb4u4zuEgYAq96qglmlBi
	 26vjCbYzBLtZNC82gj/Tihrlt5YjHllAlAaxldtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389270AbfAKOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbfAKOe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC89E204EC;
        Fri, 11 Jan 2019 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217296;
        bh=H7uAdKN/S0Mg0So+OAyKBDKGFh8Gzj3pT2IyDT/lAwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DisqhUiRguKQzgRfRXsYHuzYdrekyMVzM9pETgc1x2mQnTiLuPSddfMr5AgTgsb75
         5WLU07SHxaJVDg9DcD3FP3XDoyW9M69xpx0ZdwN4dnYJudhw4lB6qpwhDfwjv0zj1M
         77Bfo0oTi51pGpYwUILGk8Ro5i+Fs31kMbsZQCzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/148] IB/mlx5: Block DEVX umem from the non applicable cases
Date:   Fri, 11 Jan 2019 15:13:08 +0100
Message-Id: <20190111131114.746725571@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



