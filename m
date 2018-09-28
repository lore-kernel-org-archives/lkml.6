Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7040204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7040204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeI2ASf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:18:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeI2ASf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:18:35 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9E9A3002738;
        Fri, 28 Sep 2018 17:53:41 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CAAF2010D95;
        Fri, 28 Sep 2018 17:53:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] locking/lockdep: Add a faster path in __lock_release()
Date:   Fri, 28 Sep 2018 13:53:19 -0400
Message-Id: <1538157201-29173-4-git-send-email-longman@redhat.com>
In-Reply-To: <1538157201-29173-1-git-send-email-longman@redhat.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 28 Sep 2018 17:53:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __lock_release() is called, the most likely unlock scenario is
on the innermost lock in the chain.  In this case, we can skip some of
the checks and provide a faster path to completion.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index add0468..ca002c0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3625,6 +3625,13 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
 
+	/*
+	 * The most likely case is when the unlock is on the innermost
+	 * lock. In this case, we are done!
+	 */
+	if (i == depth - 1)
+		return 1;
+
 	if (reacquire_held_locks(curr, depth, i + 1))
 		return 0;
 
@@ -3632,10 +3639,14 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	 * We had N bottles of beer on the wall, we drank one, but now
 	 * there's not N-1 bottles of beer left on the wall...
 	 */
-	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1))
-		return 0;
+	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1);
 
-	return 1;
+	/*
+	 * Since reacquire_held_locks() would have called check_chain_key()
+	 * indirectly via __lock_acquire(), we don't need to do it again
+	 * on return.
+	 */
+	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read)
-- 
1.8.3.1

