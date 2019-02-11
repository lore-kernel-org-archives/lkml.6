Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B6EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C149B21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBKKxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:53:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58283 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfBKKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:53:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BArUPq3499263
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:53:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BArTA73499259;
        Mon, 11 Feb 2019 02:53:29 -0800
Date:   Mon, 11 Feb 2019 02:53:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hugo Lefeuvre <tipbot@zytor.com>
Message-ID: <tip-2b9c2a4859ad5ac7b5a28e9db28c3e618760fe8c@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        joel@joelfernandes.org, hle@owl.eu.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          joel@joelfernandes.org, hle@owl.eu.com, mingo@kernel.org,
          peterz@infradead.org, rjw@rjwysocki.net
In-Reply-To: <20190207200352.GA27859@behemoth.owl.eu.com.local>
References: <20190207200352.GA27859@behemoth.owl.eu.com.local>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/wait: Use freezable_schedule() when possible
Git-Commit-ID: 2b9c2a4859ad5ac7b5a28e9db28c3e618760fe8c
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

Commit-ID:  2b9c2a4859ad5ac7b5a28e9db28c3e618760fe8c
Gitweb:     https://git.kernel.org/tip/2b9c2a4859ad5ac7b5a28e9db28c3e618760fe8c
Author:     Hugo Lefeuvre <hle@owl.eu.com>
AuthorDate: Thu, 7 Feb 2019 21:03:52 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:34:04 +0100

sched/wait: Use freezable_schedule() when possible

Replace 'schedule(); try_to_freeze();' with a call to freezable_schedule().

Tasks calling freezable_schedule() set the PF_FREEZER_SKIP flag
before calling schedule(). Unlike tasks calling schedule();
try_to_freeze() tasks calling freezable_schedule() are not awaken by
try_to_freeze_tasks(). Instead they call try_to_freeze() when they
wake up if the freeze is still underway.

It is not a problem since sleeping tasks can't do anything which isn't
allowed for a frozen task while sleeping.

The result is a potential performance gain during freeze, since less
tasks have to be awaken.

For instance on a bare Debian vm running a 4.19 stable kernel, the
number of tasks skipped in freeze_task() went up from 12 without the
patch to 32 with the patch (out of 448), an increase of > x2.5.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190207200352.GA27859@behemoth.owl.eu.com.local
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/wait.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ed7c122cb31f..5f3efabc36f4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -308,7 +308,7 @@ do {										\
 
 #define __wait_event_freezable(wq_head, condition)				\
 	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
-			    schedule(); try_to_freeze())
+			    freezable_schedule())
 
 /**
  * wait_event_freezable - sleep (or freeze) until a condition gets true
@@ -367,7 +367,7 @@ do {										\
 #define __wait_event_freezable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
 		      TASK_INTERRUPTIBLE, 0, timeout,				\
-		      __ret = schedule_timeout(__ret); try_to_freeze())
+		      __ret = freezable_schedule_timeout(__ret))
 
 /*
  * like wait_event_timeout() -- except it uses TASK_INTERRUPTIBLE to avoid
@@ -588,7 +588,7 @@ do {										\
 
 #define __wait_event_freezable_exclusive(wq, condition)				\
 	___wait_event(wq, condition, TASK_INTERRUPTIBLE, 1, 0,			\
-			schedule(); try_to_freeze())
+			freezable_schedule())
 
 #define wait_event_freezable_exclusive(wq, condition)				\
 ({										\
