Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeBWPOa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:14:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39954 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751785AbeBWPO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:14:26 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 04/11] perf vendor events: add support for pmu events vendor subdirectory
Date: Sat, 24 Feb 2018 00:05:25 +0800
Message-ID: <1519401932-205051-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some architectures (like arm), it is required to support
a vendor subdirectory and not locate all the JSONs for a
specific vendor in the same folder.

This is because all the events for the same vendor will be
placed in the same pmu events table, which may cause conflict.
This conflict would be in the instance that a vendor's custom
implemented events do have the same meaning on different platforms,
so events in the pmu table would conflict. In addition, per list
command may show events which are not even supported for a given
platform.

This patch adds support for a arch/vendor/platform directory
hierarchy, while maintaining backwards-compatibility for existing
arch/platform structure. In this, each platform would always have
its own pmu events table.

In generated file pmu_events.c, each platform table name is in
the format pme{_vendor}_platform, like this:

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
---
 tools/perf/pmu-events/README    |  4 +++
 tools/perf/pmu-events/jevents.c | 64 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index 2407abc..655286f 100644
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
index 1d02faf..7b9e210 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -572,7 +572,7 @@ static char *file_name_to_table_name(char *fname)
 	 * Derive rest of table name from basename of the JSON file,
 	 * replacing hyphens and stripping out .json suffix.
 	 */
-	n = asprintf(&tblname, "pme_%s", basename(fname));
+	n = asprintf(&tblname, "pme_%s", fname);
 	if (n < 0) {
 		pr_info("%s: asprintf() error %s for file %s\n", prog,
 				strerror(errno), fname);
@@ -582,7 +582,7 @@ static char *file_name_to_table_name(char *fname)
 	for (i = 0; i < strlen(tblname); i++) {
 		c = tblname[i];
 
-		if (c == '-')
+		if (c == '-' || c == '/')
 			tblname[i] = '_';
 		else if (c == '.') {
 			tblname[i] = '\0';
@@ -739,25 +739,77 @@ static int get_maxfds(void)
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
+		if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
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
 
-- 
1.9.1
