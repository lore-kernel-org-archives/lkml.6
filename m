Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ECBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A992620872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A992620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeFTNbC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:31:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754460AbeFTNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:30:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KDTSx8024525
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:30:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqpkbkx2d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:30:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 20 Jun 2018 14:30:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 14:30:52 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KDUqsZ32637094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 13:30:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3206C4C06D;
        Wed, 20 Jun 2018 14:21:51 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97AAC4C044;
        Wed, 20 Jun 2018 14:21:48 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.195.33.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 14:21:48 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        dsahern@gmail.com, davidcc@google.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 2/3] perf script: Fix crash because of missing evsel->priv
Date:   Wed, 20 Jun 2018 19:00:29 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620133030.2188-1-ravi.bangoria@linux.ibm.com>
References: <20180620133030.2188-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062013-0028-0000-0000-000002D2F4F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062013-0029-0000-0000-0000238A3A0D
Message-Id: <20180620133030.2188-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf script in pipped mode is crashing because evsel->priv is not
set properly. Fix it.

Before:
  # ./perf record -o - -- ls | ./perf script
    Segmentation fault (core dumped)

After:
  # ./perf record -o - -- ls | ./perf script
  ls 2282 1031.731974:  250000 cpu-clock:uhH:  7effe4b3d29e
  ls 2282 1031.732222:  250000 cpu-clock:uhH:  7effe4b3a650

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: a14390fde64e ("perf script: Allow creating per-event dump files")
---
 tools/perf/builtin-script.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4d1cee68cfd2..acee05562f5e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1822,6 +1822,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct perf_evlist *evlist;
 	struct perf_evsel *evsel, *pos;
 	int err;
+	static struct perf_evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -1830,6 +1831,19 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evlist = *pevlist;
 	evsel = perf_evlist__last(*pevlist);
 
+	if (!evsel->priv) {
+		if (scr->per_event_dump) {
+			evsel->priv = perf_evsel_script__new(evsel,
+						scr->session->data);
+		} else {
+			es = zalloc(sizeof(*es));
+			if (!es)
+				return -ENOMEM;
+			es->fp = stdout;
+			evsel->priv = es;
+		}
+	}
+
 	if (evsel->attr.type >= PERF_TYPE_MAX &&
 	    evsel->attr.type != PERF_TYPE_SYNTH)
 		return 0;
-- 
2.14.4

