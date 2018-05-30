Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeE3L2p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:28:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60958 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752453AbeE3LHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:06 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Florian Westphal" <fw@strlen.de>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Cong Wang" <xiyou.wangcong@gmail.com>,
        "Eric Dumazet" <eric.dumazet@gmail.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.948453769@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 090/153] netfilter: ipt_CLUSTERIP: fix a refcount bug
 in clusterip_config_find_get()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit db93a3632b0f8773a3899e04a3a3e0aa7a26eb46 upstream.

In clusterip_config_find_get() we hold RCU read lock so it could
run concurrently with clusterip_config_entry_put(), as a result,
the refcnt could go back to 1 from 0, which leads to a double
list_del()... Just replace refcount_inc() with
refcount_inc_not_zero(), as for c->refcount.

Fixes: d73f33b16883 ("netfilter: CLUSTERIP: RCU conversion")
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.2: s/refcount/atomic/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/netfilter/ipt_CLUSTERIP.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -135,8 +135,12 @@ clusterip_config_find_get(__be32 cluster
 	if (c) {
 		if (unlikely(!atomic_inc_not_zero(&c->refcount)))
 			c = NULL;
-		else if (entry)
-			atomic_inc(&c->entries);
+		else if (entry) {
+			if (unlikely(!atomic_inc_not_zero(&c->entries))) {
+				clusterip_config_put(c);
+				c = NULL;
+			}
+		}
 	}
 	rcu_read_unlock_bh();
 
