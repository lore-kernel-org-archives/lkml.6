Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeBQLfU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:35:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44369 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeBQLfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:35:18 -0500
Date: Sat, 17 Feb 2018 03:24:58 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c39629614640a7a5331bf156b0d26effade0a67f@git.kernel.org>
Cc: hpa@zytor.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, dsahern@gmail.com,
        acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        mingo@kernel.org, namhyung@kernel.org
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, dsahern@gmail.com,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org
In-Reply-To: <20180215122635.24029-3-jolsa@kernel.org>
References: <20180215122635.24029-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Check if we read regular file in
 dso__load()
Git-Commit-ID: c39629614640a7a5331bf156b0d26effade0a67f
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

Commit-ID:  c39629614640a7a5331bf156b0d26effade0a67f
Gitweb:     https://git.kernel.org/tip/c39629614640a7a5331bf156b0d26effade0a67f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:28 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:25:56 -0300

perf symbols: Check if we read regular file in dso__load()

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
index cc065d4..e366e30 100644
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
