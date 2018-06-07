Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OzcIG3lDGVviCAAAmS7hNA
	; Thu, 07 Jun 2018 14:40:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 343BE607E7; Thu,  7 Jun 2018 14:40:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F2FA601C3;
	Thu,  7 Jun 2018 14:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F2FA601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934380AbeFGOj6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:39:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40523 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934351AbeFGOjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:39:55 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbL-0005Zs-O3; Thu, 07 Jun 2018 15:09:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003IN-TH; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michal Hocko" <mhocko@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Yisheng Xie" <xieyisheng1@huawei.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Dmitriy Vyukov" <dvyukov@google.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.822826031@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 391/410] mm/mempolicy.c: avoid use uninitialized
 preferred_node
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -2160,6 +2160,9 @@ bool __mpol_equal(struct mempolicy *a, s
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
+		/* a's ->flags is the same as b's */
+		if (a->flags & MPOL_F_LOCAL)
+			return true;
 		return a->v.preferred_node == b->v.preferred_node;
 	default:
 		BUG();
