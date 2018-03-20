Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeCTGY5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:24:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTGYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:24:54 -0400
Date: Mon, 19 Mar 2018 23:24:14 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, ganapatrao.kulkarni@cavium.com,
        jolsa@redhat.com, will.deacon@arm.com, mingo@kernel.org,
        john.garry@huawei.com, tglx@linutronix.de, wcohen@redhat.com,
        peterz@infradead.org, ak@linux.intel.com, zhangshaokun@hisilicon.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Reply-To: acme@redhat.com, jolsa@redhat.com, ganapatrao.kulkarni@cavium.com,
        hpa@zytor.com, wcohen@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        john.garry@huawei.com, will.deacon@arm.com, ak@linux.intel.com,
        zhangshaokun@hisilicon.com, peterz@infradead.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
In-Reply-To: <1520506716-197429-8-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-8-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events: Add support for arch standard
 events
Git-Commit-ID: e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
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

Commit-ID:  e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
Gitweb:     https://git.kernel.org/tip/e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:32 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:35 -0300

perf vendor events: Add support for arch standard events

For some architectures (like arm), there are architecture- defined
events. Sometimes these events may be "recommended" according to the
architecture standard, in that the implementer is free ignore the
"recommendation" and create its custom event.

This patch adds support for parsing standard events from arch-defined
JSONs, and fixing up vendor events when they have implemented these
events as standard.

Support is also ensured that the vendor may implement their own custom
events.

A new step is added to the pmu events parsing to fix up the vendor
events with the arch-standard events.

The arch-defined JSONs must be placed in the arch root folder for
preprocessing prior to tree JSON processing.

In the vendor JSON, to specify that the arch event is supported, the
keyword "ArchStdEvent" should be used, like this:

[
    {
        "ArchStdEvent": "L1D_CACHE_WR",
    },
]

Matching is based on the "EventName" field in the architecture JSON.

No other JSON objects are strictly required. However, for other objects
added, these take precedence over architecture defined standard events,
thus supporting separate events which have the same event code.

Signed-off-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-8-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/Build     |   2 +
 tools/perf/pmu-events/README    |   6 ++
 tools/perf/pmu-events/jevents.c | 167 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 999a4e878162..17783913d330 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,10 +1,12 @@
 hostprogs := jevents
 
 jevents-y	+= json.o jsmn.o jevents.o
+CHOSTFLAGS_jevents.o	= -I$(srctree)/tools/include
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell [ -d $(JDIR) ] &&				\
 			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index 655286ff8767..e62b09b6a844 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -16,6 +16,12 @@ tree tools/perf/pmu-events/arch/foo.
 
 	- Directories are traversed, but all other files are ignored.
 
+	- To reduce JSON event duplication per architecture, platform JSONs may
+	  use "ArchStdEvent" keyword to dereference an "Architecture standard
+	  events", defined in architecture standard JSONs.
+	  Architecture standard JSONs must be located in the architecture root
+	  folder. Matching is based on the "EventName" field.
+
 The PMU events supported by a CPU model are expected to grouped into topics
 such as Pipelining, Cache, Memory, Floating-point etc. All events for a topic
 should be placed in a separate JSON file - where the file name identifies
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 0981d313064f..db3a594ee1e4 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -45,6 +45,7 @@
 #include <sys/resource.h>		/* getrlimit */
 #include <ftw.h>
 #include <sys/stat.h>
+#include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
 #include "jevents.h"
@@ -351,6 +352,81 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	return 0;
 }
 
+struct event_struct {
+	struct list_head list;
+	char *name;
+	char *event;
+	char *desc;
+	char *long_desc;
+	char *pmu;
+	char *unit;
+	char *perpkg;
+	char *metric_expr;
+	char *metric_name;
+	char *metric_group;
+};
+
+#define ADD_EVENT_FIELD(field) do { if (field) {		\
+	es->field = strdup(field);				\
+	if (!es->field)						\
+		goto out_free;					\
+} } while (0)
+
+#define FREE_EVENT_FIELD(field) free(es->field)
+
+#define TRY_FIXUP_FIELD(field) do { if (es->field && !*field) {\
+	*field = strdup(es->field);				\
+	if (!*field)						\
+		return -ENOMEM;					\
+} } while (0)
+
+#define FOR_ALL_EVENT_STRUCT_FIELDS(op) do {			\
+	op(name);						\
+	op(event);						\
+	op(desc);						\
+	op(long_desc);						\
+	op(pmu);						\
+	op(unit);						\
+	op(perpkg);						\
+	op(metric_expr);					\
+	op(metric_name);					\
+	op(metric_group);					\
+} while (0)
+
+static LIST_HEAD(arch_std_events);
+
+static void free_arch_std_events(void)
+{
+	struct event_struct *es, *next;
+
+	list_for_each_entry_safe(es, next, &arch_std_events, list) {
+		FOR_ALL_EVENT_STRUCT_FIELDS(FREE_EVENT_FIELD);
+		list_del(&es->list);
+		free(es);
+	}
+}
+
+static int save_arch_std_events(void *data, char *name, char *event,
+				char *desc, char *long_desc, char *pmu,
+				char *unit, char *perpkg, char *metric_expr,
+				char *metric_name, char *metric_group)
+{
+	struct event_struct *es;
+	struct stat *sb = data;
+
+	es = malloc(sizeof(*es));
+	if (!es)
+		return -ENOMEM;
+	memset(es, 0, sizeof(*es));
+	FOR_ALL_EVENT_STRUCT_FIELDS(ADD_EVENT_FIELD);
+	list_add_tail(&es->list, &arch_std_events);
+	return 0;
+out_free:
+	FOR_ALL_EVENT_STRUCT_FIELDS(FREE_EVENT_FIELD);
+	free(es);
+	return -ENOMEM;
+}
+
 static void print_events_table_suffix(FILE *outfp)
 {
 	fprintf(outfp, "{\n");
@@ -392,6 +468,32 @@ static char *real_event(const char *name, char *event)
 	return event;
 }
 
