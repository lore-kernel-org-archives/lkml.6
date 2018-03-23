Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeCWWx7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:53:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCWWx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:53:57 -0400
From: Colin King <colin.king@canonical.com>
To: Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S . Miller" <davem@davemloft.net>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] batman-adv: don't pass a NULL hard_iface to batadv_hardif_put
Date: Fri, 23 Mar 2018 22:53:50 +0000
Message-Id: <20180323225350.7350-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where hard_iface is NULL, the error path may pass a null
pointer to batadv_hardif_put causing a null pointer dereference error.
Avoid this by only calling the function if  hard_iface not null.

Detected by CoverityScan, CID#1466456 ("Explicit null dereferenced")

Fixes: 53dd9a68ba68 ("batman-adv: add multicast flags netlink support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/batman-adv/multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index de3a055f7dd8..bd0ea374d043 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1536,7 +1536,7 @@ batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
 
 	if (!ret && primary_if)
 		*primary_if = hard_iface;
-	else
+	else if (hard_iface)
 		batadv_hardif_put(hard_iface);
 
 	return ret;
-- 
2.15.1
