Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeDUHvG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:51:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeDUHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:51:04 -0400
Date: Sat, 21 Apr 2018 00:50:58 -0700
From: tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-a7e9eab3dbd35268c16244557a4155a2d9a641c3@git.kernel.org>
Cc: ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: ak@linux.intel.com, mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org
In-Reply-To: <20180406203812.3087-2-andi@firstfloor.org>
References: <20180406203812.3087-2-andi@firstfloor.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mem: Allow all record/report options
Git-Commit-ID: a7e9eab3dbd35268c16244557a4155a2d9a641c3
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

Commit-ID:  a7e9eab3dbd35268c16244557a4155a2d9a641c3
Gitweb:     https://git.kernel.org/tip/a7e9eab3dbd35268c16244557a4155a2d9a641c3
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:38:09 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:35:48 -0300

perf mem: Allow all record/report options

For perf mem report / perf mem record, pass all unknown options
through to the underlying report/record commands. This makes things
like

perf mem record -a sleep 1

work. Matches how c2c and other tools work.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 3 +++
 tools/perf/builtin-mem.c              | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index b0211410969b..8806ed5f3802 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -67,6 +67,9 @@ OPTIONS
 --phys-data::
 	Record/Report sample physical addresses
 
+In addition, for report all perf report options are valid, and for record
+all perf record options.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 506564651cda..57393e94d156 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -83,7 +83,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	};
 
 	argc = parse_options(argc, argv, options, record_mem_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_KEEP_UNKNOWN);
 
 	rec_argc = argc + 9; /* max number of arguments */
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
@@ -436,7 +436,7 @@ int cmd_mem(int argc, const char **argv)
 	}
 
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
-					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!argc || !(strncmp(argv[0], "rec", 3) || mem.operation))
 		usage_with_options(mem_usage, mem_options);
