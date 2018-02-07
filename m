Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbeBGOs5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:48:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932091AbeBGOsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:48:55 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 10/10] perf tools: Check if we read regular file in dso__load
Date: Wed,  7 Feb 2018 15:48:38 +0100
Message-Id: <20180207144838.16823-11-jolsa@kernel.org>
In-Reply-To: <20180207144838.16823-1-jolsa@kernel.org>
References: <20180207144838.16823-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code in dso__load calls the is_regular_file function,
but it checks its return value only after calling symsrc__init.

That can make symsrc__init block in elf_* functions on reading
the file if the file happens to be device and not regular one.

Make the check before calling symsrc__init.

Link: http://lkml.kernel.org/n/tip-qm0sl764xzwvzgz0abqt6m46@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fe15dafaef66..ea002b27b39d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1580,9 +1580,7 @@ int dso__load(struct dso *dso, struct map *map)
 	for (i = 0; i < DSO_BINARY_TYPE__SYMTAB_CNT; i++) {
 		struct symsrc *ss = &ss_[ss_pos];
 		bool next_slot = false;
-		bool is_reg;
 		bool nsexit;
-		int sirc;
 
 		enum dso_binary_type symtab_type = binary_type_symtab[i];
 
@@ -1599,18 +1597,15 @@ int dso__load(struct dso *dso, struct map *map)
 		if (nsexit)
 			nsinfo__mountns_exit(&nsc);
 
-		is_reg = is_regular_file(name);
-		sirc = symsrc__init(ss, dso, name, symtab_type);
+		if (!is_regular_file(name))
+			continue;
+
+		if (symsrc__init(ss, dso, name, symtab_type) < 0)
+			continue;
 
 		if (nsexit)
 			nsinfo__mountns_enter(dso->nsinfo, &nsc);
 
-		if (!is_reg || sirc < 0) {
-			if (sirc >= 0)
-				symsrc__destroy(ss);
-			continue;
-		}
-
 		if (!syms_ss && symsrc__has_symtab(ss)) {
 			syms_ss = ss;
 			next_slot = true;
-- 
2.13.6