+static int
+try_fixup(const char *fn, char *arch_std, char **event, char **desc,
+	  char **name, char **long_desc, char **pmu, char **filter,
+	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
+	  char **metric_group, unsigned long long eventcode)
+{
+	/* try to find matching event from arch standard values */
+	struct event_struct *es;
+
+	list_for_each_entry(es, &arch_std_events, list) {
+		if (!strcmp(arch_std, es->name)) {
+			if (!eventcode && es->event) {
+				/* allow EventCode to be overridden */
+				free(*event);
+				*event = NULL;
+			}
+			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
+			return 0;
+		}
+	}
+
+	pr_err("%s: could not find matching %s for %s\n",
+					prog, arch_std, fn);
+	return -1;
+}
+
 /* Call func with each event in the json file */
 int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
@@ -427,6 +529,7 @@ int json_events(const char *fn,
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
 		char *metric_group = NULL;
+		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
@@ -512,6 +615,10 @@ int json_events(const char *fn,
 				addfield(map, &metric_expr, "", "", val);
 				for (s = metric_expr; *s; s++)
 					*s = tolower(*s);
+			} else if (json_streq(map, field, "ArchStdEvent")) {
+				addfield(map, &arch_std, "", "", val);
+				for (s = arch_std; *s; s++)
+					*s = tolower(*s);
 			}
 			/* ignore unknown fields */
 		}
@@ -536,8 +643,21 @@ int json_events(const char *fn,
 		if (name)
 			fixname(name);
 
+		if (arch_std) {
+			/*
+			 * An arch standard event is referenced, so try to
+			 * fixup any unassigned values.
+			 */
+			err = try_fixup(fn, arch_std, &event, &desc, &name,
+					&long_desc, &pmu, &filter, &perpkg,
+					&unit, &metric_expr, &metric_name,
+					&metric_group, eventcode);
+			if (err)
+				goto free_strings;
+		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
 			   pmu, unit, perpkg, metric_expr, metric_name, metric_group);
+free_strings:
 		free(event);
 		free(desc);
 		free(name);
@@ -550,6 +670,8 @@ int json_events(const char *fn,
 		free(metric_expr);
 		free(metric_name);
 		free(metric_group);
+		free(arch_std);
+
 		if (err)
 			break;
 		tok += j;
@@ -777,6 +899,32 @@ static int is_leaf_dir(const char *fpath)
 	return res;
 }
 
+static int is_json_file(const char *name)
+{
+	const char *suffix;
+
+	if (strlen(name) < 5)
+		return 0;
+
+	suffix = name + strlen(name) - 5;
+
+	if (strncmp(suffix, ".json", 5) == 0)
+		return 1;
+	return 0;
+}
+
+static int preprocess_arch_std_files(const char *fpath, const struct stat *sb,
+				int typeflag, struct FTW *ftwbuf)
+{
+	int level = ftwbuf->level;
+	int is_file = typeflag == FTW_F;
+
+	if (level == 1 && is_file && is_json_file(fpath))
+		return json_events(fpath, save_arch_std_events, (void *)sb);
+
+	return 0;
+}
+
 static int process_one_file(const char *fpath, const struct stat *sb,
 			    int typeflag, struct FTW *ftwbuf)
 {
@@ -854,9 +1002,7 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 	 * ignore it. It could be a readme.txt for instance.
 	 */
 	if (is_file) {
-		char *suffix = bname + strlen(bname) - 5;
-
-		if (strncmp(suffix, ".json", 5)) {
+		if (!is_json_file(bname)) {
 			pr_info("%s: Ignoring file without .json suffix %s\n", prog,
 				fpath);
 			return 0;
@@ -962,12 +1108,26 @@ int main(int argc, char *argv[])
 
 	maxfds = get_maxfds();
 	mapfile = NULL;
+	rc = nftw(ldirname, preprocess_arch_std_files, maxfds, 0);
+	if (rc && verbose) {
+		pr_info("%s: Error preprocessing arch standard files %s\n",
+			prog, ldirname);
+		goto empty_map;
+	} else if (rc < 0) {
+		/* Make build fail */
+		free_arch_std_events();
+		return 1;
+	} else if (rc) {
+		goto empty_map;
+	}
+
 	rc = nftw(ldirname, process_one_file, maxfds, 0);
 	if (rc && verbose) {
 		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		free_arch_std_events();
 		return 1;
 	} else if (rc) {
 		goto empty_map;
@@ -992,5 +1152,6 @@ int main(int argc, char *argv[])
 empty_map:
 	fclose(eventsfp);
 	create_empty_mapping(output_file);
+	free_arch_std_events();
 	return 0;
 }
