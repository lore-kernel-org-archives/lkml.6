Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeBFRAt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:00:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51560 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753086AbeBFQ4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:56:02 -0500
From: John Garry <john.garry@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>, <wcohen@redhat.com>,
        <will.deacon@arm.com>, <ganapatrao.kulkarni@cavium.com>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 5/9] perf utils: add support for arch standard events
Date: Wed, 7 Feb 2018 01:45:00 +0800
Message-ID: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
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
        "ArchStdEvent": "0x41",
	"BriefDescription": "L1D cache access, write"
    },
]

No other JSON objects are strictly required. However,
for other objects added, these take precedence over
architecture defined standard events, thus supporting
separate events which have the same event code.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/Build     |   1 +
 tools/perf/pmu-events/README    |   6 ++
 tools/perf/pmu-events/jevents.c | 185 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 182 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 999a4e8..f9e8466 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,5 +1,6 @@
 hostprogs := jevents
 
+CHOSTFLAGS	= -I$(srctree)/tools/include
 jevents-y	+= json.o jsmn.o jevents.o
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index 655286f..cff4c91 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -16,6 +16,12 @@ tree tools/perf/pmu-events/arch/foo.
 
 	- Directories are traversed, but all other files are ignored.
 
+	- To reduce JSON event duplication per architecture, platform JSONs may
+	  use "ArchStdEvent" keyword to dereference an "Architecture standard
+	  events", defined in architecture standard JSONs.
+	  Architecture standard JSONs must be located in the architecture root
+	  folder.
+
 The PMU events supported by a CPU model are expected to grouped into topics
 such as Pipelining, Cache, Memory, Floating-point etc. All events for a topic
 should be placed in a separate JSON file - where the file name identifies
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index eb183b1..19e30cd 100644
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
@@ -366,6 +367,67 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	return 0;
 }
 
+struct event_struct {
+	char *name;
+	char *event;
+	char *desc;
+	char *long_desc;
+	char *pmu;
+	char *filter;
+	char *perpkg;
+	char *unit;
+	char *metric_expr;
+	char *metric_name;
+	char *metric_group;
+	struct list_head list;
+	char strings[];
+};
+
+static LIST_HEAD(arch_std_events);
+
+#define ADD_EVENT_STRING(string) do { if (string) {		\
+	es->string = strings;					\
+	strings += snprintf(strings, len, "%s", string) + 1;	\
+} } while (0)
+
+static int save_arch_std_events(void *data, char *name, char *event,
+				char *desc, char *long_desc, char *pmu,
+				char *unit, char *perpkg, char *metric_expr,
+				char *metric_name, char *metric_group)
+{
+	struct event_struct *es;
+	struct stat *sb = data;
+	int len;
+	char *strings;
+
+	/*
+	 * Lazily allocate size of the json file to hold the
+	 * strings, which would be more than large enough.
+	 */
+	len = sb->st_size;
+
+	es = malloc(sizeof(*es) + len);
+	if (!es)
+		return -ENOMEM;
+	memset(es, 0, sizeof(*es));
+	list_add_tail(&es->list, &arch_std_events);
+
+	strings = &es->strings[0];
+
+	ADD_EVENT_STRING(name);
+	ADD_EVENT_STRING(event);
+	ADD_EVENT_STRING(desc);
+	ADD_EVENT_STRING(long_desc);
+	ADD_EVENT_STRING(pmu);
+	ADD_EVENT_STRING(unit);
+	ADD_EVENT_STRING(perpkg);
+	ADD_EVENT_STRING(metric_expr);
+	ADD_EVENT_STRING(metric_name);
+	ADD_EVENT_STRING(metric_group);
+
+	return 0;
+}
+
 static void print_events_table_suffix(FILE *outfp)
 {
 	fprintf(outfp, "{\n");
@@ -407,6 +469,52 @@ static char *real_event(const char *name, char *event)
 	return event;
 }
 
