Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE8C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415CB21471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWlu3ebf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415CB21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJCEeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:34:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42296 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJCEeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:34:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so2381037plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AIv3Hck91Zar7ePPbFWA8Vaq9kG0rplMiv6X6Z0VH1w=;
        b=oWlu3ebfKpLi2b92pIkpFU56y8rLfBcmA9zeeVWVmHkAQr/Win93G5tMAoV5YVwmph
         MbL0e+KCKaD97UobmylqDEatVpYR3w0xXhKe76b3AYHz4ot4Hzu76VI3DQoLqjsIMvKC
         CHtgpX6fDMmxjmQdU5gxl6myH7APuL82KzXZ3h8ChAdySc4kyKf+X1eWpnGzzi5tcVBy
         MRgp7HtNSwhYb6jA6dMtDqFNk1TzYER9z41hpqqBMtWfoNsJQ6vSAK+VsP+9RIDPopZD
         Nhkpcfov7Tlwhaiteiu0CXtm9ABXr0ZfMkKUVIscR5J7dURSDuOx5VcXdH7CWlyd/n1G
         8wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AIv3Hck91Zar7ePPbFWA8Vaq9kG0rplMiv6X6Z0VH1w=;
        b=M7fnoaNJHoKUSod1HU0QBzRTPCRvF8BDj3Sa7rs3Zud5fF6LR6zHlBXZBrRzV+tsze
         oFuNfoTs8wVzftkQd8XK8zwqvD9C4OwHbCxrSTh5a6ZVCqVwg2ELvzGs9i0bYv81wZKa
         8lIwre8eWViZeT2fPYJoi7twLzXg4W1BIY3jxdkwqBW8cOz8RMJ5KChPg1FH8xSixwAL
         NlnbF6S8KTk4NgQ+eNouYZml9oFxAsQ6yf6QLNXIZoMe3e1r/PWX7iUc3um5GngQbDIS
         olr+v27ghRyWgAtrmWP8HHqemg9lYIAhQHSY7IFn+MmBXOaAPJhU60zhOYcfKOUzdP49
         x2dw==
X-Gm-Message-State: ABuFfohzeb5rfA+20Zyfefl1R+9WAaQvt4BNXEMIeaGXnxcudyzXy55j
        7+irHLYFtHzMsrmTiNF6vPaHl/mS
X-Google-Smtp-Source: ACcGV62W0JLYMdxeaxxru5OPiu7g1VmZRjpQ6FG4YIaej/l7OrlWwArq2iGDupqTMmXARMhXgpsA+A==
X-Received: by 2002:a17:902:246a:: with SMTP id m39-v6mr18332931plg.57.1538516937314;
        Tue, 02 Oct 2018 14:48:57 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r1-v6sm18540312pgo.81.2018.10.02.14.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:48:56 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Will Deacon <will.deacon@arm.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] locking: Fix runtime warning in ww mutex selftest
Date:   Tue,  2 Oct 2018 14:48:49 -0700
Message-Id: <1538516929-9734-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_WW_MUTEX_SELFTEST is enabled, booting an image
in an arm64 virtual machine results in the following
traceback if 8 CPUs are enabled.

DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
WARNING: CPU: 2 PID: 537 at kernel/locking/mutex.c:1033 __mutex_unlock_slowpath+0x1a8/0x2e0
Modules linked in:
CPU: 2 PID: 537 Comm: kworker/u16:11 Not tainted 4.18.12-rc1-00133-g74ba23ae47e5 #1
Hardware name: linux,dummy-virt (DT)
Workqueue: test-ww_mutex test_cycle_work
pstate: 40000005 (nZcv daif -PAN -UAO)
pc : __mutex_unlock_slowpath+0x1a8/0x2e0
lr : __mutex_unlock_slowpath+0x1a8/0x2e0
sp : ffff00000acbbc50
x29: ffff00000acbbc50 x28: 0000000000000000
x27: 0000000000000000 x26: ffff000009fc1d80
x25: ffff000009f86558 x24: ffff000008f8d410
x23: ffff000009f86000 x22: ffff00000926f000
x21: ffff00000acbbcb8 x20: ffff80001be208c8
x19: 0000000000000000 x18: ffffffffffffffff
x17: 0000000000000000 x16: ffff80001c2a0000
x15: ffff00000926f808 x14: ffff000089f85d3f
x13: ffff000009f85d4d x12: ffff00000928a000
x11: 0000000005f5e0ff x10: ffff00000acbb8a0
x9 : 0000000000000000 x8 : ffff00000926f808
x7 : ffff000008149180 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000
x3 : ffffffffffffffff x2 : ffff00000928ab40
x1 : 6172e063a21fe300 x0 : 0000000000000000
Call trace:
 __mutex_unlock_slowpath+0x1a8/0x2e0
 ww_mutex_unlock+0x48/0xa0
 test_cycle_work+0xf8/0x200
 process_one_work+0x258/0x410
 worker_thread+0x40/0x458
 kthread+0x128/0x130
 ret_from_fork+0x10/0x18
irq event stamp: 1305
_raw_spin_unlock_irq+0x2c/0x60
__schedule+0xbc/0x780
__do_softirq+0x1e8/0x260
irq_exit+0x144/0x150

If requesting b_mutex fails with -EDEADLK, the error variable
is reassigned to the return value from calling ww_mutex_lock
on a_mutex again. If this call fails, a_mutex is not locked.
It is, however, unconditionally unlocked subsequently, causing
the reported warning. Fix the problem by using two error variables.

With this change, the selftest still fails as follows.

cyclic deadlock not resolved, ret[7/8] = -35

However, the traceback is gone.

Fixes: d1b42b800e5d0 ("locking/ww_mutex: Add kselftests for resolving
ww_mutex cyclic deadlocks")
Cc: Will Deacon <will.deacon@arm.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
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
-- 
2.7.4

