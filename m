Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeCNU0u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCNU0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:26:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7F3204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 14 Mar 2018 17:26:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, wcohen@redhat.com,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] perf vendor events: fix processing for xfs
Message-ID: <20180314202643.GG27335@kernel.org>
References: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
 <20180314185355.GC27335@kernel.org>
 <fa4f4c83-1a1a-761f-9259-ce21ee000fc3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4f4c83-1a1a-761f-9259-ce21ee000fc3@huawei.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 14, 2018 at 07:39:25PM +0000, John Garry escreveu:
> On 14/03/2018 18:53, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 15, 2018 at 01:10:52AM +0800, John Garry escreveu:
> > > In the recently introduced support for vendor subdirectory,
> > > the checking for directory entries under xfs (or any other fs
> > > which does not support dirent.d_type) is missing the check
> > > for links for current and parent directory. This can result
> > > in a broken pmu_events.c being generated.
> > > 
> > > Fix this by adding the appropriate check in is_leaf_dir().
> > 
> > So I'll lookup the patch that introduced the patch and squash this one
> > with it, so that we don't break 'git bisect' on ppc.
> 
> Right, so it's going to be "perf vendor events: add support for pmu events
> vendor subdirectory".
> 
> BTW, I don't think it's specifically ppc which was broken, but just when
> building from xfs.
> 
> Much appreciated,
> John

This is the ammended cset, and yes, I mentioned just XFS not ppc, added
Sukadev to the CC list and the link to your patch that he tested. Also
stamped his Tested-by there.

This will all go again the container build test set before a new pull
req to Ingo, where I'll avoid sending the previous 31 patches to the
mailing list, just the ones that came after it, as perf/core keeps
growing :-)

- Arnaldo

commit d24081387a00d2e10789eb012429144c549598be
Author: John Garry <john.garry@huawei.com>
Date:   Thu Mar 8 18:58:29 2018 +0800

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
 
