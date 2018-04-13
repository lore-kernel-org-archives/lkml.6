Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeDMNtM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:49:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753254AbeDMNtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:49:11 -0400
From: William Cohen <wcohen@redhat.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, William Cohen <wcohen@redhat.com>
Subject: [PATCH] Move handling of the MIDR Variant and Revision bits into the mapfile.csv file
Date: Fri, 13 Apr 2018 09:48:52 -0400
Message-Id: <20180413134852.19495-1-wcohen@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 code indentification code was filtering out the Variant and
Revision bits when it initially read the MIDR value.  It is better to
do the filtering of Variant and Revision bits in the regular
expressions in the mapsfile.csv.  If some performance events do not
function for particular versions of silicon, special case maps can be
added to mapsfile.csv before the general case to handle them.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 tools/perf/arch/arm64/util/header.c          |  7 -------
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 12 +++++++-----
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 534cd2507d83..05d1439c2cff 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -5,9 +5,6 @@
 
 #define MIDR "/regs/identification/midr_el1"
 #define MIDR_SIZE 19
-#define MIDR_REVISION_MASK      0xf
-#define MIDR_VARIANT_SHIFT      20
-#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
 
 char *get_cpuid_str(struct perf_pmu *pmu)
 {
@@ -44,11 +41,7 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		}
 		fclose(file);
 
-		/* Ignore/clear Variant[23:20] and
-		 * Revision[3:0] of MIDR
-		 */
 		midr = strtoul(buf, NULL, 16);
-		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
 		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
 		/* got midr break loop */
 		break;
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index f03e26ecb658..23372a335f97 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -3,7 +3,9 @@
 #
 # where
 #	MIDR	Processor version
-#		Variant[23:20] and Revision [3:0] should be zero.
+#		Variant[23:20] and Revision [3:0] bits should be matched
+#		with regular expression hex digits ([[:xdigit:]])
+#		unless particular variants or revisions need special handling.
 #	Version could be used to track version of of JSON file
 #		but currently unused.
 #	JSON/file/pathname is the path to JSON file, relative
@@ -12,7 +14,7 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
-0x00000000420f5160,v1,cavium/thunderx2,core
-0x00000000430f0af0,v1,cavium/thunderx2,core
-0x00000000480fd010,v1,hisilicon/hip08,core
+0x0000000041[[:xdigit:]]fd03[[:xdigit:]],v1,arm/cortex-a53,core
+0x0000000042[[:xdigit:]]f516[[:xdigit:]],v1,cavium/thunderx2,core
+0x0000000043[[:xdigit:]]f0af[[:xdigit:]],v1,cavium/thunderx2,core
+0x0000000048[[:xdigit:]]fd01[[:xdigit:]],v1,hisilicon/hip08,core
-- 
2.14.3
