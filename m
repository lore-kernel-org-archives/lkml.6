Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBA0C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F6620645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F6620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeJNXlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:41:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35869 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbeJNXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLd-0004cF-6M; Sun, 14 Oct 2018 16:30:29 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000k0-N9; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.874534774@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 342/366] aio: fix io_destroy(2) vs. lookup_ioctx() race
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit baf10564fbb66ea222cae66fbff11c444590ffd9 upstream.

kill_ioctx() used to have an explicit RCU delay between removing the
reference from ->ioctx_table and percpu_ref_kill() dropping the refcount.
At some point that delay had been removed, on the theory that
percpu_ref_kill() itself contained an RCU delay.  Unfortunately, that was
the wrong kind of RCU delay and it didn't care about rcu_read_lock() used
by lookup_ioctx().  As the result, we could get ctx freed right under
lookup_ioctx().  Tejun has fixed that in a6d7cff472e ("fs/aio: Add explicit
RCU grace period when freeing kioctx"); however, that fix is not enough.

Suppose io_destroy() from one thread races with e.g. io_setup() from another;
CPU1 removes the reference from current->mm->ioctx_table[...] just as CPU2
has picked it (under rcu_read_lock()).  Then CPU1 proceeds to drop the
refcount, getting it to 0 and triggering a call of free_ioctx_users(),
which proceeds to drop the secondary refcount and once that reaches zero
calls free_ioctx_reqs().  That does
        INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
        queue_rcu_work(system_wq, &ctx->free_rwork);
and schedules freeing the whole thing after RCU delay.

In the meanwhile CPU2 has gotten around to percpu_ref_get(), bumping the
refcount from 0 to 1 and returned the reference to io_setup().

Tejun's fix (that queue_rcu_work() in there) guarantees that ctx won't get
freed until after percpu_ref_get().  Sure, we'd increment the counter before
ctx can be freed.  Now we are out of rcu_read_lock() and there's nothing to
stop freeing of the whole thing.  Unfortunately, CPU2 assumes that since it
has grabbed the reference, ctx is *NOT* going away until it gets around to
dropping that reference.

The fix is obvious - use percpu_ref_tryget_live() and treat failure as miss.
It's not costlier than what we currently do in normal case, it's safe to
call since freeing *is* delayed and it closes the race window - either
lookup_ioctx() comes before percpu_ref_kill() (in which case ctx->users
won't reach 0 until the caller of lookup_ioctx() drops it) or lookup_ioctx()
fails, ctx->users is unaffected and caller of lookup_ioctx() doesn't see
the object in question at all.

Fixes: a6d7cff472e "fs/aio: Add explicit RCU grace period when freeing kioctx"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1025,8 +1025,8 @@ static struct kioctx *lookup_ioctx(unsig
 
 	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
-		percpu_ref_get(&ctx->users);
-		ret = ctx;
+		if (percpu_ref_tryget_live(&ctx->users))
+			ret = ctx;
 	}
 out:
 	rcu_read_unlock();

