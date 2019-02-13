Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B364C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFDB222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbfBMJEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:04:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389478AbfBMJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:04:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D93rAX196582
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:03:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D93r54196579;
        Wed, 13 Feb 2019 01:03:53 -0800
Date:   Wed, 13 Feb 2019 01:03:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-2f43c6022d84b2f562623a7023f49f1431e50747@git.kernel.org>
Cc:     hpa@zytor.com, rostedt@goodmis.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mathieu.desnoyers@efficios.com, righi.andrea@gmail.com,
        jolsa@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, mhiramat@kernel.org
Reply-To: hpa@zytor.com, rostedt@goodmis.org, acme@redhat.com,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          mathieu.desnoyers@efficios.com, righi.andrea@gmail.com,
          jolsa@redhat.com, peterz@infradead.org, mhiramat@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <154998810578.31052.1680977921449292812.stgit@devbox>
References: <154998810578.31052.1680977921449292812.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Prohibit probing on lockdep functions
Git-Commit-ID: 2f43c6022d84b2f562623a7023f49f1431e50747
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

Commit-ID:  2f43c6022d84b2f562623a7023f49f1431e50747
Gitweb:     https://git.kernel.org/tip/2f43c6022d84b2f562623a7023f49f1431e50747
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:15:05 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:41 +0100

kprobes: Prohibit probing on lockdep functions

Some lockdep functions can be involved in breakpoint handling
and probing on those functions can cause a breakpoint recursion.

Prohibit probing on those functions by blacklist.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998810578.31052.1680977921449292812.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 95932333a48b..bc35a54ae3d4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -50,6 +50,7 @@
 #include <linux/random.h>
 #include <linux/jhash.h>
 #include <linux/nmi.h>
+#include <linux/kprobes.h>
 
 #include <asm/sections.h>
 
@@ -2814,6 +2815,7 @@ void lockdep_hardirqs_on(unsigned long ip)
 	__trace_hardirqs_on_caller(ip);
 	current->lockdep_recursion = 0;
 }
+NOKPROBE_SYMBOL(lockdep_hardirqs_on);
 
 /*
  * Hardirqs were disabled:
@@ -2843,6 +2845,7 @@ void lockdep_hardirqs_off(unsigned long ip)
 	} else
 		debug_atomic_inc(redundant_hardirqs_off);
 }
+NOKPROBE_SYMBOL(lockdep_hardirqs_off);
 
 /*
  * Softirqs will be enabled:
@@ -3650,7 +3653,8 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 	return 0;
 }
 
-static int __lock_is_held(const struct lockdep_map *lock, int read)
+static nokprobe_inline
+int __lock_is_held(const struct lockdep_map *lock, int read)
 {
 	struct task_struct *curr = current;
 	int i;
@@ -3883,6 +3887,7 @@ int lock_is_held_type(const struct lockdep_map *lock, int read)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(lock_is_held_type);
+NOKPROBE_SYMBOL(lock_is_held_type);
 
 struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 {
