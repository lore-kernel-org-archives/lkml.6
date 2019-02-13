Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F33EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75787222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbfBMJFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:05:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbfBMJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:05:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D94VKV198198
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:04:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D94U1V198195;
        Wed, 13 Feb 2019 01:04:30 -0800
Date:   Wed, 13 Feb 2019 01:04:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Righi <tipbot@zytor.com>
Message-ID: <tip-02106f883cd745523f7766d90a739f983f19e650@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        righi.andrea@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mhiramat@kernel.org,
        torvalds@linux-foundation.org, jolsa@redhat.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com
Reply-To: hpa@zytor.com, acme@redhat.com, rostedt@goodmis.org,
          tglx@linutronix.de, mathieu.desnoyers@efficios.com,
          mhiramat@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@redhat.com,
          torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, righi.andrea@gmail.com,
          peterz@infradead.org
In-Reply-To: <154998813406.31052.8791425358974650922.stgit@devbox>
References: <154998813406.31052.8791425358974650922.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Prohibit probing on bsearch()
Git-Commit-ID: 02106f883cd745523f7766d90a739f983f19e650
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

Commit-ID:  02106f883cd745523f7766d90a739f983f19e650
Gitweb:     https://git.kernel.org/tip/02106f883cd745523f7766d90a739f983f19e650
Author:     Andrea Righi <righi.andrea@gmail.com>
AuthorDate: Wed, 13 Feb 2019 01:15:34 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:41 +0100

kprobes: Prohibit probing on bsearch()

Since kprobe breakpoing handler is using bsearch(), probing on this
routine can cause recursive breakpoint problem.

int3
 ->do_int3()
   ->ftrace_int3_handler()
     ->ftrace_location()
       ->ftrace_location_range()
         ->bsearch() -> int3

Prohibit probing on bsearch().

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998813406.31052.8791425358974650922.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/bsearch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bsearch.c b/lib/bsearch.c
index 18b445b010c3..82512fe7b33c 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/bsearch.h>
+#include <linux/kprobes.h>
 
 /*
  * bsearch - binary search an array of elements
@@ -53,3 +54,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
 	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
+NOKPROBE_SYMBOL(bsearch);
