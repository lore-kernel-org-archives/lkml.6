Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeBAKZb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:25:31 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:37586 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeBAKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:25:30 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc: Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] net: bridge: Fix uninitialized error in br_fdb_sync_static()
Date: Thu,  1 Feb 2018 11:25:27 +0100
Message-Id: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.1.2.:

    net/bridge/br_fdb.c: In function ‘br_fdb_sync_static’:
    net/bridge/br_fdb.c:996: warning: ‘err’ may be used uninitialized in this function

Indeed, if the list is empty, err will be uninitialized, and will be
propagated up as the function return value.

Fix this by preinitializing err to zero.

Fixes: eb7935830d00b9e0 ("net: bridge: use rhashtable for fdbs")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/bridge/br_fdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index dc87fbc9a23b04e6..d9e69e4514beb20d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -993,7 +993,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)
 {
 	struct net_bridge_fdb_entry *f, *tmp;
-	int err;
+	int err = 0;
 
 	ASSERT_RTNL();
 
-- 
2.7.4
