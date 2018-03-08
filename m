Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966096AbeCHK7z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:59:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60466 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S935524AbeCHK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:59:49 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 07/11] perf vendor events: add support for arch standard events
Date: Thu, 8 Mar 2018 18:58:32 +0800
Message-ID: <1520506716-197429-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some architectures (like arm), there are architecture-
defined events. Sometimes these events may be "recommended"
according to the architecture standard, in that the
implementer is free ignore the "recommendation" and create
its custom event.

This patch adds support for parsing standard events from
arch-defined JSONs, and fixing up vendor events when they
have implemented these events as standard.

Support is also ensured that the vendor may implement their
own custom events.

A new step is added to the pmu events parsing to fix up the
vendor events with the arch-standard events.

The arch-defined JSONs must be placed in the arch root
folder for preprocessing prior to tree JSON processing.

In the vendor JSON, to specify that the arch event is
supported, the keyword "ArchStdEvent" should be used,
like this:
[
    {
        "ArchStdEvent": "L1D_CACHE_WR",
    },
]

Matching is based on the "EventName" field in the
architecture JSON.

No other JSON objects are strictly required. However,
for other objects added, these take precedence over
architecture defined standard events, thus supporting
separate events which have the same event code.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/Build     |   2 +
 tools/perf/pmu-events/README    |   6 ++
 tools/perf/pmu-events/jevents.c | 167 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 999a4e8..1778391 100644
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
index 655286f..e62b09b 100644
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
index 7b9e210..9b970a0 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -44,6 +44,7 @@
 #include <sys/resource.h>		/* getrlimit */
 #include <ftw.h>
 #include <sys/stat.h>
+#include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
 #include "jevents.h"
@@ -350,6 +351,81 @@ static int print_events_table_entry(void *data, char *name, char *event,
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
@@ -391,6 +467,32 @@ static char *real_event(const char *name, char *event)
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
@@ -426,6 +528,7 @@ int json_events(const char *fn,
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
 		char *metric_group = NULL;
+		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
@@ -511,6 +614,10 @@ int json_events(const char *fn,
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
@@ -535,8 +642,21 @@ int json_events(const char *fn,
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
@@ -549,6 +669,8 @@ int json_events(const char *fn,
 		free(metric_expr);
 		free(metric_name);
 		free(metric_group);
+		free(arch_std);
+
 		if (err)
 			break;
 		tok += j;
@@ -773,6 +895,32 @@ static int is_leaf_dir(const char *fpath)
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
@@ -850,9 +998,7 @@ static int process_one_file(const char *fpath, const struct stat *sb,
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
@@ -958,12 +1104,26 @@ int main(int argc, char *argv[])
 
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
@@ -988,5 +1148,6 @@ int main(int argc, char *argv[])
 empty_map:
 	fclose(eventsfp);
 	create_empty_mapping(output_file);
+	free_arch_std_events();
 	return 0;
 }
-- 
1.9.1
