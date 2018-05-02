Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeEBPWl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbeEBPWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:36 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 50/52] perf symbols: Move split_kallsyms to struct map_groups
Date: Wed,  2 May 2018 12:19:40 -0300
Message-Id: <20180502151942.20542-51-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since it mainly will populate symtabs of its maps (kernel modules).

While looking at this I wonder if map_groups__split_kallsyms_for_kcore()
shouldn't be all that we need, seems much simpler.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3d1f3iby76popdr8ia9yimsc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 76de63cecf98..f48dc157c2bd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -676,9 +676,8 @@ static int dso__load_all_kallsyms(struct dso *dso, const char *filename)
 	return kallsyms__parse(filename, dso, map__process_kallsym_symbol);
 }
 
-static int dso__split_kallsyms_for_kcore(struct dso *dso, struct map *map)
+static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct dso *dso)
 {
-	struct map_groups *kmaps = map__kmaps(map);
 	struct map *curr_map;
 	struct symbol *pos;
 	int count = 0;
@@ -728,11 +727,11 @@ static int dso__split_kallsyms_for_kcore(struct dso *dso, struct map *map)
  * kernel range is broken in several maps, named [kernel].N, as we don't have
  * the original ELF section names vmlinux have.
  */
-static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
+static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso, u64 delta,
+				      struct map *initial_map)
 {
-	struct map_groups *kmaps = map__kmaps(map);
 	struct machine *machine;
-	struct map *curr_map = map;
+	struct map *curr_map = initial_map;
 	struct symbol *pos;
 	int count = 0, moved = 0;
 	struct rb_root *root = &dso->symbols;
@@ -758,7 +757,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 			*module++ = '\0';
 
 			if (strcmp(curr_map->dso->short_name, module)) {
-				if (curr_map != map &&
+				if (curr_map != initial_map &&
 				    dso->kernel == DSO_TYPE_GUEST_KERNEL &&
 				    machine__is_default_guest(machine)) {
 					/*
@@ -777,7 +776,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 					         "inconsistency while looking "
 						 "for \"%s\" module!\n",
 						 machine->root_dir, module);
-					curr_map = map;
+					curr_map = initial_map;
 					goto discard_symbol;
 				}
 
@@ -787,11 +786,11 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 			}
 			/*
 			 * So that we look just like we get from .ko files,
-			 * i.e. not prelinked, relative to map->start.
+			 * i.e. not prelinked, relative to initial_map->start.
 			 */
 			pos->start = curr_map->map_ip(curr_map, pos->start);
 			pos->end   = curr_map->map_ip(curr_map, pos->end);
-		} else if (curr_map != map) {
+		} else if (curr_map != initial_map) {
 			char dso_name[PATH_MAX];
 			struct dso *ndso;
 
@@ -802,7 +801,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 			}
 
 			if (count == 0) {
-				curr_map = map;
+				curr_map = initial_map;
 				goto add_symbol;
 			}
 
@@ -836,7 +835,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 			pos->end -= delta;
 		}
 add_symbol:
-		if (curr_map != map) {
+		if (curr_map != initial_map) {
 			rb_erase(&pos->rb_node, root);
 			symbols__insert(&curr_map->dso->symbols, pos);
 			++moved;
@@ -849,7 +848,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 		symbol__delete(pos);
 	}
 
-	if (curr_map != map &&
+	if (curr_map != initial_map &&
 	    dso->kernel == DSO_TYPE_GUEST_KERNEL &&
 	    machine__is_default_guest(kmaps->machine)) {
 		dso__set_loaded(curr_map->dso);
@@ -1308,9 +1307,9 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 		dso->symtab_type = DSO_BINARY_TYPE__KALLSYMS;
 
 	if (!no_kcore && !dso__load_kcore(dso, map, filename))
-		return dso__split_kallsyms_for_kcore(dso, map);
+		return map_groups__split_kallsyms_for_kcore(kmap->kmaps, dso);
 	else
-		return dso__split_kallsyms(dso, map, delta);
+		return map_groups__split_kallsyms(kmap->kmaps, dso, delta, map);
 }
 
 int dso__load_kallsyms(struct dso *dso, const char *filename,
-- 
2.14.3
