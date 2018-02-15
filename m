Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030891AbeBOM0y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:26:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030638AbeBOM0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:51 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 9/9] perf tests: Use arch__compare_symbol_names to compare symbols
Date: Thu, 15 Feb 2018 13:26:35 +0100
Message-Id: <20180215122635.24029-10-jolsa@kernel.org>
In-Reply-To: <20180215122635.24029-1-jolsa@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol search called by machine__find_kernel_symbol_by_name
is using internally arch__compare_symbol_names function to compare
2 symbol names, because different archs have different ways of
comparing symbols. Mostly for skipping '.' prefixes and similar.

In test 1 when we try to find matching symbols in kallsyms and
vmlinux, by address and by symbol name. When either is found
we compare the pair symbol names  by simple strcmp, which is not
good enough for reasons explained in previous paragraph.

On powerpc this can cause lockup, because even thought we found
the pair, the compared names are different and don't match
simple strcmp. Following code path is executed, that leads
to lockup:

   - we find the pair in kallsyms by sym->start
next_pair:
   - we compare the names and it fails
   - we find the pair by sym->name
   - the pair addresses match so we call goto next_pair
     because we assume the names match in this case

Link: http://lkml.kernel.org/n/tip-7m91et46nmwdnsr4dkkiw00j@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/vmlinux-kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 58349297f9fb..1e5adb65632a 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -125,7 +125,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 		if (pair && UM(pair->start) == mem_start) {
 next_pair:
-			if (strcmp(sym->name, pair->name) == 0) {
+			if (arch__compare_symbol_names(sym->name, pair->name) == 0) {
 				/*
 				 * kallsyms don't have the symbol end, so we
 				 * set that by using the next symbol start - 1,
-- 
2.13.6
