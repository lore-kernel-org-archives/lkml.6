Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965245AbeBMPOl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:14:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965054AbeBMPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:14:39 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 4/4] perf test: Fix test case 23 for s390 z/VM or KVM guests
Date: Tue, 13 Feb 2018 16:14:19 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021315-0020-0000-0000-000003F53CCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021315-0021-0000-0000-00004287C8DF
Message-Id: <20180213151419.80737-4-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 perf can be executed on a LPAR with support
for hardware events (i. e. cycles) or on a z/VM or KVM guest
where no hardware events are supported. In this
environment use software event named cpu-clock
for this test case.

Use the cpuid infrastructure functions to determine
the cpuid on s390 which contains an indication of the
cpu counter facility availability.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/tests/code-reading.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 3bf7b145b826..c7115d369511 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -482,6 +482,34 @@ static void fs_something(void)
 	}
 }
 
+static const char *do_determine_event(bool excl_kernel)
+{
+	const char *event = excl_kernel ? "cycles:u" : "cycles";
+
+#ifdef __s390x__
+	char cpuid[128], model[16], model_c[16], cpum_cf_v[16];
+	unsigned int family;
+	int ret, cpum_cf_a;
+
+	if (get_cpuid(cpuid, sizeof(cpuid)))
+		goto out_clocks;
+	ret = sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%x", &family, model_c,
+		     model, cpum_cf_v, &cpum_cf_a);
+	if (ret != 5)		 /* Not available */
+		goto out_clocks;
+	if (excl_kernel && (cpum_cf_a & 4))
+		return event;
+	if (!excl_kernel && (cpum_cf_a & 2))
+		return event;
+
+	/* Fall through: missing authorization */
+out_clocks:
+	event = excl_kernel ? "cpu-clock:u" : "cpu-clock";
+
+#endif
+	return event;
+}
+
 static void do_something(void)
 {
 	fs_something();
@@ -592,10 +620,7 @@ static int do_test_code_reading(bool try_kcore)
 
 		perf_evlist__set_maps(evlist, cpus, threads);
 
-		if (excl_kernel)
-			str = "cycles:u";
-		else
-			str = "cycles";
+		str = do_determine_event(excl_kernel);
 		pr_debug("Parsing event '%s'\n", str);
 		ret = parse_events(evlist, str, NULL);
 		if (ret < 0) {
-- 
2.14.3
