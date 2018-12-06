Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B691C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301D421508
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108499;
	bh=uMD5clkFnrjyk5GufjVCr9GbFEG8LJcnuGUL9/r8XxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eP9vL/oWYBHUwRQGe5MVl3AEYkoc90KJsjoJcHSQbYZnbX9lF6J8f0fDfatJolmpf
	 IYxLfflpwuyprjlgdwYvlr3oxkjSdwknyfVesQVTmGDaD97AGmpLu72aF0oSEHRDZt
	 tn19AEMQQ/UE22CQ/2yMAQnDwze15afdUbLPtGmk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301D421508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLFPBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:01:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbeLFOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:39:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF2420892;
        Thu,  6 Dec 2018 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107197;
        bh=uMD5clkFnrjyk5GufjVCr9GbFEG8LJcnuGUL9/r8XxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzU1WrcLiYWW/H8ZbLN6ewq9WWMPvP83Xhoth6j2do4MDbN0bUIzb9+ENv6z7OJDl
         RrpVqOwmvr+0pjAEJGPm8ZkRQNJCA1kjeuEUoxBoUwUKzuarYsIGzKcYDl6VgBWXeL
         m1oSucqdNhBtsZRXGmoNeyYFllYCN0ZiTrDOZWBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Guralnik <michaelgur@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 12/41] IB/mlx5: Avoid load failure due to unknown link width
Date:   Thu,  6 Dec 2018 15:38:52 +0100
Message-Id: <20181206142950.721767750@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Michael Guralnik <michaelgur@mellanox.com>

commit db7a691a1551a748cb92d9c89c6b190ea87e28d5 upstream.

If the firmware reports a connection width that is not 1x, 4x, 8x or 12x
it causes the driver to fail during initialization.

To prevent this failure every time a new width is introduced to the RDMA
stack, we will set a default 4x width for these widths which ar unknown to
the driver.

This is needed to allow to run old kernels with new firmware.

Cc: <stable@vger.kernel.org> # 4.1
Fixes: 1b5daf11b015 ("IB/mlx5: Avoid using the MAD_IFC command under ISSI > 0 mode")
Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/main.c |   29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1094,31 +1094,26 @@ enum mlx5_ib_width {
 	MLX5_IB_WIDTH_12X	= 1 << 4
 };
 
-static int translate_active_width(struct ib_device *ibdev, u8 active_width,
+static void translate_active_width(struct ib_device *ibdev, u8 active_width,
 				  u8 *ib_width)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	int err = 0;
 
-	if (active_width & MLX5_IB_WIDTH_1X) {
+	if (active_width & MLX5_IB_WIDTH_1X)
 		*ib_width = IB_WIDTH_1X;
-	} else if (active_width & MLX5_IB_WIDTH_2X) {
-		mlx5_ib_dbg(dev, "active_width %d is not supported by IB spec\n",
-			    (int)active_width);
-		err = -EINVAL;
-	} else if (active_width & MLX5_IB_WIDTH_4X) {
+	else if (active_width & MLX5_IB_WIDTH_4X)
 		*ib_width = IB_WIDTH_4X;
-	} else if (active_width & MLX5_IB_WIDTH_8X) {
+	else if (active_width & MLX5_IB_WIDTH_8X)
 		*ib_width = IB_WIDTH_8X;
-	} else if (active_width & MLX5_IB_WIDTH_12X) {
+	else if (active_width & MLX5_IB_WIDTH_12X)
 		*ib_width = IB_WIDTH_12X;
-	} else {
-		mlx5_ib_dbg(dev, "Invalid active_width %d\n",
+	else {
+		mlx5_ib_dbg(dev, "Invalid active_width %d, setting width to default value: 4x\n",
 			    (int)active_width);
-		err = -EINVAL;
+		*ib_width = IB_WIDTH_4X;
 	}
 
-	return err;
+	return;
 }
 
 static int mlx5_mtu_to_ib_mtu(int mtu)
@@ -1225,10 +1220,8 @@ static int mlx5_query_hca_port(struct ib
 	if (err)
 		goto out;
 
-	err = translate_active_width(ibdev, ib_link_width_oper,
-				     &props->active_width);
-	if (err)
-		goto out;
+	translate_active_width(ibdev, ib_link_width_oper, &props->active_width);
+
 	err = mlx5_query_port_ib_proto_oper(mdev, &props->active_speed, port);
 	if (err)
 		goto out;


