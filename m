Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A39D206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865310;
	bh=IBs63HXrtvo+fc9IRLQBJ3GBP7LDz5CIRnUMIjgOb5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U7nJdOFmYvOgKK79wB4uQ39zOOhrR6ASTNxapSFa4Kcc2si99+ZU62yb0SkgAVAfk
	 McPuwSZj97r1kOnPbS1/KNJJf+IsQjGnAg9QWABdWlfQln21ra1rbK0pkj94T6nCIF
	 0hBM//9aM9WsysidTGcFLrHb2kOHfQdl5K3DFJDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfAGMs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbfAGMsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D6320651;
        Mon,  7 Jan 2019 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865302;
        bh=IBs63HXrtvo+fc9IRLQBJ3GBP7LDz5CIRnUMIjgOb5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l06uJ9aOp5dhSbCRGGGQ8u5kDJRIpJOnsrf0b4zNJHz2lRmbTCTqtGyAtiM5oYoBo
         CvYMK4w0c3l1KConFRZLTPqZsi4WIYPQqxDP9TKUHlUECARvTzrf8hUutIvbcjzXzc
         m/tsAwi/21ZsnmLpXjc81/xkU65kbTAu/yX2KB2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 049/170] net/mlx5e: Cancel DIM work on close SQ
Date:   Mon,  7 Jan 2019 13:31:16 +0100
Message-Id: <20190107104458.946045170@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Tal Gilboa <talgi@mellanox.com>

[ Upstream commit fa2bf86bab4bbc61e5678a42a14e40075093a98f ]

TXQ SQ closure is followed by closing the corresponding CQ. A pending
DIM work would try to modify the now non-existing CQ.
This would trigger an error:
[85535.835926] mlx5_core 0000:af:00.0: mlx5_cmd_check:769:(pid 124399):
MODIFY_CQ(0x403) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1d7771)

Fix by making sure to cancel any pending DIM work before destroying the SQ.

Fixes: cbce4f444798 ("net/mlx5e: Enable adaptive-TX moderation")
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1383,6 +1383,7 @@ static void mlx5e_close_txqsq(struct mlx
 	struct mlx5_core_dev *mdev = c->mdev;
 	struct mlx5_rate_limit rl = {0};
 
+	cancel_work_sync(&sq->dim.work);
 	mlx5e_destroy_sq(mdev, sq->sqn);
 	if (sq->rate_limit) {
 		rl.rate = sq->rate_limit;


