Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23875206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbfBMJDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:03:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfBMJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:03:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D93GHM196526
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:03:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D93GH1196523;
        Wed, 13 Feb 2019 01:03:16 -0800
Date:   Wed, 13 Feb 2019 01:03:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-a39f15b9644fac3f950f522c39e667c3af25c588@git.kernel.org>
Cc:     righi.andrea@gmail.com, acme@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org,
        jolsa@redhat.com, tglx@linutronix.de
Reply-To: righi.andrea@gmail.com, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org, mhiramat@kernel.org,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, jolsa@redhat.com, acme@redhat.com,
          peterz@infradead.org, mathieu.desnoyers@efficios.com,
          tglx@linutronix.de, torvalds@linux-foundation.org
In-Reply-To: <154998807741.31052.11229157537816341591.stgit@devbox>
References: <154998807741.31052.11229157537816341591.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Prohibit probing on RCU debug routine
Git-Commit-ID: a39f15b9644fac3f950f522c39e667c3af25c588
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

Commit-ID:  a39f15b9644fac3f950f522c39e667c3af25c588
Gitweb:     https://git.kernel.org/tip/a39f15b9644fac3f950f522c39e667c3af25c588
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:14:37 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:40 +0100

kprobes: Prohibit probing on RCU debug routine

Since kprobe itself depends on RCU, probing on RCU debug
routine can cause recursive breakpoint bugs.

Prohibit probing on RCU debug routines.

int3
 ->do_int3()
   ->ist_enter()
     ->RCU_LOCKDEP_WARN()
       ->debug_lockdep_rcu_enabled() -> int3

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
Link: http://lkml.kernel.org/r/154998807741.31052.11229157537816341591.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/rcu/update.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1971869c4072..f4ca36d92138 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -52,6 +52,7 @@
 #include <linux/tick.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/isolation.h>
+#include <linux/kprobes.h>
 
 #define CREATE_TRACE_POINTS
 
@@ -249,6 +250,7 @@ int notrace debug_lockdep_rcu_enabled(void)
 	       current->lockdep_recursion == 0;
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
+NOKPROBE_SYMBOL(debug_lockdep_rcu_enabled);
 
 /**
  * rcu_read_lock_held() - might we be in RCU read-side critical section?
