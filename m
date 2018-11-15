Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3319C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D48121780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D48121780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbeKOUCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:02:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728609AbeKOUCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:02:39 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAF9rxPb083560
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 04:55:32 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ns59jksbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 04:55:31 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 15 Nov 2018 09:55:29 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Nov 2018 09:55:26 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAF9tPZ229884460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 09:55:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E99511C050;
        Thu, 15 Nov 2018 09:55:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA84211C052;
        Thu, 15 Nov 2018 09:55:23 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.35.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Nov 2018 09:55:23 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com, tmricht@linux.vnet.ibm.com,
        anton@samba.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [RFC 2/2] perf stat: Fix shadow stats for clock events
Date:   Thu, 15 Nov 2018 15:25:33 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115095533.16930-1-ravi.bangoria@linux.ibm.com>
References: <20181115095533.16930-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18111509-0012-0000-0000-000002CAD630
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111509-0013-0000-0000-000020FFECAC
Message-Id: <20181115095533.16930-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0aa802a79469 ("perf stat: Get rid of extra clock display
function") introduced scale and unit for clock events. Thus,
perf_stat__update_shadow_stats() now saves scaled values of
clock events in msecs, instead of original nsecs. But while
calculating values of shadow stats we still consider clock
event values in nsecs. This results in a wrong shadow stat
values. Ex,

  # ./perf stat -e task-clock,cycles ls
    <SNIP>
              2.62 msec task-clock:u    #    0.624 CPUs utilized
         2,501,536      cycles:u        # 1250768.000 GHz

Fix this by considering clock events's saved stats in msecs:

  # ./perf stat -e task-clock,cycles ls
    <SNIP>
              2.42 msec task-clock:u    #    0.754 CPUs utilized
         2,338,747      cycles:u        #    1.169 GHz

Note:
The problem with this approach is, we are losing fractional part
while converting nsecs to msecs. This results in a sightly different
values of shadow stats.

Reported-by: Anton Blanchard <anton@samba.org>
Fixes: 0aa802a79469 ("perf stat: Get rid of extra clock display function")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/stat-shadow.c | 13 +++++++------
 tools/perf/util/stat.h        |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f0a8cec55c47..5b28b278a24e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <linux/time64.h>
 #include "evsel.h"
 #include "stat.h"
 #include "color.h"
@@ -213,7 +214,7 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 	count *= counter->scale;
 
 	if (perf_evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
+		update_runtime_stat(st, STAT_MSECS, 0, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
@@ -873,10 +874,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
 		print_stalled_cycles_backend(config, cpu, evsel, avg, out, st);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
+		total = runtime_stat_avg(st, STAT_MSECS, 0, cpu);
 
 		if (total) {
-			ratio = avg / total;
+			ratio = avg / (total * NSEC_PER_MSEC);
 			print_metric(config, ctxp, NULL, "%8.3f", "GHz", ratio);
 		} else {
 			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
@@ -972,14 +973,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
 				evsel->metric_name, avg, cpu, out, st);
-	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
+	} else if (runtime_stat_n(st, STAT_MSECS, 0, cpu) != 0) {
 		char unit = 'M';
 		char unit_buf[10];
 
-		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
+		total = runtime_stat_avg(st, STAT_MSECS, 0, cpu);
 
 		if (total)
-			ratio = 1000.0 * avg / total;
+			ratio = 1000.0 * avg / (total * NSEC_PER_MSEC);
 		if (ratio < 0.001) {
 			ratio *= 1000;
 			unit = 'K';
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2f9c9159a364..941ad4b0836c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -62,7 +62,7 @@ enum {
 
 enum stat_type {
 	STAT_NONE = 0,
-	STAT_NSECS,
+	STAT_MSECS,			/* Milliseconds */
 	STAT_CYCLES,
 	STAT_STALLED_CYCLES_FRONT,
 	STAT_STALLED_CYCLES_BACK,
-- 
2.17.1

