Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbeEAE0W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 00:26:22 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40372 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeEAE0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 00:26:20 -0400
X-Google-Smtp-Source: AB8JxZr/GR1IlVeRMHJYjUjViKl22kcz2iUWRtt0uqdQqulkZRBOky94W/p9vufVuuaB634LbhbIlA==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:TIPC NETWORK LAYER),
        tipc-discussion@lists.sourceforge.net (open list:TIPC NETWORK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tipc: fix a potential missing-check bug
Date: Mon, 30 Apr 2018 23:26:01 -0500
Message-Id: <1525148761-11091-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tipc_link_xmit(), the member field "len" of l->backlog[imp] must
be less than the member field "limit" of l->backlog[imp] when imp is
equal to TIPC_SYSTEM_IMPORTANCE. Otherwise, an error code, i.e., -ENOBUFS,
is returned. This is enforced by the security check. However, at the end
of tipc_link_xmit(), the length of "list" is added to l->backlog[imp].len
without any further check. This can potentially cause unexpected values for
l->backlog[imp].len. If imp is equal to TIPC_SYSTEM_IMPORTANCE and the
original value of l->backlog[imp].len is less than l->backlog[imp].limit,
after this addition, l->backlog[imp] could be larger than
l->backlog[imp].limit. That means the security check can potentially be
bypassed, especially when an adversary can control the length of "list".

This patch performs such a check after the modification to
l->backlog[imp].len (if imp is TIPC_SYSTEM_IMPORTANCE) to avoid such
security issues. An error code will be returned if an unexpected value of
l->backlog[imp].len is generated.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/tipc/link.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 695acb7..62972fa 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -948,6 +948,11 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 			continue;
 		}
 		l->backlog[imp].len += skb_queue_len(list);
+		if (imp == TIPC_SYSTEM_IMPORTANCE &&
+		    l->backlog[imp].len >= l->backlog[imp].limit) {
+			pr_warn("%s<%s>, link overflow", link_rst_msg, l->name);
+			return -ENOBUFS;
+		}
 		skb_queue_splice_tail_init(list, backlogq);
 	}
 	l->snd_nxt = seqno;
-- 
2.7.4
