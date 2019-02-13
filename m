Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03142C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C0221934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026010;
	bh=5UQm+zEySr2J5WaEkdzlKgfQoUylPynoBWkTY97uZ0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZOU0R8njFV0hsCFmMKPTD4UpQ56+Bb7KpVOQ3FO1zKxw64bqAP52hzgiNjvs6/V/
	 M2sUmhkFEkFOujxPHPtpTtMFM09ozsqzxYiOqF7lQvdYIKtslnFVntQmHnkv5myX3s
	 VnM8qIslCpFoQD/YqyVHWppY+fmhmPPIRLfexhU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfBMCqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389010AbfBMCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479F0222CA;
        Wed, 13 Feb 2019 02:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025636;
        bh=5UQm+zEySr2J5WaEkdzlKgfQoUylPynoBWkTY97uZ0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzNwdkfqDDPXo+SxlxLmokmT3dkhSwkB3Ni5zYgD2tIoOXTUz39t6Is81Oarx5GUt
         xpAkmEMZB/jcb2XOnO2yB3HaLa7jrHBM5IevNQ6UHXNuvfAptHR4cqDn0xv8qPR5sT
         fqCKRykjvqSBusdEFzgZ4d1etiSFH3Yxi3G7XDqg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 32/34] mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky
Date:   Tue, 12 Feb 2019 21:39:50 -0500
Message-Id: <20190213023952.21311-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
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
index 9052e93e1925..ad1bf39c7e19 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1111,7 +1111,7 @@ mlxsw_sp_bridge_port_fdb_flush(struct mlxsw_sp *mlxsw_sp,
 static enum mlxsw_reg_sfd_rec_policy mlxsw_sp_sfd_rec_policy(bool dynamic)
 {
 	return dynamic ? MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_INGRESS :
-			 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY;
+			 MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_MLAG;
 }
 
 static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool adding)
@@ -1123,7 +1123,7 @@ static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool adding)
 static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				     const char *mac, u16 fid, bool adding,
 				     enum mlxsw_reg_sfd_rec_action action,
-				     bool dynamic)
+				     enum mlxsw_reg_sfd_rec_policy policy)
 {
 	char *sfd_pl;
 	u8 num_rec;
@@ -1134,8 +1134,7 @@ static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 		return -ENOMEM;
 
 	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
-	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, mlxsw_sp_sfd_rec_policy(dynamic),
-			      mac, fid, action, local_port);
+	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, policy, mac, fid, action, local_port);
 	num_rec = mlxsw_reg_sfd_num_rec_get(sfd_pl);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
 	if (err)
@@ -1154,7 +1153,8 @@ static int mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				   bool dynamic)
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, adding,
-					 MLXSW_REG_SFD_REC_ACTION_NOP, dynamic);
+					 MLXSW_REG_SFD_REC_ACTION_NOP,
+					 mlxsw_sp_sfd_rec_policy(dynamic));
 }
 
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
@@ -1162,7 +1162,7 @@ int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, 0, mac, fid, adding,
 					 MLXSW_REG_SFD_REC_ACTION_FORWARD_IP_ROUTER,
-					 false);
+					 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY);
 }
 
 static int mlxsw_sp_port_fdb_uc_lag_op(struct mlxsw_sp *mlxsw_sp, u16 lag_id,
-- 
2.19.1

