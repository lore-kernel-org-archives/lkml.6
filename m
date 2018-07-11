Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD800C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715232086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715232086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeGKHdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:33:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34231 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeGKHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:33:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so16995155wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fxRiu7oKmVq6ke/lQ/gq1h8dclx9MILloQReYHWplVE=;
        b=qvfl9kM5EHXhCceIOgaPJv9tjbXUZr7HcTIDmGzeCVbeXj8Tqq3I1vXvz8jD0CmbAI
         iFEYfe3P9uLVskKpcYIEyXP0F2Mthz/TAru1NtXgZOgqUUpF/l2bISwTqa4WMvwQmC9b
         g7PpyEtHyw9rmY8L678KoqJgNVpUmSIKAMfcuMVNenNQKh/nB16YCkkiBB8yu3hWQ7iE
         dHaTVQjQUE8ZED8cI+ALu2rkkcwAzHYBFCgw/fDGyLB3SR+ShrNTRuw15Xi7mt+5LAXw
         dve/SXL78BWz+SVQ8BMpHjWGi5HgmbL5tefTm8i20VCHLs2DJitrkxwxYS4PWuIfUbHo
         /aKA==
X-Gm-Message-State: AOUpUlEzgyfhmkTtJRL1tGAqXyXfauUAGQzL9jwbpmvYegxacioS21hz
        NGW7WuxSo9iQ+C2RSwixPH7Ywg==
X-Google-Smtp-Source: AAOMgpdXxflAZ2JRbgOKEX7ty5I8yCU4eyzbOaIL/2ph7jJ7IQyS0oJhwD8lblBtyevgNXgZ8WalOA==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr14452722wrt.37.1531294211778;
        Wed, 11 Jul 2018 00:30:11 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.255.159])
        by smtp.gmail.com with ESMTPSA id j11-v6sm19595529wrr.37.2018.07.11.00.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 00:30:11 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        bristot@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/deadline: Fix switched_from_dl
Date:   Wed, 11 Jul 2018 09:29:48 +0200
Message-Id: <20180711072948.27061-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark noticed that syzkaller is able to reliably trigger the following

  dl_rq->running_bw > dl_rq->this_bw
  WARNING: CPU: 1 PID: 153 at kernel/sched/deadline.c:124 switched_from_dl+0x454/0x608
  Kernel panic - not syncing: panic_on_warn set ...

  CPU: 1 PID: 153 Comm: syz-executor253 Not tainted 4.18.0-rc3+ #29
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x0/0x458
   show_stack+0x20/0x30
   dump_stack+0x180/0x250
   panic+0x2dc/0x4ec
   __warn_printk+0x0/0x150
   report_bug+0x228/0x2d8
   bug_handler+0xa0/0x1a0
   brk_handler+0x2f0/0x568
   do_debug_exception+0x1bc/0x5d0
   el1_dbg+0x18/0x78
   switched_from_dl+0x454/0x608
   __sched_setscheduler+0x8cc/0x2018
   sys_sched_setattr+0x340/0x758
   el0_svc_naked+0x30/0x34

syzkaller reproducer runs a bunch of threads that constantly switch
between DEADLINE and NORMAL classes while interacting through futexes.

The splat above is caused by the fact that if a DEADLINE task is setattr
back to NORMAL while in non_contending state (blocked on a futex -
inactive timer armed), its contribution to running_bw is not removed
before sub_rq_bw() gets called (!task_on_rq_queued() branch) and the
latter sees running_bw > this_bw.

Fix it by removing a task contribution from running_bw if the task is
not queued and in non_contending state while switched to a different
class.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..10c7b51c0d1f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2290,8 +2290,17 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
-	if (!task_on_rq_queued(p))
+	if (!task_on_rq_queued(p)) {
+		/*
+		 * Inactive timer is armed. However, p is leaving DEADLINE and
+		 * might migrate away from this rq while continuing to run on
+		 * some other class. We need to remove its contribution from
+		 * this rq running_bw now, or sub_rq_bw (below) will complain.
+		 */
+		if (p->dl.dl_non_contending)
+			sub_running_bw(&p->dl, &rq->dl);
 		sub_rq_bw(&p->dl, &rq->dl);
+	}
 
 	/*
 	 * We cannot use inactive_task_timer() to invoke sub_running_bw()
-- 
2.14.4

