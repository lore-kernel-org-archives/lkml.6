Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A295DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F47D21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F47D21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbeGLONC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:13:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeGLONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:13:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE2xFH3934896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:02:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE2xLw3934893;
        Thu, 12 Jul 2018 07:02:59 -0700
Date:   Thu, 12 Jul 2018 07:02:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a09603f851045b031e990d2d663958ccb49db525@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, peterz@infradead.org,
        jolsa@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, dsahern@gmail.com,
          namhyung@kernel.org, peterz@infradead.org, jolsa@kernel.org,
          mingo@kernel.org
In-Reply-To: <20180702134202.17745-1-jolsa@kernel.org>
References: <20180702134202.17745-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix compilation errors on gcc8
Git-Commit-ID: a09603f851045b031e990d2d663958ccb49db525
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

Commit-ID:  a09603f851045b031e990d2d663958ccb49db525
Gitweb:     https://git.kernel.org/tip/a09603f851045b031e990d2d663958ccb49db525
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 2 Jul 2018 15:42:01 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 09:39:57 -0400

perf tools: Fix compilation errors on gcc8

We are getting following warnings on gcc8 that break compilation:

  $ make
    CC       jvmti/jvmti_agent.o
  jvmti/jvmti_agent.c: In function ‘jvmti_open’:
  jvmti/jvmti_agent.c:252:35: error: ‘/jit-’ directive output may be truncated \
    writing 5 bytes into a region of size between 1 and 4096 [-Werror=format-truncation=]
    snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());

There's no point in checking the result of snprintf call in
jvmti_open, the following open call will fail in case the
name is mangled or too long.

Using tools/lib/ function scnprintf that touches the return value from
the snprintf() calls and thus get rid of those warnings.

  $ make DEBUG=1
    CC       arch/x86/util/perf_regs.o
  arch/x86/util/perf_regs.c: In function ‘arch_sdt_arg_parse_op’:
  arch/x86/util/perf_regs.c:229:4: error: ‘strncpy’ output truncated before terminating nul
  copying 2 bytes from a string of the same length [-Werror=stringop-truncation]
    strncpy(prefix, "+0", 2);
    ^~~~~~~~~~~~~~~~~~~~~~~~

Using scnprintf instead of the strncpy (which we know is safe in here)
to get rid of that warning.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180702134202.17745-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/perf_regs.c | 2 +-
 tools/perf/jvmti/jvmti_agent.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 4b2caf6d48e7..fead6b3b4206 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -226,7 +226,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 		else if (rm[2].rm_so != rm[2].rm_eo)
 			prefix[0] = '+';
 		else
-			strncpy(prefix, "+0", 2);
+			scnprintf(prefix, sizeof(prefix), "+0");
 	}
 
 	/* Rename register */
diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 0c6d1002b524..ac1bcdc17dae 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -35,6 +35,7 @@
 #include <sys/mman.h>
 #include <syscall.h> /* for gettid() */
 #include <err.h>
+#include <linux/kernel.h>
 
 #include "jvmti_agent.h"
 #include "../util/jitdump.h"
@@ -249,7 +250,7 @@ void *jvmti_open(void)
 	/*
 	 * jitdump file name
 	 */
-	snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
+	scnprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
 
 	fd = open(dump_path, O_CREAT|O_TRUNC|O_RDWR, 0666);
 	if (fd == -1)
