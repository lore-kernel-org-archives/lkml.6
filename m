Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74652C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D541A20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOxdO2mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D541A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeGYTNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeGYTNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:53 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985B520852;
        Wed, 25 Jul 2018 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541667;
        bh=OJgFAolyv3oj7m48biFluQeJIzVr4g+Mpebyxtzncqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOxdO2mm6XR0Q3lIF9ImQEsYtw0F9HueEA8ktgbYvbHaIM7xTN939mBs7LOimGce8
         HFXD5Y/CSCxLQD8X7+DSRUmNKsqPBHC1nUTYX0kQy4KCNx6VR/sHxZDEByR2nH+VcH
         BtNtL3LyT+CvUgtMlRpWv5EI/4BLDzqmG1jstfUk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/27] perf stat: Add transaction flag (-T) support for s390
Date:   Wed, 25 Jul 2018 14:59:42 -0300
Message-Id: <20180725180001.15108-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

The 'perf stat' command line flag -T to display transaction counters is
currently supported for x86 only.

Add support for s390. It is based on the metrics flag -M transaction
using the architecture dependent JSON files. This requires a metric
named "transaction" in the JSON files for the platform.

Introduce a new function metricgroup__has_metric() to check for the
existence of a metric_name transaction.

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
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180626071701.58190-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c     | 12 ++++++++++++
 tools/perf/util/metricgroup.c | 22 ++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  1 +
 3 files changed, 35 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 05be023c3f0e..dfd13d6e2931 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2449,6 +2449,18 @@ static int add_default_attributes(void)
 		return 0;
 
 	if (transaction_run) {
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
index 1ddc3d1d0147..96eab4ec34ff 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -490,3 +490,25 @@ int metricgroup__parse_groups(const struct option *opt,
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
+		if (match_metric(pe->metric_name, metric))
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
2.14.4

