Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D96C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C187206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeLNUpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:45:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50791 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbeLNUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:45:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKipFu1456970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:44:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKipQm1456967;
        Fri, 14 Dec 2018 12:44:51 -0800
Date:   Fri, 14 Dec 2018 12:44:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-6024b7a51a19256df871d148925b2f0e4fc18436@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        mingo@kernel.org
Reply-To: ak@linux.intel.com, hpa@zytor.com, acme@redhat.com,
          mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181204001848.24769-1-andi@firstfloor.org>
References: <20181204001848.24769-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Support 'srccode' output
Git-Commit-ID: 6024b7a51a19256df871d148925b2f0e4fc18436
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6024b7a51a19256df871d148925b2f0e4fc18436
Gitweb:     https://git.kernel.org/tip/6024b7a51a19256df871d148925b2f0e4fc18436
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 3 Dec 2018 16:18:48 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:32 -0300

perf tools: Support 'srccode' output

When looking at PT or brstackinsn traces with 'perf script' it can be
very useful to see the source code. This adds a simple facility to print
them with 'perf script', if the information is available through dwarf

  % perf record ...
  % perf script -F insn,ip,sym,srccode
  ...

            4004c6 main
  5               for (i = 0; i < 10000000; i++)
             4004cd main
  5               for (i = 0; i < 10000000; i++)
             4004c6 main
  5               for (i = 0; i < 10000000; i++)
             4004cd main
  5               for (i = 0; i < 10000000; i++)
             4004cd main
  5               for (i = 0; i < 10000000; i++)
             4004cd main
  5               for (i = 0; i < 10000000; i++)
             4004cd main
  5               for (i = 0; i < 10000000; i++)
             4004cd main
  5               for (i = 0; i < 10000000; i++)
             4004b3 main
  6                       v++;

  % perf record -b ...
  % perf script -F insn,ip,sym,srccode,brstackinsn

  ...
         main+22:
          0000000000400543        insn: e8 ca ff ff ff            # PRED
  |18                     f1();
          f1:
          0000000000400512        insn: 55
  |10       {
          0000000000400513        insn: 48 89 e5
          0000000000400516        insn: b8 00 00 00 00
  |11             f2();
          000000000040051b        insn: e8 d6 ff ff ff            # PRED
          f2:
          00000000004004f6        insn: 55
  |5        {
          00000000004004f7        insn: 48 89 e5
          00000000004004fa        insn: 8b 05 2c 0b 20 00
  |6              c = a / b;
          0000000000400500        insn: 8b 0d 2a 0b 20 00
          0000000000400506        insn: 99
          0000000000400507        insn: f7 f9
          0000000000400509        insn: 89 05 29 0b 20 00
          000000000040050f        insn: 90
  |7        }
          0000000000400510        insn: 5d
          0000000000400511        insn: c3                        # PRED
          f1+14:
          0000000000400520        insn: b8 00 00 00 00
  |12             f2();
          0000000000400525        insn: e8 cc ff ff ff            # PRED
          f2:
          00000000004004f6        insn: 55
  |5        {
          00000000004004f7        insn: 48 89 e5
          00000000004004fa        insn: 8b 05 2c 0b 20 00
  |6              c = a / b;

Not supported for callchains currently, would need some layout changes
there.

Committer notes:

Fixed the build on Alpine Linux (3.4 .. 3.8) by addressing this
warning:

  In file included from util/srccode.c:19:0:
  /usr/include/sys/fcntl.h:1:2: error: #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h> [-Werror=cpp]
   #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h>
    ^~~~~~~
  cc1: all warnings being treated as errors

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181204001848.24769-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |   2 +-
 tools/perf/builtin-script.c              |  47 +++++++-
 tools/perf/util/Build                    |   1 +
 tools/perf/util/evsel_fprintf.c          |   1 +
 tools/perf/util/map.c                    |  49 ++++++++
 tools/perf/util/map.h                    |  16 +++
 tools/perf/util/srccode.c                | 186 +++++++++++++++++++++++++++++++
 tools/perf/util/srccode.h                |   7 ++
 tools/perf/util/srcline.c                |  28 +++++
 tools/perf/util/srcline.h                |   1 +
 tools/perf/util/thread.c                 |   2 +
 tools/perf/util/thread.h                 |   2 +
 12 files changed, 339 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index a2b37ce48094..9e4def08d569 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -117,7 +117,7 @@ OPTIONS
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output, brstackinsn,
-        brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc.
+        brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc, srccode.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3ea98fe72f7f..3728b50e52e2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -96,6 +96,7 @@ enum perf_output_field {
 	PERF_OUTPUT_UREGS	    = 1U << 27,
 	PERF_OUTPUT_METRIC	    = 1U << 28,
 	PERF_OUTPUT_MISC            = 1U << 29,
+	PERF_OUTPUT_SRCCODE	    = 1U << 30,
 };
 
 struct output_option {
@@ -132,6 +133,7 @@ struct output_option {
 	{.str = "phys_addr", .field = PERF_OUTPUT_PHYS_ADDR},
 	{.str = "metric", .field = PERF_OUTPUT_METRIC},
 	{.str = "misc", .field = PERF_OUTPUT_MISC},
+	{.str = "srccode", .field = PERF_OUTPUT_SRCCODE},
 };
 
 enum {
@@ -424,7 +426,7 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 		pr_err("Display of DSO requested but no address to convert.\n");
 		return -EINVAL;
 	}
-	if (PRINT_FIELD(SRCLINE) && !PRINT_FIELD(IP)) {
+	if ((PRINT_FIELD(SRCLINE) || PRINT_FIELD(SRCCODE)) && !PRINT_FIELD(IP)) {
 		pr_err("Display of source line number requested but sample IP is not\n"
 		       "selected. Hence, no address to lookup the source line number.\n");
 		return -EINVAL;
@@ -907,6 +909,22 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	return len;
 }
 
+static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
+{
+	struct addr_location al;
+	int ret = 0;
+
+	memset(&al, 0, sizeof(al));
+	thread__find_map(thread, cpumode, addr, &al);
+	if (!al.map)
+		return 0;
+	ret = map__fprintf_srccode(al.map, al.addr, stdout,
+		    &thread->srccode_state);
+	if (ret)
+		ret += printf("\n");
+	return ret;
+}
+
 static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct perf_insn *x, u8 *inbuf, int len,
 			    int insn, FILE *fp, int *total_cycles)
@@ -998,6 +1016,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					   x.cpumode, x.cpu, &lastsym, attr, fp);
 		printed += ip__fprintf_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
 					    &x, buffer, len, 0, fp, &total_cycles);
+		if (PRINT_FIELD(SRCCODE))
+			printed += print_srccode(thread, x.cpumode, br->entries[nr - 1].from);
 	}
 
 	/* Print all blocks */
