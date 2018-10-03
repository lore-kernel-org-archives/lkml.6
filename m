Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A152C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1E82098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1E82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJCOUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:20:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:20:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w937WX5c2264524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 00:32:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w937WWDJ2264521;
        Wed, 3 Oct 2018 00:32:32 -0700
Date:   Wed, 3 Oct 2018 00:32:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Guenter Roeck <tipbot@zytor.com>
Message-ID: <tip-e4a02ed2aaf447fa849e3254bfdb3b9b01e1e520@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, linux@roeck-us.net,
        torvalds@linux-foundation.org, chris@chris-wilson.co.uk,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: chris@chris-wilson.co.uk, peterz@infradead.org,
          torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          linux@roeck-us.net, will.deacon@arm.com
In-Reply-To: <1538516929-9734-1-git-send-email-linux@roeck-us.net>
References: <1538516929-9734-1-git-send-email-linux@roeck-us.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/ww_mutex: Fix runtime warning in the
 WW mutex selftest
Git-Commit-ID: e4a02ed2aaf447fa849e3254bfdb3b9b01e1e520
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e4a02ed2aaf447fa849e3254bfdb3b9b01e1e520
Gitweb:     https://git.kernel.org/tip/e4a02ed2aaf447fa849e3254bfdb3b9b01e1e520
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Tue, 2 Oct 2018 14:48:49 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Oct 2018 08:56:31 +0200

locking/ww_mutex: Fix runtime warning in the WW mutex selftest

If CONFIG_WW_MUTEX_SELFTEST=y is enabled, booting an image
in an arm64 virtual machine results in the following
traceback if 8 CPUs are enabled:

  DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
  WARNING: CPU: 2 PID: 537 at kernel/locking/mutex.c:1033 __mutex_unlock_slowpath+0x1a8/0x2e0
  ...
  Call trace:
   __mutex_unlock_slowpath()
   ww_mutex_unlock()
   test_cycle_work()
   process_one_work()
   worker_thread()
   kthread()
   ret_from_fork()

If requesting b_mutex fails with -EDEADLK, the error variable
is reassigned to the return value from calling ww_mutex_lock
on a_mutex again. If this call fails, a_mutex is not locked.
It is, however, unconditionally unlocked subsequently, causing
the reported warning. Fix the problem by using two error variables.

With this change, the selftest still fails as follows:

  cyclic deadlock not resolved, ret[7/8] = -35

However, the traceback is gone.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: d1b42b800e5d0 ("locking/ww_mutex: Add kselftests for resolving ww_mutex cyclic deadlocks")
Link: http://lkml.kernel.org/r/1538516929-9734-1-git-send-email-linux@roeck-us.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 0be047dbd897..65a3b7e55b9f 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -260,7 +260,7 @@ static void test_cycle_work(struct work_struct *work)
 {
 	struct test_cycle *cycle = container_of(work, typeof(*cycle), work);
 	struct ww_acquire_ctx ctx;
-	int err;
+	int err, erra = 0;
 
 	ww_acquire_init(&ctx, &ww_class);
 	ww_mutex_lock(&cycle->a_mutex, &ctx);
@@ -270,17 +270,19 @@ static void test_cycle_work(struct work_struct *work)
 
 	err = ww_mutex_lock(cycle->b_mutex, &ctx);
 	if (err == -EDEADLK) {
+		err = 0;
 		ww_mutex_unlock(&cycle->a_mutex);
 		ww_mutex_lock_slow(cycle->b_mutex, &ctx);
-		err = ww_mutex_lock(&cycle->a_mutex, &ctx);
+		erra = ww_mutex_lock(&cycle->a_mutex, &ctx);
 	}
 
 	if (!err)
 		ww_mutex_unlock(cycle->b_mutex);
-	ww_mutex_unlock(&cycle->a_mutex);
+	if (!erra)
+		ww_mutex_unlock(&cycle->a_mutex);
 	ww_acquire_fini(&ctx);
 
-	cycle->result = err;
+	cycle->result = err ?: erra;
 }
 
 static int __test_cycle(unsigned int nthreads)
