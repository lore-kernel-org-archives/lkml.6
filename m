Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCTGYg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:24:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50073 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTGYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:24:34 -0400
Date: Mon, 19 Mar 2018 23:22:49 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-51ce1dcc5d0d3e40e26893a7fa9e30538960ee7e@git.kernel.org>
Cc: ak@linux.intel.com, sukadev@linux.vnet.ibm.com, peterz@infradead.org,
        acme@redhat.com, hpa@zytor.com, jolsa@kernel.org, wcohen@redhat.com,
        will.deacon@arm.com, tglx@linutronix.de, john.garry@huawei.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, zhangshaokun@hisilicon.com
Reply-To: sukadev@linux.vnet.ibm.com, ak@linux.intel.com, hpa@zytor.com,
        acme@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        john.garry@huawei.com, wcohen@redhat.com, will.deacon@arm.com,
        jolsa@kernel.org, zhangshaokun@hisilicon.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        ganapatrao.kulkarni@cavium.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com
In-Reply-To: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-5-git-send-email-john.garry@huawei.com>
        <1521047452-28565-1-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events: Add support for pmu events
 vendor subdirectory
Git-Commit-ID: 51ce1dcc5d0d3e40e26893a7fa9e30538960ee7e
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

Commit-ID:  51ce1dcc5d0d3e40e26893a7fa9e30538960ee7e
Gitweb:     https://git.kernel.org/tip/51ce1dcc5d0d3e40e26893a7fa9e30538960ee7e
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:29 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:16 -0300

perf vendor events: Add support for pmu events vendor subdirectory

For some architectures (like arm), it is required to support a vendor
subdirectory and not locate all the JSONs for a specific vendor in the
same folder.

This is because all the events for the same vendor will be placed in the
same pmu events table, which may cause conflict.  This conflict would be
in the instance that a vendor's custom implemented events do have the
same meaning on different platforms, so events in the pmu table would
conflict. In addition, per list command may show events which are not
even supported for a given platform.

This patch adds support for a arch/vendor/platform directory hierarchy,
while maintaining backwards-compatibility for existing arch/platform
structure. In this, each platform would always have its own pmu events
table.

In generated file pmu_events.c, each platform table name is in the
format pme{_vendor}_platform, like this:

struct pmu_events_map pmu_events_map[] = {
{
	.cpuid = "0x00000000420f5160",
	.version = "v1",
	.type = "core",
	.table = pme_cavium_thunderx2
},
{
	.cpuid = 0,
	.version = 0,
	.type = 0,
	.table = 0,
},
};

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-5-git-send-email-john.garry@huawei.com
Link: http://lkml.kernel.org/r/1521047452-28565-1-git-send-email-john.garry@huawei.com
[ Add missing limits.h include, fixing the build on at least all Alpine Linux versions tested (3.4 to 3.7 + edge), ]
[ Applied a patch to fix reading ./.. directories in XFS, see second Link tag ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/README    |  4 +++
 tools/perf/pmu-events/jevents.c | 68 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index 2407abc1d441..655286ff8767 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -28,6 +28,10 @@ sub directory. Thus for the Silvermont X86 CPU:
 	Cache.json 	Memory.json 	Virtual-Memory.json
 	Frontend.json 	Pipeline.json
 
+The JSONs folder for a CPU model/family may be placed in the root arch
+folder, or may be placed in a vendor sub-folder under the arch folder
+for instances where the arch and vendor are not the same.
+
 Using the JSON files and the mapfile, 'jevents' generates the C source file,
 'pmu-events.c', which encodes the two sets of tables:
 
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 1d02fafdc34d..0981d313064f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -39,6 +39,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <libgen.h>
+#include <limits.h>
 #include <dirent.h>
 #include <sys/time.h>			/* getrlimit */
 #include <sys/resource.h>		/* getrlimit */
@@ -572,7 +573,7 @@ static char *file_name_to_table_name(char *fname)
 	 * Derive rest of table name from basename of the JSON file,
 	 * replacing hyphens and stripping out .json suffix.
 	 */
-	n = asprintf(&tblname, "pme_%s", basename(fname));
+	n = asprintf(&tblname, "pme_%s", fname);
 	if (n < 0) {
 		pr_info("%s: asprintf() error %s for file %s\n", prog,
 				strerror(errno), fname);
@@ -582,7 +583,7 @@ static char *file_name_to_table_name(char *fname)
 	for (i = 0; i < strlen(tblname); i++) {
 		c = tblname[i];
 
-		if (c == '-')
+		if (c == '-' || c == '/')
 			tblname[i] = '_';
 		else if (c == '.') {
 			tblname[i] = '\0';
@@ -739,25 +740,80 @@ static int get_maxfds(void)
 static FILE *eventsfp;
 static char *mapfile;
 
+static int is_leaf_dir(const char *fpath)
+{
+	DIR *d;
+	struct dirent *dir;
+	int res = 1;
+
+	d = opendir(fpath);
+	if (!d)
+		return 0;
+
+	while ((dir = readdir(d)) != NULL) {
+		if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
+			continue;
+
+		if (dir->d_type == DT_DIR) {
+			res = 0;
+			break;
+		} else if (dir->d_type == DT_UNKNOWN) {
+			char path[PATH_MAX];
+			struct stat st;
+
+			sprintf(path, "%s/%s", fpath, dir->d_name);
+			if (stat(path, &st))
+				break;
+
+			if (S_ISDIR(st.st_mode)) {
+				res = 0;
+				break;
+			}
+		}
+	}
+
+	closedir(d);
+
+	return res;
+}
+
 static int process_one_file(const char *fpath, const struct stat *sb,
 			    int typeflag, struct FTW *ftwbuf)
 {
-	char *tblname, *bname  = (char *) fpath + ftwbuf->base;
+	char *tblname, *bname;
 	int is_dir  = typeflag == FTW_D;
 	int is_file = typeflag == FTW_F;
 	int level   = ftwbuf->level;
 	int err = 0;
 
+	if (level == 2 && is_dir) {
+		/*
+		 * For level 2 directory, bname will include parent name,
+		 * like vendor/platform. So search back from platform dir
+		 * to find this.
+		 */
+		bname = (char *) fpath + ftwbuf->base - 2;
+		for (;;) {
+			if (*bname == '/')
+				break;
+			bname--;
+		}
+		bname++;
+	} else
+		bname = (char *) fpath + ftwbuf->base;
+
 	pr_debug("%s %d %7jd %-20s %s\n",
 		 is_file ? "f" : is_dir ? "d" : "x",
 		 level, sb->st_size, bname, fpath);
 
-	/* base dir */
-	if (level == 0)
+	/* base dir or too deep */
+	if (level == 0 || level > 3)
 		return 0;
 
+
 	/* model directory, reset topic */
-	if (level == 1 && is_dir) {
+	if ((level == 1 && is_dir && is_leaf_dir(fpath)) ||
+	    (level == 2 && is_dir)) {
 		if (close_table)
 			print_events_table_suffix(eventsfp);
 