@@ -1027,12 +1047,16 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			if (ip == end) {
 				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp,
 							    &total_cycles);
+				if (PRINT_FIELD(SRCCODE))
+					printed += print_srccode(thread, x.cpumode, ip);
 				break;
 			} else {
 				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
 						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
 					break;
+				if (PRINT_FIELD(SRCCODE))
+					print_srccode(thread, x.cpumode, ip);
 				insn++;
 			}
 		}
@@ -1063,6 +1087,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
+		if (PRINT_FIELD(SRCCODE))
+			print_srccode(thread, x.cpumode, sample->ip);
 		goto out;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
@@ -1070,6 +1096,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
+		if (PRINT_FIELD(SRCCODE))
+			print_srccode(thread, x.cpumode, start + off);
 	}
 out:
 	return printed;
@@ -1252,7 +1280,16 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
 
 	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
-	return printed + fprintf(fp, "\n");
+	printed += fprintf(fp, "\n");
+	if (PRINT_FIELD(SRCCODE)) {
+		int ret = map__fprintf_srccode(al->map, al->addr, stdout,
+					 &thread->srccode_state);
+		if (ret) {
+			printed += ret;
+			printed += printf("\n");
+		}
+	}
+	return printed;
 }
 
 static struct {
@@ -1792,6 +1829,12 @@ static void process_event(struct perf_script *script,
 		fprintf(fp, "%16" PRIx64, sample->phys_addr);
 	fprintf(fp, "\n");
 
+	if (PRINT_FIELD(SRCCODE)) {
+		if (map__fprintf_srccode(al->map, al->addr, stdout,
+					 &thread->srccode_state))
+			printf("\n");
+	}
+
 	if (PRINT_FIELD(METRIC))
 		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b7bf201fe8a8..af72be7f5b3b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -77,6 +77,7 @@ libperf-y += stat-shadow.o
 libperf-y += stat-display.o
 libperf-y += record.o
 libperf-y += srcline.o
+libperf-y += srccode.o
 libperf-y += data.o
 libperf-y += tsc.o
 libperf-y += cloexec.o
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 0d0a4c6f368b..95ea147f9e18 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -173,6 +173,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (!print_oneline)
 				printed += fprintf(fp, "\n");
 
+			/* Add srccode here too? */
 			if (symbol_conf.bt_stop_list &&
 			    node->sym &&
 			    strlist__has_entry(symbol_conf.bt_stop_list,
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a0d58b4d9c32..6751301a755c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -19,6 +19,7 @@
 #include "srcline.h"
 #include "namespaces.h"
 #include "unwind.h"
+#include "srccode.h"
 
 static void __maps__insert(struct maps *maps, struct map *map);
 static void __maps__insert_name(struct maps *maps, struct map *map);
@@ -421,6 +422,54 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 	return ret;
 }
 
+int map__fprintf_srccode(struct map *map, u64 addr,
+			 FILE *fp,
+			 struct srccode_state *state)
+{
+	char *srcfile;
+	int ret = 0;
+	unsigned line;
+	int len;
+	char *srccode;
+
+	if (!map || !map->dso)
+		return 0;
+	srcfile = get_srcline_split(map->dso,
+				    map__rip_2objdump(map, addr),
+				    &line);
+	if (!srcfile)
+		return 0;
+
+	/* Avoid redundant printing */
+	if (state &&
+	    state->srcfile &&
+	    !strcmp(state->srcfile, srcfile) &&
+	    state->line == line) {
+		free(srcfile);
+		return 0;
+	}
+
+	srccode = find_sourceline(srcfile, line, &len);
+	if (!srccode)
+		goto out_free_line;
+
+	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
+	state->srcfile = srcfile;
+	state->line = line;
+	return ret;
+
+out_free_line:
+	free(srcfile);
+	return ret;
+}
+
+
+void srccode_state_free(struct srccode_state *state)
+{
+	zfree(&state->srcfile);
+	state->line = 0;
+}
+
 /**
  * map__rip_2objdump - convert symbol start address to objdump address.
  * @map: memory map
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 5c792c90fc4c..09282aa45c80 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -174,6 +174,22 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
+struct srccode_state {
+	char *srcfile;
+	unsigned line;
+};
+
+static inline void srccode_state_init(struct srccode_state *state)
+{
+	state->srcfile = NULL;
+	state->line = 0;
+}
+
+void srccode_state_free(struct srccode_state *state);
+
+int map__fprintf_srccode(struct map *map, u64 addr,
+			 FILE *fp, struct srccode_state *state);
+
 int map__load(struct map *map);
 struct symbol *map__find_symbol(struct map *map, u64 addr);
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
new file mode 100644
index 000000000000..fcc8630f6dff
--- /dev/null
+++ b/tools/perf/util/srccode.c
@@ -0,0 +1,186 @@
+/*
+ * Manage printing of source lines
+ * Copyright (c) 2017, Intel Corporation.
+ * Author: Andi Kleen
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#include "linux/list.h"
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <assert.h>
+#include <string.h>
+#include "srccode.h"
+#include "debug.h"
+#include "util.h"
+
+#define MAXSRCCACHE (32*1024*1024)
+#define MAXSRCFILES     64
+#define SRC_HTAB_SZ	64
+
+struct srcfile {
+	struct hlist_node hash_nd;
+	struct list_head nd;
+	char *fn;
+	char **lines;
+	char *map;
+	unsigned numlines;
+	size_t maplen;
+};
+
+static struct hlist_head srcfile_htab[SRC_HTAB_SZ];
+static LIST_HEAD(srcfile_list);
+static long map_total_sz;
+static int num_srcfiles;
+
+static unsigned shash(unsigned char *s)
+{
+	unsigned h = 0;
+	while (*s)
+		h = 65599 * h + *s++;
+	return h ^ (h >> 16);
+}
+
+static int countlines(char *map, int maplen)
+{
+	int numl;
+	char *end = map + maplen;
+	char *p = map;
+
+	if (maplen == 0)
+		return 0;
+	numl = 0;
+	while (p < end && (p = memchr(p, '\n', end - p)) != NULL) {
+		numl++;
+		p++;
+	}
+	if (p < end)
+		numl++;
+	return numl;
+}
+
+static void fill_lines(char **lines, int maxline, char *map, int maplen)
+{
+	int l;
+	char *end = map + maplen;
+	char *p = map;
+
+	if (maplen == 0 || maxline == 0)
+		return;
+	l = 0;
+	lines[l++] = map;
+	while (p < end && (p = memchr(p, '\n', end - p)) != NULL) {
+		if (l >= maxline)
+			return;
+		lines[l++] = ++p;
+	}
+	if (p < end)
+		lines[l] = p;
+}
+
+static void free_srcfile(struct srcfile *sf)
+{
+	list_del(&sf->nd);
+	hlist_del(&sf->hash_nd);
+	map_total_sz -= sf->maplen;
+	munmap(sf->map, sf->maplen);
+	free(sf->lines);
+	free(sf->fn);
+	free(sf);
+	num_srcfiles--;
+}
+
+static struct srcfile *find_srcfile(char *fn)
+{
+	struct stat st;
+	struct srcfile *h;
+	int fd;
+	unsigned long sz;
+	unsigned hval = shash((unsigned char *)fn) % SRC_HTAB_SZ;
+
+	hlist_for_each_entry (h, &srcfile_htab[hval], hash_nd) {
+		if (!strcmp(fn, h->fn)) {
+			/* Move to front */
+			list_del(&h->nd);
+			list_add(&h->nd, &srcfile_list);
+			return h;
+		}
+	}
+
+	/* Only prune if there is more than one entry */
+	while ((num_srcfiles > MAXSRCFILES || map_total_sz > MAXSRCCACHE) &&
+	       srcfile_list.next != &srcfile_list) {
+		assert(!list_empty(&srcfile_list));
+		h = list_entry(srcfile_list.prev, struct srcfile, nd);
+		free_srcfile(h);
+	}
+
+	fd = open(fn, O_RDONLY);
+	if (fd < 0 || fstat(fd, &st) < 0) {
+		pr_debug("cannot open source file %s\n", fn);
+		return NULL;
+	}
+
+	h = malloc(sizeof(struct srcfile));
+	if (!h)
+		return NULL;
+
+	h->fn = strdup(fn);
+	if (!h->fn)
+		goto out_h;
+
+	h->maplen = st.st_size;
+	sz = (h->maplen + page_size - 1) & ~(page_size - 1);
+	h->map = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
+	close(fd);
+	if (h->map == (char *)-1) {
+		pr_debug("cannot mmap source file %s\n", fn);
+		goto out_fn;
+	}
+	h->numlines = countlines(h->map, h->maplen);
+	h->lines = calloc(h->numlines, sizeof(char *));
+	if (!h->lines)
+		goto out_map;
+	fill_lines(h->lines, h->numlines, h->map, h->maplen);
+	list_add(&h->nd, &srcfile_list);
+	hlist_add_head(&h->hash_nd, &srcfile_htab[hval]);
+	map_total_sz += h->maplen;
+	num_srcfiles++;
+	return h;
+
+out_map:
+	munmap(h->map, sz);
+out_fn:
+	free(h->fn);
+out_h:
+	free(h);
+	return NULL;
+}
+
+/* Result is not 0 terminated */
+char *find_sourceline(char *fn, unsigned line, int *lenp)
+{
+	char *l, *p;
+	struct srcfile *sf = find_srcfile(fn);
+	if (!sf)
+		return NULL;
+	line--;
+	if (line >= sf->numlines)
+		return NULL;
+	l = sf->lines[line];
+	if (!l)
+		return NULL;
+	p = memchr(l, '\n', sf->map + sf->maplen - l);
+	*lenp = p - l;
+	return l;
+}
diff --git a/tools/perf/util/srccode.h b/tools/perf/util/srccode.h
new file mode 100644
index 000000000000..e500a746d5f1
--- /dev/null
+++ b/tools/perf/util/srccode.h
@@ -0,0 +1,7 @@
+#ifndef SRCCODE_H
+#define SRCCODE_H 1
+
+/* Result is not 0 terminated */
+char *find_sourceline(char *fn, unsigned line, int *lenp);
+
+#endif
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index e767c4a9d4d2..dc86597d0cc4 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -548,6 +548,34 @@ out:
 	return srcline;
 }
 
