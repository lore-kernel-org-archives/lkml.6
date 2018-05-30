Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbeE3Ll6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:41:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60707 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752102AbeE3LG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:59 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michal Hocko" <mhocko@kernel.org>,
        "Dmitriy Vyukov" <dvyukov@google.com>,
        "Yisheng Xie" <xieyisheng1@huawei.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Alexander Potapenko" <glider@google.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.889299916@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 142/153] mm/mempolicy.c: avoid use uninitialized
 preferred_node
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>

commit 8970a63e965b43288c4f5f40efbc2bbf80de7f16 upstream.

Alexander reported a use of uninitialized memory in __mpol_equal(),
which is caused by incorrect use of preferred_node.

When mempolicy in mode MPOL_PREFERRED with flags MPOL_F_LOCAL, it uses
numa_node_id() instead of preferred_node, however, __mpol_equal() uses
preferred_node without checking whether it is MPOL_F_LOCAL or not.

[akpm@linux-foundation.org: slight comment tweak]
Link: http://lkml.kernel.org/r/4ebee1c2-57f6-bcb8-0e2d-1833d1ee0bb7@huawei.com
Fixes: fc36b8d3d819 ("mempolicy: use MPOL_F_LOCAL to Indicate Preferred Local Policy")
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mempolicy.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2019,6 +2019,9 @@ int __mpol_equal(struct mempolicy *a, st
 	case MPOL_INTERLEAVE:
 		return nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
+		/* a's ->flags is the same as b's */
+		if (a->flags & MPOL_F_LOCAL)
+			return true;
 		return a->v.preferred_node == b->v.preferred_node;
 	default:
 		BUG();
