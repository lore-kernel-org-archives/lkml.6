Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8268C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7645C2148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVCMrIpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7645C2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeJPMDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbeJPMDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5E021477;
        Tue, 16 Oct 2018 04:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663284;
        bh=XwsuxFEQiPUSAicv/vJTkne6pwSJNNTrKnnQrkEqdZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVCMrIpGgDYG/L00DLznoaos1HqS+e8u6HGQW24VuM/qg4xpj9UXBms2dg7tK5jwy
         TP2JoaTzj22n6CH9vkiTiuTD86OnixTk+j1fIwq7QuwfTsR3zABoJIlZQDR2qHeeWY
         CfYYUox/iy3x/sEZFilt8QSsueMdW7jfAv3y0DDM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianbo Liu <jianbol@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 45/61] net/mlx5e: Set vlan masks for all offloaded TC rules
Date:   Tue, 16 Oct 2018 00:13:47 -0400
Message-Id: <20181016041403.135678-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianbo Liu <jianbol@mellanox.com>

[ Upstream commit cee26487620bc9bc3c7db21b6984d91f7bae12ae ]

In flow steering, if asked to, the hardware matches on the first ethertype
which is not vlan. It's possible to set a rule as follows, which is meant
to match on untagged packet, but will match on a vlan packet:
    tc filter add dev eth0 parent ffff: protocol ip flower ...

To avoid this for packets with single tag, we set vlan masks to tell
hardware to check the tags for every matched packet.

Fixes: 095b6cfd69ce ('net/mlx5e: Add TC vlan match parsing')
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index e28f9dab9ceb..9e0be077df9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -864,6 +864,9 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 			MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_prio, mask->vlan_priority);
 			MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_prio, key->vlan_priority);
 		}
+	} else {
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, svlan_tag, 1);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
-- 
2.17.1

