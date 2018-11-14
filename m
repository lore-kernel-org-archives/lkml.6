Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D260BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983EE2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9lg8P23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983EE2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeKOI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbeKOI1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:18 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCD12252E;
        Wed, 14 Nov 2018 22:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234135;
        bh=3YjUD5jnfZOFBbs99hn+DueBbA90XJuNrWm6x9PLkHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9lg8P23k+ZdWfY7AkW5KB6nq6OXy6/co2JxPr2Utxbx0TMwnZgD8FSZ0dljRuD/t
         TR7ooHW7Pv/b1i/i0WLBI1/vdMGbZnImZQNgPZ2eqrljV2jq97O9miFZHrdxREe7VV
         eZy13guedV/drJSfbIw1Sezq/kC1e7HN7ePHXioA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shalom Toledo <shalomt@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 27/73] mlxsw: spectrum: Fix IP2ME CPU policer configuration
Date:   Wed, 14 Nov 2018 17:21:21 -0500
Message-Id: <20181114222207.98701-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shalom Toledo <shalomt@mellanox.com>

[ Upstream commit 96801552f846460fe9ac10f1b189602992f004e1 ]

The CPU policer used to police packets being trapped via a local route
(IP2ME) was incorrectly configured to police based on bytes per second
instead of packets per second.

Change the policer to police based on packets per second and avoid
packet loss under certain circumstances.

Fixes: 9148e7cf73ce ("mlxsw: spectrum: Add policers for trap groups")
Signed-off-by: Shalom Toledo <shalomt@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 30bb2c533cec..ada644d90029 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3519,7 +3519,6 @@ static int mlxsw_sp_cpu_policers_set(struct mlxsw_core *mlxsw_core)
 			burst_size = 7;
 			break;
 		case MLXSW_REG_HTGT_TRAP_GROUP_SP_IP2ME:
-			is_bytes = true;
 			rate = 4 * 1024;
 			burst_size = 4;
 			break;
-- 
2.17.1

