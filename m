Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033235AbeE1KUm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033218AbeE1KUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:20:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 144/268] mm/mempolicy.c: avoid use uninitialized preferred_node
Date: Mon, 28 May 2018 12:01:58 +0200
Message-Id: <20180528100218.647890361@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>

[ Upstream commit 8970a63e965b43288c4f5f40efbc2bbf80de7f16 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mempolicy.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2142,6 +2142,9 @@ bool __mpol_equal(struct mempolicy *a, s
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
+		/* a's ->flags is the same as b's */
+		if (a->flags & MPOL_F_LOCAL)
+			return true;
 		return a->v.preferred_node == b->v.preferred_node;
 	default:
 		BUG();
