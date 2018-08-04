Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F86C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AD921775
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AD921775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHDLCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:02:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeHDLCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:02:48 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7A83BB3;
        Sat,  4 Aug 2018 09:02:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 08/31] net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager
Date:   Sat,  4 Aug 2018 11:00:43 +0200
Message-Id: <20180804082632.804143977@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
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

[ Upstream commit 5f5991f36dce1e69dd8bd7495763eec2e28f08e7 ]

Execute mlx5_eswitch_init() only if we have MLX5_ESWITCH_MANAGER
capabilities.
Do the same for mlx5_eswitch_cleanup().

Fixes: a9f7705ffd66 ("net/mlx5: Unify vport manager capability check")
Signed-off-by: Eli Cohen <eli@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1698,7 +1698,7 @@ int mlx5_eswitch_init(struct mlx5_core_d
 	int vport_num;
 	int err;
 
-	if (!MLX5_VPORT_MANAGER(dev))
+	if (!MLX5_ESWITCH_MANAGER(dev))
 		return 0;
 
 	esw_info(dev,
@@ -1767,7 +1767,7 @@ abort:
 
 void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 {
-	if (!esw || !MLX5_VPORT_MANAGER(esw->dev))
+	if (!esw || !MLX5_ESWITCH_MANAGER(esw->dev))
 		return;
 
 	esw_info(esw->dev, "cleanup\n");


