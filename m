Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeEBSE2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:04:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeEBSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:04:25 -0400
Date: Wed, 2 May 2018 11:04:15 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3d1f3iby76popdr8ia9yimsc@git.kernel.org>
Cc: hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, dsahern@gmail.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, wangnan0@huawei.com, adrian.hunter@intel.com,
        dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Move split_kallsyms to struct
 map_groups
Git-Commit-ID: 15e0e2d4eeb147048af1dd9c3a675c26c4a7eb80
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

Commit-ID:  15e0e2d4eeb147048af1dd9c3a675c26c4a7eb80
Gitweb:     https://git.kernel.org/tip/15e0e2d4eeb147048af1dd9c3a675c26c4a7eb80
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 27 Apr 2018 15:59:32 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 27 Apr 2018 16:05:15 -0300

perf symbols: Move split_kallsyms to struct map_groups

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
@@ -849,7 +848,7 @@ discard_symbol:
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
