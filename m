Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46414C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D61020849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676383;
	bh=eBzBnCItfae7bxtJKkziekdzsbbCs4KqrtdFXkmBMLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rVcOIUtN1hPN20Ew3GI2QuEWg1sSo1IoSlC9e2A/cb9jzLWp6x0O0oEcT2XfBclY8
	 dR9Cod+k9aDZv347RtUM4Y+R3mrbZ1k9AiARJ5r6EVlWaFznxan8lEWo5NX6dfYiKH
	 gVjI03fmuiws/Z7scKWr/pYhqVAADMCWcuEzVaxE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D61020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeLMEqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:46:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbeLMEal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A66920672;
        Thu, 13 Dec 2018 04:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675441;
        bh=eBzBnCItfae7bxtJKkziekdzsbbCs4KqrtdFXkmBMLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0ZL25z0sQpALJjLvaEDXmPXDK8KDZoRe2yChApC0uxLWZrJrR/PS1jwEoowy9mds
         b4rEKRkfIL4xn2RT0AKfsoP6xQnQIXgBr6BdKEqy1mGzXbUYrtYiKNuB6gg3rcZ+8F
         glNGLqnemSo93EF2RHZp3t7JZP6GN7S9+mprfHlw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 65/73] mlxsw: spectrum_switchdev: Fix VLAN device deletion via ioctl
Date:   Wed, 12 Dec 2018 23:28:30 -0500
Message-Id: <20181213042838.75160-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

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

