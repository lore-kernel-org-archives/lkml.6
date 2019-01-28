Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9419BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641042147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690709;
	bh=RoBQAU8TVZYQgxtYRK5Pzr23g+VjWa5ktoRyXdwpbTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0AM8jJ/BFVrd2R5uaUdFxfMd8mXL1gG738/wSAX/gv6FjczcJeOQy3YhhmIIdxugr
	 H/Nyg/yQ+ilcbEJTkQts9mK+ISbG2662Zzok0stb9toM42hccL8i48f7lUjH95kfIN
	 tCGy/cFpZR8cotcDPEIYEKAOEx1HT4dddDB2kXAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfA1Pvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfA1Pvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3AB32175B;
        Mon, 28 Jan 2019 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690702;
        bh=RoBQAU8TVZYQgxtYRK5Pzr23g+VjWa5ktoRyXdwpbTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0TwwwapsXE4puloRGgcsiUEc5xrw+z2EESGFMNK3VBvrsoPUMAPYORlXUH2sdx6P2
         LrGRXzGBErJx05yJY8pdPrheEeshPFMz4rZV5uVt7oBuMWU2VFPsVP1HqIfetOXMxE
         AYfAt8h1v5T0BhuU4+j4+j+whs3XPFAmjCTnANk0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nir Dotan <nird@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 169/304] mlxsw: spectrum_acl: Limit priority value
Date:   Mon, 28 Jan 2019 10:41:26 -0500
Message-Id: <20190128154341.47195-169-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit d7263ab35be25505ab57ebecd93cbc5dba8be717 ]

In Spectrum-2, higher priority value wins and priority valid values are in
the range of {1,cap_kvd_size-1}. mlxsw_sp_acl_tcam_priority_get converts
from lower-bound priorities alike tc flower to Spectrum-2 HW range. Up
until now tc flower did not provide priority 0 or reached the maximal
value, however multicast routing does provide priority 0.

Therefore, Change mlxsw_sp_acl_tcam_priority_get to verify priority is in
the correct range. Make sure priority is never set to zero and never
exceeds the maximal allowed value.

Signed-off-by: Nir Dotan <nird@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index e171513bb32a..30931a2c025b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -95,8 +95,9 @@ int mlxsw_sp_acl_tcam_priority_get(struct mlxsw_sp *mlxsw_sp,
 	if (!MLXSW_CORE_RES_VALID(mlxsw_sp->core, KVD_SIZE))
 		return -EIO;
 
-	max_priority = MLXSW_CORE_RES_GET(mlxsw_sp->core, KVD_SIZE);
-	if (rulei->priority > max_priority)
+	/* Priority range is 1..cap_kvd_size-1. */
+	max_priority = MLXSW_CORE_RES_GET(mlxsw_sp->core, KVD_SIZE) - 1;
+	if (rulei->priority >= max_priority)
 		return -EINVAL;
 
 	/* Unlike in TC, in HW, higher number means higher priority. */
-- 
2.19.1

