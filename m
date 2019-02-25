Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A7AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A4720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129880;
	bh=cZT7Bjrk0GU/X8O8vfg865M+PxqrT7P+3qe4w+WvuCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VoLmrjEt5BmR36Psb63zeJcC1wGi/inKYnJJJA6OIKZru5Q3RBjZSqNl3TbBZ2UMZ
	 Ei72b/fg3vXVK6vdWxOymVzZOOWjak9vuN17wUNUF7cl3g9E3c1bpp58HiFynkHS1M
	 aZtjTTWCtHR+VVxebBBhm99Sky0eMj0XqyYfX6g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfBYVYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbfBYVYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C8B21734;
        Mon, 25 Feb 2019 21:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129875;
        bh=cZT7Bjrk0GU/X8O8vfg865M+PxqrT7P+3qe4w+WvuCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWc4q7Hr2CFu1j2FdkN93l/j543g5bKWtwHZQ9PTvsFc6n8vR1gVjmMAKtWYGI/T8
         MSAlryT5go21vx2+ttlc4GigizgETUMgrO9baHUctvwTtoeta0bn3XBYjFGsTLCq4B
         cisahOBvhQeY19oUn655aNk0hGFQmeqat5AuSmi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Alexander Petrovskiy <alexpe@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/152] mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky
Date:   Mon, 25 Feb 2019 22:11:26 +0100
Message-Id: <20190225195049.470067858@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
index cdec48bcc6ad5..af673abdb4823 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1209,7 +1209,7 @@ mlxsw_sp_bridge_port_fdb_flush(struct mlxsw_sp *mlxsw_sp,
 static enum mlxsw_reg_sfd_rec_policy mlxsw_sp_sfd_rec_policy(bool dynamic)
 {
 	return dynamic ? MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_INGRESS :
-			 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY;
+			 MLXSW_REG_SFD_REC_POLICY_DYNAMIC_ENTRY_MLAG;
 }
 
 static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool adding)
@@ -1221,7 +1221,7 @@ static enum mlxsw_reg_sfd_op mlxsw_sp_sfd_op(bool adding)
 static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				     const char *mac, u16 fid, bool adding,
 				     enum mlxsw_reg_sfd_rec_action action,
-				     bool dynamic)
+				     enum mlxsw_reg_sfd_rec_policy policy)
 {
 	char *sfd_pl;
 	u8 num_rec;
@@ -1232,8 +1232,7 @@ static int __mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 		return -ENOMEM;
 
 	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
-	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, mlxsw_sp_sfd_rec_policy(dynamic),
-			      mac, fid, action, local_port);
+	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, policy, mac, fid, action, local_port);
 	num_rec = mlxsw_reg_sfd_num_rec_get(sfd_pl);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
 	if (err)
@@ -1252,7 +1251,8 @@ static int mlxsw_sp_port_fdb_uc_op(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 				   bool dynamic)
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid, adding,
-					 MLXSW_REG_SFD_REC_ACTION_NOP, dynamic);
+					 MLXSW_REG_SFD_REC_ACTION_NOP,
+					 mlxsw_sp_sfd_rec_policy(dynamic));
 }
 
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
@@ -1260,7 +1260,7 @@ int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 {
 	return __mlxsw_sp_port_fdb_uc_op(mlxsw_sp, 0, mac, fid, adding,
 					 MLXSW_REG_SFD_REC_ACTION_FORWARD_IP_ROUTER,
-					 false);
+					 MLXSW_REG_SFD_REC_POLICY_STATIC_ENTRY);
 }
 
 static int mlxsw_sp_port_fdb_uc_lag_op(struct mlxsw_sp *mlxsw_sp, u16 lag_id,
-- 
2.19.1



