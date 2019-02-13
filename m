Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA3AC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A87B206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025403;
	bh=khOtuIy0TpPiKz61b1idq1ShLFlz5z8hVWVgGLXVebY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XXi7xBfjMN8uqIyDTKC9Ny1NN6ul0x0u1bISAiDlO5iWP3uGlNwDGDu1s0gxGfX4c
	 WYp/v2HzGSqfx5CK2ff4YnoI/hpaHbZm2lo/ecJebXUnKJ5F5/rTodtYO+kdOJN0Tt
	 gEJRCMmCyHu/fpaHFjzhQUFKFjJM2bd/VG/F5fco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbfBMCgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388114AbfBMCge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680DA222C9;
        Wed, 13 Feb 2019 02:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025393;
        bh=khOtuIy0TpPiKz61b1idq1ShLFlz5z8hVWVgGLXVebY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qC+amlX+vgYbxPmleklbd1VU26sEtsYV9msQoQKFZb2lWkyGksDfJBgzgpeFfItO6
         fB0jYDhGI0jLxUvCcpNxJ3Whp6rdABBiP+0eA1qW3S0BYPcgu7Iwj2jEE/KT8u7pex
         9M/yngJyMZamxg0akOV4eH4BiA9Mqx32rq2UjtDY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 100/105] mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky
Date:   Tue, 12 Feb 2019 21:33:31 -0500
Message-Id: <20190213023336.19019-100-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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
index 69f556ddb934..9fc6b609834b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1244,7 +1244,7 @@ mlxsw_sp_bridge_port_fdb_flush(struct mlxsw_sp *mlxsw_sp,
 static enum mlxsw_reg_sfd_rec_policy mlxsw_sp_sfd_rec_policy(bool dynamic)
 {
 	return dynamic ? MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_INGRESS :
-			 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY;
+			 MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_MLAG;
 }
 
 static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool adding)
@@ -1301,7 +1301,7 @@ out:
 static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				     const char *mac, u16 fid, bool adding,
 				     enum mlxsw_reg_sfd_rec_action action,
-				     bool dynamic)
+				     enum mlxsw_reg_sfd_rec_policy policy)
 {
 	char *sfd_pl;
 	u8 num_rec;
@@ -1312,8 +1312,7 @@ static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 		return -ENOMEM;
 
 	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
-	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, mlxsw_sp_sfd_rec_policy(dynamic),
-			      mac, fid, action, local_port);
+	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, policy, mac, fid, action, local_port);
 	num_rec = mlxsw_reg_sfd_num_rec_get(sfd_pl);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
 	if (err)
@@ -1332,7 +1331,8 @@ static int mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				   bool dynamic)
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, adding,
-					 MLXSW_REG_SFD_REC_ACTION_NOP, dynamic);
+					 MLXSW_REG_SFD_REC_ACTION_NOP,
+					 mlxsw_sp_sfd_rec_policy(dynamic));
 }
 
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
@@ -1340,7 +1340,7 @@ int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, 0, mac, fid, adding,
 					 MLXSW_REG_SFD_REC_ACTION_FORWARD_IP_ROUTER,
-					 false);
+					 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY);
 }
 
 static int mlxsw_sp_port_fdb_uc_lag_op(struct mlxsw_sp *mlxsw_sp, u16 lag_id,
-- 
2.19.1

