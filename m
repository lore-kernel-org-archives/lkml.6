Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeDJBRn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:17:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42228 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDJBRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:17:41 -0400
X-Google-Smtp-Source: AIpwx4/CMq8Lho+WDwJafbNAqqr5kLozyTqn8sUhOswhssRvFpcnQT7nzf8X5AcLwaelOvuWHaF8ew==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: jon.maloy@ericsson.com, ying.xue@windriver.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] net: tipc: Replace GFP_ATOMIC with GFP_KERNEL in tipc_mon_create
Date: Tue, 10 Apr 2018 09:17:33 +0800
Message-Id: <1523323053-28127-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tipc_mon_create() is never called in atomic context.

The call chain ending up at dn_route_init() is:
[1] tipc_mon_create() <- tipc_enable_bearer() <- tipc_nl_bearer_enable()
tipc_nl_bearer_enable() calls rtnl_lock(), which indicates this function
is not called in atomic context.

Despite never getting called from atomic context,
tipc_mon_create() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Modify the description of GFP_ATOMIC in v1.
  Thank Eric for good advice.
---
 net/tipc/monitor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 9e109bb..9714d80 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -604,9 +604,9 @@ int tipc_mon_create(struct net *net, int bearer_id)
 	if (tn->monitors[bearer_id])
 		return 0;
 
-	mon = kzalloc(sizeof(*mon), GFP_ATOMIC);
-	self = kzalloc(sizeof(*self), GFP_ATOMIC);
-	dom = kzalloc(sizeof(*dom), GFP_ATOMIC);
+	mon = kzalloc(sizeof(*mon), GFP_KERNEL);
+	self = kzalloc(sizeof(*self), GFP_KERNEL);
+	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
 	if (!mon || !self || !dom) {
 		kfree(mon);
 		kfree(self);
-- 
1.9.1
