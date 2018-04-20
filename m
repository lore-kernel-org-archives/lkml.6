Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755393AbeDTOdj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755377AbeDTOdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D725217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sihyeon Jang <uneedsihyeon@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/17] perf tools: Add '\n' at the end of parse-options error messages
Date: Fri, 20 Apr 2018 11:32:24 -0300
Message-Id: <20180420143227.16030-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Few error messages does not have '\n' at the end and thus next prompt
gets printed in the same line. Ex,

  linux~$ perf buildid-cache -verbose --add ./a.out
   Error: did you mean `--verbose` (with two dashes ?)linux~$

Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180417041346.5617-2-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index f6a1babcbac4..cb7154eccbdc 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -433,7 +433,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 
 	if (ambiguous_option) {
 		 fprintf(stderr,
-			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)",
+			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)\n",
 			 arg,
 			 (ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			 ambiguous_option->long_name,
@@ -458,7 +458,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (strstarts(arg, "no-")) {
-		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 		exit(129);
 	}
 
@@ -466,7 +466,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (strstarts(options->long_name, arg)) {
-			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 			exit(129);
 		}
 	}
-- 
2.14.3
