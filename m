Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BB66FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B60E208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B60E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755268AbeFNLte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:49:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755220AbeFNLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:49:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5EBmbLf080126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:49:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jknhgxf62-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:49:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 14 Jun 2018 12:49:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Jun 2018 12:48:57 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5EBmuQA34078752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 11:48:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18C5A4C059;
        Thu, 14 Jun 2018 12:40:05 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFBC24C04A;
        Thu, 14 Jun 2018 12:40:04 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jun 2018 12:40:04 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, jolsa@redhat.com
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/3] perf alias: Rebuild alias expression string to make it comparable
Date:   Thu, 14 Jun 2018 13:48:44 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180614114845.41221-1-tmricht@linux.ibm.com>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061411-4275-0000-0000-0000028DB11D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061411-4276-0000-0000-00003794DFDA
Message-Id: <20180614114845.41221-2-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMU alias definitions in sysfs files may have spaces, newlines
and number with leading zeroes. Same alias definitions may
also appear in JSON files without spaces, etc.

Scan alias definitions and remove leading zeroes, spaces,
newlines, etc and rebuild string to make alias->str member
comparable.

s390 for example  has terms specified as
event=0x0091 (read from files ../<PMU>/events/<FILE>
and terms specified as event=0x91 (read from JSON files).

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/pmu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 26c79a9c4142..da8f243743d3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -241,9 +241,11 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *metric_expr,
 				 char *metric_name)
 {
+	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
 	int ret;
 	int num;
+	char newval[256];
 
 	alias = malloc(sizeof(*alias));
 	if (!alias)
@@ -262,6 +264,27 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		return ret;
 	}
 
+	/* Scan event and remove leading zeroes, spaces, newlines, some
+	 * platforms have terms specified as
+	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
+	 * and terms specified as event=0x91 (read from JSON files).
+	 *
+	 * Rebuild string to make alias->str member comparable.
+	 */
+	memset(newval, 0, sizeof(newval));
+	ret = 0;
+	list_for_each_entry(term, &alias->terms, list) {
+		if (ret)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 ",");
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%#x", term->config, term->val.num);
+		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%s", term->config, term->val.str);
+	}
+
 	alias->name = strdup(name);
 	if (dir) {
 		/*
@@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
-	alias->str = strdup(val);
+	alias->str = strdup(newval);
 
 	list_add_tail(&alias->list, list);
 
-- 
2.14.3

