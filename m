Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0CBC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C202145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBJ9GjrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C202145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeJPMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeJPMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE5720869;
        Tue, 16 Oct 2018 04:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663197;
        bh=wL8Uw9k/2BnHHmRA9MiszFSzfXRwymP5gJiT/jDoHjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBJ9GjrYjAwTkLFX4sTY33BnCEf3GQMdBPAXXmDEaJtTtyXjaNXmuj+wHiGS6jDkQ
         +Q7MlQUU1+Std6fJPcuvV3sE1UtsPlPRPeMpYb1jeeaTtbR251DxOXlywAPA6K1sP1
         VxrZ8T8IqE2gKiuWxC6YN+pD2sHSQ1PvyvLw0wqA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianbo Liu <jianbol@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 061/100] net/mlx5e: Set vlan masks for all offloaded TC rules
Date:   Tue, 16 Oct 2018 00:11:42 -0400
Message-Id: <20181016041221.135528-61-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
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
index dfbcda0d0e08..701af5ffcbc9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1339,6 +1339,9 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 
 			*match_level = MLX5_MATCH_L2;
 		}
+	} else {
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, svlan_tag, 1);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
 	}
 
 	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {
-- 
2.17.1

