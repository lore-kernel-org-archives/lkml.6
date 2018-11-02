Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17632C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BBA2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKEPaA12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BBA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbeKCECk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbeKCECj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:02:39 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75CAD20848;
        Fri,  2 Nov 2018 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184864;
        bh=GT90lk2hdG/w4vfIMBet4FbiqtqbZYJ/Hl2vtdxMCNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKEPaA12RD56Wy1yCiyTnaVYaqHaWZkGn7teeUpWIBhdAJHc87ZH1BGSlxgV+gEAf
         qXDdMG8oPlejaIfuxTsTpef2Lf787H8r1D5tegaqaq52p3vv08MlXQzIsWujqg8+r+
         +/YRu6yEgNDlp/vg4AMgAj8s3BCmWvn3/yGAdtRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Lesokhin <ilyal@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/143] IB/mlx5: Avoid passing an invalid QP type to firmware
Date:   Fri,  2 Nov 2018 19:34:13 +0100
Message-Id: <20181102182902.678318483@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e7b169f34403becd3c9fd3b6e46614ab788f2187 ]

During QP creation, the mlx5 driver translates the QP type to an
internal value which is passed on to FW. There was no check to make
sure that the translated value is valid, and -EINVAL was coerced into
the mailbox command.

Current firmware refuses this as an invalid QP type, but future/past
firmware may do something else.

Fixes: 09a7d9eca1a6c ('{net,IB}/mlx5: QP/XRCD commands via mlx5 ifc')
Reviewed-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index ef9ee6c328a1..dfc190055167 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1527,6 +1527,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 	struct mlx5_ib_create_qp ucmd;
 	struct mlx5_ib_qp_base *base;
+	int mlx5_st;
 	void *qpc;
 	u32 *in;
 	int err;
@@ -1535,6 +1536,10 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 
+	mlx5_st = to_mlx5_st(init_attr->qp_type);
+	if (mlx5_st < 0)
+		return -EINVAL;
+
 	if (init_attr->rwq_ind_tbl) {
 		if (!udata)
 			return -ENOSYS;
@@ -1688,7 +1693,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
-	MLX5_SET(qpc, qpc, st, to_mlx5_st(init_attr->qp_type));
+	MLX5_SET(qpc, qpc, st, mlx5_st);
 	MLX5_SET(qpc, qpc, pm_state, MLX5_QP_PM_MIGRATED);
 
 	if (init_attr->qp_type != MLX5_IB_QPT_REG_UMR)
-- 
2.17.1



