Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F85EC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78332146F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO8Rq2+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78332146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbeGKUvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389657AbeGKUvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:23 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37AD921471;
        Wed, 11 Jul 2018 20:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341916;
        bh=+fOSYRBjK7ON61lC+xOlMfXh3uiQy7iiXdg7WVGgF/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WO8Rq2+pljjvhDPizBe/0pIW2rqpSJXJ+C3dRxsPXbLjAPZbZkJmFiwJLNaoEJTZM
         X5tVI5ln3uCh/Mzr//pKiLUylqz/QmgQcIrm0csVeAE/PXX2NyuyNTrd30+39uuxNI
         cQbwKbepVfqHArexIZ+4A/EfoOvqU6Rf7GmG/aNo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/14] perf tools: Fix compilation errors on gcc8
Date:   Wed, 11 Jul 2018 16:43:02 -0400
Message-Id: <20180711204305.12924-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

