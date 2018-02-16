Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeBPTiy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753469AbeBPTSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16A9217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/41] perf symbols: Check if we read regular file in dso__load()
Date: Fri, 16 Feb 2018 16:17:17 -0300
Message-Id: <20180216191746.11095-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The current code in dso__load() calls is_regular_file(), but it checks
its return value only after calling symsrc__init().

That can make symsrc__init() block in elf_* functions on reading
the file if the file happens to be device and not regular one.

Call symsrc__init() only for regular files. Also remove the
symsrc__destroy() cleanup, which is not needed now, because we call
symsrc__init() only for regular files.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
