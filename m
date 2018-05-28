Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162878AbeE1Kkt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162829AbeE1Kkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:40:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 320/329] perf tests: Use arch__compare_symbol_names to compare symbols
Date: Mon, 28 May 2018 12:04:09 +0200
Message-Id: <20180528100307.589966351@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit ab6e9a99345131cd8e54268d1d0dc04a33f7ed11 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/vmlinux-kallsyms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -123,7 +123,7 @@ int test__vmlinux_matches_kallsyms(int s
 
 		if (pair && UM(pair->start) == mem_start) {
 next_pair:
-			if (strcmp(sym->name, pair->name) == 0) {
+			if (arch__compare_symbol_names(sym->name, pair->name) == 0) {
 				/*
 				 * kallsyms don't have the symbol end, so we
 				 * set that by using the next symbol start - 1,
