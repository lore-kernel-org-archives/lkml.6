Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B137C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AB8222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025272;
	bh=7qL2qAw+ftxunrtgcGs/Cs/pM5vHKgr9jDWsCZma3Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IETYU1xq7C+pnSflaR933gGgXwa2YXAg6R08orroEiks/2YFdlnGUp9Mz7D5KvzMF
	 Wb5CGvjfxlnG8yWirgI4HJTiUDF4JBohM9qHqZm6XTqnLeqkbXemYPJcWpppHy4hlD
	 JpBMQ5EWNkYaa3EMNx/gW1VRQ/PL793Qf96DA2X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbfBMCeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387667AbfBMCeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400F7222C9;
        Wed, 13 Feb 2019 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025258;
        bh=7qL2qAw+ftxunrtgcGs/Cs/pM5vHKgr9jDWsCZma3Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUwXWzL0NwhMxup/PmpGWfXbHLF+aDuqWvRuJX8YSboE/zZfZxsO/Qvkmva17o82J
         zy8lTuUPamqWY7AYR1VTIRHBk+Y23gWHW1fZDFpRfP7Z/qH08v07/G4+bjWDnvKFN4
         tvhBhxiR7e4xvGi3TcMnQhma3ksp4O+XQHQcXuCk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nir Dotan <nird@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 035/105] mlxsw: spectrum_acl: Add cleanup after C-TCAM update error condition
Date:   Tue, 12 Feb 2019 21:32:26 -0500
Message-Id: <20190213023336.19019-35-sashal@kernel.org>
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

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit ff0db43cd6c530ff944773ccf48ece55d32d0c22 ]

When writing to C-TCAM, mlxsw driver uses cregion->ops->entry_insert().
In case of C-TCAM HW insertion error, the opposite action should take
place.
Add error handling case in which the C-TCAM region entry is removed, by
calling cregion->ops->entry_remove().

Fixes: a0a777b9409f ("mlxsw: spectrum_acl: Start using A-TCAM")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c   | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c
index e3c6fe8b1d40..1dcf152b2813 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c
@@ -75,7 +75,15 @@ mlxsw_sp_acl_ctcam_region_entry_insert(struct mlxsw_sp *mlxsw_sp,
 	act_set = mlxsw_afa_block_first_set(rulei->act_block);
 	mlxsw_reg_ptce2_flex_action_set_memcpy_to(ptce2_pl, act_set);
 
-	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(ptce2), ptce2_pl);
+	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(ptce2), ptce2_pl);
+	if (err)
+		goto err_ptce2_write;
+
+	return 0;
+
+err_ptce2_write:
+	cregion->ops->entry_remove(cregion, centry);
+	return err;
 }
 
 static void
-- 
2.19.1

