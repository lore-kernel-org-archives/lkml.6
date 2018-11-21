Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA04A214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSL5RW7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA04A214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbeKVFms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbeKVFmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B4D214DB;
        Wed, 21 Nov 2018 19:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827234;
        bh=zNg3NGQk/x75FDTpX1/gOI4FCaXpIu3RUjvawtiYNmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sSL5RW7l4SQfhxM+NLZw3Y3zhgivuiFDi5cmJQQ8WHT4WBWHTjSGAp+ulPgpuzURI
         XJEK+yqEuQKekPJq51hU7kq4kkP6FYK1mztPY7t1HhN6F+kqzt+IFg2haPBT50SLM7
         z7lQgaAIldj1KpLHl58ys6UQw0G/jjSQhQUBZfnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Agroskin <shayag@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 25/42] net/mlx5e: Removed unnecessary warnings in FEC caps query
Date:   Wed, 21 Nov 2018 20:06:01 +0100
Message-Id: <20181121183149.092880760@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Agroskin <shayag@mellanox.com>

[ Upstream commit 64e283348458e2fd2fe41b60dfb6c30e88ee695f ]

Querying interface FEC caps with 'ethtool [int]' after link reset
throws warning regading link speed.
This warning is not needed as there is already an indication in
user space that the link is not up.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Shay Agroskin <shayag@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c        |    4 +---
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c |    4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -88,10 +88,8 @@ int mlx5e_port_linkspeed(struct mlx5_cor
 
 	eth_proto_oper = MLX5_GET(ptys_reg, out, eth_proto_oper);
 	*speed = mlx5e_port_ptys2speed(eth_proto_oper);
-	if (!(*speed)) {
-		mlx5_core_warn(mdev, "cannot get port speed\n");
+	if (!(*speed))
 		err = -EINVAL;
-	}
 
 	return err;
 }
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -130,8 +130,10 @@ static u32 calculate_xoff(struct mlx5e_p
 	int err;
 
 	err = mlx5e_port_linkspeed(priv->mdev, &speed);
-	if (err)
+	if (err) {
+		mlx5_core_warn(priv->mdev, "cannot get port speed\n");
 		return 0;
+	}
 
 	xoff = (301 + 216 * priv->dcbx.cable_len / 100) * speed / 1000 + 272 * mtu / 100;
 


