Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A08C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489362534E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489362534E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeGBNmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:42:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751931AbeGBNmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:42:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00B3C87AC7;
        Mon,  2 Jul 2018 13:42:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6495D178B6;
        Mon,  2 Jul 2018 13:42:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/2] perf tools: Fix compilation errors on gcc8
Date:   Mon,  2 Jul 2018 15:42:01 +0200
Message-Id: <20180702134202.17745-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 13:42:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 13:42:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Using tool's function scnprintf that touches the return value
from the snprintf calls and thus get rid of those warnings.

  $ make DEBUG=1
    CC       arch/x86/util/perf_regs.o
  arch/x86/util/perf_regs.c: In function ‘arch_sdt_arg_parse_op’:
  arch/x86/util/perf_regs.c:229:4: error: ‘strncpy’ output truncated before terminating nul
  copying 2 bytes from a string of the same length [-Werror=stringop-truncation]
    strncpy(prefix, "+0", 2);
    ^~~~~~~~~~~~~~~~~~~~~~~~

Using scnprintf instead of the strncpy (which we know is safe
in here) to get rid of that warning.

Link: http://lkml.kernel.org/n/tip-sqmh28njbvm1mh6farkktlmj@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.1

