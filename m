Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeEBRzK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:55:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEBRzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:55:09 -0400
Date: Wed, 2 May 2018 10:54:57 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x29k9e1ohastsoqbilp3mguh@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dsahern@gmail.com, acme@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        jolsa@kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        wangnan0@huawei.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Remove enum_type arg to
 map_groups__first()
Git-Commit-ID: dce0478b5fa05147a69dc6dd6cfcaac2f0e0eb2f
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

Commit-ID:  dce0478b5fa05147a69dc6dd6cfcaac2f0e0eb2f
Gitweb:     https://git.kernel.org/tip/dce0478b5fa05147a69dc6dd6cfcaac2f0e0eb2f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 17:28:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:15 -0300

perf map: Remove enum_type arg to map_groups__first()

Only the symbol core needs to use that, so provide a __ variant for that
case, that will end up removed when we ditch the MAP__ split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x29k9e1ohastsoqbilp3mguh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h    |  6 +-----
 tools/perf/util/symbol.c | 14 ++++++++++++--
 tools/perf/util/vdso.c   |  6 ++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index b4bcf569a131..579ad7d2711d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -225,11 +225,7 @@ static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 	return __map_groups__find(mg, MAP__FUNCTION, addr);
 }
 
-static inline struct map *map_groups__first(struct map_groups *mg,
-					    enum map_type type)
-{
-	return maps__first(&mg->maps[type]);
-}
+struct map *map_groups__first(struct map_groups *mg);
 
 static inline struct map *map_groups__next(struct map *map)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8d9967357354..5d77c60e63bf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1044,6 +1044,16 @@ out_delete_from:
 	return ret;
 }
 
+static struct map *__map_groups__first(struct map_groups *mg, enum map_type type)
+{
+	return maps__first(&mg->maps[type]);
+}
+
+struct map *map_groups__first(struct map_groups *mg)
+{
+	return __map_groups__first(mg, MAP__FUNCTION);
+}
+
 static int do_validate_kcore_modules(const char *filename, struct map *map,
 				  struct map_groups *kmaps)
 {
@@ -1055,7 +1065,7 @@ static int do_validate_kcore_modules(const char *filename, struct map *map,
 	if (err)
 		return err;
 
-	old_map = map_groups__first(kmaps, map->type);
+	old_map = __map_groups__first(kmaps, map->type);
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 		struct module_info *mi;
@@ -1218,7 +1228,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	old_map = map_groups__first(kmaps, map->type);
+	old_map = __map_groups__first(kmaps, map->type);
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 0acb1ec0e2f0..741af209b19d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -139,12 +139,10 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
 	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map *map;
-	struct dso *dso;
+	struct map *map = map_groups__first(thread->mg);
 
-	map = map_groups__first(thread->mg, MAP__FUNCTION);
 	for (; map ; map = map_groups__next(map)) {
-		dso = map->dso;
+		struct dso *dso = map->dso;
 		if (!dso || dso->long_name[0] != '/')
 			continue;
 		dso_type = dso__type(dso, machine);
