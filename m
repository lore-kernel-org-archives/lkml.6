Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeEBPYA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752402AbeEBPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:30 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 48/52] perf symbols: Remove unused dso__load_all_kallsyms() 'map' parameter
Date: Wed,  2 May 2018 12:19:38 -0300
Message-Id: <20180502151942.20542-49-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Only the 'dso' is needed, so ditch the struct used to pass (map, dso),
passing just the used 'dso' pointer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-17a4gkk1cs4up4smkviymi2g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index efc16a3e0b45..2517f2c2454f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -608,11 +608,6 @@ int modules__parse(const char *filename, void *arg,
 	return err;
 }
 
-struct process_kallsyms_args {
-	struct map *map;
-	struct dso *dso;
-};
-
 /*
  * These are symbols in the kernel image, so make sure that
  * sym is from a kernel DSO.
@@ -648,8 +643,8 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 				       char type, u64 start)
 {
 	struct symbol *sym;
-	struct process_kallsyms_args *a = arg;
-	struct rb_root *root = &a->dso->symbols;
+	struct dso *dso = arg;
+	struct rb_root *root = &dso->symbols;
 
 	if (!symbol_type__filter(type))
 		return 0;
@@ -676,11 +671,9 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
  * so that we can in the next step set the symbol ->end address and then
  * call kernel_maps__split_kallsyms.
  */
-static int dso__load_all_kallsyms(struct dso *dso, const char *filename,
-				  struct map *map)
+static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
 {
-	struct process_kallsyms_args args = { .map = map, .dso = dso, };
-	return kallsyms__parse(filename, &args, map__process_kallsym_symbol);
+	return kallsyms__parse(filename, dso, map__process_kallsym_symbol);
 }
 
 static int dso__split_kallsyms_for_kcore(struct dso *dso, struct map *map)
@@ -1300,7 +1293,7 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 	if (symbol__restricted_filename(filename, "/proc/kallsyms"))
 		return -1;
 
-	if (dso__load_all_kallsyms(dso, filename, map) < 0)
+	if (dso__load_all_kallsyms(dso, filename) < 0)
 		return -1;
 
 	if (kallsyms__delta(map, filename, &delta))
-- 
2.14.3
