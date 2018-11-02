Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B4DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53512084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Q4qh4ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53512084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeKCDtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbeKCDtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E8D20847;
        Fri,  2 Nov 2018 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184051;
        bh=kOxteSRExmDSkUY1c9uqI60AZ9Uuvd7Sze2JYVlaXvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Q4qh4ulA+Hgq/AXlnIdpHO2xFptRFX+vfEchixRrIbqvdqqYUZ63OipQLXRVZlK0
         6xCHkqWKMOBf/eHgt9NzOmzpvCnSuxiKtp8oAUVQcirk62Xcci4NcgjgQdExSJ9gzd
         cd/+fwXvYIuSnHamxrLO/Tv1gQ5Rp6kkeGk5Q2VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 064/150] locking/ww_mutex: Fix runtime warning in the WW mutex selftest
Date:   Fri,  2 Nov 2018 19:33:46 +0100
Message-Id: <20181102182908.079653218@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e4a02ed2aaf447fa849e3254bfdb3b9b01e1e520 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 0e4cd64ad2c0..654977862b06 100644
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
-- 
2.17.1



