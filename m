Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2212C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BBF2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760271;
	bh=rbkDiwapLHWoxx0UlJdRTiViksY+z1n9VzMDEZecZc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BpauFtCAdk/GfyPiGdCeYQZm5yBlXDyWwP7v0JUqUMKlQjhBhTeFoUAUcdCsokQ6O
	 RgV5BhZ99crCR+SIUOieSvN2wrqDESKkcJdiL2aD+FfdO4SkYWR+WwwMqlnS8YUmga
	 rHKSLNRIwSd0IQSCyl/TrwC8LdMSynu8uBgetHLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfBUOoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbfBUOoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:44:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573AB20700;
        Thu, 21 Feb 2019 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760241;
        bh=rbkDiwapLHWoxx0UlJdRTiViksY+z1n9VzMDEZecZc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mmqzliE6q7cJCHPqJOze4XolspWOlkJaRIXWr9eHDmP/TfTuFvGvKmk2DctVvy5TA
         rPgOV9GFHgRapgN0gqGG/1Q7vadw4oiY9+c2K26biBJ7rBpQvFdhOxYHgIDhlj6yVL
         xG+1l5uUHfeubz4luniAcXAE7OqEaWUSTtGvgPc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 06/32] mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable
Date:   Thu, 21 Feb 2019 15:35:54 +0100
Message-Id: <20190221125251.212920390@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

[ Upstream commit 289460404f6947ef1c38e67d680be9a84161250b ]

The function-local variable "delay" enters the loop interpreted as delay
in bits. However, inside the loop it gets overwritten by the result of
mlxsw_sp_pg_buf_delay_get(), and thus leaves the loop as quantity in
cells. Thus on second and further loop iterations, the headroom for a
given priority is configured with a wrong size.

Fix by introducing a loop-local variable, delay_cells. Rename thres to
thres_cells for consistency.

Fixes: f417f04da589 ("mlxsw: spectrum: Refactor port buffer configuration")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 8f1180fff9551..280173b489624 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -845,8 +845,9 @@ int __mlxsw_sp_port_headroom_set(struct mlxsw_sp_port *mlxsw_sp_port, int mtu,
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
 		bool configure = false;
 		bool pfc = false;
+		u16 thres_cells;
+		u16 delay_cells;
 		bool lossy;
-		u16 thres;
 
 		for (j = 0; j < IEEE_8021QAZ_MAX_TCS; j++) {
 			if (prio_tc[j] == i) {
@@ -860,10 +861,11 @@ int __mlxsw_sp_port_headroom_set(struct mlxsw_sp_port *mlxsw_sp_port, int mtu,
 			continue;
 
 		lossy = !(pfc || pause_en);
-		thres = mlxsw_sp_pg_buf_threshold_get(mlxsw_sp, mtu);
-		delay = mlxsw_sp_pg_buf_delay_get(mlxsw_sp, mtu, delay, pfc,
-						  pause_en);
-		mlxsw_sp_pg_buf_pack(pbmc_pl, i, thres + delay, thres, lossy);
+		thres_cells = mlxsw_sp_pg_buf_threshold_get(mlxsw_sp, mtu);
+		delay_cells = mlxsw_sp_pg_buf_delay_get(mlxsw_sp, mtu, delay,
+							pfc, pause_en);
+		mlxsw_sp_pg_buf_pack(pbmc_pl, i, thres_cells + delay_cells,
+				     thres_cells, lossy);
 	}
 
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(pbmc), pbmc_pl);
-- 
2.19.1



