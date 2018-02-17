Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeBQLiv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:38:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeBQLit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:38:49 -0500
Date: Sat, 17 Feb 2018 03:28:26 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ab6e9a99345131cd8e54268d1d0dc04a33f7ed11@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@kernel.org, dsahern@gmail.com,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, dsahern@gmail.com, mingo@kernel.org,
        peterz@infradead.org, naveen.n.rao@linux.vnet.ibm.com,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de
In-Reply-To: <20180215122635.24029-10-jolsa@kernel.org>
References: <20180215122635.24029-10-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Use arch__compare_symbol_names to
 compare symbols
Git-Commit-ID: ab6e9a99345131cd8e54268d1d0dc04a33f7ed11
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

Commit-ID:  ab6e9a99345131cd8e54268d1d0dc04a33f7ed11
Gitweb:     https://git.kernel.org/tip/ab6e9a99345131cd8e54268d1d0dc04a33f7ed11
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:35 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:26:01 -0300

perf tests: Use arch__compare_symbol_names to compare symbols

The symbol search called by machine__find_kernel_symbol_by_name is using
internally arch__compare_symbol_names function to compare 2 symbol
names, because different archs have different ways of comparing symbols.
Mostly for skipping '.' prefixes and similar.

In test 1 when we try to find matching symbols in kallsyms and vmlinux,
by address and by symbol name. When either is found we compare the pair
symbol names  by simple strcmp, which is not good enough for reasons
explained in previous paragraph.

On powerpc this can cause lockup, because even thought we found the
pair, the compared names are different and don't match simple strcmp.
Following code path is executed, that leads to lockup:

   - we find the pair in kallsyms by sym->start
next_pair:
   - we compare the names and it fails
   - we find the pair by sym->name
   - the pair addresses match so we call goto next_pair
     because we assume the names match in this case

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 031b84c407c3 ("perf probe ppc: Enable matching against dot symbols automatically")
Link: http://lkml.kernel.org/r/20180215122635.24029-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 5834929..1e5adb6 100644
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
