Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB76C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D3D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896294;
	bh=yGvcv5h7jZZjzuU8yDx9WX+u3gnEwVRIoRaJQedb/uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jm9IxVQHZfeRuhgjinjDRDPs9jPLgNcAd0dP7gJKCnENYeG+ZeD+Q48ZrVSgh8RtJ
	 FNtTDGH3DaSPAG28FxaVGTC3oMPVNInml1pz3iwJT6lGcxywaCG2bjhbdQ8jzoJ7uH
	 4/eS0qdiwX0228EYhKBLFkXncAeUjRy4C3OdZsts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfBKOov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732358AbfBKOos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40DAF206BA;
        Mon, 11 Feb 2019 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896287;
        bh=yGvcv5h7jZZjzuU8yDx9WX+u3gnEwVRIoRaJQedb/uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXqMG+7+i3eysOnk57nrSh98ZLtWmF3S2L2VinY9Bc7lNw6Dh+EurovwuyiNl5w4K
         3+wT6bzQlbt2AcMW/6CDW97X0EsLmgID94NNE9kZurDjbiXjtex/YjcIuSCVdm2i3A
         yy7OdUxjOA98Np33AvNy9n2HLOW7nm3itcstpQA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 135/313] mlxsw: spectrum_acl: Limit priority value
Date:   Mon, 11 Feb 2019 15:16:55 +0100
Message-Id: <20190211141902.712669999@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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



