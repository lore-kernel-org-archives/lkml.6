Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966332AbeEYJvH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:51:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965631AbeEYJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:51:04 -0400
Date: Fri, 25 May 2018 02:50:41 -0700
From: tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-10b1105004fbd81058383537b67df35cc188ab62@git.kernel.org>
Cc: alexey.budankov@linux.intel.com, torvalds@linux-foundation.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, acme@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        eranian@google.com, jolsa@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu
Reply-To: acme@redhat.com, torvalds@linux-foundation.org,
        alexey.budankov@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com, eranian@google.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        vincent.weaver@maine.edu
In-Reply-To: <311d4a34-f81b-5535-3385-01427ac73b41@linux.intel.com>
References: <311d4a34-f81b-5535-3385-01427ac73b41@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Store user space frame-pointer value on a
 sample
Git-Commit-ID: 10b1105004fbd81058383537b67df35cc188ab62
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  10b1105004fbd81058383537b67df35cc188ab62
Gitweb:     https://git.kernel.org/tip/10b1105004fbd81058383537b67df35cc188ab62
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Thu, 24 May 2018 17:11:54 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:11:12 +0200

perf/x86: Store user space frame-pointer value on a sample

Store user space frame-pointer value (BP register) into the perf trace
on a sample for a process so the value becomes available when
unwinding call stacks for functions gaining event samples.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/311d4a34-f81b-5535-3385-01427ac73b41@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/perf_regs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e47b2dbbdef3..c06c4c16c6b6 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -151,17 +151,19 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	regs_user_copy->sp = user_regs->sp;
 	regs_user_copy->cs = user_regs->cs;
 	regs_user_copy->ss = user_regs->ss;
-
 	/*
-	 * Most system calls don't save these registers, don't report them.
+	 * Store user space frame-pointer value on sample
+	 * to facilitate stack unwinding for cases when
+	 * user space executable code has such support
+	 * enabled at compile time:
 	 */
+	regs_user_copy->bp = user_regs->bp;
+
 	regs_user_copy->bx = -1;
-	regs_user_copy->bp = -1;
 	regs_user_copy->r12 = -1;
 	regs_user_copy->r13 = -1;
 	regs_user_copy->r14 = -1;
 	regs_user_copy->r15 = -1;
-
 	/*
 	 * For this to be at all useful, we need a reasonable guess for
 	 * the ABI.  Be careful: we're in NMI context, and we're
