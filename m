Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F119C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4608E20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791156;
	bh=UZ4W0Io4q0Btk0t5gSOp3ArpXWDMUdI8OcVvFYfUs2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f9fuUbXneg49ZzO7d0/rsrcQ/YrPvmJPD7D6CG9is6pI1N4Lq3v1oK4+NEjj1sIV1
	 BULKO271BKCTjjO4uuf3Tdjdrp5gY+F3cRECCzU+CcmS93l0oA7lSHspPT7jkkHKA+
	 zF5z1DEZA3JKnjvvQ8rRnGO5ONYRik7+cVIiFtSc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4608E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbeLNMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbeLNMFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1252148E;
        Fri, 14 Dec 2018 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789101;
        bh=UZ4W0Io4q0Btk0t5gSOp3ArpXWDMUdI8OcVvFYfUs2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbKVqywwDWRqWOvVrFhU9zyJzoNpSPo5rqRuhAI9MTUITNGePGCcAHoA1CIIFLB/i
         0xGmDz+UcJDG7a8LIItK8bs3JFk2IN89Tk/+/qobS/XY8Qjp5BHsVhWdYQAnHK5Asz
         Dhe0ysX0inMEFPvpOeTXRpsg3cOOOCDKoJ+M6lxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/142] RDMA/core: Add GIDs while changing MAC addr only for registered ndev
Date:   Fri, 14 Dec 2018 12:59:17 +0100
Message-Id: <20181214115749.943982347@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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
2.19.1



