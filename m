Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C3DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DE62145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DE62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeKPOja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 09:39:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727272AbeKPOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 09:39:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAG4ON7B151290
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:28:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nsk73qwdv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:28:43 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 16 Nov 2018 04:28:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Nov 2018 04:28:37 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAG4SaIT2359742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 04:28:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70F2D42042;
        Fri, 16 Nov 2018 04:28:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABC0B4203F;
        Fri, 16 Nov 2018 04:28:34 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.35.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Nov 2018 04:28:34 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com, tmricht@linux.vnet.ibm.com,
        anton@samba.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] perf stat: Fix shadow stats for clock events
Date:   Fri, 16 Nov 2018 09:58:43 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115141745.GJ9600@krava>
References: <20181115141745.GJ9600@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18111604-0016-0000-0000-00000227C108
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111604-0017-0000-0000-0000327FE7DD
Message-Id: <20181116042843.24067-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160036
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
              2.60 msec task-clock:u    #    0.877 CPUs utilized
         2,430,564      cycles:u        # 1215282.000 GHz

Fix this by saving original nsec values for clock events in
perf_stat__update_shadow_stats(). After patch:

  # ./perf stat -e task-clock,cycles ls
    <SNIP>
              3.14 msec task-clock:u    #    0.839 CPUs utilized
         3,094,528      cycles:u        #    0.985 GHz

Reported-by: Anton Blanchard <anton@samba.org>
Suggested-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 0aa802a79469 ("perf stat: Get rid of extra clock display function")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/stat-shadow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f0a8cec55c47..3c22c58b3e90 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -209,11 +209,12 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st)
 {
 	int ctx = evsel_context(counter);
+	u64 count_ns = count;
 
 	count *= counter->scale;
 
 	if (perf_evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
+		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-- 
2.17.1

