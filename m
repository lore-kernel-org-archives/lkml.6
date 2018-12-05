Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FB0C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC2B20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgmEDpBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC2B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeLEJjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeLEJjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:03 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE57D20878;
        Wed,  5 Dec 2018 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002742;
        bh=YmedVj6Aid15qfQhC6u8lTqayvURBq31CWKJdNaJENU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgmEDpBOy7/QT2ChpS7G0srRa+kzh5Rr8R814PXEEq5uqr3wIhHGEg5z6wwySE/by
         NdVJnoVZVQgRyc4UvjAz53ESwM2jW+2GrBorkA2d92Ge11SorCMKCBnH4S/eOG8NMa
         rPjonCVTCAF+syRTH00Qj/KQDJVK69uZLtLkS9gU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 054/123] RDMA/core: Add GIDs while changing MAC addr only for registered ndev
Date:   Wed,  5 Dec 2018 04:34:46 -0500
Message-Id: <20181205093555.5386-54-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit d52ef88a9f4be523425730da3239cf87bee936da ]

Currently when MAC address is changed, regardless of the netdev reg_state,
GID entries are removed and added to reflect the new MAC address and new
default GID entries.

When a bonding device is used and the underlying PCI device is removed
several netdevice events are generated. Two events of the interest are
CHANGEADDR and UNREGISTER event on lower(slave) netdevice of the bond
netdevice.

Sometimes CHANGEADDR event is generated when netdev state is
UNREGISTERING (after UNREGISTER event is generated). In this scenario, GID
entries for default GIDs are added and never deleted because GID entries
are deleted only when netdev state is < UNREGISTERED.

This leads to non zero reference count on the netdevice. Due to this, PCI
device unbind operation is getting stuck.

To avoid it, when changing mac address, add GID entries only if netdev is
in REGISTERED state.

Fixes: 03db3a2d81e6 ("IB/core: Add RoCE GID table management")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index ee366199b169..25d43c8f1c2a 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -767,8 +767,10 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
 
 	case NETDEV_CHANGEADDR:
 		cmds[0] = netdev_del_cmd;
-		cmds[1] = add_default_gid_cmd;
-		cmds[2] = add_cmd;
+		if (ndev->reg_state == NETREG_REGISTERED) {
+			cmds[1] = add_default_gid_cmd;
+			cmds[2] = add_cmd;
+		}
 		break;
 
 	case NETDEV_CHANGEUPPER:
-- 
2.17.1

