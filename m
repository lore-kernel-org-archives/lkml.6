Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA8EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E187425965
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E187425965
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933963AbeFYMmp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:42:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755426AbeFYMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:42:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PCeQDW101353
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:42:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jtw7ks4rb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:42:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 25 Jun 2018 13:42:39 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 13:42:35 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PCgY8R25165894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 12:42:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E4A4AE05A;
        Mon, 25 Jun 2018 13:42:30 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58979AE057;
        Mon, 25 Jun 2018 13:42:28 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.84.229.130])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 13:42:28 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        dsahern@gmail.com, davidcc@google.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v2 2/3] perf script: Fix crash because of missing evsel->priv
Date:   Mon, 25 Jun 2018 18:12:19 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180625124220.6434-1-ravi.bangoria@linux.ibm.com>
References: <20180625124220.6434-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062512-0008-0000-0000-0000024B8D05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062512-0009-0000-0000-000021B1F852
Message-Id: <20180625124220.6434-3-ravi.bangoria@linux.ibm.com>
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
index f3fefbcc4503..ad2ac1300420 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1834,6 +1834,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct perf_evlist *evlist;
 	struct perf_evsel *evsel, *pos;
 	int err;
+	static struct perf_evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -1842,6 +1843,19 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
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

