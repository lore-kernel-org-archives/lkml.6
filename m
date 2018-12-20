Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93447218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298348;
	bh=9ikH5Dsnnc9iaLVTqfUGywIv42k0W9qhuX7tvqSLRxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nl53NVCdEZFF0xjtieUGbztjn0fbgaTbtS3YuV2+oBjnvGfkXRBTfOlcAJerBTZz5
	 wGGWz788Lpf0VX57GAx9iVO9q0CQP693Sa2jawgj0y01ebmwBg6kBTGgHj5w3NEIuj
	 Cd3R5tJKfB/QN7nKOsZp01iRCGcPEBcbr9aO2ai0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbeLTJbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:31:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733062AbeLTJbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:31:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766B020989;
        Thu, 20 Dec 2018 09:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298267;
        bh=9ikH5Dsnnc9iaLVTqfUGywIv42k0W9qhuX7tvqSLRxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x4/tR4Hp160xOPHmpF16ohi1+hveBa21txcJrO6YIpSNrfnZTxITnZBBk/VWvOeW+
         oyNoe3X5XI0Whai4vGLhZpPKNjjlOk1aFSoSC9K2FTETEYHh943hhk4O3zVjd45iqX
         FUnClBpwuDHVlXW1PGj006btLwoXDcC21jwBwL7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 60/67] mlxsw: spectrum_switchdev: Fix VLAN device deletion via ioctl
Date:   Thu, 20 Dec 2018 10:19:12 +0100
Message-Id: <20181220085905.912936650@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit 993107fea5eefdfdfde1ca38d3f01f0bebf76e77 ]

When deleting a VLAN device using an ioctl the netdev is unregistered
before the VLAN filter is updated via ndo_vlan_rx_kill_vid(). It can
lead to a use-after-free in mlxsw in case the VLAN device is deleted
while being enslaved to a bridge.

The reason for the above is that when mlxsw receives the CHANGEUPPER
event, it wrongly assumes that the VLAN device is no longer its upper
and thus destroys the internal representation of the bridge port despite
the reference count being non-zero.

Fix this by checking if the VLAN device is our upper using its real
device. In net-next I'm going to remove this trick and instead make
mlxsw completely agnostic to the order of the events.

Fixes: c57529e1d5d8 ("mlxsw: spectrum: Replace vPorts with Port-VLAN")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 7715f1ed2bcb..4eb64cb0d9a1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -286,7 +286,13 @@ static bool
 mlxsw_sp_bridge_port_should_destroy(const struct mlxsw_sp_bridge_port *
 				    bridge_port)
 {
-	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(bridge_port->dev);
+	struct net_device *dev = bridge_port->dev;
+	struct mlxsw_sp *mlxsw_sp;
+
+	if (is_vlan_dev(dev))
+		mlxsw_sp = mlxsw_sp_lower_get(vlan_dev_real_dev(dev));
+	else
+		mlxsw_sp = mlxsw_sp_lower_get(dev);
 
 	/* In case ports were pulled from out of a bridged LAG, then
 	 * it's possible the reference count isn't zero, yet the bridge
@@ -2020,7 +2026,7 @@ mlxsw_sp_bridge_8021d_port_leave(struct mlxsw_sp_bridge_device *bridge_device,
 
 	vid = is_vlan_dev(dev) ? vlan_dev_vlan_id(dev) : 1;
 	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_vid(mlxsw_sp_port, vid);
-	if (WARN_ON(!mlxsw_sp_port_vlan))
+	if (!mlxsw_sp_port_vlan)
 		return;
 
 	mlxsw_sp_port_vlan_bridge_leave(mlxsw_sp_port_vlan);
-- 
2.19.1



