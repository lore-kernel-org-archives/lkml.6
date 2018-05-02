Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeEBSD1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:03:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeEBSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:03:25 -0400
Date: Wed, 2 May 2018 11:03:16 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-17a4gkk1cs4up4smkviymi2g@git.kernel.org>
Cc: namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        dsahern@gmail.com, adrian.hunter@intel.com, wangnan0@huawei.com,
        jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        acme@redhat.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Remove unused
 dso__load_all_kallsyms() 'map' parameter
Git-Commit-ID: 333cc76c9df9ee70f664dc809607e8223f5a629a
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

Commit-ID:  333cc76c9df9ee70f664dc809607e8223f5a629a
Gitweb:     https://git.kernel.org/tip/333cc76c9df9ee70f664dc809607e8223f5a629a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 27 Apr 2018 15:36:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 27 Apr 2018 15:36:15 -0300

perf symbols: Remove unused dso__load_all_kallsyms() 'map' parameter

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
@@ -608,11 +608,6 @@ out:
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
