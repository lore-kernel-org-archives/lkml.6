Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53AE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131698;
	bh=LgXnbvr+QdMVf+2BTxJE5tpleIkLWo49/W4L7Qd42Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqPw59XwHtRk6XcXJ4TY9Cb26LpNC8TQFCpJcmv7v2GC/n6/AaYNaGrsp0eSdCLEj
	 iXelznPH7/HrCHn8hBBE/Yesb4cE5IJrHgP3uoRjT7bpVps90btx3vkm1kwP5BFC/d
	 bTdmKiz1GaB86A3N7Y6QoN3NVyNp9BC6SZv2ev8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfBYVy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbfBYVV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5FA21852;
        Mon, 25 Feb 2019 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129717;
        bh=LgXnbvr+QdMVf+2BTxJE5tpleIkLWo49/W4L7Qd42Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wyGue5Sa1PwSu1UqpywWiEKHBmsMlHfOPZsiYaAPpQs3y8s1ar12lvFa9QufyqQcK
         tYdj9vg5sHBGhMbOkq9mQ1Qr7OS7bYpOSFr/FEeL2I4T+MSxMFCorNKDVtaSQgvKNg
         HvEvfD4w3AsJqs/uM33VmRTXUDtJW7zxXmHMaP/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/152] mlxsw: spectrum_acl: Add cleanup after C-TCAM update error condition
Date:   Mon, 25 Feb 2019 22:10:37 +0100
Message-Id: <20190225195046.847263981@linuxfoundation.org>
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
index e3c6fe8b1d406..1dcf152b28138 100644
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



