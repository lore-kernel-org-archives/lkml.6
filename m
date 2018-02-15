Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968026AbeBOM0s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:26:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967889AbeBOM0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:41 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/9] perf tools: Check if we read regular file in dso__load
Date: Thu, 15 Feb 2018 13:26:28 +0100
Message-Id: <20180215122635.24029-3-jolsa@kernel.org>
In-Reply-To: <20180215122635.24029-1-jolsa@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code in dso__load calls the is_regular_file function,
but it checks its return value only after calling symsrc__init.

That can make symsrc__init block in elf_* functions on reading
the file if the file happens to be device and not regular one.

Calling symsrc__init only for regular files. Also removing
the symsrc__destroy cleanup, which is not needed now, because
we call symsrc__init only for regular files.

Link: http://lkml.kernel.org/n/tip-qm0sl764xzwvzgz0abqt6m46@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cc065d4bfafc..e366e3060e6b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1582,7 +1582,7 @@ int dso__load(struct dso *dso, struct map *map)
 		bool next_slot = false;
 		bool is_reg;
 		bool nsexit;
-		int sirc;
+		int sirc = -1;
 
 		enum dso_binary_type symtab_type = binary_type_symtab[i];
 
@@ -1600,16 +1600,14 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_exit(&nsc);
 
 		is_reg = is_regular_file(name);
-		sirc = symsrc__init(ss, dso, name, symtab_type);
+		if (is_reg)
+			sirc = symsrc__init(ss, dso, name, symtab_type);
 
 		if (nsexit)
 			nsinfo__mountns_enter(dso->nsinfo, &nsc);
 
-		if (!is_reg || sirc < 0) {
-			if (sirc >= 0)
-				symsrc__destroy(ss);
+		if (!is_reg || sirc < 0)
 			continue;
-		}
 
 		if (!syms_ss && symsrc__has_symtab(ss)) {
 			syms_ss = ss;
-- 
2.13.6
