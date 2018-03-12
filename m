Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeCLJn1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932328AbeCLJnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:24 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 05/13] perf bpf: Add compile option
Date: Mon, 12 Mar 2018 10:43:05 +0100
Message-Id: <20180312094313.18738-6-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding -c/--compile option to provide compilation
for ebpf objects, like:

  $ perf bpf -c samples/syscall-counts.c
  LLVM: dumping samples/syscall-counts.o

Link: http://lkml.kernel.org/n/tip-w48lyepbrde7no35sxi2vtxh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-bpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-bpf.c b/tools/perf/builtin-bpf.c
index 6f02352caf79..1ae93fd01a97 100644
--- a/tools/perf/builtin-bpf.c
+++ b/tools/perf/builtin-bpf.c
@@ -145,6 +145,7 @@ int cmd_bpf(int argc, const char **argv)
 		"perf bpf [<options>] -- <command> [<options>]",
 		NULL
 	};
+	const char *compile_src = NULL;
 	const struct option bpf_options[] = {
 		OPT_CALLBACK('e', "event", &bpf.evlist, "event",
 			     "event selector. use 'perf list' to list available events",
@@ -159,6 +160,8 @@ int cmd_bpf(int argc, const char **argv)
 			   "record events on existing thread id"),
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose"),
+		OPT_STRING('c', "compile", &compile_src, "eBPF source",
+			   "compile eBPF object"),
 		OPT_END()
 	};
 
@@ -170,6 +173,10 @@ int cmd_bpf(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, bpf_options, bpf_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (compile_src)
+		return bpf__compile(compile_src);
+
 	if (!argc && target__none(&bpf.target))
 		usage_with_options(bpf_usage, bpf_options);
 
-- 
2.13.6
