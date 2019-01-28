Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5442C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A773E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691570;
	bh=RoBQAU8TVZYQgxtYRK5Pzr23g+VjWa5ktoRyXdwpbTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DCzz2ivrYbGaVb1P8C9ugpPQi2XXVUxRkpMR9KaC6mdSbWWbJSYV2RISCY5cJXIWd
	 u1h0h0D5i4KRJNPFnN7zf+clJlCNrvDoxzi3hobeNtrI2qGpckzRsJTPymXsM/xGKq
	 QHoGlX8I8/+dh6DeQiSb1U0hRQC+ikTy2j3/oLIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfA1QGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731469AbfA1QGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24542147A;
        Mon, 28 Jan 2019 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691564;
        bh=RoBQAU8TVZYQgxtYRK5Pzr23g+VjWa5ktoRyXdwpbTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vO2ccZpYIRKdRICCH9J/EHCznwrl5YKMzxhSy+lUKWRJzDx75w/JzNnWIrwiPJ/3w
         Ml8Ivj9pRMnZGlPWHJ1wFkwhS062izXUrjgop0w9HmDDd9o95DEb2tMDEFuBqv6Bp0
         KL0+BXYbvqoRUXTIPo7CVgqvMoYokuWRoVp3QPEE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nir Dotan <nird@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 143/258] mlxsw: spectrum_acl: Limit priority value
Date:   Mon, 28 Jan 2019 10:57:29 -0500
Message-Id: <20190128155924.51521-143-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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

