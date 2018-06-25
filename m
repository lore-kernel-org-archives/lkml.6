Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD9EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F2D259D1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F2D259D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeFYM7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:59:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755221AbeFYM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:59:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PCwY2s110844
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:59:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju00q2fxv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:59:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 25 Jun 2018 13:59:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 13:59:00 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PCwxk232833662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 12:58:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3639FAE056;
        Mon, 25 Jun 2018 13:58:55 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EED7DAE051;
        Mon, 25 Jun 2018 13:58:54 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 13:58:54 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 4/4 v3] perf stat: Add transaction flag (-T) support for s390
Date:   Mon, 25 Jun 2018 14:58:56 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18062512-0028-0000-0000-000002D4A84B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062512-0029-0000-0000-0000238C0715
Message-Id: <20180625125856.20262-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf stat command line flag -T to display transaction counters is
currently supported for x86 only.
Add support for s390. It is based on the metrics flag -M transaction
using the architecture dependend json files. This requires a metric
named "transaction" in the json files for the platform.

v2 --> v3:
Introduce new function metricgroup__has_metric() to check for
the existance of a metric named transaction.

As suggested by Andi Kleen, this is the new approach to support
transactions counters. Other architectures will follow.

Output before:
[root@p23lp27 perf]# ./perf stat -T -- sleep 1
Cannot set up transaction events
[root@p23lp27 perf]#

Output after:
[root@s35lp76 perf]# ./perf stat -T -- ~/mytesttx 1 >/tmp/111

 Performance counter stats for '/root/mytesttx 1':

                 1      tx_c_tend           #     13.0 transaction
                 1      tx_nc_tend
                11      tx_nc_tabort
                 0      tx_c_tabort_special
                 0      tx_c_tabort_no_special

       0.001070109 seconds time elapsed

[root@s35lp76 perf]#

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/builtin-stat.c     | 12 ++++++++++++
 tools/perf/util/metricgroup.c | 23 +++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  1 +
 3 files changed, 36 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a4f662a462c6..e309279e7b04 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2425,6 +2425,18 @@ static int add_default_attributes(void)
 	if (transaction_run) {
 		struct parse_events_error errinfo;
 
+		/* Handle -T as -M transaction. Once platform specific metrics
+		 * support has been added to the json files, all archictures
+		 * will use this approach. To determine transaction support
+		 * on an architecture test for such a metric name.
+		 */
+		if (metricgroup__has_metric("transaction")) {
+			struct option opt = { .value = &evsel_list };
+
+			return metricgroup__parse_groups(&opt, "transaction",
+							 &metric_events);
+		}
+
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1ddc3d1d0147..90cff5226ecc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -490,3 +490,26 @@ int metricgroup__parse_groups(const struct option *opt,
 	metricgroup__free_egroups(&group_list);
 	return ret;
 }
+
+bool metricgroup__has_metric(const char *metric)
+{
+	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+	struct pmu_event *pe;
+	int i;
+
+	if (!map)
+		return false;
+
+	for (i = 0; ; i++) {
+		pe = &map->table[i];
+
+		if (!pe->name && !pe->metric_group && !pe->metric_name)
+			break;
+		if (!pe->metric_expr)
+			continue;
+		if (match_metric(pe->metric_group, metric) ||
+		    match_metric(pe->metric_name, metric))
+			return true;
+	}
+	return false;
+}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 06854e125ee7..8a155dba0581 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -28,4 +28,5 @@ int metricgroup__parse_groups(const struct option *opt,
 			struct rblist *metric_events);
 
 void metricgroup__print(bool metrics, bool groups, char *filter, bool raw);
+bool metricgroup__has_metric(const char *metric);
 #endif
-- 
2.14.3

