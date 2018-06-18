Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAAFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6BF20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6BF20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964973AbeFRIUg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:20:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964908AbeFRIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B050FC7A;
        Mon, 18 Jun 2018 08:20:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 117/279] RDMA/mlx5: Properly check return value of mlx5_get_uars_page
Date:   Mon, 18 Jun 2018 10:11:42 +0200
Message-Id: <20180618080613.654060805@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit 444261ca6ff201fa03de97a5041237e67a9d8d31 ]

Starting from commit 72f36be06138 ("net/mlx5: Fix mlx5_get_uars_page to
return error code") the mlx5_get_uars_page() call returns error in case
of failure, but it was mistakenly overlooked in the merge commit.

Fixes: e7996a9a77fc ("Merge tag v4.15 of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git")
Reported-by: Alaa Hleihel <alaa@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4833,9 +4833,7 @@ static void mlx5_ib_stage_cong_debugfs_c
 static int mlx5_ib_stage_uar_init(struct mlx5_ib_dev *dev)
 {
 	dev->mdev->priv.uar = mlx5_get_uars_page(dev->mdev);
-	if (!dev->mdev->priv.uar)
-		return -ENOMEM;
-	return 0;
+	return PTR_ERR_OR_ZERO(dev->mdev->priv.uar);
 }
 
 static void mlx5_ib_stage_uar_cleanup(struct mlx5_ib_dev *dev)