+static void fixup_field(char *from, char **to)
+{
+	*to = malloc(strlen(from));
+
+	strcpy(*to, from);
+}
+
+#define EVENT_PREFIX "event="
+
+#define TRY_FIXUP_FIELD(string)	do { if (es->string && !*string)\
+			fixup_field(es->string, string);	\
+} while (0)
+
+static int
+try_fixup(const char *fn, char *arch_std, char **event, char **desc,
+	  char **name, char **long_desc, char **pmu, char **filter,
+	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
+	  char **metric_group)
+{
+	/* try to find matching event from arch standard values */
+	struct event_struct *es;
+
+	list_for_each_entry(es, &arch_std_events, list) {
+		if (!strcmp(arch_std, es->event+strlen(EVENT_PREFIX))) {
+			/* now fixup */
+			fixup_field(es->event, event);
+			TRY_FIXUP_FIELD(desc);
+			TRY_FIXUP_FIELD(name);
+			TRY_FIXUP_FIELD(long_desc);
+			TRY_FIXUP_FIELD(pmu);
+			TRY_FIXUP_FIELD(filter);
+			TRY_FIXUP_FIELD(perpkg);
+			TRY_FIXUP_FIELD(unit);
+			TRY_FIXUP_FIELD(metric_expr);
+			TRY_FIXUP_FIELD(metric_name);
+			TRY_FIXUP_FIELD(metric_group);
+
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
@@ -442,6 +550,7 @@ int json_events(const char *fn,
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
 		char *metric_group = NULL;
+		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
@@ -527,6 +636,10 @@ int json_events(const char *fn,
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
@@ -538,7 +651,7 @@ int json_events(const char *fn,
 				addfield(map, &extra_desc, " ",
 						"(Precise event)", NULL);
 		}
-		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
+		snprintf(buf, sizeof(buf), "%s%#llx", EVENT_PREFIX, eventcode);
 		addfield(map, &event, ",", buf, NULL);
 		if (desc && extra_desc)
 			addfield(map, &desc, " ", extra_desc, NULL);
@@ -550,9 +663,21 @@ int json_events(const char *fn,
 			addfield(map, &event, ",", msr->pname, msrval);
 		if (name)
 			fixname(name);
-
-		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name, metric_group);
+		err = 0;
+		if (arch_std) {
+			/*
+			 * An arch standard event is referenced, so try to
+			 * fixup any unassigned values.
+			 */
+			err = try_fixup(fn, arch_std, &event, &desc, &name,
+					&long_desc, &pmu, &filter, &perpkg,
+					&unit, &metric_expr, &metric_name,
+					&metric_group);
+		}
+		if (!err)
+			err = func(data, name, real_event(name, event), desc,
+				   long_desc, pmu, unit, perpkg, metric_expr,
+				   metric_name, metric_group);
 		free(event);
 		free(desc);
 		free(name);
@@ -565,6 +690,7 @@ int json_events(const char *fn,
 		free(metric_expr);
 		free(metric_name);
 		free(metric_group);
+
 		if (err)
 			break;
 		tok += j;
@@ -789,6 +915,32 @@ static int is_leaf_dir(const char *fpath)
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
@@ -876,9 +1028,7 @@ static int process_one_file(const char *fpath, const struct stat *sb,
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
@@ -940,6 +1090,7 @@ int main(int argc, char *argv[])
 	const char *output_file;
 	const char *start_dirname;
 	struct stat stbuf;
+	struct event_struct *es1, *es2;
 
 	prog = basename(argv[0]);
 	if (argc < 4) {
@@ -984,17 +1135,28 @@ int main(int argc, char *argv[])
 
 	maxfds = get_maxfds();
 	mapfile = NULL;
+	rc = nftw(ldirname, preprocess_arch_std_files, get_maxfds(), 0);
+	if (rc && verbose) {
+		pr_info("%s: Error preprocessing arch standard files %s\n",
+			prog, ldirname);
+		goto empty_map;
+	} else if (rc < 0) {
+		/* Make build fail */
+		return 1;
+	}
 	rc = nftw(ldirname, process_one_file, maxfds, 0);
 	if (rc && verbose) {
 		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
-		goto empty_map;
+		goto free_standard_arch_events;
 	} else if (rc < 0) {
 		/* Make build fail */
 		return 1;
-	} else if (rc) {
-		goto empty_map;
 	}
 
+	/* Free memories for architecture standard events */
+	list_for_each_entry_safe(es1, es2, &arch_std_events, list)
+		free(es1);
+
 	if (close_table)
 		print_events_table_suffix(eventsfp);
 
@@ -1011,6 +1173,9 @@ int main(int argc, char *argv[])
 
 	return 0;
 
+free_standard_arch_events:
+	list_for_each_entry_safe(es1, es2, &arch_std_events, list)
+		free(es1);
 empty_map:
 	fclose(eventsfp);
 	create_empty_mapping(output_file);
-- 
1.9.1
