Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CF720844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895852;
	bh=+6X3NTbqlSpjZME1/xm6n/Ck4+VDlGa8gAD4BEsUMc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=unb1mRi8rn36BI41JqlCTnN0nzmkg/7jiTZ+XdswaPjj5hgMSqcL2NSKoUmW4NDZD
	 Vt2hY3czwTL6QcNjTeqUizs7MV74LulD+bxc3FcTgYtFHbPwkPwuiAEMsZMjI8rS8v
	 ACLo+9Crh69mM3GgokThWqmzj8D8A3k+doKgP/wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfBKOha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbfBKOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D441B20700;
        Mon, 11 Feb 2019 14:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895846;
        bh=+6X3NTbqlSpjZME1/xm6n/Ck4+VDlGa8gAD4BEsUMc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggiDpG1p3Bgs9rJIru9G/JjTGlCLaqSRjGJvrBx+Rm5VsTvvrwAcWcXNEdNJ0y7O7
         kGBLfMyiLNzPtP5PO6x4sFB/CF4PJ+cU+IWcIur4osq2ID8MGDLpzDOFZ2FKeayJUa
         31YsNTw5q6eRWB/oHtIluqAg4PHU8BcADGW2V59w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guy Shattah <sguy@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.20 311/352] net/mlx5e: Use the inner headers to determine tc/pedit offload limitation on decap flows
Date:   Mon, 11 Feb 2019 15:18:58 +0100
Message-Id: <20190211141906.620299354@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guy Shattah <sguy@mellanox.com>

[ Upstream commit 1651925d403e077e3fc86f961905e27c6810e132 ]

In packets that need to be decaped the internal headers
have to be checked, not the external ones.

Fixes: bdd66ac0aeed ("net/mlx5e: Disallow TC offloading of unsupported match/action combinations")
Signed-off-by: Guy Shattah <sguy@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2133,6 +2133,7 @@ static bool csum_offload_supported(struc
 
 static bool modify_header_match_supported(struct mlx5_flow_spec *spec,
 					  struct tcf_exts *exts,
+					  u32 match_actions,
 					  struct netlink_ext_ack *extack)
 {
 	const struct tc_action *a;
@@ -2143,7 +2144,11 @@ static bool modify_header_match_supporte
 	u16 ethertype;
 	int nkeys, i;
 
-	headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
+	if (match_actions & MLX5_FLOW_CONTEXT_ACTION_DECAP)
+		headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, inner_headers);
+	else
+		headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
+
 	ethertype = MLX5_GET(fte_match_set_lyr_2_4, headers_v, ethertype);
 
 	/* for non-IP we only re-write MACs, so we're okay */
@@ -2200,7 +2205,7 @@ static bool actions_match_supported(stru
 
 	if (actions & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
 		return modify_header_match_supported(&parse_attr->spec, exts,
-						     extack);
+						     actions, extack);
 
 	return true;
 }


