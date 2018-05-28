Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423948AbeE1Lvb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423466AbeE1LJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 125/272] net: qualcomm: rmnet: check for null ep to avoid null pointer dereference
Date: Mon, 28 May 2018 12:02:38 +0200
Message-Id: <20180528100251.639539158@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 0c29ba1b43df1eb7d8beb03fc929d2dac4c15f7e ]

The call to rmnet_get_endpoint can potentially return NULL so check
for this to avoid any subsequent null pointer dereferences on a NULL
ep.

Detected by CoverityScan, CID#1465385 ("Dereference null return value")

Fixes: 23790ef12082 ("net: qualcomm: rmnet: Allow to configure flags for existing devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -307,6 +307,8 @@ static int rmnet_changelink(struct net_d
 	if (data[IFLA_VLAN_ID]) {
 		mux_id = nla_get_u16(data[IFLA_VLAN_ID]);
 		ep = rmnet_get_endpoint(port, priv->mux_id);
+		if (!ep)
+			return -ENODEV;
 
 		hlist_del_init_rcu(&ep->hlnode);
 		hlist_add_head_rcu(&ep->hlnode, &port->muxed_ep[mux_id]);
