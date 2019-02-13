Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11D3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4E9222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbfBMJDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:03:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfBMJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:03:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D92d25196272
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:02:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D92dU0196268;
        Wed, 13 Feb 2019 01:02:39 -0800
Date:   Wed, 13 Feb 2019 01:02:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-984640ce427fa67c7c1f8550ab53495733bd11fc@git.kernel.org>
Cc:     mingo@kernel.org, righi.andrea@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, mathieu.desnoyers@efficios.com,
        acme@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        hpa@zytor.com, jolsa@redhat.com
Reply-To: jolsa@redhat.com, hpa@zytor.com, peterz@infradead.org,
          rostedt@goodmis.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com,
          mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mhiramat@kernel.org, mingo@kernel.org,
          righi.andrea@gmail.com, torvalds@linux-foundation.org
In-Reply-To: <154998804911.31052.3541963527929117920.stgit@devbox>
References: <154998804911.31052.3541963527929117920.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Prohibit probing on preemption checking
 debug functions
Git-Commit-ID: 984640ce427fa67c7c1f8550ab53495733bd11fc
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

Commit-ID:  984640ce427fa67c7c1f8550ab53495733bd11fc
Gitweb:     https://git.kernel.org/tip/984640ce427fa67c7c1f8550ab53495733bd11fc
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:14:09 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:40 +0100

kprobes: Prohibit probing on preemption checking debug functions

Since kprobes depends on preempt disable/enable, probing
on the preempt debug routines can cause recursive breakpoint
bugs.

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
Link: http://lkml.kernel.org/r/154998804911.31052.3541963527929117920.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/smp_processor_id.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 85925aaa4fff..157d9e31f6c2 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -5,10 +5,11 @@
  * DEBUG_PREEMPT variant of smp_processor_id().
  */
 #include <linux/export.h>
+#include <linux/kprobes.h>
 #include <linux/sched.h>
 
-notrace static unsigned int check_preemption_disabled(const char *what1,
-							const char *what2)
+notrace static nokprobe_inline
+unsigned int check_preemption_disabled(const char *what1, const char *what2)
 {
 	int this_cpu = raw_smp_processor_id();
 
@@ -56,9 +57,11 @@ notrace unsigned int debug_smp_processor_id(void)
 	return check_preemption_disabled("smp_processor_id", "");
 }
 EXPORT_SYMBOL(debug_smp_processor_id);
+NOKPROBE_SYMBOL(debug_smp_processor_id);
 
 notrace void __this_cpu_preempt_check(const char *op)
 {
 	check_preemption_disabled("__this_cpu_", op);
 }
 EXPORT_SYMBOL(__this_cpu_preempt_check);
+NOKPROBE_SYMBOL(__this_cpu_preempt_check);
