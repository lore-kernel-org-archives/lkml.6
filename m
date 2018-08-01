Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB383C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6025020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6025020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407617AbeHATYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:24:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436564AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3EC2E04;
        Wed,  1 Aug 2018 16:53:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 015/336] mlxsw: spectrum_switchdev: Fix port_vlan refcounting
Date:   Wed,  1 Aug 2018 18:45:50 +0200
Message-Id: <20180801165029.543271655@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 9e25826ffc942e985b8595b2f1cf2065d3880514 ]

Switchdev notifications for addition of SWITCHDEV_OBJ_ID_PORT_VLAN are
distributed not only on clean addition, but also when flags on an
existing VLAN are changed. mlxsw_sp_bridge_port_vlan_add() calls
mlxsw_sp_port_vlan_get() to get at the port_vlan in question, which
implicitly references the object. This then leads to discrepancies in
reference counting when the VLAN is removed. spectrum.c warns about the
problem when the module is removed:

[13578.493090] WARNING: CPU: 0 PID: 2454 at drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2973 mlxsw_sp_port_remove+0xfd/0x110 [mlxsw_spectrum]
[...]
[13578.627106] Call Trace:
[13578.629617]  mlxsw_sp_fini+0x2a/0xe0 [mlxsw_spectrum]
[13578.634748]  mlxsw_core_bus_device_unregister+0x3e/0x130 [mlxsw_core]
[13578.641290]  mlxsw_pci_remove+0x13/0x40 [mlxsw_pci]
[13578.646238]  pci_device_remove+0x31/0xb0
[13578.650244]  device_release_driver_internal+0x14f/0x220
[13578.655562]  driver_detach+0x32/0x70
[13578.659183]  bus_remove_driver+0x47/0xa0
[13578.663134]  pci_unregister_driver+0x1e/0x80
[13578.667486]  mlxsw_sp_module_exit+0xc/0x3fa [mlxsw_spectrum]
[13578.673207]  __x64_sys_delete_module+0x13b/0x1e0
[13578.677888]  ? exit_to_usermode_loop+0x78/0x80
[13578.682374]  do_syscall_64+0x39/0xe0
[13578.685976]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix by putting the port_vlan when mlxsw_sp_port_vlan_bridge_join()
determines it's a flag-only change.

Fixes: b3529af6bb0d ("spectrum: Reference count VLAN entries")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1013,8 +1013,10 @@ mlxsw_sp_port_vlan_bridge_join(struct ml
 	int err;
 
 	/* No need to continue if only VLAN flags were changed */
-	if (mlxsw_sp_port_vlan->bridge_port)
+	if (mlxsw_sp_port_vlan->bridge_port) {
+		mlxsw_sp_port_vlan_put(mlxsw_sp_port_vlan);
 		return 0;
+	}
 
 	err = mlxsw_sp_port_vlan_fid_join(mlxsw_sp_port_vlan, bridge_port);
 	if (err)


