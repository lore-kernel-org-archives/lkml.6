Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeBPTVX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753581AbeBPTUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:20:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39881217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/41] perf test: Fix test case 23 for s390 z/VM or KVM guests
Date: Fri, 16 Feb 2018 16:17:44 -0300
Message-Id: <20180216191746.11095-40-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390 perf can be executed on a LPAR with support for hardware events
(i. e. cycles) or on a z/VM or KVM guest where no hardware events are
supported. In this environment use software event named cpu-clock for
this test case.

Use the cpuid infrastructure functions to determine the cpuid on s390
which contains an indication of the cpu counter facility availability.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180213151419.80737-4-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
