Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C61C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DEF222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025588;
	bh=Qy4n4eGBuSPz1fEplyi85cCJW9ROOYTDUMUNTBNQl5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aONGCPG1CF4Fc300PW2bwz5MEDEQrkPzbtc75mAZIYU/5FHrW8mRKstUA+fKYsOUe
	 1MyjABlA+3rmKxSl3Qrke8obDdlF0/YAUvO4Sj63ocShc/IHoSpBW2IbKqP4V9QbHn
	 BXbJYD4BVFpwkCiyBi+HGIaG2pWfui6CjRhjKcGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfBMCjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388763AbfBMCjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7AB222CD;
        Wed, 13 Feb 2019 02:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025575;
        bh=Qy4n4eGBuSPz1fEplyi85cCJW9ROOYTDUMUNTBNQl5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6Q1qjIxkGujB1EyuiZO4k6q1WQPbUkvPjostvVtYK37c8mKvymUn6ET1A9UdzVrI
         f8YLHZQ7qHScb17btu2/qpO609bCaLQuLJGqdbTjV6wVHpJoqgHBzyyZqa9obLNFJ/
         +epWddaIsMOnfL7dEBoRrtrfQGEr7ZOXAmhY4hAE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 80/83] mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky
Date:   Tue, 12 Feb 2019 21:36:58 -0500
Message-Id: <20190213023701.20286-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 64254a2054611205798e6bde634639bc704573ac ]

The driver currently treats static FDB entries as both static and
sticky. This is incorrect and prevents such entries from being roamed to
a different port via learning.

Fix this by configuring static entries with ageing disabled and roaming
enabled.

In net-next we can add proper support for the newly introduced 'sticky'
flag.

Fixes: 56ade8fe3fe1 ("mlxsw: spectrum: Add initial support for Spectrum ASIC")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 0d9ea37c5d21..ed8421144d5f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1234,7 +1234,7 @@ mlxsw_sp_bridge_port_fdb_flush(struct mlxsw_sp *mlxsw_sp,
 static enum mlxsw_reg_sfd_rec_policy mlxsw_sp_sfd_rec_policy(bool dynamic)
 {
 	return dynamic ? MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_INGRESS :
-			 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY;
+			 MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_MLAG;
 }
 
 static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool adding)
@@ -1246,7 +1246,7 @@ static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool adding)
 static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				     const char *mac, u16 fid, bool adding,
 				     enum mlxsw_reg_sfd_rec_action action,
-				     bool dynamic)
+				     enum mlxsw_reg_sfd_rec_policy policy)
 {
 	char *sfd_pl;
 	u8 num_rec;
@@ -1257,8 +1257,7 @@ static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 		return -ENOMEM;
 
 	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
-	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, mlxsw_sp_sfd_rec_policy(dynamic),
-			      mac, fid, action, local_port);
+	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, policy, mac, fid, action, local_port);
 	num_rec = mlxsw_reg_sfd_num_rec_get(sfd_pl);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
 	if (err)
@@ -1277,7 +1276,8 @@ static int mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				   bool dynamic)
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, adding,
-					 MLXSW_REG_SFD_REC_ACTION_NOP, dynamic);
+					 MLXSW_REG_SFD_REC_ACTION_NOP,
+					 mlxsw_sp_sfd_rec_policy(dynamic));
 }
 
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
@@ -1285,7 +1285,7 @@ int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, 0, mac, fid, adding,
 					 MLXSW_REG_SFD_REC_ACTION_FORWARD_IP_ROUTER,
-					 false);
+					 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY);
 }
 
 static int mlxsw_sp_port_fdb_uc_lag_op(struct mlxsw_sp *mlxsw_sp, u16 lag_id,
-- 
2.19.1