+/* Returns filename and fills in line number in line */
+char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
+{
+	char *file = NULL;
+	const char *dso_name;
+
+	if (!dso->has_srcline)
+		goto out;
+
+	dso_name = dso__name(dso);
+	if (dso_name == NULL)
+		goto out;
+
+	if (!addr2line(dso_name, addr, &file, line, dso, true, NULL, NULL))
+		goto out;
+
+	dso->a2l_fails = 0;
+	return file;
+
+out:
+	if (dso->a2l_fails && ++dso->a2l_fails > A2L_FAIL_LIMIT) {
+		dso->has_srcline = 0;
+		dso__free_a2l(dso);
+	}
+
+	return NULL;
+}
+
 void free_srcline(char *srcline)
 {
 	if (srcline && strcmp(srcline, SRCLINE_UNKNOWN) != 0)
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index b2bb5502fd62..5762212dc342 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -16,6 +16,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		  bool show_sym, bool show_addr, bool unwind_inlines,
 		  u64 ip);
 void free_srcline(char *srcline);
+char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line);
 
 /* insert the srcline into the DSO, which will take ownership */
 void srcline__tree_insert(struct rb_root *tree, u64 addr, char *srcline);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 3d9ed7d0e281..c83372329f89 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -64,6 +64,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		RB_CLEAR_NODE(&thread->rb_node);
 		/* Thread holds first ref to nsdata. */
 		thread->nsinfo = nsinfo__new(pid);
+		srccode_state_init(&thread->srccode_state);
 	}
 
 	return thread;
@@ -103,6 +104,7 @@ void thread__delete(struct thread *thread)
 
 	unwind__finish_access(thread);
 	nsinfo__zput(thread->nsinfo);
+	srccode_state_free(&thread->srccode_state);
 
 	exit_rwsem(&thread->namespaces_lock);
 	exit_rwsem(&thread->comm_lock);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 5920c3bb8ffe..712dd48cc0ca 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include "symbol.h"
+#include "map.h"
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
@@ -38,6 +39,7 @@ struct thread {
 	void			*priv;
 	struct thread_stack	*ts;
 	struct nsinfo		*nsinfo;
+	struct srccode_state	srccode_state;
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void				*addr_space;
 	struct unwind_libunwind_ops	*unwind_libunwind_ops;
