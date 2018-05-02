Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeEBSBB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:01:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeEBSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:00:59 -0400
Date: Wed, 2 May 2018 10:59:51 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-khmi5jccpcwqa9nybefluzqp@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
        wangnan0@huawei.com, mingo@kernel.org, acme@redhat.com,
        jolsa@kernel.org, dsahern@gmail.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, namhyung@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, jolsa@kernel.org, acme@redhat.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: No need to special case MAP__FUNCTION
 in fixup
Git-Commit-ID: d1fd8d9e6b7b72c8a51bd43b17409c37d82cddef
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

Commit-ID:  d1fd8d9e6b7b72c8a51bd43b17409c37d82cddef
Gitweb:     https://git.kernel.org/tip/d1fd8d9e6b7b72c8a51bd43b17409c37d82cddef
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 12:36:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:20 -0300

perf symbols: No need to special case MAP__FUNCTION in fixup

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
