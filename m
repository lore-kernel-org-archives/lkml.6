Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DAF206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfAKLxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:53:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728488AbfAKLxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:53:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BBmtco147323
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:53:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pxr5d7mrs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:53:09 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 11 Jan 2019 11:53:08 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 11:53:04 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BBr33t6422980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 11:53:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D959E5204E;
        Fri, 11 Jan 2019 11:53:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E2A452051;
        Fri, 11 Jan 2019 11:53:03 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [Patch 1/4] perf report: Add function for verbose dump of raw data
Date:   Fri, 11 Jan 2019 12:52:56 +0100
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19011111-0008-0000-0000-000002AF73E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011111-0009-0000-0000-0000221B7DA0
Message-Id: <20190111115259.99438-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to call an architecture dependend function to interpret
raw data verbatim when dumping the perf.data file with
option -D.

This allows to display the event's raw data more verbatim
than just plain hex data.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/session.c | 7 +++++++
 tools/perf/util/session.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d2c8ce6cfad..1c8d6d0ef300 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1050,6 +1050,12 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
 			sample->read.one.id, sample->read.one.value);
 }
 
+void __weak arch__trace_event(struct perf_evlist *evlist __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused)
+{
+}
+
 static void dump_event(struct perf_evlist *evlist, union perf_event *event,
 		       u64 file_offset, struct perf_sample *sample)
 {
@@ -1060,6 +1066,7 @@ static void dump_event(struct perf_evlist *evlist, union perf_event *event,
 	       file_offset, event->header.size, event->header.type);
 
 	trace_event(event);
+	arch__trace_event(evlist, event, sample);
 
 	if (sample)
 		perf_evlist__print_tstamp(evlist, event, sample);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index d96eccd7d27f..160d9cd6a3ae 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -128,4 +128,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 				    struct perf_evlist *evlist,
 				    struct machine *machine);
 
+void arch__trace_event(struct perf_evlist *evlist __maybe_unused,
+		       union perf_event *event __maybe_unused,
+		       struct perf_sample *sample __maybe_unused);
 #endif /* __PERF_SESSION_H */
-- 
2.14.3

