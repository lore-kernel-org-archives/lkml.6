Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6264AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196B620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196B620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGYV7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:59:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49347 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbeGYV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:59:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKhWIa498895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:43:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKhVfI498890;
        Wed, 25 Jul 2018 13:43:31 -0700
Date:   Wed, 25 Jul 2018 13:43:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-742d92ff219f3aa7a67c184a57acfa8d88936cd6@git.kernel.org>
Cc:     tmricht@linux.ibm.com, schwidefsky@de.ibm.com, mingo@kernel.org,
        heiko.carstens@de.ibm.com, acme@redhat.com, jolsa@redhat.com,
        brueckner@linux.ibm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        tglx@linutronix.de
Reply-To: schwidefsky@de.ibm.com, mingo@kernel.org, tmricht@linux.ibm.com,
          acme@redhat.com, heiko.carstens@de.ibm.com, jolsa@redhat.com,
          hpa@zytor.com, brueckner@linux.ibm.com, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180626071701.58190-1-tmricht@linux.ibm.com>
References: <20180626071701.58190-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add transaction flag (-T) support for
 s390
Git-Commit-ID: 742d92ff219f3aa7a67c184a57acfa8d88936cd6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  742d92ff219f3aa7a67c184a57acfa8d88936cd6
Gitweb:     https://git.kernel.org/tip/742d92ff219f3aa7a67c184a57acfa8d88936cd6
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Tue, 26 Jun 2018 09:17:01 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:49:37 -0300

perf stat: Add transaction flag (-T) support for s390

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
@@ -490,3 +490,25 @@ out:
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
