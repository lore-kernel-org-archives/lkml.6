Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6360EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A21E208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A21E208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeHWMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:08:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeHWMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:08:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8bW6g3187908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:37:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8bWgx3187905;
        Thu, 23 Aug 2018 01:37:32 -0700
Date:   Thu, 23 Aug 2018 01:37:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jack Henschel <tipbot@zytor.com>
Message-ID: <tip-49836f7811f383d8613661fff110ce74f4710d52@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jackdev@mailbox.org,
        jolsa@kernel.org, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: acme@redhat.com, hpa@zytor.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jackdev@mailbox.org, jolsa@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180704121345.19025-1-jackdev@mailbox.org>
References: <20180704121345.19025-1-jackdev@mailbox.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf parser: Improve error message for PMU
 address filters
Git-Commit-ID: 49836f7811f383d8613661fff110ce74f4710d52
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

Commit-ID:  49836f7811f383d8613661fff110ce74f4710d52
Gitweb:     https://git.kernel.org/tip/49836f7811f383d8613661fff110ce74f4710d52
Author:     Jack Henschel <jackdev@mailbox.org>
AuthorDate: Wed, 4 Jul 2018 14:13:45 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:58 -0300

perf parser: Improve error message for PMU address filters

This is the second version of a patch that improves the error message of
the perf events parser when the PMU hardware does not support address
filters.

Previously, the perf returned the following error:

  $ perf record -e intel_pt// --filter 'filter sys_write'
  --filter option should follow a -e tracepoint or HW tracer option

This implies there is some syntax error present in the command line,
which is not true. Rather, notify the user that the CPU does not have
support for this feature.

For example, Intel chips based on the Broadwell micro-archticture have
the Intel PT PMU, but do not support address filtering.

Now, perf prints the following error message:

  $ perf record -e intel_pt// --filter 'filter sys_write'
  This CPU does not support address filtering

Signed-off-by: Jack Henschel <jackdev@mailbox.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180704121345.19025-1-jackdev@mailbox.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 15eec49e71a1..f8cd3e7c9186 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1991,8 +1991,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	int nr_addr_filters = 0;
 	struct perf_pmu *pmu = NULL;
 
-	if (evsel == NULL)
-		goto err;
+	if (evsel == NULL) {
+		fprintf(stderr,
+			"--filter option should follow a -e tracepoint or HW tracer option\n");
+		return -1;
+	}
 
 	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
 		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
@@ -2014,8 +2017,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
 
-	if (!nr_addr_filters)
-		goto err;
+	if (!nr_addr_filters) {
+		fprintf(stderr,
+			"This CPU does not support address filtering\n");
+		return -1;
+	}
 
 	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
@@ -2024,12 +2030,6 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	}
 
 	return 0;
-
-err:
-	fprintf(stderr,
-		"--filter option should follow a -e tracepoint or HW tracer option\n");
-
-	return -1;
 }
 
 int parse_filter(const struct option *opt, const char *str,
