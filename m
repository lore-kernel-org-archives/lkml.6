Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeEBPWP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbeEBPWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:08 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 41/52] perf symbols: No need to special case MAP__FUNCTION in fixup
Date: Wed,  2 May 2018 12:19:31 -0300
Message-Id: <20180502151942.20542-42-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In 39b12f781271 ("perf tools: Make it possible to read object code from
vmlinux") we special case MAP__FUNCTION maps inconsistently, the first
test tests the map type while the following tests added by this patch
don't do that, be consistent and elliminate this special case.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-khmi5jccpcwqa9nybefluzqp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c       | 2 +-
 tools/perf/util/symbol-elf.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 49a41b4b59cf..e65903a695a6 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -282,7 +282,7 @@ static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
 
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
 	if (sym && map) {
-		if (map->type == MAP__VARIABLE) {
+		if (sym->type == STT_OBJECT) {
 			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
 					ip - map->unmap_ip(map, sym->start));
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 88f6f3050665..cf2e6f428bb4 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -921,10 +921,10 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);
 	/*
-	 * Initial kernel and module mappings do not map to the dso.  For
-	 * function mappings, flag the fixups.
+	 * Initial kernel and module mappings do not map to the dso.
+	 * Flag the fixups.
 	 */
-	if (map->type == MAP__FUNCTION && (dso->kernel || kmodule)) {
+	if (dso->kernel || kmodule) {
 		remap_kernel = true;
 		adjust_kernel_syms = dso->adjust_symbols;
 	}
-- 
2.14.3
