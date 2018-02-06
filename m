Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeBFQ5W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:57:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51532 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753136AbeBFQ4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:56:02 -0500
From: John Garry <john.garry@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>, <wcohen@redhat.com>,
        <will.deacon@arm.com>, <ganapatrao.kulkarni@cavium.com>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 1/9] perf vendor events: drop incomplete multiple mapfile support
Date: Wed, 7 Feb 2018 01:44:56 +0800
Message-ID: <1517939104-230881-2-git-send-email-john.garry@huawei.com>
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

Currently jevents supports multiple mapfiles, but this
is only in the form where mapfile basename starts with
'mapfile.csv'

At the moment, no architectures actually use multiple mapfiles,
so drop the support for now.

This patch also solves a nuisance where, when the mapfile is
edited and the text editor may create a backup, jevents may
use the backup, as shown:
jevents: Many mapfiles? Using pmu-events/arch/arm64/mapfile.csv~, ignoring pmu-events/arch/arm64/mapfile.csv

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/README    |  5 ++---
 tools/perf/pmu-events/jevents.c | 10 ++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index c2ee3e4..2407abc 100644
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
index b578aa2..9e0a21e 100644
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
1.9.1
