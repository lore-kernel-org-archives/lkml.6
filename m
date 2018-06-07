Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J324IbtMGVtEYwAAmS7hNA
	; Thu, 07 Jun 2018 15:18:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3DA25608B8; Thu,  7 Jun 2018 15:18:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6BD586074D;
	Thu,  7 Jun 2018 15:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BD586074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936048AbeFGPSh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:18:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41285 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935690AbeFGO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:31 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbh-0005Zs-7U; Thu, 07 Jun 2018 15:09:41 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002zJ-Q4; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tejun Heo" <tj@kernel.org>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Adam Wallis" <awallis@codeaurora.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Lai Jiangshan" <laijs@cn.fujitsu.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.211503978@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 198/410] kernel/async.c: revert "async: simplify
 lowest_in_progress()"
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

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 4f7e988e63e336827f4150de48163bed05d653bd upstream.

This reverts commit 92266d6ef60c ("async: simplify lowest_in_progress()")
which was simply wrong: In the case where domain is NULL, we now use the
wrong offsetof() in the list_first_entry macro, so we don't actually
fetch the ->cookie value, but rather the eight bytes located
sizeof(struct list_head) further into the struct async_entry.

On 64 bit, that's the data member, while on 32 bit, that's a u64 built
from func and data in some order.

I think the bug happens to be harmless in practice: It obviously only
affects callers which pass a NULL domain, and AFAICT the only such
caller is

  async_synchronize_full() ->
  async_synchronize_full_domain(NULL) ->
  async_synchronize_cookie_domain(ASYNC_COOKIE_MAX, NULL)

and the ASYNC_COOKIE_MAX means that in practice we end up waiting for
the async_global_pending list to be empty - but it would break if
somebody happened to pass (void*)-1 as the data element to
async_schedule, and of course also if somebody ever does a
async_synchronize_cookie_domain(, NULL) with a "finite" cookie value.

Maybe the "harmless in practice" means this isn't -stable material.  But
I'm not completely confident my quick git grep'ing is enough, and there
might be affected code in one of the earlier kernels that has since been
removed, so I'll leave the decision to the stable guys.

Link: http://lkml.kernel.org/r/20171128104938.3921-1-linux@rasmusvillemoes.dk
Fixes: 92266d6ef60c "async: simplify lowest_in_progress()"
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Adam Wallis <awallis@codeaurora.org>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/async.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/kernel/async.c
+++ b/kernel/async.c
@@ -84,20 +84,24 @@ static atomic_t entry_count;
 
 static async_cookie_t lowest_in_progress(struct async_domain *domain)
 {
-	struct list_head *pending;
+	struct async_entry *first = NULL;
 	async_cookie_t ret = ASYNC_COOKIE_MAX;
 	unsigned long flags;
 
 	spin_lock_irqsave(&async_lock, flags);
 
-	if (domain)
-		pending = &domain->pending;
-	else
-		pending = &async_global_pending;
+	if (domain) {
+		if (!list_empty(&domain->pending))
+			first = list_first_entry(&domain->pending,
+					struct async_entry, domain_list);
+	} else {
+		if (!list_empty(&async_global_pending))
+			first = list_first_entry(&async_global_pending,
+					struct async_entry, global_list);
+	}
 
-	if (!list_empty(pending))
-		ret = list_first_entry(pending, struct async_entry,
-				       domain_list)->cookie;
+	if (first)
+		ret = first->cookie;
 
 	spin_unlock_irqrestore(&async_lock, flags);
 	return ret;
