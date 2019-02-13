Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61485C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31704222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025584;
	bh=rhUvPPBNANly9SLzat6WICnDg7ZlhnGAs2h+tLtIBiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdC7ka3iVQKIoAq68WGTtY1uxKua2TIyEz0OU9pCLzyoGRHXAD7BPJRBuYPZUVCAs
	 Sd+ayIg2ydVAbXyE5d6WiJXUy14Sz9ArEnISOqZI4HbRxQRAeZ4NtMhNkVUmpOcL8e
	 c+r83fI9puGdTHoGKI0Zy7nBP+aqGt2YEEaoJVBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbfBMCjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbfBMCjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 797FF222CF;
        Wed, 13 Feb 2019 02:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025574;
        bh=rhUvPPBNANly9SLzat6WICnDg7ZlhnGAs2h+tLtIBiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijD1KiaWVlhqFtaulhGoTZgjJNvTUTPfAeSj0clRP/x0ghLCDsTJJ3hY/grGAj4kI
         1rYTUe9c97edLG/yWiJ8RAQo2zZ6Ao6NdL9Td9Gv8bDByDPpeP/OnvS+X2kLw4DUC/
         cIpnbxhRDg3GS7w9l4LqcdiygQYT7nT5KdPpb2qo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        bridge@lists.linux-foundation.org,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 79/83] net: bridge: Mark FDB entries that were added by user as such
Date:   Tue, 12 Feb 2019 21:36:57 -0500
Message-Id: <20190213023701.20286-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 710ae72877378e7cde611efd30fe90502a6e5b30 ]

Externally learned entries can be added by a user or by a switch driver
that is notifying the bridge driver about entries that were learned in
hardware.

In the first case, the entries are not marked with the 'added_by_user'
flag, which causes switch drivers to ignore them and not offload them.

The 'added_by_user' flag can be set on externally learned FDB entries
based on the 'swdev_notify' parameter in br_fdb_external_learn_add(),
which effectively means if the created / updated FDB entry was added by
a user or not.

Fixes: 816a3bed9549 ("switchdev: Add fdb.added_by_user to switchdev notifications")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_fdb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 502f66349530..4d4b9b5ea1c1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1088,6 +1088,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			err = -ENOMEM;
 			goto err_unlock;
 		}
+		if (swdev_notify)
+			fdb->added_by_user = 1;
 		fdb->added_by_external_learn = 1;
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
@@ -1107,6 +1109,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
+		if (swdev_notify)
+			fdb->added_by_user = 1;
+
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
-- 
2.19.1

