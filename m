Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9953BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EDA25965
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EDA25965
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeFYMmu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:42:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933968AbeFYMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:42:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PCcx9e128207
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:42:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jty0cvkq7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:42:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 25 Jun 2018 13:42:43 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 13:42:40 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PCgd7g34340952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 12:42:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5D88AE04D;
        Mon, 25 Jun 2018 13:42:34 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BE57AE057;
        Mon, 25 Jun 2018 13:42:32 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.84.229.130])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 13:42:31 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        dsahern@gmail.com, davidcc@google.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v2 3/3] perf script/annotate: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE]
Date:   Mon, 25 Jun 2018 18:12:20 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180625124220.6434-1-ravi.bangoria@linux.ibm.com>
References: <20180625124220.6434-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062512-0012-0000-0000-000002833BFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062512-0013-0000-0000-000020B4955D
Message-Id: <20180625124220.6434-4-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event__process_feature() accesses feat_ops[HEADER_LAST_FEATURE]
which is not defined and thus perf is crashing. HEADER_LAST_FEATURE
is used as an end marker for the perf report but it's unused for
perf script/annotate. Ignore HEADER_LAST_FEATURE for perf script/
annotate.

Before:
  # ./perf record -o - ls | ./perf script
  Segmentation fault (core dumped)

After:
  # ./perf record -o - ls | ./perf script
  ls 7031 4392.099856:  250000 cpu-clock:uhH:  7f5e0ce7cd60
  ls 7031 4392.100355:  250000 cpu-clock:uhH:  7f5e0c706ef7

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: 57b5de463925 ("perf report: Support forced leader feature in pipe mode")
---
 tools/perf/builtin-annotate.c | 11 ++++++++++-
 tools/perf/builtin-report.c   |  3 ++-
 tools/perf/builtin-script.c   | 11 ++++++++++-
 tools/perf/util/header.c      |  2 +-
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5eb22cc56363..8180319285af 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,6 +283,15 @@ static int process_sample_event(struct perf_tool *tool,
 	return ret;
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_evsel *evsel,
 				    struct perf_annotate *ann)
@@ -471,7 +480,7 @@ int cmd_annotate(int argc, const char **argv)
 			.attr	= perf_event__process_attr,
 			.build_id = perf_event__process_build_id,
 			.tracing_data   = perf_event__process_tracing_data,
-			.feature	= perf_event__process_feature,
+			.feature	= process_feature_event,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index cdb5b6949832..c04dc7b53797 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -217,7 +217,8 @@ static int process_feature_event(struct perf_tool *tool,
 	}
 
 	/*
-	 * All features are received, we can force the
+	 * (feat_id = HEADER_LAST_FEATURE) is the end marker which
+	 * means all features are received, now we can force the
 	 * group if needed.
 	 */
 	setup_forced_leader(rep, session->evlist);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ad2ac1300420..568ddfac3213 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3044,6 +3044,15 @@ int process_cpu_map_event(struct perf_tool *tool __maybe_unused,
 	return set_maps(script);
 }
 
+static int process_feature_event(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_session *session)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(tool, event, session);
+	return 0;
+}
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 static int perf_script__process_auxtrace_info(struct perf_tool *tool,
 					      union perf_event *event,
@@ -3088,7 +3097,7 @@ int cmd_script(int argc, const char **argv)
 			.attr		 = process_attr,
 			.event_update   = perf_event__process_event_update,
 			.tracing_data	 = perf_event__process_tracing_data,
-			.feature	 = perf_event__process_feature,
+			.feature	 = process_feature_event,
 			.build_id	 = perf_event__process_build_id,
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_script__process_auxtrace_info,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 59fcc790c865..653ff65aa2c3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3464,7 +3464,7 @@ int perf_event__process_feature(struct perf_tool *tool,
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return 0;
 	}
-	if (feat == HEADER_RESERVED || feat > HEADER_LAST_FEATURE) {
+	if (feat == HEADER_RESERVED || feat >= HEADER_LAST_FEATURE) {
 		pr_warning("invalid record type %d in pipe-mode\n", type);
 		return -1;
 	}
-- 
2.14.4

