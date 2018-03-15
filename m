Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeCOMfm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:35:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:38 -0400
Message-Id: <20180315123202.630084556@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 06/11] sched/wait,fscache: Replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-6.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/fscache/cookie.c           |    7 ++++---
 include/linux/fscache-cache.h |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -557,9 +557,10 @@ void __fscache_disable_cookie(struct fsc
 	 * n_active reaches 0).  This makes sure outstanding reads and writes
 	 * have completed.
 	 */
-	if (!atomic_dec_and_test(&cookie->n_active))
-		wait_on_atomic_t(&cookie->n_active, atomic_t_wait,
-				 TASK_UNINTERRUPTIBLE);
+	if (!atomic_dec_and_test(&cookie->n_active)) {
+		wait_var_event(&cookie->n_active,
+			       !atomic_read(&cookie->n_active));
+	}
 
 	/* Make sure any pending writes are cancelled. */
 	if (cookie->def->type != FSCACHE_COOKIE_TYPE_INDEX)
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -496,7 +496,7 @@ static inline bool __fscache_unuse_cooki
 
 static inline void __fscache_wake_unused_cookie(struct fscache_cookie *cookie)
 {
-	wake_up_atomic_t(&cookie->n_active);
+	wake_up_var(&cookie->n_active);
 }
 
 /**
