Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeCNMlx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:41:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750902AbeCNMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:41:52 -0400
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/2 v2] perf stat: Rework x86 transaction counter handling
Date: Wed, 14 Mar 2018 13:40:03 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18031412-0012-0000-0000-000005BE5AD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031412-0013-0000-0000-0000193A5E95
Message-Id: <20180314124004.98937-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command 'perf stat -T -- sleep 2' displays transaction
counters.  Right now there is only hard coded support
for x86.

This patch introduces architecture specific counter
tables for x86. The architecture is queried
and the event string for transaction counters is constructed
depending on the architecture and the CPU measurement
facility counter list. This scheme can be easily extended
to support other architectures.

Output does not change.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/builtin-stat.c | 130 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 86c8c8a9229c..8d7b97c708e4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -95,22 +95,8 @@ static const char *transaction_attrs = {
 	"task-clock,"
 	"{"
 	"instructions,"
-	"cycles,"
-	"cpu/cycles-t/,"
-	"cpu/tx-start/,"
-	"cpu/el-start/,"
-	"cpu/cycles-ct/"
-	"}"
-};
-
-/* More limited version when the CPU does not have all events. */
-static const char * transaction_limited_attrs = {
-	"task-clock,"
-	"{"
-	"instructions,"
-	"cycles,"
-	"cpu/cycles-t/,"
-	"cpu/tx-start/"
+	"cycles"
+	"%s"
 	"}"
 };
 
@@ -2149,13 +2135,93 @@ __weak void arch_topdown_group_warn(void)
 {
 }
 
+struct pmu_tx_events {			/* Define transaction counters */
+	const char *pmu;		/* PMU name */
+	const char *name;		/* Counter name */
+};
+
+static struct pmu_tx_events x86_tx_events[] = {/* x86 transaction counters */
+	{
+		.pmu = "cpu",
+		.name = "cycles-t",
+	},
+	{
+		.pmu = "cpu",
+		.name = "tx-start",
+	},
+	{
+		.pmu = "cpu",
+		.name = "el-start",
+	},
+	{
+		.pmu = "cpu",
+		.name = "cycles-ct",
+	},
+	{
+		.pmu = 0
+	}
+};
+
+struct arch_pmu_tx_events {
+	const char *archname;		/* Architecture name */
+	struct pmu_tx_events *tx;	/* Architecture specific counters */
+} arch_pmu_tx_events[] = {
+	{
+		.archname = "x86",
+		.tx = x86_tx_events
+	},
+	{
+		.archname = 0
+	}
+};
+
+static struct pmu_tx_events *pmu_tx_find_arch(const char *name)
+{
+	struct arch_pmu_tx_events *p = arch_pmu_tx_events;
+
+	for (; p->archname; ++p)
+		if (!strcmp(name, p->archname))
+			return p->tx;
+	return NULL;
+}
+
+/* Search the list of transaction events and test if they are valid for
+ * this PMU. The events are named cpu/cycles-t/ or cpum_cf/TX_NC_TEND/
+ * that is the PMU name followed by the event name surrounded by slashes.
+ *
+ * The function returns a string which contains the tested (and existing)
+ * PMU transaction events. The caller must free this string.
+ *
+ * If no PMU transaction events are found, a NULL pointer is returned.
+ */
+static char *build_tx_string(const char *fmt, struct pmu_tx_events *txp)
+{
+	struct pmu_tx_events *p = txp;
+	char buffer[512], *result;
+	int rc, i = 0;
+
+	memset(buffer, 0, sizeof(buffer));
+	for (p = txp; p->pmu; ++p) {
+		if (pmu_have_event(p->pmu, p->name)) {
+			rc = scnprintf(buffer + i, sizeof(buffer) - i,
+				       ",%s/%s/", p->pmu, p->name);
+			i += rc;
+			if (i >= (int)sizeof(buffer))
+				break;
+		}
+	}
+	if (i)			/* Transaction counters found */
+		return asprintf(&result, fmt, buffer) < 0 ? NULL : result;
+	return NULL;
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
  */
 static int add_default_attributes(void)
 {
-	int err;
+	int err = -1;
 	struct perf_event_attr default_attrs0[] = {
 
   { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
@@ -2274,21 +2340,29 @@ static int add_default_attributes(void)
 		return 0;
 
 	if (transaction_run) {
-		struct parse_events_error errinfo;
+		struct parse_events_error errinfo = { .idx = 0 };
+		char *tx_str;
+		struct pmu_tx_events *tx_archp;
 
-		if (pmu_have_event("cpu", "cycles-ct") &&
-		    pmu_have_event("cpu", "el-start"))
-			err = parse_events(evsel_list, transaction_attrs,
-					   &errinfo);
-		else
-			err = parse_events(evsel_list,
-					   transaction_limited_attrs,
-					   &errinfo);
-		if (err) {
+		/* Find architecture transaction counter string table */
+		tx_archp = pmu_tx_find_arch(perf_env__arch(NULL));
+		if (!tx_archp) {
 			fprintf(stderr, "Cannot set up transaction events\n");
 			return -1;
 		}
-		return 0;
+
+		/* Build architecture transaction counter string */
+		tx_str = build_tx_string(transaction_attrs, tx_archp);
+		if (!tx_str) {
+			fprintf(stderr, "Cannot set up transaction events\n");
+			return -1;
+		}
+
+		err = parse_events(evsel_list, tx_str, &errinfo);
+		if (err)
+			parse_events_print_error(&errinfo, tx_str);
+		free(tx_str);
+		return err;
 	}
 
 	if (smi_cost) {
-- 
2.14.3
