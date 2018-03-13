Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933224AbeCMMGC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933198AbeCMMF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:05:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41608204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/31] perf vendor events: Drop incomplete multiple mapfile support
Date: Tue, 13 Mar 2018 09:04:48 -0300
Message-Id: <20180313120508.29327-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Currently jevents supports multiple mapfiles, but this is only in the
form where mapfile basename starts with 'mapfile.csv'

At the moment, no architectures actually use multiple mapfiles, so drop
the support for now.

This patch also solves a nuisance where, when the mapfile is edited and
the text editor may create a backup, jevents may use the backup, as
shown:

  jevents: Many mapfiles? Using pmu-events/arch/arm64/mapfile.csv~, ignoring pmu-events/arch/arm64/mapfile.csv

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-2-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/README    |  5 ++---
 tools/perf/pmu-events/jevents.c | 10 ++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index c2ee3e4417fe..2407abc1d441 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -11,9 +11,8 @@ tree tools/perf/pmu-events/arch/foo.
 	- Regular files with '.json' extension in the name are assumed to be
 	  JSON files, each of which describes a set of PMU events.
 
-	- Regular files with basename starting with 'mapfile.csv' are assumed
-	  to be a CSV file that maps a specific CPU to its set of PMU events.
-	  (see below for mapfile format)
+	- The CSV file that maps a specific CPU to its set of PMU events is to
+	  be named 'mapfile.csv' (see below for mapfile format).
 
 	- Directories are traversed, but all other files are ignored.
 
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b578aa26e375..9e0a21e74a67 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -798,16 +798,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 	 * after processing all JSON files (so we can write out the
 	 * mapping table after all PMU events tables).
 	 *
-	 * TODO: Allow for multiple mapfiles? Punt for now.
 	 */
 	if (level == 1 && is_file) {
-		if (!strncmp(bname, "mapfile.csv", 11)) {
-			if (mapfile) {
-				pr_info("%s: Many mapfiles? Using %s, ignoring %s\n",
-						prog, mapfile, fpath);
-			} else {
-				mapfile = strdup(fpath);
-			}
+		if (!strcmp(bname, "mapfile.csv")) {
+			mapfile = strdup(fpath);
 			return 0;
 		}
 
-- 
2.14.3
