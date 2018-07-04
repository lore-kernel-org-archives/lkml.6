Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51577C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050A1208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S+kOhvd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050A1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeGDJyh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:54:37 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:64552 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGDJyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:54:35 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 830F840FF5;
        Wed,  4 Jul 2018 11:54:33 +0200 (CEST)
Authentication-Results: spamfilter02.heinlein-hosting.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        message-id:date:date:subject:subject:from:from:received; s=
        mail20150812; t=1530698070; bh=qR3KYNNbLY+slAzvA/ueLMifqjP6i1eS0
        6TwPvvauJU=; b=S+kOhvd5iVlnS1VX4LQOClfUQonsx+jqSeC2B1coc2HltXCxn
        BAFoA6HvPeQv1nB2q4k8+kA1fGviDqVMudAnE0frIXPaSnEcQplBXGAIUU+H2FCQ
        wai5DPjzI53a1qBp02S9CUOO4sJJ+0txRXRqb6XaPH9AqLv1HjZl/jQ6YIAdH/gw
        jkI5k1ryoawAyjh/NxinMlFziYKWpXp3UG3w3tudl7DO5F+IAzqyDTWU6p1d7yAi
        44nmztIfwQoqUtRyL+MSf7TK9s3Wl7VJIREHtl+QgtFGbJAnuSZIKoJXIAX4WbfG
        oTirQD9VOHHAvdzjzPA4HUzg1iwxSs9/e3Anw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id vY-4TODkCQXf; Wed,  4 Jul 2018 11:54:30 +0200 (CEST)
From:   Jack Henschel <jackdev@mailbox.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jack Henschel <jackdev@mailbox.org>
Subject: [PATCH] perf parser: Improve error message for PMU address filters
Date:   Wed,  4 Jul 2018 11:54:09 +0200
Message-Id: <20180704095409.6109-1-jackdev@mailbox.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the error message of the perf events parser
when the PMU hardware does not support address filters.

Previously, the perf returned the following error:
> --filter option should follow a -e tracepoint or HW tracer option
This implies there is some syntax error present in the command line,
which is not true. Rather, notify the user that the CPU does not have
support for this feature.

For example, Intel chips based on the Broadwell micro-archticture have
the Intel PT PMU, but do not support address filtering.

Signed-off-by: Jack Henschel <jackdev@mailbox.org>
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
-- 
2.18.0

