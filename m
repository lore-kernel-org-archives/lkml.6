Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424856AbeE1LYm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424453AbeE1LYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:24:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 011/272] aio: fix io_destroy(2) vs. lookup_ioctx() race
Date: Mon, 28 May 2018 12:00:44 +0200
Message-Id: <20180528100241.222266816@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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

Cc: stable@kernel.org
Fixes: a6d7cff472e "fs/aio: Add explicit RCU grace period when freeing kioctx"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1087,8 +1087,8 @@ static struct kioctx *lookup_ioctx(unsig
 
 	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
-		percpu_ref_get(&ctx->users);
-		ret = ctx;
+		if (percpu_ref_tryget_live(&ctx->users))
+			ret = ctx;
 	}
 out:
 	rcu_read_unlock();
